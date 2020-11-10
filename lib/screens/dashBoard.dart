import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sampleLoginPage/screens/dailychallenges.dart';
import 'package:sampleLoginPage/screens/individual/dailychallengesIndividual.dart';
import 'package:sampleLoginPage/screens/individual/liveTrainingIndividual.dart';
import 'package:sampleLoginPage/screens/individual/manageGetInspiredIndividual.dart';
import 'package:sampleLoginPage/screens/individual/managefactsIndividual.dart';
import 'package:sampleLoginPage/screens/individual/manageworkoutsIndividual.dart';
import 'package:sampleLoginPage/screens/liveTraining.dart';
import 'package:sampleLoginPage/screens/loginPage.dart';
import 'package:sampleLoginPage/screens/manageGetInspired.dart';
import 'package:sampleLoginPage/screens/managefacts.dart';
import 'package:sampleLoginPage/screens/manageworkouts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/httpRequestBody.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  static final List<String> selectDropdownItems = ['Corporate', 'Individual'];
  double width, height;
  String actualDropdown = selectDropdownItems[0];
  int actualSelection = 0;
  TextEditingController _goal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _goal = new TextEditingController(text: '20000');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    var isCorporate = (actualDropdown == 'Corporate') ? true : false;
    print(isCorporate);

    return Scaffold(
        appBar: AppBar(
          title: Text("DashBoard"),
          backgroundColor: Colors.black45,
          actions: [
            Center(
              child: Theme(
                data: ThemeData(canvasColor: Colors.black54),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: true,
                      value: actualDropdown,
                      onChanged: (String value) => setState(() {
                            actualDropdown = value;
                            actualSelection = selectDropdownItems
                                .indexOf(value); // Refresh the chart
                          }),
                      items: selectDropdownItems.map((String title) {
                        return DropdownMenuItem(
                          value: title,
                          child: Text(title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0)),
                        );
                      }).toList()),
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.white)
          ],
        ),
        body: ListView(children: [
          StaggeredGridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Global Steps',
                                style: TextStyle(color: Colors.blueAccent)),
                            Text('265K',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 34.0))
                          ],
                        ),
                        Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.timeline,
                                  color: Colors.white, size: 30.0),
                            )))
                      ]),
                ),
              ),
              (isCorporate)
                  ? _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.teal,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.settings_applications,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Manage Facts',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0)),
                              Text('Add, Delete Facts',
                                  style: TextStyle(color: Colors.black45)),
                            ]),
                      ), onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ManageFacts()));
                    })
                  : _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.teal,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.settings_applications,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Manage Facts',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0)),
                              Text('Add, Delete Facts',
                                  style: TextStyle(color: Colors.black45)),
                            ]),
                      ), onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ManageFactsIndividual()));
                    }),
              (isCorporate)
                  ? _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.amber,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.notifications,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Workouts',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0)),
                              Text('Add,edit delete template',
                                  style: TextStyle(color: Colors.black45)),
                            ]),
                      ), onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ManageWorkouts()));
                    })
                  : _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.amber,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.notifications,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Workouts',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0)),
                              Text('Add,edit delete template',
                                  style: TextStyle(color: Colors.black45)),
                            ]),
                      ), onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ManageWorkoutsIndividual()));
                    }),
              // _buildTile(
              //   Padding(
              //       padding: const EdgeInsets.all(24.0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Text('Revenue',
              //                       style: TextStyle(color: Colors.green)),
              //                   Text('\$16K',
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontWeight: FontWeight.w700,
              //                           fontSize: 34.0)),
              //                 ],
              //               ),
              //               DropdownButton(
              //                   isDense: true,
              //                   value: actualDropdown,
              //                   onChanged: (String value) => setState(() {
              //                         actualDropdown = value;
              //                         actualChart = chartDropdownItems
              //                             .indexOf(value); // Refresh the chart
              //                       }),
              //                   items: chartDropdownItems.map((String title) {
              //                     return DropdownMenuItem(
              //                       value: title,
              //                       child: Text(title,
              //                           style: TextStyle(
              //                               color: Colors.blue,
              //                               fontWeight: FontWeight.w400,
              //                               fontSize: 14.0)),
              //                     );
              //                   }).toList())
              //             ],
              //           ),
              //           Padding(padding: EdgeInsets.only(bottom: 4.0)),
              //         ],
              //       )),
              // ),
              (isCorporate)
                  ? _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Manage Goal',
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                  Text('20000',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.directions_run,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ]),
                      ),
                      onTap: () {
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
                                          "Edit Goal",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        TextFormField(
                                          controller: _goal,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: 'Edit goal'),
                                        ),
                                        RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .2),
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.blue)),
                                          onPressed: () {},
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
                    )
                  : _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Manage Goal',
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                  Text('15000',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.directions_run,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ]),
                      ),
                      onTap: () {
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
                                          "Edit Goal Individual",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        TextFormField(
                                          controller: _goal,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: 'Edit goal'),
                                        ),
                                        RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .2),
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.blue)),
                                          onPressed: () {},
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
                    ),
              (isCorporate)
                  ? _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Manage Daily Challenges',
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                  Text('173',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.fitness_center,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ]),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DailChallenges()));
                      },
                    )
                  : _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Manage Daily Challenges',
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                  Text('142',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.fitness_center,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ]),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DailChallengesIndividual()));
                      },
                    )
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 180.0),
              // StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 00.0),
            child: Column(
              children: <Widget>[
                (isCorporate)
                    ? _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Manage Get Inspired',
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    Text('Category/Videos',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0))
                                  ],
                                ),
                                Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.video_library,
                                          color: Colors.white, size: 30.0),
                                    )))
                              ]),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GetInspiredPage()));
                        },
                      )
                    : _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Manage Get Inspired',
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    Text('Category/Videos',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0))
                                  ],
                                ),
                                Material(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.video_library,
                                          color: Colors.white, size: 30.0),
                                    )))
                              ]),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  GetInspiredPageIndividual()));
                        },
                      ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: <Widget>[
                (isCorporate)
                    ? _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Manage Live Training',
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    Text('Live training',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0))
                                  ],
                                ),
                                Material(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.live_tv,
                                          color: Colors.white, size: 30.0),
                                    )))
                              ]),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LiveTraining()));
                        },
                      )
                    : _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Manage Live Training',
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    Text('Live training',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0))
                                  ],
                                ),
                                Material(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.live_tv,
                                          color: Colors.white, size: 30.0),
                                    )))
                              ]),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LiveTrainingIndividual()));
                        },
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Close App',
                                    style: TextStyle(color: Colors.redAccent)),
                                Text('Logout',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24.0))
                              ],
                            ),
                            Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.power_settings_new_rounded,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                    onTap: () async {
                      await prefs.clear();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));

                      // print("corporateLogin" +
                      //     prefs.getBool('corporate_login').toString());
                      // print("corporate_dashboard" +
                      //     prefs.getBool('corporate_dashboard').toString());
                      // if (prefs.getBool('corporate_dashboard') != null) {
                      //   if (prefs.getBool('corporate_dashboard')) {
                      //     Navigator.pushReplacementNamed(
                      //         context, '/selectionpage');
                      //   } else {
                      //     Navigator.pushReplacementNamed(
                      //         context, ('/signUpPage'));
                      //     //after akshys undo
                      //     //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
                      //   }
                      // } else {
                      //   Navigator.pushReplacementNamed(
                      //       context, ('/signUpPage'));
                      //   //after akshys undo
                      //   //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
                      // }
                      // prefs.setBool('corporate_login', false);
                      // prefs.setBool('corporate_dashboard', false);

                      //clear login from sharedPrefs
                    },
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
