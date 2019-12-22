import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/widgets/dashboardBody.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:b2b_trade/ui/widgets/painter.dart';

class UsersBody extends StatefulWidget {
  @override
  _UsersBodyState createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  @override
  Widget build(BuildContext context) {
    final _screen = ScreenInfo(context);
    return CustomPaint(
      painter: MyPainter(_screen),
      child: StreamBuilder(
        stream: baseAPIDB.getAllUsers("users"),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return (!snapshot.hasData)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Card(
                        elevation: 3,
                        child: Container(
                          child: design.getDesign(context, snapshot, index),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                      //contentPadding: EdgeInsets.all(10),
                    );
                  },
                );
        },
      ),
    );
  }
}

//List View Design (Show All Users)

class ListDesign {
  Column getDesign(context, AsyncSnapshot<QuerySnapshot> s, index) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text("Email", style: reuse.getPlaceholderStyle())),
            Expanded(
                flex: 2,
                child: FittedBox(
                  child: Text(
                    "${s.data.documents[index]['email']}",
                    style: reuse.getPlaceholderStyle(),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                "Password",
                style: reuse.getPlaceholderStyle(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "${s.data.documents[index]['password']}",
                style: reuse.getPlaceholderStyle(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    color: reuse.getBGColor(),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                    ),
                    iconSize: 28,
                    color: Colors.redAccent,
                    onPressed: () async {

                      baseAPIDB.deleteUser(
                          context, "users", s.data.documents[index].documentID);
                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

ListDesign design = ListDesign();
