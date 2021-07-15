import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final String title;
  const InfoPage({Key? key, this.title = 'InfoPage'}) : super(key: key);
  @override
  InfoPageState createState() => InfoPageState();
}
class InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}