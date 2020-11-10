import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:intl/intl.dart';

class AddWorkoutTemplate extends StatefulWidget {
  AddWorkoutTemplate({Key key}) : super(key: key);

  @override
  _AddWorkoutTemplateState createState() => _AddWorkoutTemplateState();
}

class _AddWorkoutTemplateState extends State<AddWorkoutTemplate> {
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String result = "";
  bool isNextPressed = false;
  TextEditingController _trainers = TextEditingController();
  TextEditingController _url = TextEditingController();
  final formatTime = DateFormat("hh:mm a");
  final format = DateFormat("dd-MM-yyyy");
  TimeOfDay _endTime;
  TimeOfDay _startTime;
  DateTime _startdate;
  DateTime _enddate;
  double width, height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Workout",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: (isNextPressed)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('select start date'),
                          DateTimeField(
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              _startdate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 2));

                              return _startdate;
                            },
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('select end date'),
                          DateTimeField(
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              _startdate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 2));

                              return _startdate;
                            },
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: width * .3),
                      shape:
                          StadiumBorder(side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        print(
                            _startdate.toString() + " " + _enddate.toString());
                      },
                      color: Colors.blue,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HtmlEditor(
                      hint: "Create new workout template....",
                      //value: "text content initial, if any",
                      key: keyEditor,
                      height: 400, showBottomToolbar: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            color: Colors.blueGrey,
                            onPressed: () {
                              setState(() {
                                keyEditor.currentState.setEmpty();
                              });
                            },
                            child: Text("Reset",
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          FlatButton(
                            color: Colors.blue,
                            onPressed: () async {
                              final txt =
                                  await keyEditor.currentState.getText();
                              setState(() {
                                result = txt;
                                isNextPressed = true;
                              });
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(result),
                    )
                  ],
                ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
