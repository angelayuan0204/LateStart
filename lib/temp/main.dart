import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'settings.dart'; // Import the settings page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GetStorage _storage = GetStorage();
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() {
    setState(() {
      _language = _storage.read<String>('language') ?? 'English';
      debugPrint(_language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // Define the default brightness and colors
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 125, 92, 245),
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),

          // Use ColorScheme to define colors
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 125, 92, 245),
            secondary: const Color.fromARGB(255, 0, 0, 0),
            onPrimary: Colors.white, // Text color on primary color
            onSecondary: Colors.white, // Text color on secondary color
            surface: const Color(0xFF000000),
            onSurface: Colors.white, // Text color on background
          ),

          // Define the default font family
          fontFamily: 'arial',

          // Define the default `TextTheme`
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 125, 92, 245)),
            titleLarge: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 125, 92, 245)),
            bodyMedium: TextStyle(
                fontSize: 15.0,
                fontFamily: 'arial',
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        // home: const HomePage(), // Set the home page
        home: const SettingsPage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Settings'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
      ),
    );
  }
}
