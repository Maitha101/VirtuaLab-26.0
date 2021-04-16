import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'stu_course_contents.dart';
import 'package:virtulab/student/stu_course_register.dart';

// import './studentNavBar.dart';

class StudentCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentCourses();
  }
}

class _StudentCourses extends State<StudentCourses> {
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
      floatingActionButton: AddCourseButton(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Courses'),
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

    // );
  }

  Widget _courseList({Map courseList}) {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => StudentCourseContents(
                  courseName: courseList['name'],
                ),
              ),
            ),
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
                            Icon(Icons.auto_stories),
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
  }
// Container(

// child: Column(
//   children: <Widget>[
//     Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
//           child: Text(
//             'My Courses',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     ),
//     Expanded(
//       child: new ListView.builder(
//         itemCount: stuCourse.length,
//         itemBuilder: (context, index) {
//           Widget column = Expanded(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   //Multiple texts in a widget
//                   Text(
//                     courseList['name'],//stuCourse[index].courseName,
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         height: 2,
//                         color: Colors.deepPurple),
//                   ),
//                   Text(courseList['instID'])//stuCourse[index].insName),
//                 ],
//               ),
//             ),
//           );
//           return Card(
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         StudentCourseContents(),
//                   ),
//                 );
//               }, // Navigate when tapped
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.auto_stories,
//                     ),
//                     column,
//                     Icon(Icons.arrow_forward_ios_rounded),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     ),
// Align(
//   alignment: Alignment.centerRight,
//   child: Container(
//     child: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: <Widget>[
//           FloatingActionButton.extended(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                     StuCourseRegister(),
//               ),
//             ), //When pressed
//             icon: Icon(Icons.add),
//             label: Text(
//               "Add New Course",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             backgroundColor: Colors.amber,
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
// ],
// ),
// );
// }
//

}

class AddCourseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // Align(
        // alignment: Alignment.centerRight,
        // child: Container(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: Column(
        // children: <Widget>[
        FloatingActionButton.extended(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => StuCourseRegister(),
        ),
      ), //When pressed
      icon: Icon(Icons.add),
      label: Text(
        "Add New Course",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.amber,
    );
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
