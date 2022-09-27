import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice_firebase_crud/model/user.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({Key? key}) : super(key: key);

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(controller: controllerName, decoration: decoration('Name')),
          const SizedBox(height: 24),
          TextField(
            controller: controllerAge,
            decoration: decoration('Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          DateTimeField(
            controller: controllerDate,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
            format: DateFormat('yyyy-MM-dd'),
            decoration: decoration('Birthday'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              final user = User(
                name: controllerName.text,
                age: int.parse(controllerAge.text),
                birthday: DateTime.parse(controllerDate.text),
              );
              createUser(user);
              Navigator.pop(context, user.name);
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }

  Future createUser(User user) async {
    //Reference to document
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(); //it generate id automatically
    user.id = docUser.id;

    final json = user.toJson(); //Map<String, dynamic>
    //Create document and write data to Firebase
    await docUser.set(json);
  }
}
