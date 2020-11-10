import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sampleLoginPage/screens/addworkout.dart';
import 'package:sampleLoginPage/screens/editLiveSession.dart';
import 'package:sampleLoginPage/screens/editworkout.dart';
import 'package:sampleLoginPage/screens/newSession.dart';
import 'package:sampleLoginPage/screens/workoutsinfo.dart';

class LiveTraining extends StatefulWidget {
  @override
  _LiveTrainingState createState() => _LiveTrainingState();
}

class _LiveTrainingState extends State<LiveTraining> {
  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;
  double width, height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
    _firstDate = DateTime.now().subtract(Duration(days: 1));
    _lastDate = DateTime.now().add(Duration(days: 45));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Sessions'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Allocated sessions:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(
              height: height * .02,
            ),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 1,
                      color: Colors.white,
                      child: Slidable(
                        movementDuration: Duration(seconds: 1),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            leading: Card(
                              elevation: 2,
                              child: Container(
                                height: 70,
                                width: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Slot 0",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            title: Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Json, David',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Text('10-11-2020 10:20am'),
                                Text('to'),
                                Text('10-11-2020 12:20am'),
                              ],
                            ),
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (ctx) => WorkoutInfo()));
                            },
                          ),
                        ),
                        // actions: <Widget>[
                        //   IconSlideAction(
                        //     caption: 'Archive',
                        //     color: Colors.blue,
                        //     icon: Icons.archive,
                        //     onTap: () => _showSnackBar('Archive'),
                        //   ),
                        //   IconSlideAction(
                        //     caption: 'Share',
                        //     color: Colors.indigo,
                        //     icon: Icons.share,
                        //     onTap: () => _showSnackBar('Share'),
                        //   ),
                        // ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Edit',
                            color: Colors.cyan,
                            icon: Icons.edit,
                            foregroundColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => EditLiveSession()));
                            },
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm"),
                                    content: Text(
                                        "Are you sure you want to delete this session?"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Confirm"),
                                        onPressed: () async {},
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            // Material(
            //   elevation: 1,
            //   color: Colors.white,
            //   child: ListTile(
            //     contentPadding: const EdgeInsets.only(
            //       left: 10,
            //       top: 10,
            //       bottom: 10,
            //     ),
            //     leading: Card(
            //       elevation: 2,
            //       child: Container(
            //         height: 70,
            //         width: 60,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text(
            //               "Slot 1",
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 14,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     title: Padding(
            //       padding: EdgeInsets.only(bottom: 3),
            //       child: Column(
            //         children: <Widget>[
            //           Text(
            //             'Week 1',
            //             style: TextStyle(fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),
            //     ),
            //     subtitle: Column(
            //       children: <Widget>[
            //         Text('10-11-2020( Mon)'),
            //         Text('to'),
            //         Text('16-11-2020( Sun)')
            //       ],
            //     ),
            //   ),
            // )
            // Container(
            //   child: Column(
            //     children: <Widget>[
            //       Text("Slot - 1 : "),

            //     ],
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => NewSession()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
