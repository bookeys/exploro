import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  final User user;

  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged-In User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.displayName ?? 'N/A'}'),
            Text('Email: ${user.email ?? 'N/A'}'),
            Text('Phone: ${user.phoneNumber ?? 'N/A'}'),
            // Add more details as needed...
          ],
        ),
      ),
    );
  }
}
