import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/instructor/inst_experiments.dart';
import 'inst_expstep_edit.dart';
import 'inst_expstep_form.dart';

// THIS SCREEN LISTS DRAFTED EXP STEPS FOR EDITING/ DELETION OF STEPS OR EXP!!!
class InstExperimentsStepList extends StatefulWidget {
  final String snapshotKey;
  InstExperimentsStepList({this.snapshotKey});
  @override
  State<StatefulWidget> createState() {
    return _InstExperimentsStepList();
  }
}

class _InstExperimentsStepList extends State<InstExperimentsStepList> {
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

  Widget _buildExperimentList({Map step}) {
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
                    step['step_number'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _showStepDeleteDialog(step: step);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red[700],
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpStepEditDetail(
                        snapshotKey: step['key'],
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

  _showStepDeleteDialog({Map step}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Experiment Step'),
            content:
                Text('are you sure you want to delete this experiment step?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    dbrefrence
                        .child('steps')
                        .child(step['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.yellow[700],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ExperimentStepForm(
                  snapshotKey: key,
                ),
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
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    dbrefrence.update({"draft": 'false'});
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    dbrefrence.update({"draft": 'true'});
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('Draft'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog();
                  },
                  child: Text('Cancel'),
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
                    Map step = snapshot.value;
                    step['key'] = snapshot.key;
                    return _buildExperimentList(step: step);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
