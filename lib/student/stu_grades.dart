import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_course_grades.dart';
// import './studentNavBar.dart';

class StudentGrades extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentGrades();
  }
}

class _StudentGrades extends State<StudentGrades> {
  Query _courses;

  initState() {
    super.initState();
    _courses = firebaseref
        .child('course')
        .orderByChild('studID/ID')
        .equalTo(getCurrentID());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Grades'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FirebaseAnimatedList(
        query: _courses,
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index) {
          Map _courses = snapshot.value;
          _courses['key'] = snapshot.key;

          return _courseList(courseList: _courses);
        },
      ),
    );
  }

  _courseList({Map courseList}) {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CourseGrades(
                  courseName: courseList['name'],
                ),
              ),
            ),
            // ),
            // ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              // height: 70,
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
                            Icon(
                              Icons.grading,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  courseList['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 2,
                                      color: Colors.deepPurple),
                                ),
                                Text(
                                  'Instructor: ' + courseList['instID'],
                                  // style: TextStyle(fontSize: 16, color: Colors.grey)
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ],
      // ),
    );

    //return  new Container(
    //       child: Column(children: <Widget>[
    //     Align(
    //       //Listview
    //       alignment: Alignment.centerLeft,
    //       child: Container(
    //           child: Padding(
    //         padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
    //         child: Text(
    //           'My Grades',
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //       )),
    //     ),
    //     Expanded(
    //       child: new ListView.builder(
    //         itemCount: stuCourse.length,
    //         itemBuilder: (context, index) {
    //           Widget column = Expanded(
    //               child: Padding(
    //             padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 //Multiple texts in a widget
    //                 Text(
    //                   stuCourse[index].courseName,
    //                   style: TextStyle(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                       height: 2,
    //                       color: Colors.deepPurple),
    //                 ),
    //                 Text(stuCourse[index].insName),
    //               ],
    //             ),
    //           ));
    //           return Card(
    //               child: InkWell(
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (BuildContext context) => CourseGrades(),
    //                 ),
    //               );
    //             }, // Navigate when tapped
    //             child: Padding(
    //               padding: const EdgeInsets.all(25.0),
    //               child: Row(
    //                 children: <Widget>[
    //                   Icon(
    //                     Icons.grading,
    //                   ),
    //                   column,
    //                   Icon(Icons.arrow_forward_ios_rounded),
    //                 ],
    //               ),
    //             ),
    //           ));
    //         },
    //       ),
    //     ),
    //   ]));
  }
}
