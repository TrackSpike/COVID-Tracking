import 'package:flutter/material.dart';

class ScreenMoreN extends StatefulWidget {
  @override
  _ScreenMoreNState createState() => _ScreenMoreNState();
}

class _ScreenMoreNState extends State<ScreenMoreN> {
  // Screen to display Text and Heading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Color(0xFF114084),
        title: Center(
            child: Text(
          "Covid-19 Tracker",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFF3466AA),
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Main Heading",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat congue urna, eget tempor nibh scelerisque eget. Donec a dui sodales, gravida mi vitae, ornare neque. Aliquam erat volutpat. Integer purus augue, interdum ut ipsum interdum, volutpat rhoncus metus. Nunc volutpat tempus interdum. Donec fringilla nibh quis lacus bibendum sagittis. Pellentesque ultrices velit vel ultricies pulvinar. Mauris eu vulputate sapien. Suspendisse porttitor diam gravida libero gravida mollis in sit amet purus. Maecenas lobortis, odio efficitur malesuada ultricies, nisi nulla fermentum felis, non congue felis libero ac eros. Nulla malesuada ultricies tellus, vitae bibendum risus tristique ut. Vestibulum a vulputate urna. Duis metus nisl, hendrerit vitae sodales id, feugiat vel tellus.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
