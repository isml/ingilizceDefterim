import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  Gradient themeColor = LinearGradient(
      colors: [Color.fromRGBO(22, 34, 42, 1), Color.fromRGBO(58, 96, 115, 1)]);

  Gradient themeColorLight = LinearGradient(colors: [
    Color.fromRGBO(151,150,240, 1),
    Color.fromRGBO(251,199,212, 1),
  ]);
  Gradient homeCardThemeColor = LinearGradient(colors: [
    Color.fromRGBO(48, 67, 82, 1),
    Color.fromRGBO(215, 210, 204, 1),
  ]);
  Gradient homeCardThemeColorLight = LinearGradient(colors: [
    Color.fromRGBO(255,110,127, 0.7),
    Color.fromRGBO(191,233,255, 0.7),
  ]);
  Gradient testSuccesCardThemeColor = LinearGradient(colors: [
    Color.fromRGBO(29, 151, 108, 1),
    Color.fromRGBO(147, 249, 185, 1),
  ]);
  Gradient testWarningCardThemeColor = LinearGradient(colors: [
    Color.fromRGBO(255, 65, 108, 1),
    Color.fromRGBO(255, 75, 43, 1),
  ]);
  Gradient testAnswerbuttonThemeColor = LinearGradient(colors: [
    Color.fromRGBO(28, 146, 210, 1),
    Color.fromRGBO(242, 252, 254, 1),
  ]);
  Gradient testQuestionCardThemeColor = LinearGradient(colors: [
    Color.fromRGBO(255, 251, 213, 1),
    Color.fromRGBO(176, 106, 179, 1),
  ]);
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  Future<String> themeSelect() async {
    final prefs = await SharedPreferences.getInstance();
    String startTheme = await getThemeFromSharedPref();
    if (startTheme == "dark") {
      await prefs.setString('theme', "light");
    } else {
      await prefs.setString('theme', "dark");
    }
  }

  Future<String> getThemeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startTheme = prefs.getString('theme');
    if (startTheme == null) {
      await prefs.setString('theme', "dark");
      return "dark";
    } else if (startTheme == "dark") {
      return "dark";
    } else {
      return "light";
    }
  }
}
