import 'package:exploro/ui_components/input_fields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffFEBD2F),
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Image.asset("images/logo.png", height: 60,),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "EXPLORO",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "ColabBold",
                    fontSize: 35),
              ),
              const SizedBox(
                height: 70,
              ),
              Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 6, 30, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "ColabBold",
                                    fontSize: 25),
                              ),
                              Text(
                                "Please log in to your account",
                                style: TextStyle(color: Colors.grey, fontSize: 16,fontFamily: "ColabRegular",),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ExploroTextBox(
                                hintText: "Email",

                              ),
                              ExploroTextBox(
                                hintText: "Password",
                                obscureText: true,
                              ),

                            ],
                          ),
                        )),
                  ))
            ],
          ),
        ),
      )
    );
  }
}
