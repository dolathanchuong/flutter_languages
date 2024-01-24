import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
//Package Customer
import 'package:flutter_languages/classes/language.dart';
import 'package:flutter_languages/classes/language_constants.dart';
import 'package:flutter_languages/main.dart';
import 'package:flutter_languages/router/route_constants.dart';

import '../constants.dart';

///
/// (1): Menu Left
///
/// (2): Title - (2.0): Title_Change_Language - (2.1): Title_Align_Center
///
/// (3): Languages - (3.1): Language_Icon - (3.2): Language_Change - (3.3): language_List
///
/// (4): Body
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Logger logger = Logger();

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      //(2): Title - (2.0): Title_Change_Language - (2.1): Title_Align_Center
      //(3): Languages - (3.1): Language_Icon - (3.2): Language_Change - (3.3): language_List
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          //(2.0)
          translation(context).homePage,
          //(2.1)
          textAlign: TextAlign.center,
        ),
        //(2.1)
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            //(3)
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              //(3.1)
              icon: const Icon(
                Icons.language,
                color: Colors.green,
              ),
              //(3.2)
              onChanged: (Language? language) async {
                if (language != null) {
                  MyApp.setLocale(
                      context, await setLocale(language.languageCode));
                }
                logger.i('Selected Language : ${language!.languageCode}');
              },
              //(3.3)
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      //
      //(1) : Call Menu_Left_Container
      drawer: Drawer(
        child: _drawerList(),
      ),
      //
      //(4) : Call Body_Form
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _mainForm(context),
      ),
    );
  }

  ///
  /// (4): Body_Form
  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Text(
                translation(context).personalInformation,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).name,
              hintText: translation(context).nameHint,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).email,
              hintText: translation(context).emailHint,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: translation(context).dateOfBirth,
            ),
            onTap: () async {
              logger.i('Chose Date Created!');
              FocusScope.of(context).requestFocus(FocusNode());
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(DateTime.now().year + 20),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              logger.i('Click Submit');
              if (_key.currentState != null && _key.currentState!.validate()) {
                _showSuccessDialog();
              }
            },
            height: 50,
            shape: const StadiumBorder(),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                translation(context).submitInfo,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// (1): Menu_Left_Container
  Container _drawerList() {
    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: SizedBox(
              height: 100,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(loGoAssetImage),
                // child: ClipOval(
                //   child: Image(
                //     image: AssetImage(loGoAssetImage),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                //backgroundColor: Colors.lightGreen,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              translation(context).aboutUs,
              style: textStyle,
            ),
            onTap: () {
              logger.i('Pop Up About!');
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, aboutRoute);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              translation(context).settings,
              style: textStyle,
            ),
            onTap: () {
              logger.i('Pop Up Settings!');
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, settingsRoute);
            },
          ),
        ],
      ),
    );
  }
}
