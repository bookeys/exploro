import 'package:flutter/material.dart';
import 'homePage.dart';

class UserDetailsPage extends StatelessWidget {
  final UserCard user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            Text('Phone: ${user.phone}'),
            Text('Phone: ${user.selectedState}'),
            ListView.builder(
                shrinkWrap: true,
                itemCount: user.selectedPlaces.length,
                itemBuilder: (BuildContext context, int index){
              return Text('Phone: ${user.selectedPlaces[index]}');
            }),
            // Add more details as needed...
          ],
        ),
      ),
    );
  }
}
