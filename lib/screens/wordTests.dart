import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ingilizcedefterim/db/db.dart';
import 'package:ingilizcedefterim/models/wordModel.dart';
import 'package:ingilizcedefterim/utilities/utilities.dart';

class WordTests extends StatefulWidget {
  String theme;

  int questionNumber;
  WordTests({this.questionNumber, this.theme});
  @override
  _WordTestsState createState() => _WordTestsState();
}

class _WordTestsState extends State<WordTests> {
  Utilities uti = Utilities();
  List<Word> listWords = List<Word>();
  List<Word> listWord = List<Word>();
  Word randomWord;
  var db = Db();
  int i = 0, j = 0;
  Color asnwerButtonColor = Colors.white;
  Color wrongAnswerButtonColor = Colors.red;
  Color correctAnswerButtonColor = Colors.green;
  int wordSize;
  int cevapKontrolSayac = 0;
  Gradient themeColor;
  List<Word> cevaplar = List<Word>();
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
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: widget.theme != "dark" ? Colors.black : Colors.white,
          ),
          title: Text(
            "Kelime Testi",
            style: TextStyle(
              color: widget.theme != "dark" ? Colors.black : Colors.white,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: themeColor),
          )),
      body: _deneme(screenSize),
    );
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
            future: _getWords(),
            builder: (context, snapshot) {
              print("i+" + i.toString());
              return i == listWord.length
                  ? Center(child: Text(""))
                  : Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Toplam doğru sayısı : " + j.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                      width: 3, color: Colors.pink[50])),
                              child: Container(
                                width: screenSize.width / 1.2,
                                height: screenSize.height / 1.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: uti.testQuestionCardThemeColor,
                                ),
                                child: Center(
                                    child: Text(
                                  i >= listWord.length ? "" : listWord[i].eng,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: screenSize.height / 10,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Material(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          width: 2, color: Colors.white38)),
                                  child: Container(
                                    height: screenSize.height / 15,
                                    width: screenSize.width / 3.3,
                                    decoration: BoxDecoration(
                                      gradient: uti.testAnswerbuttonThemeColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: FlatButton(
                                        onPressed: () {
                                          print(listWord.length.toString());
                                          if (listWord[i].tr ==
                                              cevaplar[0].tr) {
                                            if (i <= listWord.length) {
                                              setState(() {
                                                if (cevapKontrolSayac == 0) {
                                                  j++;
                                                }
                                                i++;

                                                cevapKontrolSayac = 0;
                                                if (i ==
                                                    widget.questionNumber) {
                                                  _showMyDialog();
                                                }
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              cevapKontrolSayac++;
                                            });
                                          }
                                        },
                                        child: Text(cevaplar[0].tr,
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.width / 18))),
                                  ),
                                ),
                                Material(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          width: 2, color: Colors.white38)),
                                  child: Container(
                                    height: screenSize.height / 15,
                                    width: screenSize.width / 3.3,
                                    decoration: BoxDecoration(
                                      gradient: uti.testAnswerbuttonThemeColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (listWord[i].tr ==
                                              cevaplar[1].tr) {
                                            if (i <= listWord.length) {
                                              setState(() {
                                                if (cevapKontrolSayac == 0) {
                                                  j++;
                                                }
                                                cevapKontrolSayac = 0;
                                                i++;
                                                if (i ==
                                                    widget.questionNumber) {
                                                  _showMyDialog();
                                                }
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              cevapKontrolSayac++;
                                            });
                                          }
                                        },
                                        child: Text(cevaplar[1].tr,
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.width / 18))),
                                  ),
                                ),
                                Material(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          width: 2, color: Colors.white38)),
                                  child: Container(
                                    height: screenSize.height / 15,
                                    width: screenSize.width / 3.3,
                                    decoration: BoxDecoration(
                                      gradient: uti.testAnswerbuttonThemeColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (listWord[i].tr ==
                                              cevaplar[2].tr) {
                                            if (i <= listWord.length) {
                                              setState(() {
                                                if (cevapKontrolSayac == 0) {
                                                  j++;
                                                }
                                                i++;
                                                cevapKontrolSayac = 0;
                                                if (i ==
                                                    widget.questionNumber) {
                                                  _showMyDialog();
                                                }
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              cevapKontrolSayac++;
                                            });
                                          }
                                        },
                                        child: Text(
                                          cevaplar[2].tr,
                                          style: TextStyle(
                                              fontSize: screenSize.width / 18),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
            }),
      ],
    );
  }

  _deneme(Size screenSize) {
    return Stack(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(gradient: themeColor),
        ),
        FutureBuilder<Object>(
            future: _getWords(),
            builder: (context, snapshot) {
              return i == listWord.length
                  ? Center(child: Text(""))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Toplam doğru sayısı : " + j.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Material(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    width: 3, color: Colors.pink[50])),
                            child: Container(
                              width: screenSize.width / 1.2,
                              height: screenSize.height / 1.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: uti.testQuestionCardThemeColor,
                              ),
                              child: Center(
                                  child: Text(
                                i >= listWord.length ? "" : listWord[i].eng,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenSize.height / 10,
                                ),
                              )),
                            ),
                          ),
                          Container(
                            height: screenSize.height / 3.6,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              width: 2, color: Colors.white38)),
                                      child: Container(
                                        height: screenSize.height / 15,
                                        width: screenSize.width / 1.1,
                                        decoration: BoxDecoration(
                                          gradient:
                                              uti.testAnswerbuttonThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                              print(listWord.length.toString());
                                              if (listWord[i].tr ==
                                                  cevaplar[0].tr) {
                                                if (i <= listWord.length) {
                                                  setState(() {
                                                    if (cevapKontrolSayac ==
                                                        0) {
                                                      j++;
                                                    }
                                                    i++;

                                                    cevapKontrolSayac = 0;
                                                    if (i ==
                                                        widget.questionNumber) {
                                                      _showMyDialog();
                                                    }
                                                  });
                                                }
                                              } else {
                                                setState(() {
                                                  cevapKontrolSayac++;
                                                });
                                              }
                                            },
                                            child: AutoSizeText(
                                              cevaplar[0].tr,
                                              style: TextStyle(fontSize: 25),
                                              minFontSize: 10,
                                              stepGranularity: 10,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              width: 2, color: Colors.white38)),
                                      child: Container(
                                        height: screenSize.height / 15,
                                        width: screenSize.width / 1.1,
                                        decoration: BoxDecoration(
                                          gradient:
                                              uti.testAnswerbuttonThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                              if (listWord[i].tr ==
                                                  cevaplar[1].tr) {
                                                if (i <= listWord.length) {
                                                  setState(() {
                                                    if (cevapKontrolSayac ==
                                                        0) {
                                                      j++;
                                                    }
                                                    cevapKontrolSayac = 0;
                                                    i++;
                                                    if (i ==
                                                        widget.questionNumber) {
                                                      _showMyDialog();
                                                    }
                                                  });
                                                }
                                              } else {
                                                setState(() {
                                                  cevapKontrolSayac++;
                                                });
                                              }
                                            },
                                            child: AutoSizeText(
                                              cevaplar[1].tr,
                                              style: TextStyle(fontSize: 25),
                                              minFontSize: 10,
                                              stepGranularity: 10,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              width: 2, color: Colors.white38)),
                                      child: Container(
                                        height: screenSize.height / 15,
                                        width: screenSize.width / 1.1,
                                        decoration: BoxDecoration(
                                          gradient:
                                              uti.testAnswerbuttonThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                              if (listWord[i].tr ==
                                                  cevaplar[2].tr) {
                                                if (i <= listWord.length) {
                                                  setState(() {
                                                    if (cevapKontrolSayac ==
                                                        0) {
                                                      j++;
                                                    }
                                                    i++;
                                                    cevapKontrolSayac = 0;
                                                    if (i ==
                                                        widget.questionNumber) {
                                                      _showMyDialog();
                                                    }
                                                  });
                                                }
                                              } else {
                                                setState(() {
                                                  cevapKontrolSayac++;
                                                });
                                              }
                                            },
                                            child: AutoSizeText(
                                              cevaplar[2].tr,
                                              style: TextStyle(fontSize: 25),
                                              minFontSize: 10,
                                              stepGranularity: 10,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ],
    );
  }

  _getWords() async {
    cevaplar.clear();
    if (listWord.isEmpty) {
      await db.getWords().then((value) => {
            listWords = value,
          });
      int k = 0;
      bool kontrol = true;
      while (k < widget.questionNumber) {
        kontrol = true;
        randomWord = getRandomElement(listWords);
        if (listWord.isEmpty) {
        } else {
          for (var m = 0; m < listWord.length; m++) {
            if (listWord[m].eng == randomWord.eng) {
              kontrol = false;
            }
          }
        }

        if (kontrol) {
          listWord.add(randomWord);
          k++;
        }
      }
      listWord.shuffle();
    }

    //bu kısımda i+1 ve i+2 nin boş olma kontrolü yapılacak
    cevaplar.add(listWord[i]);
    if (i + 2 < listWord.length - 1) {
      cevaplar.add(listWord[i + 1]);
      cevaplar.add(listWord[i + 2]);
    } else if (listWord.length >= 4) {
      cevaplar.add(listWord[i - 1]);
      cevaplar.add(listWord[i - 2]);
    } else {
      cevaplar.add(listWord[i]);
      cevaplar.add(listWord[i]);
    }

    cevaplar.shuffle();
  }

  getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  Future<void> _showMyDialog() async {
    String tr, eng;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: Colors.blue[300],
          title: Text('Test Sonucu '),
          content: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenSize.width / 1.2,
                  height: screenSize.width / 6,
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.green)),
                  child: Center(child: Text("Doğru sayısı : " + j.toString())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenSize.width / 1.2,
                  height: screenSize.width / 6,
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.red)),
                  child: Center(
                      child: Text("Yanlış sayısı : " +
                          (widget.questionNumber - j).toString())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.amber[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(width: 2, color: Colors.amber)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Tamam")),
              )
            ],
          )),
        );
      },
    );
  }
}
