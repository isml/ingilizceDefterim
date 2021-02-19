import 'package:flutter/material.dart';
import 'package:ingilizcedefterim/screens/sentenceScreen.dart';
import 'package:ingilizcedefterim/screens/sentenceTestScreen.dart';
import 'package:ingilizcedefterim/screens/wordScreen.dart';
import 'package:ingilizcedefterim/screens/wordTestScreen.dart';
import 'package:ingilizcedefterim/utilities/utilities.dart';
import 'package:route_transitions/route_transitions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Utilities uti = Utilities();
  String theme;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<Object>(
        future: _getTheme(),
        builder: (context, snapshot) {
          print(theme);
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "İngilizce Defterim",
                  style: TextStyle(
                      color: theme == "dark" ? Colors.white : Colors.black),
                ),
                centerTitle: true,
                elevation: 5,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: theme == "dark"
                          ? uti.themeColor
                          : uti.themeColorLight),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                          theme == "dark" ? Icons.wb_sunny : Icons.nights_stay,
                          color: theme == "dark" ? Colors.white : Colors.black),
                      onPressed: () async {
                        setState(() {
                          uti.themeSelect();
                        });
                      })
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        gradient: theme == "dark"
                            ? uti.themeColor
                            : uti.themeColorLight),
                  ),
                  _bodyWidget(screenSize),
                ],
              ));
        });
  }

  _bodyWidget(Size screenSize) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _wordButton(screenSize),
              _sentenceButton(screenSize),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _wordTestButton(screenSize),
              _sentenceTestButton(screenSize),
            ],
          )
        ],
      ),
    );
  }

  _wordButton(Size screenSize) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 3, color: Colors.blueGrey[600])),
      elevation: 5,
      child: Container(
        height: screenSize.height / 2.6,
        width: screenSize.width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: theme == "dark"
                ? uti.homeCardThemeColor
                : uti.homeCardThemeColorLight),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            //sayfa yönlendirmesi
            Navigator.of(context).push(PageRouteTransition(
                animationType: AnimationType.slide_right,
                builder: (context) => WordScreen(theme:theme)));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenSize.width / 2.6,
                  height: screenSize.width / 2.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/word.png"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Kelimelerim",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        
                        fontSize: 30),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  _sentenceButton(Size screenSize) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 3, color: Colors.blueGrey[600])),
      elevation: 5,
      child: Container(
        height: screenSize.height / 2.6,
        width: screenSize.width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: theme == "dark"
                ? uti.homeCardThemeColor
                : uti.homeCardThemeColorLight),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            //sayfa yönlendirmesi
            Navigator.of(context).push(PageRouteTransition(
                animationType: AnimationType.slide_right,
                builder: (context) => SentenceScreen(theme:theme)));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenSize.width / 2.6,
                  height: screenSize.width / 2.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/sentence.png"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cümlelerim",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        
                        fontSize: 30),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  _wordTestButton(Size screenSize) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 3, color: Colors.blueGrey[600])),
      elevation: 5,
      child: Container(
        height: screenSize.height / 2.6,
        width: screenSize.width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: theme == "dark"
                ? uti.homeCardThemeColor
                : uti.homeCardThemeColorLight),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            //sayfa yönlendirmesi
            Navigator.of(context).push(PageRouteTransition(
                animationType: AnimationType.slide_right,
                builder: (context) => WordTestScreen(theme:theme)));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenSize.width / 2.6,
                  height: screenSize.width / 2.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/wordTest.png"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Kelime Testleri",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        
                        fontSize: 30),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  _sentenceTestButton(Size screenSize) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 3, color: Colors.blueGrey[600])),
      elevation: 5,
      child: Container(
        height: screenSize.height / 2.6,
        width: screenSize.width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: theme == "dark"
                ? uti.homeCardThemeColor
                : uti.homeCardThemeColorLight),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            //sayfa yönlendirmesi
            Navigator.of(context).push(PageRouteTransition(
                animationType: AnimationType.slide_right,
                builder: (context) => SentenceTestScreen(theme:theme)));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenSize.width / 2.6,
                  height: screenSize.width / 2.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/sentenceTest.png"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cümle Testleri",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        
                        fontSize: 30),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  _getTheme() async {
    theme = await uti.getThemeFromSharedPref();
  }
}
