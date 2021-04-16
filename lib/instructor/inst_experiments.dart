import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'Experiment/inst_exp_steps_list.dart';
import 'Experiment/inst_exp_steps.dart';
import 'Experiment/inst_create_exp.dart';

class InstExperiments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstExperiments();
  }
}

class _InstExperiments extends State<InstExperiments> {
  Query dbRefDraft;
  Query dbRefSubm;
  DataSnapshot snapshot;

  @override
  void initState() {
    super.initState();
    dbRefDraft = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .orderByChild('draft')
        .equalTo("true");
    dbRefSubm = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .orderByChild('draft')
        .equalTo("false");
  }

  Widget _buildExperimentList({Map experiment}) {
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    experiment['title'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        onTap: () {
          if (experiment['draft'] == 'true') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InstExperimentsStepList(
                        snapshotKey: experiment['key'])));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InstExperimentsStep(snapshotKey: experiment['key'])));
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
                builder: (BuildContext context) => CreateExperiment(),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text('New'),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Experiments'),
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
                      Map experiment = snapshot.value;
                      experiment['key'] = snapshot.key;
                      return _buildExperimentList(experiment: experiment);
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
                    Map experiment = snapshot.value;
                    experiment['key'] = snapshot.key;
                    return _buildExperimentList(experiment: experiment);
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
