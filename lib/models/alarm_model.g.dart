// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlarmModelCollection on Isar {
  IsarCollection<AlarmModel> get alarmModels => this.collection();
}

const AlarmModelSchema = CollectionSchema(
  name: r'AlarmModel',
  id: 1796575337475990193,
  properties: {
    r'alarmID': PropertySchema(
      id: 0,
      name: r'alarmID',
      type: IsarType.string,
    ),
    r'alarmNextDateTime': PropertySchema(
      id: 1,
      name: r'alarmNextDateTime',
      type: IsarType.string,
    ),
    r'alarmSettingsDateTime': PropertySchema(
      id: 2,
      name: r'alarmSettingsDateTime',
      type: IsarType.string,
    ),
    r'alarmSettingsId': PropertySchema(
      id: 3,
      name: r'alarmSettingsId',
      type: IsarType.long,
    ),
    r'alarmTime': PropertySchema(
      id: 4,
      name: r'alarmTime',
      type: IsarType.string,
    ),
    r'androidFullScreenIntent': PropertySchema(
      id: 5,
      name: r'androidFullScreenIntent',
      type: IsarType.bool,
    ),
    r'assetAudioPath': PropertySchema(
      id: 6,
      name: r'assetAudioPath',
      type: IsarType.string,
    ),
    r'days': PropertySchema(
      id: 7,
      name: r'days',
      type: IsarType.boolList,
    ),
    r'enableNotificationOnKill': PropertySchema(
      id: 8,
      name: r'enableNotificationOnKill',
      type: IsarType.bool,
    ),
    r'fadeDuration': PropertySchema(
      id: 9,
      name: r'fadeDuration',
      type: IsarType.long,
    ),
    r'isEnabled': PropertySchema(
      id: 10,
      name: r'isEnabled',
      type: IsarType.bool,
    ),
    r'label': PropertySchema(
      id: 11,
      name: r'label',
      type: IsarType.string,
    ),
    r'loopAudio': PropertySchema(
      id: 12,
      name: r'loopAudio',
      type: IsarType.bool,
    ),
    r'minutesSinceMidnight': PropertySchema(
      id: 13,
      name: r'minutesSinceMidnight',
      type: IsarType.long,
    ),
    r'notificationBody': PropertySchema(
      id: 14,
      name: r'notificationBody',
      type: IsarType.string,
    ),
    r'notificationTitle': PropertySchema(
      id: 15,
      name: r'notificationTitle',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 16,
      name: r'type',
      type: IsarType.long,
    ),
    r'vibrate': PropertySchema(
      id: 17,
      name: r'vibrate',
      type: IsarType.bool,
    ),
    r'volume': PropertySchema(
      id: 18,
      name: r'volume',
      type: IsarType.double,
    )
  },
  estimateSize: _alarmModelEstimateSize,
  serialize: _alarmModelSerialize,
  deserialize: _alarmModelDeserialize,
  deserializeProp: _alarmModelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _alarmModelGetId,
  getLinks: _alarmModelGetLinks,
  attach: _alarmModelAttach,
  version: '3.1.0+1',
);

int _alarmModelEstimateSize(
  AlarmModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.alarmID.length * 3;
  {
    final value = object.alarmNextDateTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.alarmSettingsDateTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.alarmTime.length * 3;
  bytesCount += 3 + object.assetAudioPath.length * 3;
  bytesCount += 3 + object.days.length;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.notificationBody.length * 3;
  bytesCount += 3 + object.notificationTitle.length * 3;
  return bytesCount;
}

void _alarmModelSerialize(
  AlarmModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alarmID);
  writer.writeString(offsets[1], object.alarmNextDateTime);
  writer.writeString(offsets[2], object.alarmSettingsDateTime);
  writer.writeLong(offsets[3], object.alarmSettingsId);
  writer.writeString(offsets[4], object.alarmTime);
  writer.writeBool(offsets[5], object.androidFullScreenIntent);
  writer.writeString(offsets[6], object.assetAudioPath);
  writer.writeBoolList(offsets[7], object.days);
  writer.writeBool(offsets[8], object.enableNotificationOnKill);
  writer.writeLong(offsets[9], object.fadeDuration);
  writer.writeBool(offsets[10], object.isEnabled);
  writer.writeString(offsets[11], object.label);
  writer.writeBool(offsets[12], object.loopAudio);
  writer.writeLong(offsets[13], object.minutesSinceMidnight);
  writer.writeString(offsets[14], object.notificationBody);
  writer.writeString(offsets[15], object.notificationTitle);
  writer.writeLong(offsets[16], object.type);
  writer.writeBool(offsets[17], object.vibrate);
  writer.writeDouble(offsets[18], object.volume);
}

