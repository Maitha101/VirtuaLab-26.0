import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_case_study_view.dart';

// import './studentNavBar.dart';

class CaseStudiesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CaseStudiesList();
  }
}

class _CaseStudiesList extends State<CaseStudiesList> {
  Query _caseStudyTitle;

  @override
  void initState() {
    super.initState();
    _caseStudyTitle = firebaseref.child('case_study');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Case Studies'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FirebaseAnimatedList(
        query: _caseStudyTitle,
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index) {
          Map caseStudy = snapshot.value;
          caseStudy['key'] = snapshot.key;
          return _caseStudyList(caseStudy: caseStudy);
        },
      ),
    );
  }

  Widget _caseStudyList({Map caseStudy}) {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () {},
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
                              Icons.description_sharp,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  caseStudy['title'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 2,
                                      color: Colors.deepPurple),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CaseStudyView(
                                           csKey: caseStudy['key'],
                                           caseStudyName:caseStudy['title'] ,
                                          ),
                                    ),
                                  )
                                },
                            child: Text('Start'),
                            // color: Colors.amber,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber))),
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
    );
  }
}
