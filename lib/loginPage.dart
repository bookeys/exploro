import 'package:exploro/registerPage.dart';
import 'package:exploro/ui_components/input_fields.dart';
import 'package:exploro/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'exceptions.dart';
import 'page_route.dart';

class LoginModel{
  String email = "";
  String password = "";
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final LoginModel login = LoginModel();
  bool validated = false;
  bool loginClicked = false;
  bool isLoading = false;
  var validate = [false, false];
  String errorMessage = "";
  var key1 = GlobalKey<FormState>();

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        print('User logged in successfully! User ID: ${user.uid}');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sucessfully Logged in')));
      } else {
        print('User email is not verified. Please verify your email.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User email is not verified. Please verify your email.')));
      }

    } catch (e) {
      print('Error logging in user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:  Form(
          key: key1,
          child: Container(
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
                  child: Image.asset("images/exploro.png", height: 50,),
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
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                                  onChanged: (value){
                                    login.email = value;
                                    setState(() {
                                      validate[0] = validateEmailBool(value);
                                    });
                                    if (validated){
                                      key1.currentState!.validate();
                                    }
                                  },
                                  validated: validate[0],
                                  validator: (value){
                                    validated = true;
                                    if(value!.isEmpty){
                                      return "Email is required";
                                    }
                                    return validateEmail(value);
                                  },
                                ),
                                ExploroTextBox(
                                  hintText: "Password",
                                  obscureText: true,
                                  onChanged: (value) {
                                    login.password = value;
                                    setState(() {
                                      validate[1] = value.isNotEmpty;
                                    });

                                    if (validated) {
                                      setState(() {
                                        key1.currentState!.validate();
                                      });
                                    }
                                  },
                                  validated: validate[1],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password is required.";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal:0),
                                          child:  ElevatedButton(

                                            onPressed: !validate.contains(false) ?
                                                () {
                                              if (!loginClicked) {
                                                setState(() {
                                                  errorMessage = "";
                                                });
                                                // FocusManager.instance.primaryFocus?.unfocus();

                                                if (key1.currentState!.validate()) {
                                                  setState(() {
                                                    loginClicked = !loginClicked;
                                                  });
                                                  isLoading = true;
                                                  Future loginF;
                                                  loginF =
                                                      loginUser(login.email, login.password);
                                                  setState(() {
                                                    debugPrint("====================value from login =======================");
                                                    loginClicked = !loginClicked;
                                                  });
                                                  loginF.then((value) {

                                                  }).catchError((error) {
                                                    setState(() {
                                                      debugPrint("Error $error");
                                                      loginClicked = !loginClicked;
                                                      errorMessage =
                                                          exceptionToProperString(
                                                              error.toString());
                                                    });
                                                  });
                                                }
                                              }
                                            }   : null,
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)),
                                                backgroundColor: Color(0xffFEBD2F),
                                                textStyle: const TextStyle(
                                                    fontFamily: "ColabBold", fontSize: 19)),
                                            child: !loginClicked
                                                ? const Text(
                                              "Login",
                                              style: TextStyle(fontFamily: "GilroyMedium"),
                                            )
                                                : const SizedBox(
                                                height: 23,
                                                width: 23,
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 1.5,
                                                )),

                                          )
                                      ))
                                ]),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width:70,
                                    ),
                                    Text("Don't have account? ", style: TextStyle(
                                        fontFamily:"ColabRegular",
                                        fontSize: 15
                                    ),),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushReplacement(
                                          HorizontalSlideRoute(
                                            builder: (_, __, ___) {
                                              return const RegisterPage();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text("Sign up", style: TextStyle(
                                          fontFamily:"ColabRegular",
                                          fontSize: 15,
                                          color: Color(0xffFEBD2F)
                                      ),),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ))
              ],
            ),
          ),
        )
      )
    );
  }
}
