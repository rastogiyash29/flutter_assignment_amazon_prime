import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/home_screen.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {checkUserAndRedirect(context);});
  }

  void checkUserAndRedirect(context) async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.popAndPushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(40.0),
            child: Image.asset('assets/images/logo.png'),
          ),
          SizedBox(height: 30.0,),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                  'Yash Amazon',
                  textStyle: splashScreentextStyle,
                  speed: Duration(milliseconds: 150),
                  textAlign: TextAlign.center,
                cursor: ""
              ),
            ],
            isRepeatingAnimation: false,
          ),
        ],
      ),
    );
  }
}