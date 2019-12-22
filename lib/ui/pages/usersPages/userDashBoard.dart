import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/pages/loginPage.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:b2b_trade/ui/widgets/painter.dart';

class UserDashBoard extends StatefulWidget {
  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  Widget build(BuildContext context) {
    final _screen =ScreenInfo(context);
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: (){
                baseAPIDB.signout();
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context)=>LoginPage()
                  )
                );
              },
            )
          ],
        ),
        body: CustomPaint(
          painter: MyPainter(_screen),
    child:StreamBuilder(
          stream: baseAPIDB.getNewsData("news"),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return (!snapshot.hasData)
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: reuse.getBGColor(),
                    ),
                  )
                : (snapshot.data.documents.length <= 0)
                    ? Center(
                        child: Text("No data."),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return (snapshot.data.documents[index]['newsImage'] !=
                                      null &&
                                  snapshot.data.documents[index]['newsText'] !=
                                      null)
                              ? imageANDText(context, snapshot, index)
                              : (snapshot.data.documents[index]['newsText'] ==
                                      null)
                                  ? imagePost(context, snapshot, index)
                                  : textPost(context, snapshot, index);
                        },
                      );
          },
        ),),);
  }
}

//!TextPost

textPost(context, AsyncSnapshot<QuerySnapshot> s, index) {
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 3,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "${s.data.documents[index]['newsText']}",
            textScaleFactor: 1.1,
            textAlign: TextAlign.justify,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            
          ],
        )
      ],
    ),
  );
}

//!Image

imagePost(context, AsyncSnapshot<QuerySnapshot> s, index) {
  final _screen = ScreenInfo(context);
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 3,
    child: Column(
      children: <Widget>[
        Container(
            child: Image.network(
                s.data.documents[index]['newsImage'],
                width: _screen.getWidth * 0.9,
                height: _screen.getHeight * 0.4,
                fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingpro) {
                return (loadingpro == null)
                    ? child
                    : Image.asset('lib/assets/loading.gif');
              },
        ),),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
           
          ],
        )
      ],
    ),
  );
}

//!Text And Images

imageANDText(context, AsyncSnapshot<QuerySnapshot> s, index) {
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 3,
    child: Column(
      children: <Widget>[
        Container(
            child: Column(
          children: <Widget>[
            Image.network(s.data.documents[index]['newsImage'],
              loadingBuilder: (context, child, loadingpro) {
                return (loadingpro == null)
                    ? child
                    : Image.asset('lib/assets/loading.gif');
              },),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "${s.data.documents[index]['newsText']}",
                textScaleFactor: 1.1,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        )),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
           
          ],
        )
      ],
    ),
  );
}
