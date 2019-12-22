import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/pages/adminPages/postPage.dart';
import 'package:b2b_trade/ui/pages/adminPages/usersPage.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:b2b_trade/ui/widgets/painter.dart';

import 'package:flutter/material.dart';

class DashBoardBody extends StatefulWidget {
  @override
  _DashBoardBodyState createState() => _DashBoardBodyState();
}

class _DashBoardBodyState extends State<DashBoardBody> {
  @override
  Widget build(BuildContext context) {
    final _screen = ScreenInfo(context);
    return CustomPaint(
      painter: MyPainter(_screen),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  //!Top bar for total users
                  ListTile(
                    contentPadding: EdgeInsets.all(15),
                    enabled: true,
                    trailing: Icon(
                      Icons.contacts,
                      size: 30,
                      color: reuse.getBGColor(),
                    ),
                    title: Text(
                      "TOTAL USERS",
                      style: reuse.getTextStyle2(),
                    ),
                    subtitle: StreamBuilder(
                      stream: baseAPIDB.getAllUserLength(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> userLen) {
                        return (userLen.hasData)
                            ? Text("${userLen.data.documents.length}")
                            : Text("");
                      },
                    ),
                  ),
                  //!Divider
                  Divider(
                    color: Colors.black26,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: _screen.getHeight * 0.02,
                  ),
                  //!All Menu
                  Container(
                    child: Row(
                      children: <Widget>[
                        //!First Menu
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UsersPage()),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('lib/assets/alluser.jpg'),
                                    Text(
                                      "ALL USERS",
                                      style: reuse.getTextStyle2(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        //!Second Menu
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminPostPage(),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('lib/assets/post.jpg'),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Text(
                                      "ADD NEWS",
                                      style: reuse.getTextStyle2(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

