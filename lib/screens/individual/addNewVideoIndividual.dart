import 'package:flutter/material.dart';

class NewVideoIndividual extends StatefulWidget {
  @override
  _NewVideoIndividualState createState() => _NewVideoIndividualState();
}

class _NewVideoIndividualState extends State<NewVideoIndividual> {
  TextEditingController _category = TextEditingController();

  TextEditingController _title = TextEditingController();

  TextEditingController _url = TextEditingController();

  TextEditingController _desc = TextEditingController();

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
        title: Text("Add new video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _title,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'title'),
            ),
            TextFormField(
              controller: _url,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'url'),
            ),
            TextFormField(
              controller: _desc,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'description'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Select a category"),
                DropdownButton<String>(
                  value: selectedValue,
                  items: category.map((dynamic value) {
                    return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(
                          value,
                        ));
                  }).toList(),
                  onChanged: (_value) {
                    setState(() {
                      selectedValue = _value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: width * .3),
              shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
              onPressed: () {},
              color: Colors.blue,
              child: Text(
                'SUBMIT',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
