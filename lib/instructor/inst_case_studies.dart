import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'Case Study/inst_case_study_info.dart';
import 'Case Study/inst_edit_case_study.dart';
import 'Case Study/inst_create_cs.dart';

class InstCaseStudies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstCaseStudies();
  }
}

class _InstCaseStudies extends State<InstCaseStudies> {
  Query dbRefDraft;
  Query dbRefSubm;
  DataSnapshot snapshot;

  @override
  void initState() {
    super.initState();
    dbRefDraft = FirebaseDatabase.instance
        .reference()
        .child('case_study')
        .orderByChild('draft')
        .equalTo("true");
    dbRefSubm = FirebaseDatabase.instance
        .reference()
        .child('case_study')
        .orderByChild('draft')
        .equalTo("false");
  }

  Widget _buildCaseStudyList({Map caseStudy}) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          height: 90,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    caseStudy['title'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'grade: ' + caseStudy['total_grade'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text(
                caseStudy['deadline'],
                //course['description'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              )
            ],
          ),
        ),
        onTap: () {
          if (caseStudy['draft'] == 'true') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CaseStudyEditForm(snapshotKey: caseStudy['key'])));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CaseStudyDetail(snapshotKey: caseStudy['key'])));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.yellow[700],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateCaseStudy(),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text('New'),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Case Studies'),
          backgroundColor: Colors.deepPurple,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Drafts'),
              ),
              Tab(
                child: Text('Submitted'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Drafts Tab
            Tab(
              child: Container(
                child: FirebaseAnimatedList(
                    query: dbRefDraft,
                    defaultChild: Center(child:CircularProgressIndicator()),
                    itemBuilder: (BuildContext context, snapshot,
                        Animation<double> animation, int index) {
                      Map casestudy = snapshot.value;
                      casestudy['key'] = snapshot.key;
                      return _buildCaseStudyList(caseStudy: casestudy);
                    }),
              ),
            ),

            //Submitted Tab
            Tab(
              child: Container(
                child: FirebaseAnimatedList(
                  query: dbRefSubm,
                  defaultChild: Center(child:CircularProgressIndicator()),
                  itemBuilder: (BuildContext context, snapshot,
                      Animation<double> animation, int index) {
                    Map casestudy = snapshot.value;
                    casestudy['key'] = snapshot.key;
                    return _buildCaseStudyList(caseStudy: casestudy);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
