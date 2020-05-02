import 'dart:convert';

import 'package:covid_19/models/global-stats.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        hintColor: Color(0xFFC90F19),
        primaryColor: Color(0xFFC90F19),
        canvasColor: Colors.transparent,
        fontFamily: "Montserrat",
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalStatsResult _globalStats;
  void _getGlobalStats() async {
    const url = "https://api.thevirustracker.com/free-api?global=stats";
    http.Response res = await http.get(url);
    setState(() {
      this._globalStats = GlobalStats.fromJson(res.body).results[0];
    });
  }

  @override
  void initState() {
    super.initState();
    _getGlobalStats();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          // hero image
          HeroImage(),
          Expanded(
            child: Container(
              color: Colors.grey[900],
              child: ListView(
                children: <Widget>[
                  InfoCard(
                    background: LinearGradient(
                      colors: [Colors.red[600], Colors.red[900]],
                    ),
                    label: "Deaths",
                    total: _globalStats != null
                        ? _globalStats.totalDeaths
                        : null,
                    newTotal: _globalStats != null
                        ? _globalStats.totalNewDeathsToday
                        : null,
                  ),
                  InfoCard(
                    background: LinearGradient(
                      colors: [Colors.amber[600], Colors.amber[900]],
                    ),
                    label: "Cases",
                    total: _globalStats != null
                        ? _globalStats.totalCases
                        : null,
                    newTotal: _globalStats != null
                        ? _globalStats.totalNewCasesToday
                        : null,
                  ),
                  InfoCard(
                    background: LinearGradient(
                      colors: [Colors.pink[600], Colors.pink[900]],
                    ),
                    label: "Recovereds",
                    total: _globalStats != null
                        ? _globalStats.totalRecovered
                        : null,
                  ),
                  InfoCard(
                    background: LinearGradient(
                      colors: [Colors.green[600], Colors.green[900]],
                    ),
                    label: "Unresolved",
                    total: _globalStats != null
                        ? _globalStats.totalUnresolved
                        : null,
                  ),
                  InfoCard(
                    background: LinearGradient(
                      colors: [Colors.blue[600], Colors.blue[900]],
                    ),
                    label: "Serious",
                    total: _globalStats != null
                        ? _globalStats.totalSeriousCases
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final LinearGradient background;
  final int total;
  final int newTotal;
  final String label;
  const InfoCard({
    Key key, 
    @required this.background,
    @required this.label,
    this.total,
    this.newTotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        gradient: background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Total ${this.label}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${this.total == null ? "" : total}",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),
            Divider(
              height: 16,
            ),
            newTotal != null ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "New ${this.label}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "$newTotal",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ) : Container(),
          ],
        ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image(
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/banner.jpg"),
          ),
          Positioned(
            child: Container(
              height: 200,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        //   stops: [0, 1],
                        //   colors: [Colors.black, Colors.red],
                        // ),
                        color: Colors.grey[900],
                        ),
                  ),
                  clipper: BottomWaveClipper(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, -20, size.width / 2, 20);
    path.quadraticBezierTo(3 / 4 * size.width, size.height, size.width, 20);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
