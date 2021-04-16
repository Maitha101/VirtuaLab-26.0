import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtulab/functions/auth.dart';

class CreateCourse extends StatelessWidget {
  _validator(String value){
    if(value.isEmpty){
      return '* Required';
    }
  }
  final dbRef = FirebaseDatabase.instance.reference().child('course');
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('New'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.yellow[700],
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create Course'),
                content: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    SingleChildScrollView(child:Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: TextFormField(
                                validator: (value) => _validator(value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Course Name',
                                ),
                                controller: _nameController,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: TextFormField(
                                validator: (value) => _validator(value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Course Code',
                                ),
                                controller: _codeController,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: TextFormField(
                                validator: (value) => _validator(value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Course Description',
                                ),
                                controller: _descrController,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                child: Text('Create'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    dbRef.push().set({
                                      'name': _nameController.text,
                                      'instID': getCurrentID(),
                                      'code': _codeController.text,
                                      'description': _descrController.text,
                                    });
                                    _nameController.clear();
                                    _codeController.clear();
                                    _descrController.clear();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),)
                  ],
                ),
              );
            });
      },
    );
  }
}
