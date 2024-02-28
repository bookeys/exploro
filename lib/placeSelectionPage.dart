import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploro/loginPage.dart';
import 'package:exploro/main.dart';
import 'package:exploro/page_route.dart';
import 'package:exploro/ui_components/stateSelection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IconMenu {
  final String imageName;
  final String titleIcon;
  IconMenu({required this.imageName,  required this.titleIcon});
}

List<IconMenu> iconList = [
  IconMenu(imageName: "images/mountains.jpeg", titleIcon: "Mountains"),
  IconMenu(imageName: "images/snow.jpeg", titleIcon: "Snow"),
  IconMenu(imageName: "images/desert.jpg", titleIcon: "Desert"),
  IconMenu(imageName: "images/waterfall.jpeg", titleIcon: "Waterfall"),
  IconMenu(imageName: "images/beach.jpeg", titleIcon: "Beach"),
  IconMenu(imageName: "images/city.jpg", titleIcon: "City"),
];

class PlaceSelectionPage extends StatefulWidget {
  const PlaceSelectionPage({super.key});

  @override
  State<PlaceSelectionPage> createState() => _PlaceSelectionPageState();
}

class _PlaceSelectionPageState extends State<PlaceSelectionPage> with TickerProviderStateMixin {

  late AnimationController scaleController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation = CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
  late Animation<double> checkAnimation = CurvedAnimation(parent: checkController, curve: Curves.linear);

  List<bool> selectedItems = List.filled(iconList.length, false);

  void toggleSelection(int index) {
    setState(() {
      selectedItems[index] = !selectedItems[index];
    });
  }

  bool isAtLeastThreeSelected() {
    int count = 0;
    for (bool isSelected in selectedItems) {
      if (isSelected) {
        count++;
        if (count >= 3) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> addPreferences(List<String> preference) async{
    try {
      await FirebaseFirestore.instance.collection('users').doc(userCredential!.user?.uid).set({
        'selectedPlaces': preference,
      }, SetOptions(merge: true));
      //await AccessTokenStorage.savePreference(preference);// Merge the new data with existing document
      print('Selected places stored successfully!');
      Navigator.of(context).pushReplacement(
        HorizontalSlideRoute(
          builder: (_, __, ___) {
            return const StateSelection();
          },
        ),
      );

    } catch (e) {
      print('Error storing selected places: $e');
    }
  }





  @override
  void initState() {
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
    super.initState();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(child:  Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tell us your preferences", style: TextStyle(fontFamily: "ColabRegular", fontSize: 20),),

                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                  ) ,
                  itemCount: iconList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        toggleSelection(index);
                        if (!selectedItems[index] && !isAtLeastThreeSelected()) {
                          toggleSelection(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('At least three items must be selected.'),
                            ),
                          );
                        }
                      },
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
                                    iconList[index].titleIcon,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "ColabRegular",
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: (selectedItems[index]) ?  Color(0xffFEBD2F) : Colors.transparent,
                                      child: (selectedItems[index]) ? Icon(Icons.check, color:  Colors.white, size: 20,) : null,
                                    )
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
      ),),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xffFEBD2F),
        onPressed: () {
          if (!isAtLeastThreeSelected()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('At least three items must be selected.'),
              ),
            );
          } else {
            List<String> selectedNames = [];
            for (int i = 0; i < selectedItems.length; i++) {
              if (selectedItems[i]) {
                selectedNames.add(iconList[i].titleIcon);
              }
            }
            addPreferences(selectedNames);
            print(selectedNames); // Output selected item names to console
          }
        },
        child: Icon(Icons.check, color: Colors.white,),
      ),
    );
  }
}




