import 'package:flutter/material.dart';
import 'package:lwk/Auth_service.dart';
import 'package:lwk/Database_service.dart';
import 'package:lwk/UserData.dart';
import 'package:lwk/main.dart';
import 'package:lwk/Game/Kitchen.dart';
import 'package:lwk/Game/Storage.dart';
import 'package:lwk/Game/Telephone.dart';
import 'package:lwk/Game/Garden.dart';
import 'package:lwk/Game/Bedroom.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lwk/Game/GameOver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final AuthService _auth = AuthService();
  bool isGameOver = false;
  String username;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    List leaderboard = [{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0},{'username':'','len':0}];
    
    Firestore.instance.collection('data').snapshots().listen((data) =>
        data.documents.forEach((doc) =>
          Lead().lead(leaderboard, doc, user)
        ));
    return isGameOver? GameOver() : Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context){
              return IconButton(
              icon: Icon(Icons.group),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
            },
          ),
            title: Text('The COVID-19 Survival Guide'),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: ()async{await _auth.signOut();},
                  icon: Icon(Icons.person),
                  label: Text('Logout')
              )
            ],
        ),
        drawer: Drawer(
          child: Builder(
            builder: (BuildContext context) {
              leaderboard.sort((a,b) => b['len'].compareTo(a['len']));
              return Column(
                //padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: StreamBuilder<UserData>(
                      stream: DatabaseService(uid: user.uid).userData,
                      builder: (context, snapshot) {
                      if (snapshot.hasData) {
                      UserData userData = snapshot.data;
                      if (userData.username == 'No username'){
                        username = '';
                      }else{
                        username = userData.username;
                      }
                        return Column(
                          children: <Widget>[
                            Text('Leaderboard', style: TextStyle(fontSize: 50)),
                            TextFormField(
                              initialValue: username,
                              onChanged: (val) {
                                setState(() {
                                  username = val;
                                });
                                DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger,userData.zhistory,userData.zbest, username);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Username', errorStyle: TextStyle(
                                  fontSize: 20)),
                            ),
                          ],
                        );
                      }else{
                       return Container();
                      }}
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children:<Widget>[
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: <Widget>[Text(
                                    '1. ' + leaderboard[0]['username'].toString() + ': ' +
                                        leaderboard[0]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '2. ' + leaderboard[1]['username'].toString() + ': ' +
                                          leaderboard[1]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '3. ' + leaderboard[2]['username'].toString() + ': ' +
                                          leaderboard[2]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '4. ' + leaderboard[3]['username'].toString() + ': ' +
                                          leaderboard[3]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '5. ' + leaderboard[4]['username'].toString() + ': ' +
                                          leaderboard[4]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '6. ' + leaderboard[5]['username'].toString() + ': ' +
                                          leaderboard[5]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '7. ' + leaderboard[6]['username'].toString() + ': ' +
                                          leaderboard[6]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '8. ' + leaderboard[7]['username'].toString() + ': ' +
                                          leaderboard[7]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '9. ' + leaderboard[8]['username'].toString() + ': ' +
                                          leaderboard[8]['len'].toString())]
                              )
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                  children: <Widget>[Text(
                                      '10. ' + leaderboard[9]['username'].toString() + ': ' +
                                          leaderboard[9]['len'].toString())]
                              )
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
              );
            }
          ),
        ),
        body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return isGameOver ? GameOver() : Stack(
                children: <Widget>[
                  Image.asset('assets/_startBckg.jpg',fit: BoxFit.cover,height: double.infinity,width: double.infinity,alignment: Alignment.centerRight,),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)
                                  ),
                                ),
                                margin: EdgeInsets.fromLTRB(0,0,0,8),
                                padding: EdgeInsets.fromLTRB(8.0,8,8,0),
                                child: Text('Welcome!', style: TextStyle(
                                    fontSize: 50, decoration: TextDecoration.underline)),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Padding(
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
                                            Icon(Icons.favorite, color: Color(0xFFF25CA2)),
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
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Where do you wanna go?'),
                          decoration: BoxDecoration(
                            color: Color(0xFF0B9ED9),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)
                            ),
                          ),
                        ),
                        Expanded(flex:1,child: SizedBox(height: 40)),
                        Expanded(
                          flex: 20,
                          child: Wrap(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  userData.zhistory.add('Kitchen');
                                  DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                                  setState(() {
                                    isGameOver = Check().checkHunger(userData.hunger);
                                  });
                                  if (!isGameOver) {
                                    Navigator.push(context, ScaleRoute(page: Kitchen()));
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints.tightForFinite(width: 300),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                                          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                          child: Image(image: AssetImage('assets/kitchen.png')))
                                      ,
                                      Text('Kitchen'),
                                    ],
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  userData.zhistory.add('Storage');
                                  DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                                  setState(() {
                                    isGameOver = Check().checkHunger(userData.hunger);
                                  });
                                  if (!isGameOver) {
                                    Navigator.push(context, ScaleRoute(page: Storage()));
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints.tightForFinite(width: 300),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                                          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                          child: Image(image: AssetImage('assets/storage.png')))
                                      ,
                                      Text('Storage'),
                                    ],
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  userData.zhistory.add('Telephone');
                                  DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                                  setState(() {
                                    isGameOver = Check().checkHunger(userData.hunger);
                                  });
                                  if (!isGameOver) {
                                    Navigator.push(context, ScaleRoute(page: Telephone()));
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints.tightForFinite(width: 300),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                                          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                          child: Image(image: AssetImage('assets/telephone.png')))
                                      ,
                                      Text('Telephone'),
                                    ],
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  userData.zhistory.add('Garden');
                                  DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                                  setState(() {
                                    isGameOver = Check().checkHunger(userData.hunger);
                                  });
                                  if (!isGameOver) {
                                    Navigator.push(
                                        context, ScaleRoute(page: Garden()));
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints.tightForFinite(width: 300),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                                          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                          child: Image(image: AssetImage('assets/garden.png')))
                                      ,
                                      Text('Garden'),
                                    ],
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  userData.zhistory.add('Bedroom');
                                  DatabaseService(uid: user.uid).updateUserData(userData.money, userData.hunger-1, userData.zhistory, userData.zbest, userData.username);
                                  setState(() {
                                    isGameOver = Check().checkHunger(userData.hunger);
                                  });
                                  await showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text('I\'m glad you are well-rested.'),
                                          actions: <Widget>[FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'),
                                          )
                                          ],
                                        );
                                      }
                                  );
                                  if (!isGameOver) {
                                    Navigator.push(
                                        context, ScaleRoute(page: Bedroom()));
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints.tightForFinite(width: 300),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                                          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                          child: Image(image: AssetImage('assets/sleep.png')))
                                      ,
                                      Text('Sleep'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else{
              return AlertDialog(
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Loading'),
                    ],
                  ));
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

class Lead {
  bool ch = true;
  lead(List leaderboard, doc, user){
//    if (doc["zbest"] == null){
//      if (doc["username"] == null){
//        DatabaseService(uid: user.uid).updateUserData(doc['money'], doc['hunger'], doc['zhistory'], [], 'noname');
//      }else{
//        DatabaseService(uid: user.uid).updateUserData(doc['money'], doc['hunger'], doc['zhistory'], [], doc['username']);
//      }
//    }
  for (int i=0; i < leaderboard.length; i++){
    for (var key in leaderboard[i].values) {
        if (doc['username'] == key){
          ch = false;
      }
    }
  }
  if (ch){
    leaderboard.add({'username': doc['username'], 'len': doc["zbest"].length});
  }
  }
}