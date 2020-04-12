import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Request',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Network Request Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool networkRequestMade=false;
  String statusCode="Welcome";
  void _makeNetworkRequest() async{
    setState(() {
      networkRequestMade=true;
    });
    var url = 'http://slowwly.robertomurray.co.uk/delay/8000/url/http://www.google.co.uk';
    var response = await http.get(url);
    setState(() {
      networkRequestMade=false;
      statusCode=response.statusCode.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            networkRequestMade? new CircularProgressIndicator(
              backgroundColor: Colors.red,
            ):Text(
              statusCode,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: networkRequestMade?Colors.grey:Theme.of(context).primaryColor,
        onPressed: networkRequestMade?null:_makeNetworkRequest,
        tooltip: 'Make Network Request',
        label: networkRequestMade?Text("Awaiting Response"):Text("Make Network Request"),
        icon: networkRequestMade?Icon(Icons.pause):Icon(Icons.call_made),
      ),
    );
  }
}
