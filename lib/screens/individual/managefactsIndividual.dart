import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sampleLoginPage/screens/addfacts.dart';
import 'package:sampleLoginPage/screens/editfacts.dart';

class ManageFactsIndividual extends StatefulWidget {
  ManageFactsIndividual({Key key}) : super(key: key);

  @override
  _ManageFactsIndividualState createState() => _ManageFactsIndividualState();
}

class _ManageFactsIndividualState extends State<ManageFactsIndividual> {
  double width, height;

  var facts = [
    {
      "fact":
          'They make the work outs fun but also hard to push your limits and yourself. They treat you like family but at the same time keep it professional and make sure you get what you pay for. Truly one of the best decisions I have made in my life.'
    },
    {
      "fact":
          'They make the work outs fun but also hard to push your limits and yourself. They treat you like family but at the same time keep it professional and make sure you get what you pay for. Truly one of the best decisions I have made in my life.'
    },
    {
      "fact":
          'They make the work outs fun but also hard to push your limits and yourself. They treat you like family but at the same time keep it professional and make sure you get what you pay for. Truly one of the best decisions I have made in my life.'
    },
    {
      "fact":
          'They make the work outs fun but also hard to push your limits and yourself. They treat you like family but at the same time keep it professional and make sure you get what you pay for. Truly one of the best decisions I have made in my life.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Manage Facts',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "All Facts (9):",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Container(
            //   child: Row(

            //   ),
            // )

            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.transparent,
                    );
                  },
                  itemCount: facts.length,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Fact",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
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
                            title: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    facts[index]["fact"],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: Colors.grey[600]),
                                  )
                                ],
                              ),
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
                            onTap: () => {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => EditFacts(
                              //           fact: facts[index]["fact"],
                              //         )))
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
                                        "Are you sure you want to delete this Fact?"),
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
                                          facts.remove(index);
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddFacts()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
