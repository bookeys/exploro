import 'package:exploro/homePage.dart';
import 'package:exploro/page_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _imageFile;
  final picker = ImagePicker();
  bool _isUploading = false;

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImageAndSaveToFirestore() async {
    setState(() {
      _isUploading = true;
    });

    try {
      if (_imageFile != null) {
        // Upload image to Firebase Storage
        String imageName = 'user_image_${DateTime.now().millisecondsSinceEpoch}';
        Reference ref = FirebaseStorage.instance.ref().child('images').child(imageName);
        UploadTask uploadTask = ref.putFile(_imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        // Get download URL of the uploaded image
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Save download URL to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential!.user?.uid).set({
          'imageUrl': downloadURL,
        }, SetOptions(merge: true));

        print('Image uploaded and download URL saved to Firestore successfully!');

        Navigator.of(context).pushReplacement(
          HorizontalSlideRoute(
            builder: (_, __, ___) {
              return  HomePage();
            },
          ),
        );
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error uploading image and saving download URL: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a profile picture', style: TextStyle(
          fontFamily: "ColabRegular",
          fontSize: 20
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? Text('No image selected.', style: TextStyle(
              fontFamily: "ColabRegular"
            ),)
                :
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 4
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(200))
              ),
              child:  ClipOval(
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Color(0xffFEBD2F),
                ),
              onPressed: getImage,
              child: Text('Select Image',style: TextStyle(
                  fontFamily: "ColabRegular",
                fontSize: 20,
                color: Colors.black
              )),
            ),
            const SizedBox(height: 20,),
            _imageFile != null ?
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Color(0xffFEBD2F),
              ),
              onPressed: uploadImageAndSaveToFirestore,
              child: Text(
                'Save', style: TextStyle(
                  fontFamily: "ColabRegular",
                  fontSize: 20,
                  color: Colors.black
              ),),
            ): const SizedBox(),
            _isUploading ? CircularProgressIndicator() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
