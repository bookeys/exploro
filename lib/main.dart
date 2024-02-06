import 'package:exploro/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCbGFfjns-U8-Uw_2JIPwmnuyVAaWSFp7c",
        appId: "1:735931683557:android:2f8167d0ace39fe2117a0c",
        messagingSenderId: "735931683557",
        projectId: "exploro-66c4a")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget? widgettoRender;

  @override
  Widget build(BuildContext context) {
  widgettoRender = SplashScreen();
    return Scaffold(
      body: widgettoRender,
    );
  }
}
