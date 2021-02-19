import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ingilizcedefterim/db/db.dart';
import 'package:ingilizcedefterim/models/wordModel.dart';
import 'package:ingilizcedefterim/screens/wordTests.dart';
import 'package:ingilizcedefterim/utilities/utilities.dart';
import 'package:route_transitions/route_transitions.dart';

class WordTestScreen extends StatefulWidget {
  String theme;
  WordTestScreen({this.theme});
  @override
  _WordTestScreenState createState() => _WordTestScreenState();
}

class _WordTestScreenState extends State<WordTestScreen> {
  Utilities uti = Utilities();
  List<Word> listWord = List<Word>();
  var db = Db();
  int i = 0, j = 0, questionNumber;
  Color asnwerButtonColor = Colors.white;
  Color wrongAnswerButtonColor = Colors.red;
  Color correctAnswerButtonColor = Colors.green;
  int wordSize;
  Gradient themeColor;

  List<Word> cevaplar = List<Word>();
  @override
  Widget build(BuildContext context) {
    if (widget.theme=="dark") {
      themeColor=uti.themeColor;
    }else{
      themeColor=uti.themeColorLight;
    }
    Size screenSize = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color:widget.theme!="dark"?Colors.black:Colors.white,
          ),
          title: Text(
            "Kelime Testleri",
            style: TextStyle(color:widget.theme!="dark"?Colors.black:Colors.white,),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: themeColor),
          )),
      body: _bodyWidget(screenSize),
    );
  }

  getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  _bodyWidget(Size screenSize) {
    return Stack(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(gradient: themeColor),
        ),
        FutureBuilder<Object>(
            future: _getWord(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: uti.spinkit,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side:
                                  BorderSide(width: 3, color: Colors.white38)),
                          child: Container(
                            height: screenSize.height / 3.8,
                            width: screenSize.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: wordSize >= 10
                                    ? uti.testSuccesCardThemeColor
                                    : uti.testWarningCardThemeColor),
                            child: FlatButton(
                              onPressed: wordSize >= 10
                                  ? () {
                                      questionNumber = 10;
                                      Navigator.of(context).push(
                                          PageRouteTransition(
                                              animationType:
                                                  AnimationType.slide_right,
                                              builder: (context) => WordTests(theme:widget.theme,
                                                  questionNumber:
                                                      questionNumber)));
                                    }
                                  : null,
                              child: wordSize >= 10
                                  ?  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/questions.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(child: Text("10 soruluk test",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15,))),
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/questions.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(
                                                                              child: Text(
                                        "10 soruluk test(Bu teste girecek kadar kelimeniz yoktur)",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15)),
                                      ),
                                    ],
                                  )
                            ),
                          ),
                        ),
                        Material(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side:
                                  BorderSide(width: 3, color: Colors.white38)),
                                                  child: Container(
                            height: screenSize.height / 3.8,
                            width: screenSize.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                
                                gradient: wordSize >= 20
                                    ? uti.testSuccesCardThemeColor
                                    : uti.testWarningCardThemeColor),
                            child: FlatButton(
                              onPressed: wordSize >= 20
                                  ? () {
                                      questionNumber = 20;
                                      Navigator.of(context).push(
                                          PageRouteTransition(
                                              animationType:
                                                  AnimationType.slide_right,
                                              builder: (context) => WordTests(theme:widget.theme,
                                                  questionNumber:
                                                      questionNumber)));
                                    }
                                  : null,
                              child: wordSize >= 20
                                  ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/question2.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(child: Text("20 soruluk test",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15,))),
                                    ],
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/question2.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(
                                                                              child: Text(
                                        "20 soruluk test(Bu teste girecek kadar kelimeniz yoktur)",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15,)),
                                      ),
                                    ],
                                  )
                            ),
                          ),
                        ),
                        Material(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side:
                                  BorderSide(width: 3, color: Colors.white38)),
                                                  child: Container(
                            height: screenSize.height / 3.8,
                            width: screenSize.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                
                                gradient: wordSize >= 50
                                    ? uti.testSuccesCardThemeColor
                                    : uti.testWarningCardThemeColor),
                            child: FlatButton(
                              onPressed: wordSize >= 50
                                  ? () {
                                      questionNumber = 50;
                                      Navigator.of(context).push(
                                          PageRouteTransition(
                                              animationType:
                                                  AnimationType.slide_right,
                                              builder: (context) => WordTests(theme:widget.theme,
                                                  questionNumber:
                                                      questionNumber)));
                                    }
                                  : null,
                              child: wordSize >= 50
                                  ?Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/question3.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(child: Text("50 soruluk test",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15,))),
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/question3.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(
                                                                              child: Text(
                                        "50 soruluk test(Bu teste girecek kadar kelimeniz yoktur)",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15)),
                                      ),
                                    ],
                                  )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  _getWord() async {
    await db.getWords().then((value) => wordSize = value.length);
  }
}
