import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sampleLoginPage/screens/managefacts.dart';
import 'package:sampleLoginPage/services/httpRequestBody.dart';

class EditFacts extends StatefulWidget {
  final Map<String, dynamic> fact;

  const EditFacts({Key key, this.fact}) : super(key: key);

  @override
  _EditFactsState createState() => _EditFactsState();
}

class _EditFactsState extends State<EditFacts> {
  double width, height;
  TextEditingController _facts;
  bool isBtnLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _facts = new TextEditingController(text: widget.fact["factDescription"]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Facts',
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
                    "Edit Facts :",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextFormField(
                controller: _facts,
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
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: width * .2),
                shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                onPressed: (isBtnLoading)
                    ? null
                    : () {
                        DateTime date = DateTime.now();
                        postFactData({
                          "factId": widget.fact["factId"],
                          "factDate": "${date.day}-${date.month}-${date.year}",
                          "factDescription": _facts.text,
                          "factName": "Title"
                        });
                      },
                color: Colors.blue,
                child: (isBtnLoading)
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text(
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
