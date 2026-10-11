

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../datas/data_base.dart';
import '../firebase_options.dart';

/**
 * schoolData 保存完整的学校信息；
 * schoolIndex/abbreviationIndex 记录所有已使用的 abbreviation；
 * schoolIndex/ownerIndex 记录邮箱与学校的唯一绑定。
 */

class FirebaseProvider {

  Future<FirebaseProvider> init() async {
    await _initializeFirebase();
    return this;
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DataBase> firebaseDataBase = [];
  String currentUserEmail = '';

  Future<void> _initializeFirebase() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint("Firebase initialized successfully");
      // _firestore = FirebaseFirestore.instance;
      debugPrint("Firebase firestoreInit  successfully");
      currentUserEmail = getCurrentUserEmail();
      debugPrint("Firebase  currentUserEmail -> $currentUserEmail");
      // if (currentUserEmail != null) {
      firebaseDataBase = await fetchPublicSchoolData();
      //   debugPrint("Firebase  firebaseDataBase -> $firebaseDataBase");
      // }
    } catch (e) {
      // Handle any errors during initialization
      debugPrint("Error during Firebase initialization: $e");
    }
  }

  Future<List<DataBase>> fetchPublicSchoolData() async {
    final firestore = FirebaseFirestore.instance;

    // 1. 先在 schoolIndex 找出 isSearchable 为 true 的 abbreviation
    final indexSnapshot = await firestore
        .collection('schoolIndex')
        .where('isSearchable', isEqualTo: true)
        .get();

    final List<String> abbreviations = indexSnapshot.docs.map((doc) => doc.id).toList();

    // 2. 根据 abbreviation 批量获取 schoolData
    if (abbreviations.isEmpty) return [];

    final schoolDataFutures = abbreviations.map((abbr) {
      return firestore.collection('schoolData').doc(abbr).get();
    }).toList();

    final docs = await Future.wait(schoolDataFutures);

    final List<DataBase> schoolList = docs
        .where((doc) => doc.exists)
        // .map((doc) => _fromFirestoreData(doc.data()!))
        .map((doc) => DataBase.fromJson(doc.data()!))
        .toList();

    return schoolList;
  }

  Future<DataBase?> fetchSchoolDataByEmail(String email) async {
    final firestore = FirebaseFirestore.instance;

    // 1. 先在 schoolIndex 查找 ownerEmail
    final querySnapshot = await firestore
        .collection('schoolIndex')
        .where('ownerEmail', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    // 2. 获取 abbreviation
    final abbreviation = querySnapshot.docs.first.id;

    // 3. 再获取 schoolData
    final schoolDoc = await firestore.collection('schoolData').doc(abbreviation).get();

    if (!schoolDoc.exists) return null;

    return DataBase.fromJson(schoolDoc.data()!);
    // return _fromFirestoreData(schoolDoc.data()!);
  }

  Future<void> createSchoolData({
    required String userEmail,
    required DataBase schoolData,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final abbreviation = schoolData.abbreviation();

    // 索引文档引用
    final indexRef = firestore.collection('schoolIndex').doc(abbreviation);
    final schoolRef = firestore.collection('schoolData').doc(abbreviation);

    await firestore.runTransaction((txn) async {
      // 1. 检查 abbreviation 是否已存在
      final indexSnap = await txn.get(indexRef);
      if (indexSnap.exists) {
        throw Exception('abbreviation "$abbreviation" has already been used！');
      }

      // 2. 检查邮箱是否已有学校
      final emailQuery = await firestore
          .collection('schoolIndex')
          .where('ownerEmail', isEqualTo: userEmail)
          .get();
      if (emailQuery.docs.isNotEmpty) {
        throw Exception('This email has been linked to another school\'s data.');
      }

      // 3. 写入 schoolData
      txn.set(schoolRef, schoolData.toJson());

      // 4. 写入索引
      txn.set(indexRef, {
        'ownerEmail': userEmail,
        'isSearchable': false,
      });
    });
  }

  Future<void> updateSchoolData({
    required String userEmail,
    required DataBase newData,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final newAbbr = newData.abbreviation();

    await firestore.runTransaction((txn) async {
      // 1. 查找旧的 schoolIndex 文档
      final querySnap = await firestore
          .collection('schoolIndex')
          .where('ownerEmail', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (querySnap.docs.isEmpty) {
        throw Exception('Update failed');
      }

      final oldIndexSnap = querySnap.docs.first;
      final oldAbbr = oldIndexSnap.id;
      final oldData = oldIndexSnap.data();

      // 2. 检查新 abbreviation 是否被占用（如果修改了）
      if (newAbbr != oldAbbr) {
        final newIndexSnap = await txn.get(firestore.collection('schoolIndex').doc(newAbbr));
        if (newIndexSnap.exists) {
          throw Exception('Abbreviation has already been used');
        }
      }

      final oldSchoolRef = firestore.collection('schoolData').doc(oldAbbr);
      final newSchoolRef = firestore.collection('schoolData').doc(newAbbr);
      final newIndexRef = firestore.collection('schoolIndex').doc(newAbbr);

      // 3. 写入新的 schoolData
      txn.set(newSchoolRef, newData.toJson());

      // 4. 写入新的 schoolIndex
      txn.set(newIndexRef, {
        'ownerEmail': userEmail,
        'isSearchable': oldData['isSearchable'] ?? false,
      });

      // 5. 删除旧文档（如果 abbreviation 改了）
      if (newAbbr != oldAbbr) {
        txn.delete(oldSchoolRef);
        txn.delete(firestore.collection('schoolIndex').doc(oldAbbr));
      }
    });
  }

  String getCurrentUserEmail() {
    try {
      return FirebaseAuth.instance.currentUser?.email??'';
    } catch (e) {
      return '';
    }

  }

  Future<bool> signInWithGoogle() async {
    // 触发 Google 登录
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // 获取 token
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // 构造凭证
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    currentUserEmail = userCredential.user?.email??'';

    return (currentUserEmail??'') != '';
  }

  Future<void> signOutFromGoogle() async {
    try {
      // 退出 Firebase 登录
      await FirebaseAuth.instance.signOut();

      // 退出 Google 登录（仅登出，不清除授权）
      await GoogleSignIn().signOut();

      currentUserEmail = '';
      debugPrint('已登出 Google 帐号');
    } catch (e) {
      debugPrint('登出失败: $e');
    }
  }


  /// 上传公共 BreakoutDays
  Future<void> uploadPublicBreakoutDays({
    required Map<DateTime, List<String>> days,
    required String updatedBy,
  }) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('breakout_days').doc('public').set({
      'days': _encodeEvents(days),
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'updatedBy': updatedBy,
    });
  }

  /// 日期键序列化
  Map<String, List<String>> _encodeEvents(Map<DateTime, List<String>> events) {
    final Map<String, List<String>> result = {};
    events.forEach((key, value) {
      result[key.toIso8601String()] = value;
    });
    return result;
  }

  /// 读取公共 BreakoutDays
  Future<Map<DateTime, List<String>>> fetchPublicBreakoutDays() async {
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('breakout_days').doc('public').get();
    if (!doc.exists) return {};
    final data = doc.data();
    if (data == null || data['days'] == null) return {};
    final Map<DateTime, List<String>> events = {};
    data['days'].forEach((key, value) {
      events[DateTime.parse(key)] = List<String>.from(value);
    });
    return events;
  }

  /// 上传学校自定义 BreakoutDays
  Future<void> uploadSchoolBreakoutDays({
    required String abbreviation,
    required List<Map<String, dynamic>> days,
    required String updatedBy,
  }) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('breakout_days').doc(abbreviation).set({
      'days': days,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'updatedBy': updatedBy,
    });
  }

}