import 'package:b2b_trade/ui/widgets/adduser.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:b2b_trade/ui/widgets/usersBody.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!App Bar
      appBar: AppBar(
      
        iconTheme: IconThemeData(color:reuse.getBGColor()),
        title: Text(
          "Users",
          style: reuse.getTextStyle(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              color: reuse.getBGColor(),
            ),
            onPressed: ()=>   addUser(context)

          )
        ],
      ),

      //!Body
      body: UsersBody(),
    );
  }
}
