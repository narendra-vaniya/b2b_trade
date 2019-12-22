import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/pages/adminPages/dashboardPage.dart';

import 'package:b2b_trade/ui/pages/loginPage.dart';
import 'package:b2b_trade/ui/pages/usersPages/userDashBoard.dart';

import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(B2BApp());

class B2BApp extends StatefulWidget {
  @override
  _B2BAppState createState() => _B2BAppState();
}

class _B2BAppState extends State<B2BApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: reuse.getBGColor(),
        ),
        routes: {
          '/dashboard':(context)=>DashBoard(),
          '/userdashboard':(context)=>UserDashBoard(),
        },
        home: FutureBuilder(
          future: baseAPIDB.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            return(snapshot.hasData)
                    ?FutureBuilder(
                        future: baseAPIDB.checkUser(snapshot.data.email),
                        builder: (context, user) {
                          return(user.hasData)?
                             (user.data)
                                  ?FutureBuilder(
                                      future: baseAPIDB.checkStatus(snapshot.data.email),
                                      builder: (context, status) {
                                        return (status.hasData)
                                            ?(status.data)
                                                ? DashBoard()
                                                : UserDashBoard()
                                            :Loading();
                                      },
                                    )
                                  : usernotFound(context)
                          :Loading();
                        },
                      )

                 : LoginPage();
          },
        ),
    );
  }
}


//When user not found
usernotFound(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("User is not found"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}



//When App start Loading
class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenInfo _screen = ScreenInfo(context);
    return Card(
      elevation: 4,
      color: Colors.white,
      child:  Center(
        child: Container(
          width: 150,
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: reuse.getBGColor(),
              ),
              SizedBox(width: _screen.getWidth*0.04,),
              Text("Loading...",style: reuse.getTextStyle2(),)
            ],
          )
        ),
      ),
    );
  }
}
