import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_firebase_crud/add_user_page.dart';
import 'package:practice_firebase_crud/model/user.dart';

import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _navigateToAddUserPage(context);
      }),
    );
  }

  _navigateToAddUserPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $result to Firebase!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Stream<List<User>?> readUsers() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');
    return collectionReference.snapshots().map((snapshot) {
      snapshot.docs.map((doc) => User.fromJson(doc.data() as Map<String,dynamic>)).toList();
    });
  }

}



