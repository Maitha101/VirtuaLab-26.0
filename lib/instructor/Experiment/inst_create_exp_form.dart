import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inst_expstep_form.dart';

class ExperimentForm extends StatefulWidget {
  @override
  _ExperimentFormState createState() => _ExperimentFormState();
}

class _ExperimentFormState extends State<ExperimentForm> {
  TextEditingController titleController;
  Query dbq;
  final dbRef = FirebaseDatabase.instance.reference().child("experiment");
  void initState() {
    super.initState();
    dbq = FirebaseDatabase.instance.reference().child('experiment');
    titleController = TextEditingController();
  }

  @override
// EXPERIMENT FORM -- START --
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: ListView(
          children: <Widget>[
            Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              height: 30,
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Experiment Title',
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String key = dbRef.push().key;
                        dbRef.child(key).set({'title': titleController.text});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExperimentStepForm(
                                      snapshotKey: key,
                                    )));
                      },
                      child: Text('Next'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
