import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lwk/Game/Bedroom.dart';
import 'package:lwk/Game/Restaurants.dart';
import 'package:lwk/main.dart';
import 'package:lwk/Database_service.dart';
import 'package:lwk/UserData.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lwk/Game/GameOver.dart';

class Mall extends StatefulWidget {
  @override
  _MallState createState() => _MallState();
}

class _MallState extends State<Mall> {
  bool isGameOver = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(title: Text('The COVID-19 Survival Guide')),
    body: StreamBuilder<UserData>(
    stream: DatabaseService(uid: user.uid).userData,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    UserData userData = snapshot.data;
          return isGameOver ? GameOver() : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,8,0),
                  child: Align(

                    alignment: Alignment.topRight,
                    child: Container(
                      constraints: BoxConstraints.tightFor(width: 100),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20.0)
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.favorite, color: Colors.pink),
                              Text(userData.hunger.toString(),style: TextStyle(fontSize: 25)),
                              Icon(Icons.add, color: Colors.white)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.attach_money, color: Colors.green[900]),
                              Text(userData.money.toString(),style: TextStyle(fontSize: 25)),
                              Icon(Icons.add, color: Colors.white)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text('Mall',style: TextStyle(fontSize: 50,decoration: TextDecoration.underline),),
                                SizedBox(height: 10),
                Text('Where do you wanna go?'),
                SizedBox(height: 40),
                RaisedButton(
                  onPressed: () async {
                    await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Game Over!'),
                            content: Text('Your life is more important than Bubble Tea, yeah?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  if (userData.zhistory.length > userData.zbest.length){
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                                  }else{
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                                  }
                                  Navigator.popUntil(context, ModalRoute.withName('/'));
                                },
                                child: Text('Try Again'),
                              ),
                              FlatButton(
                                onPressed: (){
                                  if (userData.zhistory.length > userData.zbest.length){
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                                  }else{
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                                  }
                                  SystemNavigator.pop();
                                },
                                child: Text('Exit'),
                              ),
                            ],
                          );
                        }
                    );
                  },
                  child: Container(
                    constraints: BoxConstraints.tightForFinite(width: 300),
                    child: Row(
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Image(image: AssetImage('assets/bubbletea.png')))
                        ,
                        Text('Bubble Tea Station'),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    userData.zhistory.add('Restaurants');
                    DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                    setState(() {
                      isGameOver = Check().checkHunger(userData.hunger);
                    });
                    if (!isGameOver) {
                      Navigator.pushReplacement(context, ScaleRoute(page: Restaurants()));
                    }
                  },
                  child: Container(
                    constraints: BoxConstraints.tightForFinite(width: 300),
                    child: Row(
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Image(image: AssetImage('assets/restaurant.png')))
                        ,
                        Text('Restaurants'),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: ()async{
                    await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Game Over!'),
                            content: Text('You\'re not allowed to go to work during this crisis. Better work at home.'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  if (userData.zhistory.length > userData.zbest.length){
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                                  }else{
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                                  }
                                  Navigator.popUntil(context, ModalRoute.withName('/'));
                                },
                                child: Text('Try Again'),
                              ),
                              FlatButton(
                                onPressed: (){
                                  if (userData.zhistory.length > userData.zbest.length){
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                                  }else{
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                                  }
                                  SystemNavigator.pop();
                                },
                                child: Text('Exit'),
                              ),
                            ],
                          );
                        }
                    );
                  },
                  child: Container(
                    constraints: BoxConstraints.tightForFinite(width: 300),
                    child: Row(
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Image(image: AssetImage('assets/office.png')))
                        ,
                        Text('Office'),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: ()async{
                    await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Game Over!'),
                            content: Text('You\'re doomed! You can actually do basic exercise at home, right?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  if (userData.zhistory.length > userData.zbest.length){
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                                  }else{
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                                  }
                                  Navigator.popUntil(context, ModalRoute.withName('/'));
                                },
                                child: Text('Try Again'),
                              ),
                              FlatButton(
                                onPressed: (){
                                  if (userData.zhistory.length > userData.zbest.length){
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                                  }else{
                                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                                  }
                                  SystemNavigator.pop();
                                },
                                child: Text('Exit'),
                              ),
                            ],
                          );
                        }
                    );
                  },
                  child: Container(
                    constraints: BoxConstraints.tightForFinite(width: 300),
                    child: Row(
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Image(image: AssetImage('assets/gym.png')))
                        ,
                        Text('Gym'),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    userData.zhistory.add('Bedroom');
                    DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                    setState(() {
                      isGameOver = Check().checkHunger(userData.hunger);
                    });
                    if (!isGameOver) {
                      Navigator.pushReplacement(context, ScaleRoute(page: Bedroom()));
                    }
                  },
                  child: Container(
                    constraints: BoxConstraints.tightForFinite(width: 300),
                    child: Row(
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Image(image: AssetImage('assets/home.png')))
                        ,
                        Text('Home'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
      return Container();
    }
    }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.call),
      ),
    );
  }
}
