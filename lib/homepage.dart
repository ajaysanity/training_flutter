import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutternew/signup.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> signOut () async {
    final signOut = await FirebaseAuth.instance.signOut();
  
  }
  @override
  Widget build(BuildContext context) {

    CollectionReference otherUsers = FirebaseFirestore.instance.collection(OtherUsers);

    Future<void> addUser() {
      return otherUsers
          .add({'Full_name' : fullname})
          .then((value) => print('User Added'))
          .catchError((error) => print('Failed to add user:$error'));
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: signOut, child: const Text('Logout'),
                ),
                ),
                Container(
                  width: 300,
                  height: 50,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Other users',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton(onPressed: (){},
                       child: const Text('Add') ),
                ),
              ]
            ),
        ),
      ),
    );
  }
}