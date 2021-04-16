import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/Model/stu_case_study_model.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/back_button.dart';


class CaseStudyView extends StatefulWidget {
  final String csKey;
  final String caseStudyName;

  CaseStudyView({this.csKey,this.caseStudyName});

  @override
  State<StatefulWidget> createState() {
    return _CaseStudyView();
  }
}

class _CaseStudyView extends State<CaseStudyView> {
  bool _loading = false;
  List<CaseStudyModel> caseStudyList = [];
String title;
String description;
String body;
String question1;
String question2;
String question3;
String question4;
String question5;
  DatabaseReference _ref;


  final _formKey = GlobalKey<FormState>();
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();

  //Query _caseStudyInfo;
  DatabaseReference caseStudyInfo;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('case_study');
    getCaseStudyDetails();
    caseStudyInfo = firebaseref.child('case_study');
    caseStudyInfo.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      caseStudyList.clear();
      for (var key in keys) {
        CaseStudyModel csList = new CaseStudyModel(
          data[key]['title'],
          data[key]['description'],
          data[key]['body'],
          data[key]['question1'],
          data[key]['question2'],
          data[key]['question3'],
          data[key]['question4'],
          data[key]['question5'],
        );
        caseStudyList.add(csList);
      }

      setState(() {
        print('Length : $caseStudyList.length');
      });
    });
    //getCSInfo();
  }

  /*getCSInfo() async {
    DataSnapshot snapshot = await _caseStudyInfo.once();
    Map caseStudyinfo = snapshot.value;
    title = caseStudyinfo['title'].toString();
    description = caseStudyinfo['description'].toString();
    body = caseStudyinfo['body'].toString();
    question1 = caseStudyinfo['question1'].toString();
    question2 = caseStudyinfo['question2'].toString();
    question3 = caseStudyinfo['question3'].toString();
    question4 = caseStudyinfo['question4'].toString();
    question5 = caseStudyinfo['question5'].toString();
  }*/

  @override
  Widget build(BuildContext context) {
    return
        //WillPopScope(
        // onWillPop: () async => submitCaseStudy(context),
        // child:
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.caseStudyName,style: TextStyle(fontSize: 22),), //Temp data
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: caseStudyList.length == 0
            ? new Text('No Case Studies Uploaded')
            : Form(
          key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title == null ? "title" : title,
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  height: 2,
                                  color: Colors.deepPurple),
                            ),
                            Divider(),
                            Text(
                              'Description:',
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(fontWeight: FontWeight.bold
                              ,fontSize: 21),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                description == null ? "description" : description,
                                style: TextStyle(fontSize: 19),

                                textAlign: TextAlign.left,
                                maxLines: null,
                              ),
                            ),
                            Text(
                              'Case Study:',
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(
                                fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                body == null ? "body" : body,
                                style: TextStyle(fontSize: 19),
                                textAlign: TextAlign.left,
                                maxLines: null,
                              ),
                            ),
                            Divider(),
                            Text(
                              'Questions:',

                              textAlign: TextAlign.left,
                              style:
                              TextStyle(fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding:
                                EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      question1 == null ?  '1/ ' + "Q1" :'1/ ' + question1,

                                      style: TextStyle(fontSize: 19),
                                      textAlign: TextAlign.left,
                                      maxLines: null,
                                    ),
                                  ],
                                )),
                            TextFormField(
                              controller: question1Controller,
                              validator: (v) =>
                              v.isEmpty ? 'Enter Your Answer' : null,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Write Your Answer Here',
                              ),
                            ),
                            Container(
                                padding:
                                EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      question2 == null ?  '2/ ' + "Q2" :'2/ ' + question2,
                                      style: TextStyle(fontSize: 19),
                                      textAlign: TextAlign.left,
                                      maxLines: null,
                                    ),
                                  ],
                                )),
                            TextFormField(
                              controller: question2Controller,
                              validator: (v) =>
                              v.isEmpty ? 'Enter Your Answer' : null,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Write Your Answer Here',
                              ),
                            ),
                            Container(
                                padding:
                                EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      question3 == null ?  '3/ ' + "Q3" :'3/ ' + question3,
                                      style: TextStyle(fontSize: 19),
                                      textAlign: TextAlign.left,
                                      maxLines: null,
                                    ),
                                  ],
                                )),
                            TextFormField(
                              controller: question3Controller,
                              validator: (v) =>
                              v.isEmpty ? 'Enter Your Answer' : null,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Write Your Answer Here',
                              ),
                            ),
                            Container(
                                padding:
                                EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(

                                question4 == null ?  '4/ ' + "Q4" :'4/ ' + question4,

                                          style: TextStyle(fontSize: 19),
                                          // caseStudyList[index].question4,
                                      textAlign: TextAlign.left,
                                      maxLines: null,
                                    ),
                                  ],
                                )),
                            TextFormField(
                              controller: question4Controller,
                              validator: (v) =>
                              v.isEmpty ? 'Enter Your Answer' : null,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Write Your Answer Here',
                              ),
                            ),
                            Container(
                                padding:
                                EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                          question5 == null ?  '5/ ' + "Q5" :'5/ ' + question5,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 19),
                                      maxLines: null,
                                    ),
                                  ],
                                )),
                            TextFormField(
                              controller: question5Controller,
                              validator: (v) =>
                              v.isEmpty ? 'Enter Your Answer' : null,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Write Your Answer Here',
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            width: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                // _showAlertDialog(context);
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  firebaseref
                                                      .child('case_study')
                                                      .push()
                                                      .set({
                                                    "question1":
                                                    question1Controller
                                                        .text,
                                                    "question2":
                                                    question2Controller
                                                        .text,
                                                    "question3":
                                                    question3Controller
                                                        .text,
                                                    "question4":
                                                    question4Controller
                                                        .text,
                                                    "question5":
                                                    question5Controller
                                                        .text,
                                                  });
                                                }
                                              },
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),

                                            ),
                                          ),
                                        ],
                                      ))),
                            ),
                          ]),
                    )),
              )
            ),
      ),

      /*FirebaseAnimatedList(
        query: caseStudyInfo,
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index) {
          Map _courses = snapshot.value;
          _courses['key'] = snapshot.key;
          return _caseStudy(caseStudy: _courses);
        },
      ),*/
    );
  }

