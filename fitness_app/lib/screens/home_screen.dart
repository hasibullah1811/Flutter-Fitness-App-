import 'dart:convert';

import 'package:fitness_app/screens/exercise_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/screens/exercise_hub.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiUrl =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  ExerciseHub exerciseHub;

  @override
  void initState() {
    getExercise();

    super.initState();
  }

  void getExercise() async {
    var response = await http.get(apiUrl);
    var body = response.body;

    var decodedJson = jsonDecode(body);
    exerciseHub = ExerciseHub.fromJson(decodedJson);

    setState(() {});
    //return decodedJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: exerciseHub != null
            ? ListView(
                children: exerciseHub.exercises.map((e) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseStartScreen(
                            exercises: e,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: e.id,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: FadeInImage(
                                image: NetworkImage(e.thumbnail),
                                placeholder:
                                    AssetImage("assets/placeholder.jpg"),
                                width: MediaQuery.of(context).size.width,
                                height: 250.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF000000),
                                    Color(0x00000000),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                )),
                              ),
                            ),
                            Container(
                              height: 250,
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                e.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}
