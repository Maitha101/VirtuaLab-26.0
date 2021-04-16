import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CaseStudyDetail extends StatefulWidget {
  final String snapshotKey;
  CaseStudyDetail({this.snapshotKey});

  @override
  _CaseStudyDetailState createState() => _CaseStudyDetailState();
}

class _CaseStudyDetailState extends State<CaseStudyDetail> {
  var title;
  var count = 0;
  TextEditingController titleController,
      bodyController,
      discrController,
      gradeController,
      deadlineController,
      question1Controller,
      question2Controller,
      question3Controller,
      question4Controller,
      question5Controller;
  DatabaseReference dbRef;
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('case_study')
        .child(widget.snapshotKey);
    titleController = TextEditingController();
    bodyController = TextEditingController();
    discrController = TextEditingController();
    gradeController = TextEditingController();
    deadlineController = TextEditingController();
    question1Controller = TextEditingController();
    question2Controller = TextEditingController();
    question3Controller = TextEditingController();
    question4Controller = TextEditingController();
    question5Controller = TextEditingController();
    getDetail();
  }

  getDetail() async {
    DataSnapshot snapshot = await dbRef.once();
    Map caseStudyinfo = snapshot.value;
    title = caseStudyinfo['title'].toString();
    titleController.text = caseStudyinfo['title'];
    bodyController.text = caseStudyinfo['body'];
    discrController.text = caseStudyinfo['description'];
    gradeController.text = caseStudyinfo['grade'];
    deadlineController.text = caseStudyinfo['deadline'];
    question1Controller.text = caseStudyinfo['question1'];
    question2Controller.text = caseStudyinfo['question2'];
    question3Controller.text = caseStudyinfo['question3'];
    question4Controller.text = caseStudyinfo['question4'];
    question5Controller.text = caseStudyinfo['question5'];
  }

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Case Study'),
            content: Text('are you sure you want to delete the Case Study?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    dbRef.remove().whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text(' Case Study Information'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ListView(
            children: [
              TextFormField(
                readOnly: true,
                controller: titleController,
              ),
              TextFormField(
                controller: discrController,
                validator: (v) => v.isEmpty ? "enter description" : null,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Write a short Description of the Step',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.yellow[700],
                thickness: 3,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter question" : null,
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Write the Question here',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Options:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter Question" : null,
                controller: question1Controller,
                decoration: InputDecoration(
                  hintText: 'Question 1',
                ),
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter Question" : null,
                controller: question2Controller,
                decoration: InputDecoration(
                  hintText: 'Question 2',
                ),
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter Question" : null,
                controller: question3Controller,
                decoration: InputDecoration(
                  hintText: 'Question 3',
                ),
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter Question" : null,
                controller: question4Controller,
                decoration: InputDecoration(
                  hintText: 'Question 4',
                ),
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter Question" : null,
                controller: question5Controller,
                decoration: InputDecoration(
                  hintText: 'Question 5',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.yellow[700],
                thickness: 3,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (v) => v.isEmpty ? "enter Grade" : null,
                controller: gradeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Grade out of:',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  validator: (v) => v.isEmpty ? "enter headline" : null,
                  controller: deadlineController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    //may use date picker instead ..
                    hintText: 'Enter the deadline date',
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _showDeleteDialog();
                },
                child: Text('Delete'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red[700]),
                ),
              )
            ],
          ),
        ));
  }
}
