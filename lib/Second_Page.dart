import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pic_puzzle_game/MyData.dart';
import 'package:pic_puzzle_game/Play_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int cur_level = 0;
  int curent_pos = 0;
  SharedPreferences? pref;

  share_pref() async {
    pref = await SharedPreferences.getInstance();
    cur_level = pref!.getInt("levelno") ?? 0;

    for (int i = 0; i <= cur_level; i++) {
      int tmp = pref!.getInt("seconds$i") ?? 0;
      second[i] = tmp;
    }
    setState(() {});
  }

  @override
  void initState() {
    levels = List.filled(level.length, "");
    super.initState();
    share_pref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Level",style: TextStyle(fontSize: 20,color: Colors.black),),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index1) {
                return Container(
                    height: 50,
                    width: 290,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                        Border.all(color: Colors.teal.shade700, width: 3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "MATCH",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.teal.shade700),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.access_time_outlined,
                                    color: Colors.teal.shade700, size: 35))
                          ],
                        ),
                        Divider(
                          color: Colors.teal,
                          thickness: 2,
                        ),
                        Expanded(
                          flex: 5,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              if (index1 == 1) {
                                index += 10;
                              } else if (index1 == 2) {
                                index += 20;
                              } else if (index1 == 3) {
                                index += 30;
                              } else if (index1 == 4) {
                                index += 40;
                              }
                              return InkWell(
                                onTap: () {

                                  if (index < cur_level + 1) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return PlayPage(index, cur_level);
                                      },
                                    ));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Level is Locked",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.teal,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  height: 60,
                                  width: 100,
                                  color: (index <= cur_level)
                                      ? Colors.teal.shade700
                                      : Colors.teal.shade100,
                                  alignment: Alignment.center,
                                  child: (index < cur_level + 1)
                                      ? Text(
                                      "Level ${level[index]} - ${second[index]}s",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white))
                                      : Text(
                                    "Level ${level[index]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.teal.shade700,
          )
        ],
      ),
    );
  }
}
