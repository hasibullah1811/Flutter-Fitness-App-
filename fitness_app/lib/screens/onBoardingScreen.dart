import 'package:fitness_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

var pages = [
//Screen 1
  PageViewModel(
    title: "Title of first page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: Center(
      child: Image.asset("assets/1.png", height: 175.0),
    ),
    decoration: const PageDecoration(),
  ),

//Screen 2
  PageViewModel(
    title: "Title of first page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: Center(
      child: Image.asset("assets/2.png", height: 175.0),
    ),
  ),

//Screen 3
  PageViewModel(
    title: "Title of first page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: Center(
      child: Image.asset("assets/3.png", height: 175.0),
    ),
  )
];

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          // When done button is press
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        onSkip: () {
          // You can also override onSkip callback
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        showSkipButton: true,
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.arrow_right),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.deepOrange,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
