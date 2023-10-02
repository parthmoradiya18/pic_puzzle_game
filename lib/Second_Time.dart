import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pic_puzzle_game/MyData.dart';
import 'package:pic_puzzle_game/Time_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondTime extends StatefulWidget {
  const SecondTime({Key? key}) : super(key: key);

  @override
  State<SecondTime> createState() => _SecondTimeState();
}

class _SecondTimeState extends State<SecondTime> {
  int time_level = 0;
  int time_pos = 0;
  SharedPreferences? pref;

  share_pref() async {
    pref = await SharedPreferences.getInstance();
    time_level = pref!.getInt("timelevel") ?? 0;
    for (int i = 0; i <= time_level; i++) {
      int tmp = pref!.getInt("time$i") ?? 0;
      times[i] = tmp;
    }
    setState(() {});
  }

  @override
  void initState() {
    time = List.filled(level.length, "");
    super.initState();
    share_pref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Level\n \t Normal"),
        backgroundColor: Colors.teal.shade700,
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
                                  fontSize: 25, color: Colors.teal.shade700),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.access_time,
                                    color: Colors.teal.shade700, size: 35))
                          ],
                        ),
                        Divider(
                          color: Colors.teal.shade700,
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
                                  if (index < time_level + 1) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return TimeGame(index, time_level);
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
                                  color: (index <= time_level)
                                      ? Colors.teal.shade700
                                      : Colors.teal.shade100,
                                  alignment: Alignment.center,
                                  child: (index < time_level + 1)
                                      ? Text(
                                      "Level ${level[index]} - ${times[index]}s",
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
            height: 80,
            width: double.infinity,
            color: Colors.teal.shade700,
            alignment: Alignment.center,
            child: Text(
              "Normal Time Based Mode",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
