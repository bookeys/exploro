import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Center(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to Exploro", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                  )
                        ),

                          onPressed: (){},
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      )
                  )
                ],
              )
            ],
          ),
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
