import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lwk/Game/Start.dart';
import 'package:lwk/main.dart';
import 'package:lwk/Database_service.dart';
import 'package:lwk/UserData.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameOver extends StatefulWidget {
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return StreamBuilder<UserData>(
    stream: DatabaseService(uid: user.uid).userData,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    UserData userData = snapshot.data;
        return AlertDialog(
            title: Text('Game Over!'),
            content: Text('Plan your money and hunger wisely!'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  if (userData.zhistory.length > userData.zbest.length){
                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zhistory, userData.username);
                  }else{
                    DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], userData.zbest, userData.username);
                  }
                  Navigator.pushReplacement(context, ScaleRoute(page: Start()));
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
      }else{
      return Container();
    }}
    );
  }
}
