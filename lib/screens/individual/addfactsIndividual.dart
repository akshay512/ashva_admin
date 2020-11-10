import 'package:flutter/material.dart';

class AddFactsIndividual extends StatefulWidget {
  @override
  _AddFactsIndividualState createState() => _AddFactsIndividualState();
}

class _AddFactsIndividualState extends State<AddFactsIndividual> {
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
                onPressed: () {},
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
}
