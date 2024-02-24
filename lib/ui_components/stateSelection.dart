import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploro/homePage.dart';
import 'package:flutter/material.dart';

import '../imageSelectionPage.dart';
import '../main.dart';
import '../page_route.dart';

class StateMenu {
  final String imageName;
  final String titleIcon;
  StateMenu({required this.imageName,  required this.titleIcon});
}

List<StateMenu> stateList = [
  StateMenu(imageName: "images/mumbai.png", titleIcon: "Maharashtra"),
  StateMenu(imageName: "images/delhi.png", titleIcon: "Delhi"),
  StateMenu(imageName: "images/chennai.png", titleIcon: "Tamil Nadu"),
  StateMenu(imageName: "images/hyd.png", titleIcon: "Telangana"),
  StateMenu(imageName: "images/ahd.png", titleIcon: "Gujarat"),
  StateMenu(imageName: "images/banglore.png", titleIcon: "Karnataka"),
  StateMenu(imageName: "images/kolk.png", titleIcon: "West Bengal"),
];


class StateSelection extends StatefulWidget {
  const StateSelection({super.key});

  @override
  State<StateSelection> createState() => _StateSelectionState();
}

class _StateSelectionState extends State<StateSelection> {

  List<String> states = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu"
    "Telanaga",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
  ];

  String? selectedState;

  Future<void> addState(String selectedState) async{
    try {
      await FirebaseFirestore.instance.collection('users').doc(userCredential!.user?.uid).set({
        'selectedState': selectedState,
      }, SetOptions(merge: true));
      //await AccessTokenStorage.savePreference(preference);// Merge the new data with existing document
      print('Selected State stored successfully!');
      Navigator.of(context).pushReplacement(
        HorizontalSlideRoute(
          builder: (_, __, ___) {
            return ImageUploadPage();
          },
        ),
      );

    } catch (e) {
      print('Error storing selected places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: const Text("Select 1 state you would like to visit", style: TextStyle(fontFamily: "ColabRegular", fontSize: 18),),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,

                    ),
                    itemCount: stateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final state = stateList[index];
                      return InkWell(
                        onTap: (){
                          selectedState = state.titleIcon;
                          addState(selectedState!);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45, width: 0.4), // Add border
                          ),
                          child:Column(
                            children: [
                              Image.asset(stateList[index].imageName, height: 100, width: 50,),
                              Text(
                                stateList[index].titleIcon,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "ColabLight",
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),),
                      );
                    },
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black45,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: states.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(
                    height: 0.4,
                    color: Colors.black45,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final state = states[index];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          selectedState = state;
                          addState(selectedState!);
                        });
                      }, title: Text(states[index], style: TextStyle(
                          fontFamily: "ColabLight"
                      ),),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

