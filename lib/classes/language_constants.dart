import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String languageCODE = 'languageCode';

//languages code
const String eNGLISH = 'en';
const String fARSI = 'fa';
const String aRABIC = 'ar';
const String hINDI = 'hi';
const String vietNam = 'vi';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(languageCODE) ?? eNGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case eNGLISH:
      return const Locale(eNGLISH, '');
    case fARSI:
      return const Locale(fARSI, "");
    case aRABIC:
      return const Locale(aRABIC, "");
    case hINDI:
      return const Locale(hINDI, "");
    case vietNam:
      return const Locale(vietNam, "");
    default:
      return const Locale(eNGLISH, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
