import 'package:flutter/material.dart';

class TipList extends StatefulWidget {
  @override
  _TipListState createState() => _TipListState();
}

class _TipListState extends State<TipList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Text('holaaa si funcionaa'),
      ),
    );
  }
}