//   _showAlertDialog(BuildContext context) {
//   Widget cancelButton = FlatButton(
//   child: Text('Cancel'),
//   onPressed: () => Navigator.of(context, rootNavigator: true).pop());
//   Widget submitButton = FlatButton(
//   child: Text('Submit'),
//   onPressed: () {
//   if (_formKey.currentState.validate()) {
//   firebaseref.child('case_study').push().set({
//   "question1": question1Controller.text,
//   "question2": question2Controller.text,
//   "question3": question3Controller.text,
//   "question4": question4Controller.text,
//   "question5": question5Controller.text,
//   });
//
//   // Navigator.of(context, rootNavigator: true)
//   //     .push(MaterialPageRoute(builder: (context) => CaseStudiesList()));
//   Navigator.of(context, rootNavigator: true).pop();
//   Navigator.pop(context);
//   }
//   },
//   );
//
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//   title: Text('Alert'),
//   content: Text('Are you sure you want to submit?'),
//   actions: [
//   cancelButton,
//   submitButton,
//   ],
//   );
//
//   // show the dialog
//   showDialog(
//   context: context,
//   // barrierDismissible: false,
//   builder: (BuildContext cxt) {
//   return alert;
//   },
//   );
//   }
//
//   Widget _caseStudy(
//   String title,
//   String description,
//   String body,
//   String question1,
//   String question2,
//   String question3,
//   String question4,
//   String question5) {
//   return _loading
//   ? Container(
//   child: Center(
//   child: CircularProgressIndicator(),
//   ),
//   )
//       : Container(
//   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//   child: Form(
//   key: _formKey,
//   child: Container(
//   padding: EdgeInsets.symmetric(
//   horizontal: 20,
//   vertical: 20,
//   ),
//   child: ListView(
//   scrollDirection: Axis.vertical,
//   shrinkWrap: true,
//   children: <Widget>[
//   Text(
//   title,
//   style: TextStyle(
//   fontSize: 18,
//   fontWeight: FontWeight.bold,
//   height: 2,
//   color: Colors.deepPurple),
//   ),
//   Divider(),
//   Text(
//   'Description:',
//   textAlign: TextAlign.left,
//   style: TextStyle(fontWeight: FontWeight.bold),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Text(
//   description,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ),
//   Text(
//   'Case Study:',
//   textAlign: TextAlign.left,
//   style: TextStyle(fontWeight: FontWeight.bold),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Text(
//   body,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ),
//   Divider(),
//   Text(
//   'Questions:',
//   textAlign: TextAlign.left,
//   style: TextStyle(fontWeight: FontWeight.bold),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: <Widget>[
//   Text(
//   '1/ ' + question1,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ],
//   )),
//   TextFormField(
//   controller: question1Controller,
//   validator: (v) =>
//   v.isEmpty ? 'Enter Your Answer' : null,
//   keyboardType: TextInputType.multiline,
//   maxLines: null,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Write Your Answer Here',
//   ),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: <Widget>[
//   Text(
//   '2/ ' + question2,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ],
//   )),
//   TextFormField(
//   controller: question2Controller,
//   validator: (v) =>
//   v.isEmpty ? 'Enter Your Answer' : null,
//   keyboardType: TextInputType.multiline,
//   maxLines: null,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Write Your Answer Here',
//   ),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: <Widget>[
//   Text(
//   '3/ ' + question3,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ],
//   )),
//   TextFormField(
//   controller: question3Controller,
//   validator: (v) =>
//   v.isEmpty ? 'Enter Your Answer' : null,
//   keyboardType: TextInputType.multiline,
//   maxLines: null,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Write Your Answer Here',
//   ),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: <Widget>[
//   Text(
//   '4/ ' + question4,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ],
//   )),
//   TextFormField(
//   controller: question4Controller,
//   validator: (v) =>
//   v.isEmpty ? 'Enter Your Answer' : null,
//   keyboardType: TextInputType.multiline,
//   maxLines: null,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Write Your Answer Here',
//   ),
//   ),
//   Container(
//   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//   child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: <Widget>[
//   Text(
//   '5/ ' + question5,
//   textAlign: TextAlign.left,
//   maxLines: null,
//   ),
//   ],
//   )),
//   TextFormField(
//   controller: question5Controller,
//   validator: (v) =>
//   v.isEmpty ? 'Enter Your Answer' : null,
//   keyboardType: TextInputType.multiline,
//   maxLines: null,
//   decoration: InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Write Your Answer Here',
//   ),
//   ),
//   Align(
//   alignment: Alignment.centerRight,
//   child: Container(
//   child: Padding(
//   padding: const EdgeInsets.all(20),
//   child: Column(
//   children: <Widget>[
//   FloatingActionButton.extended(
//   onPressed: () {
//   _showAlertDialog(context);
//   },
//   label: Text(
//   "Submit",
//   style: TextStyle(
//   fontWeight: FontWeight.bold),
//   ),
//   backgroundColor: Colors.amber,
//   ),
//   ],
//   ))),
//   ),
//   ]),
//   )));
//   }


getCaseStudyDetails() async {
 DataSnapshot snapshot = await _ref.child(widget.csKey).once();
 Map caseStudy = snapshot.value;
 title = caseStudy['title'];
 description = caseStudy['description'];
 body = caseStudy['body'];
 question1 = caseStudy['question1'];
 question2 = caseStudy['question2'];
 question3 = caseStudy['question3'];
 question4 = caseStudy['question4'];
 question5= caseStudy['question5'];
}
}
