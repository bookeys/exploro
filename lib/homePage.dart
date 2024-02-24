import 'package:exploro/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCard {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  UserCard({required this.name, required this.email, required this.phone, required this.imageUrl});
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserCard?> userCards= [];


  void _openWhatsApp(String phoneNumber) async{
    String url = 'https://wa.me/$phoneNumber';
    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }else{
      throw 'Could not launch $url';
    }
  }

  Future<void> getUsers() async {
    try {
      // Get logged-in user's selected places
      user = FirebaseAuth.instance.currentUser;
      String loggedInUserId = user!.uid;

      DocumentSnapshot loggedInUserSnapshot = await FirebaseFirestore.instance.collection('users').doc(loggedInUserId).get();
      List<dynamic> selectedPlaces = (loggedInUserSnapshot.data() as Map<String, dynamic>)['selectedPlaces'] ?? [];

      // Query users where selected places array contains at least one value from logged-in user's selected places
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users')
          .where('selectedPlaces', arrayContainsAny: selectedPlaces)
          .get();

      List<UserCard?> users = usersSnapshot.docs.map((doc) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        if (doc.id != loggedInUserId) { // Exclude the logged-in user
          return UserCard(
            name: userData['displayName'] ?? '',
            email: userData['email'] ?? '',
            phone: userData['phoneno'] ?? '',
            imageUrl: userData['imageUrl'] ?? '',
          );
        } else {
          return null; // Skip the logged-in user
        }
      }).where((user) => user != null).toList(); // Filter out null entries

      setState(() {
        userCards = users;
      });

      print('Users retrieved successfully!');
    } catch (e) {
      print('Error getting users: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('exploro', style: TextStyle(
          color: Colors.black,
          fontFamily: "ColabBold"
        ),),
      ),
      body:
          userCards != null ?
              Container(
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: userCards.length,
                  itemBuilder: (context, index) {
                    return
                    Padding(padding: EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), // Adjust the radius as needed
                                    topRight: Radius.circular(10.0), ),
                                  color: Colors.orange,
                                ),
                                width: 400,
                                height: 100,

                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                  NetworkImage(userCards[index]?.imageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlx4gSigbjdiYfwDUhjdOND8yX-4rbzI0l0NH7CG_XDQ&s"),
                                ),
                              )

                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 0, 2),
                            child: Text(userCards[index]!.name, style: TextStyle(
                                color: Colors.black,
                                fontFamily: "ColabBold",
                                fontSize: 18
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 2),
                            child: Text(userCards[index]!.email, style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontFamily: "ColabRegular"
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 2),
                            child:
                            InkWell(
                              onTap: (){
                                _openWhatsApp(userCards[index]!.phone);
                              },
                              child: Text(userCards[index]!.phone, style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontFamily: "ColabRegular"
                              ),),
                            )
                          )
                        ],
                      ),
                    ),);
                  },
                ),
              ):
      CircularProgressIndicator(),
    );
  }
}
