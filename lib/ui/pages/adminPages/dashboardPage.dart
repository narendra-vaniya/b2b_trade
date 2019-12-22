/*
 * This is Admin dashboard page 
 *  only app bar  and DashBoardBody
 * 
 */
import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/pages/loginPage.dart';
import 'package:b2b_trade/ui/widgets/dashboardBody.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!App Bar
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        title: Text(
          "DashBoard",
          style: reuse.getTextStyle(),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('lib/assets/admin.jpg'),
            onPressed: () => showBottomMenu(context),
            color: reuse.getBGColor(),
            iconSize: 30,
          )
        ],
      ),
      //!Body
      body: DashBoardBody(),
    );
  }
}

//! Bottom Menu navigation bar

showBottomMenu(context) async {
  FirebaseUser user = await baseAPIDB.getCurrentUser();
  final _screen = ScreenInfo(context);
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    context: context,
    isScrollControlled: true,
    elevation: 10,
    builder: (context) {
      return BottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        onClosing: () {},
        builder: (context) {
          return Container(
            height: _screen.getHeight * 0.2,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.email,
                        color: reuse.getBGColor(),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          user.email,
                          style: reuse.getTextStyle(),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.red,
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    await baseAPIDB.signout().whenComplete(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
