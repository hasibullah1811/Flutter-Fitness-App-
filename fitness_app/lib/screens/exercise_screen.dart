import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/exercise_hub.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;
  ExerciseScreen(
      {@required this.exercises, @required this.seconds}); //Constructor

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool _isCompleted = false;
  int _elapsedSeconds = 0;

  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == widget.seconds) {
        t.cancel();
        _isCompleted = true;
      }

      setState(() {
        _elapsedSeconds = t.tick;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.exercises.gif,
              placeholder: (context, url) => Image(
                image: AssetImage("assets/placeholder.jpg"),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          _isCompleted != true
              ? SafeArea(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text("$_elapsedSeconds/${widget.seconds} s"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
