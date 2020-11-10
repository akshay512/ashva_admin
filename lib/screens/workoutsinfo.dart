import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class WorkoutInfo extends StatefulWidget {
  WorkoutInfo({Key key}) : super(key: key);

  @override
  _WorkoutInfoState createState() => _WorkoutInfoState();
}

class _WorkoutInfoState extends State<WorkoutInfo> {
  String htmlData = """
        <div>
          <h1>Demo Template</h1>
          <p>This is a fantastic product that you should buy!</p>
          <h3>Features</h3>
          <ul>
            <li>It actually works</li>
            <li>It exists</li>
            <li>It doesn't cost much!</li>
          </ul>
          <!--You can pretty much put any html in here!-->
        </div>
      """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Workout template',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            Html(
              data: htmlData,
              //Optional parameters:
              style: {
                "html": Style(
                  backgroundColor: Colors.black12,
//              color: Colors.white,
                ),
//            "h1": Style(
//              textAlign: TextAlign.center,
//            ),
                "table": Style(
                  backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                ),
                "tr": Style(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                "th": Style(
                  padding: EdgeInsets.all(6),
                  backgroundColor: Colors.grey,
                ),
                "td": Style(
                  padding: EdgeInsets.all(6),
                ),
                "var": Style(fontFamily: 'serif'),
              },
              // customRender: {
              //   "flutter": (RenderContext context, Widget child, attributes, _) {
              //     return FlutterLogo(
              //       style: (attributes['horizontal'] != null)
              //           ? FlutterLogoStyle.horizontal
              //           : FlutterLogoStyle.markOnly,
              //       textColor: context.style.color,
              //       size: context.style.fontSize.size * 5,
              //     );
              //   },
              // },
              onLinkTap: (url) {
                print("Opening $url...");
              },
              onImageTap: (src) {
                print(src);
              },
              onImageError: (exception, stackTrace) {
                print(exception);
              },
            ),
          ],
        ),
      ),
    );
  }
}
