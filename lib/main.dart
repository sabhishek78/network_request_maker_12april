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
  bool networkRequestComplete = false;
  String statusCode = "Welcome";
  bool buttonPressed = false;
  var appState;

  @override
  void initState() {
    super.initState();
    networkRequestComplete = false;
    statusCode = "Welcome";
    buttonPressed = false;
    _makeNetworkRequest();
  }
  void buttonPressedEvent(){
    buttonPressed = true;
    setState(() {});
  }
  void _makeNetworkRequest() async {
    var url =
        'http://slowwly.robertomurray.co.uk/delay/8000/url/http://www.google.co.uk';
    var response = await http.get(url);
    setState(() {
      networkRequestComplete = true;
      statusCode = response.statusCode.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!buttonPressed){
      appState=1;
    }
    else if(buttonPressed && !networkRequestComplete){
      appState=2;
    }
    else if(buttonPressed && networkRequestComplete){
      appState=3;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            appState==1 ? Text(
              "Welcome",
              style: Theme.of(context).textTheme.display1,
            ): appState==2 ? CircularProgressIndicator(
              backgroundColor: Colors.red,
            ):Text(
              statusCode,
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appState==1?Theme.of(context).primaryColor: appState==2?Colors.grey:Theme.of(context).primaryColor,
        onPressed: appState==2 ? null: buttonPressedEvent,
        label: appState==1 ? Text("Make Network Request"): appState==2 ? Text("Awaiting Response"): Text("Response Received"),

        icon: appState==1 ? Icon(Icons.call_made) : appState==2?Icon(Icons.access_alarm):Icon(Icons.pause_circle_outline),
      ),
    );
  }
}
