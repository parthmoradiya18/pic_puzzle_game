import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pic_puzzle_game/MyData.dart';
import 'package:pic_puzzle_game/Second_Time.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TimeGame extends StatefulWidget {
  int time_pos,time_level;
  TimeGame(this.time_pos,this.time_level);

  @override
  State<TimeGame> createState() => _TimeGameState();
}

class _TimeGameState extends State<TimeGame> {

  bool banner=false;
  int time_pos=0,time_level=0,s=30;

  timer() async {
    for(int i=5;i>=0;i--)
    {
      await Future.delayed(Duration(seconds: 1));
      b=i;

      if(i==0)
      {
        temp = List.filled(myimg.length, false);
        while(temp.contains(false))
        {
          await Future.delayed(Duration(seconds: 1));
          i++;
          b=i;
          setState(() {});
          if(i==s)
          {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Container(
                    height: 50,width: double.infinity,color: Colors.teal.shade700,alignment: Alignment.center,
                    child: Text("TIME OUT",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                  content: Container(height: 80,color: Colors.teal.shade100,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("TRY AGAIN?",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(style: TextButton.styleFrom(backgroundColor: Colors.teal),onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return SecondTime();
                              },));
                            }, child: Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.white),)),

                            TextButton(style: TextButton.styleFrom(backgroundColor: Colors.teal.shade700),onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return TimeGame(time_pos,time_level);
                              },));
                            }, child: Text("Ok",style: TextStyle(fontSize: 20,color: Colors.white),))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },);
            });
          }
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

      for(int i=0;i<level_puzzle[cur_level]/2 ;i++)
      {
        myimg.add(images[i]);
        myimg.add(images[i]);
      }
      myimg.shuffle();
    });
  }

  SharedPreferences ? pref ;
  share_prefs() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    time_level = widget.time_level;
    time_pos = widget.time_pos;
    temp=List.filled(level_puzzle[time_level], true);
    myimg.clear();
    timer();
    share_prefs();
    _initImages();
  }

  @override
  Widget build(BuildContext context) {
    if(b==s)
    {
      banner=true;
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Time : $b/$s "),backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Center(
              child: Container(
                child: GridView.builder(itemCount: myimg.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          if(b==s)
                          {
                            banner=true;
                            setState(() {});
                          }
                          if(banner==true)
                          {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Container(
                                  height: 50,width: double.infinity,color: Colors.teal,
                                  child: Text("TIME OUT",style: TextStyle(fontSize: 20,color: Colors.white),),
                                ),
                                content: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("TRY AGAIN?",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),

                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return SecondTime();
                                          },));
                                        }, child: Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.white),)),

                                        TextButton(onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return TimeGame(time_pos,time_level);
                                          },));
                                        }, child: Text("Ok",style: TextStyle(fontSize: 20,color: Colors.white),))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },);
                            banner=false;
                          }

                          if(!temp[index] && pos1==1)
                          {
                            temp[index]=true;
                            pos1=2;
                            y1=index;
                          }
                          if(!temp[index] && pos1==2)
                          {
                            temp[index]=true;
                            pos1=0;
                            y2=index;

                            if(myimg[y1]==myimg[y2])
                            {
                              pos1=1;
                              s+=5;
                              setState(() {});

                              if(!temp.contains(false))
                              {
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    title: Container(height: 50,alignment: Alignment.center,width: double.infinity,
                                      child: Text("NEW RECORD!"),color: Colors.teal.shade700,),
                                    content: Container(height: 150,width: 100,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("$b SECONDS",style: TextStyle(fontSize: 20),),
                                          Text("NO TIME LIMIT",style: TextStyle(fontSize: 20),),
                                          Text("LEVEL ${time_level+1}",style: TextStyle(fontSize: 20),),
                                          Text("WELL DONE",style: TextStyle(fontSize: 20),),
                                          Container(color: Colors.teal,
                                              child: TextButton(
                                                onPressed:  () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return SecondTime();},)); },
                                                child: Text("Ok",style: TextStyle(fontSize: 20,color: Colors.white),),))
                                        ],
                                      ),
                                    ),
                                  );
                                },);
                                if (b<times[time_pos]) {
                                  pref!.setInt("time${time_pos}", b);
                                }
                                if (second[time_pos]==0) {
                                  pref!.setInt("time${time_pos}", b);
                                }
                                if (widget.time_pos==time_level) {
                                  time_level++;
                                  pref!.setInt("timelevel", time_level);
                                }
                                setState(() {});
                              }
                            }
                            else
                            {
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                setState(() {
                                  temp[y1]=false;
                                  temp[22]=false;
                                  pos1=1;
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
                                    border: Border.all()))));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}