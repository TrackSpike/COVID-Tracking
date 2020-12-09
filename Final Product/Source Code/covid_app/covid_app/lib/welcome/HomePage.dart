import 'dart:async';

import 'package:covid_app/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../pages/pyramid_page.dart';
import 'learnmore.dart';

class HomePageS extends StatefulWidget {
  @override
  _HomePageSState createState() => _HomePageSState();
}

class _HomePageSState extends State<HomePageS> {
  bool isLoading = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 6000), () {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //isLoading is a bool type variable used for adding delay in application for some time so we can view the loading screen
    return isLoading == false
        ? Scaffold(
            //Loading screen with title and Image in start
            backgroundColor: Colors.white,
            body: Center(
                child: Column(
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                        // gradient: LinearGradient(
                        //     begin: Alignment.topRight,
                        //     end: Alignment.bottomLeft,
                        //     color: [Color(0xFF3383CD), Color(0xFF11249F)]),
                        image: DecorationImage(
                            image: AssetImage("assets/virus.png"))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Covid-19 Tracker",
                  style: TextStyle(fontSize: 40),
                )
              ],
            )),
          )
        : Scaffold(
            // Main Screen when App Runs
            backgroundColor: Colors.white,
            appBar: new AppBar(
              backgroundColor: Color(0xFF114084),
              title: Center(
                  child: Text(
                "Covid-19 Tracker",
                style: TextStyle(color: Colors.white),
              )), // Display Main title of the application
            ),
            body: Stack(children: <Widget>[
              Column(
                // First Column which is used to display the text
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xFF3466AA),
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome to",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "COVID-19 Tracker",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                // Second column which is displayed in the center  contain text and Learn more Link
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      //color:Colors.blueGrey[100],
                      width: double.infinity,
                      //height:double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Thank you to download our app",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "With this Application we can keep yourself safe and prevent, Covid-19",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                // At Learnmore we use inkwell to make learn more clickable  its a widget which is used to perform some action at any text & widget
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LearnMore()));
                                },
                                child: Text(
                                  "Learn more",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                  textAlign: TextAlign.left,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Color(0xFF114084),
                            borderRadius: BorderRadius.circular(50)),
                        width: double.infinity,
                        height: 60,
                        child: InkWell(
                          onTap: () {
                            //Get Started Screen will be called here by your team for development process
                             Navigator.push(context,
               MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: Center(
                              child: Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                        ),
                      ),
                    )
                  ])
              //SizedBox(height: 20,),
            ]),
          );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
