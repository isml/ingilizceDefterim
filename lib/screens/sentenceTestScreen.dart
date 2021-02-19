import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ingilizcedefterim/db/db.dart';
import 'package:ingilizcedefterim/models/sentenceModel.dart';
import 'package:ingilizcedefterim/models/wordModel.dart';
import 'package:ingilizcedefterim/screens/sentenceTests.dart';
import 'package:ingilizcedefterim/screens/wordTests.dart';
import 'package:ingilizcedefterim/utilities/utilities.dart';
import 'package:route_transitions/route_transitions.dart';

class SentenceTestScreen extends StatefulWidget {
  String theme;
  SentenceTestScreen({this.theme});
  @override
  _SentenceTestScreenState createState() => _SentenceTestScreenState();
}

class _SentenceTestScreenState extends State<SentenceTestScreen> {
  Utilities uti = Utilities();
  List<Sentence> listSentence = List<Sentence>();
  var db = Db();
  int i = 0, j = 0, questionNumber;
  Color asnwerButtonColor = Colors.white;
  Color wrongAnswerButtonColor = Colors.red;
  Color correctAnswerButtonColor = Colors.green;
  int sentenceSize;
  Gradient themeColor;

  List<Sentence> cevaplar = List<Sentence>();
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
            "Cümle Testleri",
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
                                gradient: sentenceSize >= 10
                                    ? uti.testSuccesCardThemeColor
                                    : uti.testWarningCardThemeColor),
                            child: FlatButton(
                              onPressed: sentenceSize >= 10
                                  ? () {
                                      questionNumber = 10;
                                      Navigator.of(context).push(
                                          PageRouteTransition(
                                              animationType:
                                                  AnimationType.slide_right,
                                              builder: (context) => SentenceTests(theme:widget.theme,
                                                  questionNumber:
                                                      questionNumber)));
                                    }
                                  : null,
                              child: sentenceSize >= 10
                                  ?  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/questions.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(child: Text("10 soruluk test",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15))),
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/questions.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(
                                                                              child: Text(
                                        "10 soruluk test(Bu teste girecek kadar cümleniz yoktur)",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15,)),
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
                                
                                gradient: sentenceSize >= 20
                                    ? uti.testSuccesCardThemeColor
                                    : uti.testWarningCardThemeColor),
                            child: FlatButton(
                              onPressed: sentenceSize >= 20
                                  ? () {
                                      questionNumber = 20;
                                      Navigator.of(context).push(
                                          PageRouteTransition(
                                              animationType:
                                                  AnimationType.slide_right,
                                              builder: (context) => SentenceTests(theme:widget.theme,
                                                  questionNumber:
                                                      questionNumber)));
                                    }
                                  : null,
                              child: sentenceSize >= 20
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
                                        "20 soruluk test(Bu teste girecek kadar cümleniz yoktur)",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15,)),
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
                                
                                gradient: sentenceSize >= 50
                                    ? uti.testSuccesCardThemeColor
                                    : uti.testWarningCardThemeColor),
                            child: FlatButton(
                              onPressed: sentenceSize >= 50
                                  ? () {
                                      questionNumber = 50;
                                      Navigator.of(context).push(
                                          PageRouteTransition(
                                              animationType:
                                                  AnimationType.slide_right,
                                              builder: (context) => SentenceTests(theme:widget.theme,
                                                  questionNumber:
                                                      questionNumber)));
                                    }
                                  : null,
                              child: sentenceSize >= 50
                                  ?Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/question3.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(child: Text("50 soruluk test",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15))),
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Image.asset("assets/images/question3.png",height: screenSize.height/7,width: screenSize.height/7,)),
                                      Expanded(
                                                                              child: Text(
                                        "50 soruluk test(Bu teste girecek kadar cümleniz yoktur)",textAlign: TextAlign.center,style: TextStyle(fontSize: screenSize.width/15)),
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
    await db.getSentences().then((value) => sentenceSize = value.length);
  }
}