AlarmModel _alarmModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlarmModel(
    alarmID: reader.readString(offsets[0]),
    alarmNextDateTime: reader.readStringOrNull(offsets[1]),
    alarmSettingsDateTime: reader.readStringOrNull(offsets[2]),
    alarmSettingsId: reader.readLong(offsets[3]),
    alarmTime: reader.readString(offsets[4]),
    androidFullScreenIntent: reader.readBool(offsets[5]),
    assetAudioPath: reader.readString(offsets[6]),
    days: reader.readBoolList(offsets[7]) ?? [],
    enableNotificationOnKill: reader.readBool(offsets[8]),
    fadeDuration: reader.readLong(offsets[9]),
    isEnabled: reader.readBoolOrNull(offsets[10]) ?? true,
    label: reader.readString(offsets[11]),
    loopAudio: reader.readBool(offsets[12]),
    minutesSinceMidnight: reader.readLong(offsets[13]),
    notificationBody: reader.readString(offsets[14]),
    notificationTitle: reader.readString(offsets[15]),
    type: reader.readLongOrNull(offsets[16]) ?? 0,
    vibrate: reader.readBool(offsets[17]),
    volume: reader.readDoubleOrNull(offsets[18]),
  );
  object.isarId = id;
  return object;
}

P _alarmModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBoolList(offset) ?? []) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _alarmModelGetId(AlarmModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _alarmModelGetLinks(AlarmModel object) {
  return [];
}

void _alarmModelAttach(IsarCollection<dynamic> col, Id id, AlarmModel object) {
  object.isarId = id;
}

extension AlarmModelQueryWhereSort
    on QueryBuilder<AlarmModel, AlarmModel, QWhere> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlarmModelQueryWhere
    on QueryBuilder<AlarmModel, AlarmModel, QWhereClause> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AlarmModelQueryFilter
    on QueryBuilder<AlarmModel, AlarmModel, QFilterCondition> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alarmID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alarmID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alarmID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alarmID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmID',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alarmID',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alarmNextDateTime',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alarmNextDateTime',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmNextDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmNextDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmNextDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmNextDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alarmNextDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alarmNextDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alarmNextDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alarmNextDateTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmNextDateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmNextDateTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alarmNextDateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alarmSettingsDateTime',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alarmSettingsDateTime',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmSettingsDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmSettingsDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmSettingsDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmSettingsDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alarmSettingsDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alarmSettingsDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alarmSettingsDateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alarmSettingsDateTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmSettingsDateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsDateTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alarmSettingsDateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmSettingsId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmSettingsId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmSettingsId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmSettingsIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmSettingsId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alarmTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alarmTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alarmTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> alarmTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alarmTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmTime',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      alarmTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alarmTime',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      androidFullScreenIntentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'androidFullScreenIntent',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetAudioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assetAudioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assetAudioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assetAudioPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assetAudioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assetAudioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assetAudioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assetAudioPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetAudioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      assetAudioPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assetAudioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      daysElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'days',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      daysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      daysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      enableNotificationOnKillEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enableNotificationOnKill',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      fadeDurationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fadeDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      fadeDurationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fadeDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      fadeDurationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fadeDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      fadeDurationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fadeDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isEnabledEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> loopAudioEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loopAudio',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      minutesSinceMidnightEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minutesSinceMidnight',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      minutesSinceMidnightGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minutesSinceMidnight',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      minutesSinceMidnightLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minutesSinceMidnight',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      minutesSinceMidnightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minutesSinceMidnight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationBody',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationBody',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationBody',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      notificationTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> typeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> typeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> typeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> typeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> vibrateEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibrate',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> volumeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'volume',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
      volumeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'volume',
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> volumeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> volumeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> volumeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'volume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> volumeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'volume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension AlarmModelQueryObject
    on QueryBuilder<AlarmModel, AlarmModel, QFilterCondition> {}

extension AlarmModelQueryLinks
    on QueryBuilder<AlarmModel, AlarmModel, QFilterCondition> {}

extension AlarmModelQuerySortBy
    on QueryBuilder<AlarmModel, AlarmModel, QSortBy> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAlarmID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmID', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAlarmIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmID', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAlarmNextDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmNextDateTime', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAlarmNextDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmNextDateTime', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAlarmSettingsDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsDateTime', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAlarmSettingsDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsDateTime', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAlarmSettingsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsId', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAlarmSettingsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsId', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAlarmTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAlarmTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAndroidFullScreenIntent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'androidFullScreenIntent', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAndroidFullScreenIntentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'androidFullScreenIntent', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByAssetAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetAudioPath', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByAssetAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetAudioPath', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByEnableNotificationOnKill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableNotificationOnKill', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByEnableNotificationOnKillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableNotificationOnKill', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByFadeDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fadeDuration', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByFadeDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fadeDuration', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByIsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByIsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByLoopAudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loopAudio', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByLoopAudioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loopAudio', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByMinutesSinceMidnight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesSinceMidnight', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByMinutesSinceMidnightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesSinceMidnight', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByNotificationBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByNotificationBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByNotificationTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      sortByNotificationTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByVibrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByVibrateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.desc);
    });
  }
}

