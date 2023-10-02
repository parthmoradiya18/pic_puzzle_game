import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pic_puzzle_game/MyData.dart';
import 'package:pic_puzzle_game/Second_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayPage extends StatefulWidget {
  int curent_pos, cur_level;

  PlayPage(this.curent_pos, this.cur_level);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int cur_level = 0;
  int curent_pos = 0;

  timer() async {
    for (int i = 5; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      a = i;
      if (i == 0) {
        temp = List.filled(myimg.length, false);
        while (temp.contains(false)) {
          await Future.delayed(Duration(seconds: 1));
          i++;
          a = i;
          setState(() {});
        }
      }
      setState(() {});
    }
  }

  Future _initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      images = imagePaths;
      images.shuffle();

      for (int i = 0; i < level_puzzle[curent_pos] / 2; i++) {
        myimg.add(images[i]);
        myimg.add(images[i]);
      }
      myimg.shuffle();
    });
  }

  SharedPreferences? pref;

  share_pref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    cur_level = widget.cur_level;
    curent_pos = widget.curent_pos;
    temp = List.filled(level_puzzle[curent_pos], true);
    myimg.clear();
    timer();
    _initImages();
    share_pref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text("${curent_pos + 1}\tTime: $a"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: myimg.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (!temp[index] && pos == 1) {
                            temp[index] = true;
                            pos = 2;
                            x1 = index;
                          }
                          if (!temp[index] && pos == 2) {
                            temp[index] = true;
                            pos = 0;
                            x2 = index;

                            if (myimg[x1] == myimg[x2]) {
                              pos = 1;
                              if (!temp.contains(false)) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        child: Text("NEW RECORD!",style: TextStyle(fontSize: 20),),
                                        color: Colors.teal.shade700,
                                      ),
                                      content: Container(
                                        height: 150,
                                        width: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "$a SECONDS",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "NO TIME LIMIT",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "LEVEL $cur_level",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "WELL DONE",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Container(
                                                color: Colors.teal.shade700,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return SecondPage();
                                                          },
                                                        ));
                                                  },
                                                  child: Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                                if (a < second[curent_pos]) {
                                  pref!.setInt("seconds${curent_pos}", a);
                                }
                                if (second[curent_pos] == 0) {
                                  pref!.setInt("seconds${curent_pos}", a);
                                }
                                if (widget.curent_pos == cur_level) {
                                  cur_level++;
                                  pref!.setInt("levelno", cur_level);
                                }
                              }
                              setState(() {});
                            } else {
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                setState(() {
                                  temp[x1] = false;
                                  temp[x2] = false;
                                  pos = 1;
                                });
                              });
                            }
                          }
                        },
                        child: Visibility(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    image: DecorationImage(
                                        image: AssetImage("${myimg[index]}")),
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all())),
                            visible: temp[index],
                            replacement: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all()))),
                      );
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
