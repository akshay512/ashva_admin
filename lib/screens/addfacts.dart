import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sampleLoginPage/screens/managefacts.dart';
import 'package:sampleLoginPage/services/httpRequestBody.dart';

class AddFacts extends StatefulWidget {
  @override
  _AddFactsState createState() => _AddFactsState();
}

class _AddFactsState extends State<AddFacts> {
  double width, height;
  bool isBtnLoading = false;
  TextEditingController _factdesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Facts',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Add Facts :",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextFormField(
                controller: _factdesc,
                maxLines: 9,
                decoration: const InputDecoration(
                  labelText: "Fact Description",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(fontSize: 16),
                  border: const UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Center(
                child: (isBtnLoading)
                    ? CircularProgressIndicator()
                    : ProgressButton(
                        defaultWidget: const Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white),
                        ),
                        progressWidget: const CircularProgressIndicator(),
                        width: 196,
                        height: 40,
                        borderRadius: 10.0,
                        animate: true,
                        type: ProgressButtonType.Raised,
                        color: Colors.blue,
                        onPressed: () async {
                          int score = await Future.delayed(
                              const Duration(milliseconds: 3000), () => 42);

                          return () async {
                            // if (!await user.signIn(_email.text, _pass.text))
                            //   _key.currentState.showSnackBar(SnackBar(
                            //     content: Text("Value entered does not match"),
                            //   ));
                            DateTime date = DateTime.now();
                            postFactData({
                              "factDate":
                                  "${date.day}-${date.month}-${date.year}",
                              "factDescription": _factdesc.text,
                              "factName": "Title"
                            });
                          };
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postFactData(Map<String, dynamic> reqBody) async {
    setState(() {
      isBtnLoading = true;
    });
    Response response =
        await newHttpPostAuth(uri: uriList['createFact'], body: reqBody);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ManageFacts()));
      print(response.body);

      setState(() {
        isBtnLoading = false;
      });
    } else {
      print('failed');
    }

    // print("post edit data");
  }
}
