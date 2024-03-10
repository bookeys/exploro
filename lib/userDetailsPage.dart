import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homePage.dart';


class IconMenu {
  final String imageName;
  final String titleIcon;
  IconMenu({required this.imageName,  required this.titleIcon});
}


class UserDetailsPage extends StatelessWidget {
  final UserCard user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  void _openWhatsApp(String phoneNumber) async{
    String phone = '+91$phoneNumber';
    var whatsappUrl_android = 'whatsapp://send?phone='+phone+"&text=I found you through exploro and i found that our intrest are same, so can we plan a trip together";
    var whatsappUrl_ios = 'https://wa.me/phone?text=${Uri.parse("I found you through exploro and i found that our intrest are same, so can we plan a trip together")}';
    if(Platform.isAndroid){
      if(Platform.isAndroid){
        await launchUrl(Uri.parse(whatsappUrl_android));
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Unable to launch whatsapp")));

      }
    }else{
      if(await canLaunchUrl(Uri.parse(whatsappUrl_ios))){
        await launch(whatsappUrl_ios, forceSafariVC:false);
      }else{
       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Unable to launch whatsapp")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    List<IconMenu> iconList = [
      IconMenu(imageName: "images/mountains.jpeg", titleIcon: "Mountains"),
      IconMenu(imageName: "images/snow.jpeg", titleIcon: "Snow"),
      IconMenu(imageName: "images/desert.jpg", titleIcon: "Desert"),
      IconMenu(imageName: "images/waterfall.jpeg", titleIcon: "Waterfall"),
      IconMenu(imageName: "images/beach.jpeg", titleIcon: "Beach"),
      IconMenu(imageName: "images/city.jpg", titleIcon: "City"),
    ];

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
                              Text("${user.name}", style: TextStyle(
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
                                      "${user.email}" ?? "__",
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
                                    "${user.phone}" ?? "__",
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
                                backgroundImage:  NetworkImage(user?.imageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlx4gSigbjdiYfwDUhjdOND8yX-4rbzI0l0NH7CG_XDQ&s"),
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
                                    Text("State they want to visit, now", style: TextStyle(
                                        fontFamily: "ColabRegular",
                                        fontSize: 15
                                    ),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("images/location.png", height: 40, width: 40,),
                                        Text("${user.selectedState}", style: TextStyle(
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
                                    Text("Start Messaging,on Whatsapp ?", style: TextStyle(
                                        fontFamily: "ColabRegular",
                                        fontSize: 15
                                    ),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(MdiIcons.whatsapp,  size: 35, color: Colors.green,),
                                        Text("I found you through exploro and I\nfound that our intrest are same,\nso can we plan a trip together ?",
                                        maxLines: 4, style: TextStyle(fontSize: 13, fontFamily: "ColabRegular"),),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            IconButton(onPressed: (){
                                              _openWhatsApp(user.phone);
                                            }, icon: Icon(Icons.send_outlined, size: 20, color: Colors.green,),)
                                          ],
                                        )
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
                            Padding(padding: EdgeInsets.only(bottom: 20),
                            child:GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 25,
                                mainAxisSpacing: 20,
                              ) ,
                              itemCount:user.selectedPlaces.length,
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
                                                user.selectedPlaces[index],
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
