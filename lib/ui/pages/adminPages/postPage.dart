/*
 * This is admin post page 
 *  main admin post page 
 *  top area of post page (appbar and floting button)
 */

import 'package:b2b_trade/ui/widgets/addPost.dart';
import 'package:b2b_trade/ui/widgets/adminpostBody.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AdminPostPage extends StatefulWidget {
  @override
  _AdminPostPageState createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!App Bar
      appBar: AppBar(
        iconTheme: IconThemeData(color: reuse.getBGColor()),
        title: Text(
          "Posts",
          style: reuse.getTextStyle(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      //!Add news Button
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: reuse.getBGColor(),
        elevation: 2,
        children: [
          SpeedDialChild(
            label: 'Add image',
            child: Icon(Icons.add_a_photo),
            backgroundColor: reuse.getBGColor(),
            elevation: 2,
            onTap: () async {
              await addNewsImage(context);
            },
          ),
          SpeedDialChild(
            label: 'Add text',
            child: Icon(Icons.note_add),
            backgroundColor: reuse.getBGColor(),
            elevation: 2,
            onTap: () async {
              await addNewsText(context);
            },
          ),
          SpeedDialChild(
            label: 'Both',
            child: Icon(Icons.present_to_all),
            backgroundColor: reuse.getBGColor(),
            elevation: 2,
            onTap: () async {
              await addNewsData(context);
            },
          ),
        ],
      ),
      body: AdminPostBody(),
    );
  }
}
