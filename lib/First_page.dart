import 'package:flutter/material.dart';
import 'package:pic_puzzle_game/Second_Page.dart';
import 'package:pic_puzzle_game/Second_Time.dart';
import 'package:share_plus/share_plus.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        title: Text("Select Mode",style: TextStyle(fontSize: 20,color: Colors.black),),backgroundColor: Colors.teal.shade700,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.teal.shade100,border: Border.all(color: Colors.teal.shade700,width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SecondPage();
                    },));
                  },
                  child: Container(height: 60, width: 200,
                    margin: EdgeInsets.all(10),alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade100,border: Border.all(color: Colors.teal.shade700,width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("NO TIME LIMIT",style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SecondTime();
                    },));
                  },
                  child: Container(height: 60, width: 200,
                    margin: EdgeInsets.only(left: 10,right: 10),alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade100,border: Border.all(color: Colors.teal.shade700,width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("NORMAL",style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SecondPage();
                    },));
                  },
                  child: Container(height: 60, width: 200,
                    margin: EdgeInsets.all(10),alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade100,border: Border.all(color: Colors.teal.shade700,width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("HARD",style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),

          InkWell(onTap: () {
            Navigator.pop(context);

          },
            child: Container(
              height: 60, width: 200,margin: EdgeInsets.all(10),alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.teal.shade100,border: Border.all(color: Colors.teal.shade700,width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Text("RMOVE ADS",style: TextStyle(fontSize: 20,color: Colors.white)),
            ),
          ),

          Container(margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.teal.shade100,border: Border.all(color: Colors.teal.shade700,width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(onTap: () {
                    Share.share('pic_puzzle',
                        subject: 'Look what I made!');

                    setState(() {});
                  },
                    child: Container(height: 50,width: 150,margin: EdgeInsets.all(10),
                      color: Colors.teal,alignment: Alignment.center,
                      child: Text("SHARE",style: TextStyle(fontSize: 20,color: Colors.white)),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(onTap: () {

                  },
                    child: Container(height: 50,width: 150,margin: EdgeInsets.all(10),
                      color: Colors.teal,alignment: Alignment.center,
                      child: Text("MORE GAMES",style: TextStyle(fontSize: 20,color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}