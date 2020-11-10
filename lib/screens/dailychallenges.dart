import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:sampleLoginPage/services/httpRequestBody.dart';

class DailChallenges extends StatefulWidget {
  DailChallenges({Key key}) : super(key: key);

  @override
  _DailChallengesState createState() => _DailChallengesState();
}

class _DailChallengesState extends State<DailChallenges> {
  double width, height;
  bool isLoading = true;
  List challenges = [];

  TextEditingController _challenge;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _challenge = new TextEditingController();
    getAllChallenges();
  }

  editdialog(String title, String challengeId) {
    TextEditingController _editchallenge =
        new TextEditingController(text: title);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Edit Challenge",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      controller: _editchallenge,
                      decoration: InputDecoration(labelText: 'Challenge name'),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: width * .2),
                      shape:
                          StadiumBorder(side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        postEditChallengeData({
                          "challengeId": challengeId,
                          "challengeName": _editchallenge.text,
                          "challengeScore": 0
                        });
                      },
                      color: Colors.blue,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Challenges'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "All Challenges:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            (isLoading)
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.transparent,
                          );
                        },
                        itemCount: challenges.length,
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.white,
                            elevation: 1,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    challenges[index]["challengeName"],
                                  ),
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
                                    editdialog(
                                        challenges[index]["challengeName"],
                                        challenges[index]["challengeId"]);
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
                                              "Are you sure you want to delete this Challenge?"),
                                          actions: [
                                            FlatButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("Confirm"),
                                              onPressed: () async {
                                                setState(() {
                                                  challenges.remove(index);
                                                });
                                                Navigator.of(context).pop();
                                              },
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
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Add Challenge",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          TextFormField(
                            controller: _challenge,
                            decoration: InputDecoration(labelText: 'Title'),
                          ),
                          RaisedButton(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * .2),
                            shape: StadiumBorder(
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () {
                              postChallengeData({
                                "challengeName": _challenge.text,
                                "challengeScore": 0
                              });
                            },
                            color: Colors.blue,
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> postEditChallengeData(Map<String, dynamic> reqBody) async {
    Response response =
        await newHttpPostAuth(uri: uriList['updateChallenge'], body: reqBody);

    if (response.statusCode == 200) {
      print(response.body);

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => DailChallenges()));
    } else {
      print('failed');
    }

    // print("post edit data");
  }

  Future<void> postChallengeData(Map<String, dynamic> reqBody) async {
    Response response =
        await newHttpPostAuth(uri: uriList['createChallenge'], body: reqBody);

    if (response.statusCode == 200) {
      print(response.body);

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => DailChallenges()));
    } else {
      print('failed');
    }

    // print("post edit data");
  }

  Future<void> getAllChallenges() async {
    try {
      Response response =
          await newHttpGetAuth(uri: uriList['getAllChallenges']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          print(response.body);
          challenges = jsonDecode(response.body);
          print(challenges);
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for sign up");
  }
}
