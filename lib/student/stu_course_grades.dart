import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';

// import './studentNavBar.dart';

class CourseGrades extends StatefulWidget {
  final String courseName;
  CourseGrades({this.courseName});
  @override
  State<StatefulWidget> createState() {
    return _CourseGrades();
  }
}

class _CourseGrades extends State<CourseGrades> {
  Query _csGrade;
  initState() {
    super.initState();
    _csGrade = firebaseref.child('case_study');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.courseName), //Temp data
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(children: <Widget>[
          getTotal(),
          Flexible(
            child: FirebaseAnimatedList(
              query: _csGrade,
              defaultChild: Center(child: CircularProgressIndicator()),
              itemBuilder: (BuildContext context, snapshot,
                  Animation<double> animation, int index) {
                Map _grade = snapshot.value;
                _grade['key'] = snapshot.key;
                return _gradesList(gradesList: _grade);
              },
            ),
          )
        ]));
  }

  Widget getTotal({Map total}) {
    return Column(children: <Widget>[
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  Align(
                    child: Container(
                      height: 60,
                      width: 160,
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
                      decoration: new BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            new BorderRadius.all(Radius.elliptical(50, 50)),
                      ),
                      child: Center(
                          child: Text(
                        '20',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      )), //Temp data
                    ),
                  ),
                  Divider(thickness: 2),
                ]))
          ]))
    ]);
  }

  Widget _gradesList({Map gradesList}) {
    return Column(children: <Widget>[
      Container(
          // margin: EdgeInsets.symmetric(vertical: 10),
          // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          // height: 70,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(
                      gradesList['title'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 2,
                          color: Colors.deepPurple),
                    ),
                    trailing: Text(gradesList['total_grade']),
                  ),
                  Divider(thickness: 2),
                ]))
          ]))
    ]);
  }

//old
  _gradessList({Map gradesList}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          gradesList['title'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 2,
                              color: Colors.deepPurple),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    Text(gradesList['total_grade']),
                  ],
                ),
              ),
              Divider(thickness: 2),
              SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}
