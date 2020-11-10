import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:sampleLoginPage/screens/liveTraining.dart';
import 'package:sampleLoginPage/services/httpRequestBody.dart';

class NewSession extends StatefulWidget {
  @override
  _NewSessionState createState() => _NewSessionState();
}

class _NewSessionState extends State<NewSession> {
  TextEditingController _title = TextEditingController();
  TextEditingController _trainers = TextEditingController();
  TextEditingController _url = TextEditingController();
  final formatTime = DateFormat("hh:mm a");
  final format = DateFormat("dd-MM-yyyy");
  TimeOfDay _endTime;
  TimeOfDay _startTime;
  DateTime _date;

  var category = [
    'Running',
    'Cardio',
    'Yoga',
  ];
  String selectedValue;
  List<dynamic> categoryList;
  double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new live session"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'title'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _trainers,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'trainers'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _url,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'url'),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('select start date'),
                    DateTimeField(
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        _date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));

                        return _date;
                      },
                    ),
                  ]),
              SizedBox(
                height: 20,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Select start time'),
                    DateTimeField(
                      format: formatTime,
                      onShowPicker: (context, currentValue) async {
                        _startTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.convert(_startTime);
                      },
                    ),
                  ]),
              SizedBox(
                height: 20,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Select end time'),
                    DateTimeField(
                      format: formatTime,
                      onShowPicker: (context, currentValue) async {
                        _endTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.convert(_endTime);
                      },
                    ),
                  ]),
              SizedBox(
                height: 80,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: width * .3),
                shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                onPressed: () {
                  print(_startTime.toString() +
                      "  " +
                      _endTime.toString() +
                      "  " +
                      _date.toString() +
                      " " +
                      _url.text +
                      "  " +
                      _trainers.text);

                  postCreateSessionData({
                    "currentSize": 0,
                    "description": "url",
                    "endTimeStr": "${_endTime.hour}:${_endTime.minute}",
                    "startTimeStr": "${_startTime.hour}:${_startTime.minute}",
                    "title": _title.text,
                    "totalSize": 90,
                    "trainerName": _trainers.text,
                    "trainingSessionDateStr":
                        "${DateFormat("dd-MM-yyyy").format(_date)}"
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
      ),
    );
  }

  Future<void> postCreateSessionData(Map<String, dynamic> reqBody) async {
    // print(reqBody);
    Response response =
        await newHttpPostAuth(uri: uriList['createSession'], body: reqBody);

    if (response.statusCode == 200) {
      print(response.body);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LiveTraining()));
    } else {
      print('failed');
    }

    // print("post edit data");
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}