extension AlarmModelQuerySortThenBy
    on QueryBuilder<AlarmModel, AlarmModel, QSortThenBy> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAlarmID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmID', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAlarmIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmID', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAlarmNextDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmNextDateTime', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAlarmNextDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmNextDateTime', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAlarmSettingsDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsDateTime', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAlarmSettingsDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsDateTime', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAlarmSettingsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsId', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAlarmSettingsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmSettingsId', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAlarmTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAlarmTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmTime', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAndroidFullScreenIntent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'androidFullScreenIntent', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAndroidFullScreenIntentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'androidFullScreenIntent', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByAssetAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetAudioPath', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByAssetAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetAudioPath', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByEnableNotificationOnKill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableNotificationOnKill', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByEnableNotificationOnKillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableNotificationOnKill', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByFadeDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fadeDuration', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByFadeDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fadeDuration', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEnabled', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByLoopAudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loopAudio', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByLoopAudioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loopAudio', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByMinutesSinceMidnight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesSinceMidnight', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByMinutesSinceMidnightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesSinceMidnight', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByNotificationBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByNotificationBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationBody', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByNotificationTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
      thenByNotificationTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationTitle', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByVibrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByVibrateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrate', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.desc);
    });
  }
}

extension AlarmModelQueryWhereDistinct
    on QueryBuilder<AlarmModel, AlarmModel, QDistinct> {
  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByAlarmID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByAlarmNextDateTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmNextDateTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct>
      distinctByAlarmSettingsDateTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmSettingsDateTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByAlarmSettingsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmSettingsId');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByAlarmTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct>
      distinctByAndroidFullScreenIntent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'androidFullScreenIntent');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByAssetAudioPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assetAudioPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'days');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct>
      distinctByEnableNotificationOnKill() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enableNotificationOnKill');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByFadeDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fadeDuration');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByIsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEnabled');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByLoopAudio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loopAudio');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct>
      distinctByMinutesSinceMidnight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minutesSinceMidnight');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByNotificationBody(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationBody',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByNotificationTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationTitle',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByVibrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibrate');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'volume');
    });
  }
}

extension AlarmModelQueryProperty
    on QueryBuilder<AlarmModel, AlarmModel, QQueryProperty> {
  QueryBuilder<AlarmModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AlarmModel, String, QQueryOperations> alarmIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmID');
    });
  }

  QueryBuilder<AlarmModel, String?, QQueryOperations>
      alarmNextDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmNextDateTime');
    });
  }

  QueryBuilder<AlarmModel, String?, QQueryOperations>
      alarmSettingsDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmSettingsDateTime');
    });
  }

  QueryBuilder<AlarmModel, int, QQueryOperations> alarmSettingsIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmSettingsId');
    });
  }

  QueryBuilder<AlarmModel, String, QQueryOperations> alarmTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmTime');
    });
  }

  QueryBuilder<AlarmModel, bool, QQueryOperations>
      androidFullScreenIntentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'androidFullScreenIntent');
    });
  }

  QueryBuilder<AlarmModel, String, QQueryOperations> assetAudioPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assetAudioPath');
    });
  }

  QueryBuilder<AlarmModel, List<bool>, QQueryOperations> daysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'days');
    });
  }

  QueryBuilder<AlarmModel, bool, QQueryOperations>
      enableNotificationOnKillProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enableNotificationOnKill');
    });
  }

  QueryBuilder<AlarmModel, int, QQueryOperations> fadeDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fadeDuration');
    });
  }

  QueryBuilder<AlarmModel, bool, QQueryOperations> isEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEnabled');
    });
  }

  QueryBuilder<AlarmModel, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<AlarmModel, bool, QQueryOperations> loopAudioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loopAudio');
    });
  }

  QueryBuilder<AlarmModel, int, QQueryOperations>
      minutesSinceMidnightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minutesSinceMidnight');
    });
  }

  QueryBuilder<AlarmModel, String, QQueryOperations>
      notificationBodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationBody');
    });
  }

  QueryBuilder<AlarmModel, String, QQueryOperations>
      notificationTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationTitle');
    });
  }

  QueryBuilder<AlarmModel, int, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<AlarmModel, bool, QQueryOperations> vibrateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibrate');
    });
  }

  QueryBuilder<AlarmModel, double?, QQueryOperations> volumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'volume');
    });
  }
}
