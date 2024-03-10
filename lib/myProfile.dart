import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploro/placeSelectionPage.dart';
import 'package:exploro/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'homePage.dart';
import 'main.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

 List<dynamic>? selectedPlaces;
 String? name, email, phonenumber, selectedState, imageUrl;

  Future<void> getUsers() async {
    try {
      // Get logged-in user's selected places
      user = FirebaseAuth.instance.currentUser;
      String loggedInUserId = user!.uid;

      DocumentSnapshot loggedInUserSnapshot = await FirebaseFirestore.instance.collection('users').doc(loggedInUserId).get();
      setState(() {
        selectedPlaces = loggedInUserSnapshot.get("selectedPlaces");
        name = loggedInUserSnapshot.get("displayName");
        email = loggedInUserSnapshot.get("email");
        phonenumber = loggedInUserSnapshot.get("phoneno");
        selectedState = loggedInUserSnapshot.get("selectedState");
        imageUrl = loggedInUserSnapshot.get("imageUrl");
      });


      print('Users retrieved successfully!');
    } catch (e) {
      print('Error getting users: $e');
    }
  }


  List<IconMenu> iconList = [
    IconMenu(imageName: "images/mountains.jpeg", titleIcon: "Mountains"),
    IconMenu(imageName: "images/snow.jpeg", titleIcon: "Snow"),
    IconMenu(imageName: "images/desert.jpg", titleIcon: "Desert"),
    IconMenu(imageName: "images/waterfall.jpeg", titleIcon: "Waterfall"),
    IconMenu(imageName: "images/beach.jpeg", titleIcon: "Beach"),
    IconMenu(imageName: "images/city.jpg", titleIcon: "City"),
  ];


  @override
  void initState() {
    getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            //change your color here
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            // statusBarColor: Color(0xff0c18a0),
            // systemNavigationBarColor: Color(0xff0c18a0),

          ),
          backgroundColor: const Color(0xffFEBD2F),
          elevation: 0,
        ),
        body:
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xffFEBD2F)),
                    ),
                  ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${name}", style: TextStyle(
                                fontFamily: "ColabBold",
                                fontSize: 25,
                                color: Colors.white
                            ),),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.mail_outline, color: Colors.white, size: 15,),
                                const SizedBox(width: 4,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "${email}" ?? "__",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15, fontFamily: "ColabRegular"),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(MdiIcons.whatsapp, color: Colors.white, size: 15,),
                                const SizedBox(width: 4,),
                                Text(
                                  "${phonenumber}" ?? "__",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15, fontFamily: "ColabRegular"),
                                )
                              ],
                            ),


                          ],)),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor:Theme.of(context).colorScheme.primary,
                              radius: 50,
                              backgroundImage:  NetworkImage(imageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlx4gSigbjdiYfwDUhjdOND8yX-4rbzI0l0NH7CG_XDQ&s"),
                            ),

                          ],
                        )
                      ],
                    ),),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child:SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:Colors.grey.shade300,
                                        blurRadius: 7,
                                        spreadRadius: 0
                                    )
                                  ]
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("State you want to visit, now", style: TextStyle(
                                      fontFamily: "ColabRegular",
                                      fontSize: 15
                                  ),),
                                  const SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("images/location.png", height: 40, width: 40,),
                                      Text("${selectedState}", style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "ColabBold"
                                      ),)
                                    ],
                                  ),
                                ],
                              )
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Prefered Places", style: TextStyle(
                              fontFamily: "ColabBold",
                              fontSize: 15
                          ),),

                          selectedPlaces == null ?
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(padding: EdgeInsets.only(bottom: 20),
                            child:GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 25,
                                mainAxisSpacing: 20,
                              ) ,
                              itemCount:selectedPlaces!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Stack(
                                    children: [
                                      // Blurred Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.0),
                                              image: DecorationImage(
                                                image: AssetImage(iconList[index].imageName),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Check Icon
                                      // if (selectedItems[index])
                                      //   Center(
                                      //     child:ScaleTransition(scale: scaleAnimation,
                                      //     child: SizeTransition(sizeFactor: checkAnimation,axis: Axis.horizontal, axisAlignment: -1,
                                      //     child: Icon(Icons.check, color: Colors.green, size: 100,),),)
                                      //   ),
                                      // Text at bottom
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                            color: Colors.black.withOpacity(0.5),
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [Text(
                                                selectedPlaces![index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "ColabRegular",
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),

                                              ],
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ) ,)


                        ],
                      ),
                    ) ,
                  )

                ],
              )

            ],
          ),
        )
    );
  }
}
