import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploro/homePage.dart';
import 'package:exploro/imageSelectionPage.dart';
import 'package:exploro/placeSelectionPage.dart';
import 'package:exploro/splashScreen.dart';
import 'package:exploro/ui_components/stateSelection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

User? user;
UserCredential? userCredential;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCbGFfjns-U8-Uw_2JIPwmnuyVAaWSFp7c",
        appId: "1:735931683557:android:2f8167d0ace39fe2117a0c",
        messagingSenderId: "735931683557",
        projectId: "exploro-66c4a",
        storageBucket:"exploro-66c4a.appspot.com"
    )
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

  Future<void> checkLoggedInUser() async {
    user = FirebaseAuth.instance.currentUser;
    //debugPrint("Data of USer " + user!.uid.toString());
    if (user != null) {
      debugPrint("User is not null :- ");
      try{
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get();
        // Check if the user has selectedPlaces
        Map<String, dynamic>? userDataMap = userData.data() as Map<String, dynamic>?;
        bool hasSelectedPlaces = userData.exists && userDataMap != null && userDataMap['selectedPlaces'] != null;
        bool hasSelectedState = userData.exists && userDataMap != null && userDataMap['selectedState'] != null;
        bool hasUploadedImage = userData.exists && userDataMap != null && userDataMap['imageUrl'] != null;

        if(hasSelectedPlaces && hasSelectedState && hasUploadedImage){
          setState(() {
            widgettoRender = HomePage();
          });
        }else if(hasSelectedPlaces && hasSelectedState){
          setState(() {
            widgettoRender = ImageUploadPage();
          });

        }else if(hasSelectedPlaces){
          setState(() {
            widgettoRender = StateSelection();
          });

        }else{
          setState(() {
            widgettoRender = PlaceSelectionPage();
          });
        }

      }catch(e){
        debugPrint("Exception while loading the app $e");
      }
    } else{
      setState(() {
        widgettoRender = SplashScreen();
      });
    }
  }

  @override
  void initState() {
    checkLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: widgettoRender,
    );
  }
}
