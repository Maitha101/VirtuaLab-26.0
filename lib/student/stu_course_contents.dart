import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_caseStudies_list.dart';
import 'package:virtulab/student/stu_experiments_list.dart';

class StudentCourseContents extends StatefulWidget {
 final  String courseName;
 StudentCourseContents({this.courseName});
  @override
  State<StatefulWidget> createState() {
    return _StudentCourseContents();
  }
}

class _StudentCourseContents extends State<StudentCourseContents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.courseName,style: TextStyle(fontSize: 22),), //Temp data
        backgroundColor: Colors.deepPurple,
      ),
      body: new Container(
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
              child: Text(
                'Course Contents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: coursesPage.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ListTile(
                        onTap: () {
                          //Navigate screens
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExperimentsList(),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CaseStudiesList(),
                              ),
                            );
                          }
                        },
                        title: Text(coursesPage[index].title),
                        leading: Icon(
                          coursesPage[index].icon,
                          color: Colors.black,
                          size: 30,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ));
                  }))
        ]),
      ),
    );
  }
}

class CourseContents {
  final String title;
  final IconData icon;
  const CourseContents({this.title, this.icon});
}

const List<CourseContents> coursesPage = const <CourseContents>[
  const CourseContents(
    title: 'Experiments',
    icon: Icons.device_thermostat,
  ),
  const CourseContents(
    title: 'Case Studies',
    icon: Icons.description_sharp,
  ),
];
