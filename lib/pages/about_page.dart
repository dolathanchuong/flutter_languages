import 'package:flutter/material.dart';
//Package Customer
import 'package:flutter_languages/classes/language_constants.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(translation(context).aboutUs),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(translation(context).about),
        ),
      ),
    );
  }
}
