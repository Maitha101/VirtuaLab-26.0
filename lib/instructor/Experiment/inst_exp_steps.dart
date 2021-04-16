import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/instructor/inst_experiments.dart';
import 'inst_expstep_info.dart';

// THIS SCREEN LISTS SUBMITTED EXP STEPS FOR READING AND DELETION OF EXP !!!
class InstExperimentsStep extends StatefulWidget {
  final String snapshotKey;
  InstExperimentsStep({this.snapshotKey});
  @override
  State<StatefulWidget> createState() {
    return _InstExperimentsStep();
  }
}

class _InstExperimentsStep extends State<InstExperimentsStep> {
  Query dbRef;
  DatabaseReference dbrefrence;
  DataSnapshot snapshot;
  String key;

  @override
  void initState() {
    super.initState();
    key = widget.snapshotKey;
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .child(key)
        .child('steps');
    dbrefrence =
        FirebaseDatabase.instance.reference().child('experiment').child(key);
  }

  Widget _buildExperimentList({Map experiment}) {
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
                    experiment['step_number'],
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpStepDetail(
                        snapshotKey: experiment['key'],
                        expsnapkey: key,
                      )));
        });
  }

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Experiment'),
            content: Text('are you sure you want to delete the experiment?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    dbrefrence.remove().whenComplete(() => Navigator.of(context)
                        .popUntil((route) => route.isFirst));
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
          title: Text('Experiments'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
            Flexible(
              child: Container(
                child: FirebaseAnimatedList(
                  query: dbRef,
                  defaultChild: Center(child: CircularProgressIndicator()),
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
        ));
  }
}
