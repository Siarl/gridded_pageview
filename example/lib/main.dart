import 'package:flutter/material.dart';
import 'package:gridded_pageview/gridded_pageview.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GriddedPageView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'GriddedPageView Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController _controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GriddedPageView(
        controller: _controller,
        preferredChildWidth: 160,
        preferredChildHeight: 160,
        children: List<Widget>.generate(20, (int index) {
          return Container(
            color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          );
        }),
        // overlapIndicator: false,
      )
    );
  }
}
