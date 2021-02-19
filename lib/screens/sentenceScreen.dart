import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ingilizcedefterim/db/db.dart';
import 'package:ingilizcedefterim/models/sentenceModel.dart';
import 'package:ingilizcedefterim/models/wordModel.dart';
import 'package:ingilizcedefterim/utilities/utilities.dart';
import 'package:swipeable_card/swipeable_card.dart';

class SentenceScreen extends StatefulWidget {
  String theme;
  SentenceScreen({this.theme});
  @override
  _SentenceScreenState createState() => _SentenceScreenState();
}

class _SentenceScreenState extends State<SentenceScreen> {
  Utilities uti = Utilities();
  List<Sentence> listSentence = List<Sentence>();
  var db = Db();
  final _formKey = GlobalKey<FormState>();
  CardController controller;
  Gradient themeColor;
  @override
  Widget build(BuildContext context) {
    if (widget.theme == "dark") {
      themeColor = uti.themeColor;
    } else {
      themeColor = uti.themeColorLight;
    }
    Size screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(Icons.add),
          onPressed: () {
            _showMyDialog();
          },
        ),
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: widget.theme != "dark" ? Colors.black : Colors.white,
            ),
            title: Text(
              "Cümlelerim",
              style: TextStyle(
                  color: widget.theme != "dark" ? Colors.black : Colors.white),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: themeColor),
            )),
        body: _bodyWidget(screenSize));
  }

  _bodyWidget(Size screenSize) {
    return Stack(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(gradient: themeColor),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Object>(
                  future: _wordList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: uti.spinkit,
                      );
                    } else {
                      if (listSentence.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(height: screenSize.height / 2.5),
                            Center(
                              child: Text(
                                "Henüz cümleniz yoktur,lütfen ekleyiniz :)",
                                style: TextStyle(
                                    color: widget.theme == "dark"
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: screenSize.height / 25,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return FlipCard(
                              front: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 3),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(131, 164, 212, 1),
                                      Color.fromRGBO(182, 251, 255, 1)
                                    ])),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(icon: Icon(Icons.delete,size: screenSize.width/12,), onPressed: (){
                                          setState(() {
                                             db.deleteSentence(listSentence[index].id);
                                          });
                                         
                                        }),
                                      ),
                                    ),
                                    Center(
                                        child:AutoSizeText(
                                      listSentence[index].eng ,textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 50),
                                        minFontSize: 10,
                                        stepGranularity: 10,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Türkçesini görmek için tıklayınız",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              back: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 3),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(252, 234, 187, 1),
                                      Color.fromRGBO(248, 181, 0, 1)
                                    ])),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(icon: Icon(Icons.delete,size: screenSize.width/12,), onPressed: (){
                                          setState(() {
                                             db.deleteSentence(listSentence[index].id);
                                          });
                                         
                                        }),
                                      ),
                                    ),
                                    Center(
                                        child: AutoSizeText(
                                          
                                      listSentence[index].tr ,textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 50),
                                        minFontSize: 10,
                                        stepGranularity: 10,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "İngilizcesini görmek için tıklayınız",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: listSentence.length,
                          itemWidth: screenSize.width / 1.2,
                          itemHeight: screenSize.height / 1.3,
                          layout: SwiperLayout.TINDER,
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ],
    );
    //caresoul slider ile denenecek
  }

  Future<void> _showMyDialog() async {
    String tr, eng;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Colors.amber[200],
          title: Text('Cümle Ekle '),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'İngilizce',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Lütfen ingilizce cümle giriniz';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      eng = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Türkçe',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Lütfen türkçe cümle giriniz';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      tr = value;
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                width: 3, color: Colors.blueGrey[600])),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 3),
                              color: Colors.green[300]),
                          child: FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                int sonId;
                                _formKey.currentState.save();
                                await db.getSentences().then((value) => {
                                      if (value.isEmpty)
                                        {sonId = 1}
                                      else
                                        {
                                          sonId = value.last.id + 1,
                                          //print(value.last.id.toString()+"asdasdasd")
                                        }
                                    });
                                Sentence sentence = Sentence(sonId, tr, eng);
                                setState(() {
                                  db.SaveSentence(sentence);
                                  Navigator.pop(context);
                                });
                              }
                              //print(sonId.toString());
                            },
                            child: Text('Ekle'.toUpperCase(),style: TextStyle(color:Colors.white),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        );
      },
    );
  }

  _wordList() async {
    listSentence.clear();
    await db.getSentences().then((value) => {
          value.forEach((element) {
            listSentence.add(element);
            listSentence.shuffle();
          })
        });
  }
}
