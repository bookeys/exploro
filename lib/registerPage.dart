import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploro/loginPage.dart';
import 'package:exploro/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exploro/ui_components/input_fields.dart';
import 'exceptions.dart';
import 'page_route.dart';
class Users{
  String email = "";
  String phoneNo = "";
  String password = "";
  String name = "";

  Map<String, String> getMap() {
    return {
      "email": email,
      "phoneNo": phoneNo,
      "password": password,
      "displayName": name
    };
  }
}
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final Users userForm = Users();
  bool validated = false;
  bool loginClicked = false;
  bool isLoading = false;
  var validate = [false, false, false, false];
  String errorMessage = "";
  var key = GlobalKey<FormState>();

  Future<void> registerUser(String email, String password, String displayName, String phone) async {
    debugPrint("REgister name:- $displayName");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Created Successfully.We have sent a verification email')));

        Navigator.of(context).pushReplacement(
          HorizontalSlideRoute(
            builder: (_, __, ___) {
              return const LoginPage();
            },
          ),
        );
      });

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'displayName': displayName,
        'email': email,
        'phoneno': phone,
      });


      print('User registered successfully!');
    } catch (e) {
      print('Error registering user: $e');
    }
  }


  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.green;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffFEBD2F),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
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
              // isLoading == true ?
              // CircularProgressIndicator(
              //   color: Colors.black,
              //   strokeWidth: 2.5,
              // ): SizedBox(
              //   height: 0,
              // ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child:Form(
                    key: key,
                    child:  Container(
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
                                  "Register new account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "ColabBold",
                                      fontSize: 25),
                                ),
                                Text(
                                  "Please sign up for new account",
                                  style: TextStyle(color: Colors.grey, fontSize: 16,fontFamily: "ColabRegular",),
                                ),
                                SizedBox(
                                  height: 10,
                                ),ExploroTextBox(
                                  hintText: "Your name",
                                  onChanged: (value){
                                    userForm.name = value;
                                    setState(() {
                                      validate[0] = validateNameBool(value);
                                    });
                                    if (validated){
                                      key.currentState!.validate();
                                    }
                                  },
                                  validated: validate[0],
                                  validator: (value){
                                    validated = true;
                                    if(value!.isEmpty){
                                      return "Name is required";
                                    }
                                    return validateName(value);
                                  },
                                ),
                                ExploroTextBox(
                                  hintText: "Phone number",
                                  keyboardType: TextInputType.number,
                                  onChanged: (value){
                                    userForm.phoneNo = value;
                                    setState(() {
                                      validate[1] = validatePhoneBool(value);
                                    });
                                    if (validated){
                                      key.currentState!.validate();
                                    }
                                  },
                                  validated: validate[1],
                                  validator: (value){
                                    validated = true;
                                    if(value!.isEmpty){
                                      return "Phone is required";
                                    }
                                    return validatePhone(value);
                                  },
                                ),
                                ExploroTextBox(
                                  hintText: "Email",
                                  onChanged: (value){
                                    userForm.email = value;
                                    setState(() {
                                      validate[2] = validateEmailBool(value);
                                    });
                                    if (validated){
                                      key.currentState!.validate();
                                    }
                                  },
                                  validated: validate[2],
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
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (value) {
                                    userForm.password = value;
                                    setState(() {
                                      validate[3] = value.isNotEmpty;
                                    });

                                    if (validated) {
                                      setState(() {
                                        key.currentState!.validate();
                                      });
                                    }
                                  },
                                  validated: validate[3],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password is required.";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(

                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                    Text("By creating an account you agree to our \nterms and condition",maxLines: 3
                                      , style: TextStyle(
                                          fontFamily: "ColabLight"
                                      ),)
                                  ],
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal:0),
                                          child: ElevatedButton(

                                            onPressed: !validate.contains(false) ?
                                                () {
                                                  if (!loginClicked) {
                                                    setState(() {
                                                      errorMessage = "";
                                                    });
                                                    // FocusManager.instance.primaryFocus?.unfocus();

                                                    if (key.currentState!.validate()) {
                                                      setState(() {
                                                        loginClicked = !loginClicked;
                                                      });
                                                      isLoading = true;
                                                      Future loginF;
                                                      loginF =
                                                          registerUser(userForm.email, userForm.password, userForm.name, userForm.phoneNo);
                                                      setState(() {
                                                        debugPrint("====================value from login =======================");
                                                        loginClicked = !loginClicked;
                                                      });
                                                      loginF.then((value) {
                                                        // Navigator.of(context).pushReplacement(createRoute(const ReportsSection(outletId: "")));



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
                                    Text("Already have account? ", style: TextStyle(
                                        fontFamily:"ColabRegular",
                                        fontSize: 15
                                    ),),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushReplacement(
                                          HorizontalSlideRoute(
                                            builder: (_, __, ___) {
                                              return const LoginPage();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text("Sign in", style: TextStyle(
                                          fontFamily:"ColabRegular",
                                          fontSize: 15,
                                          color: Color(0xffFEBD2F)
                                      ),),
                                    )
                                  ],
                                ),


                              ],
                            ),
                          )),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
