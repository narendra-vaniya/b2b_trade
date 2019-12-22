//!Add post by admin
/*
 * Add post page 
 * here all tyep of method like add newstext only
 * Add news Image only
 * Add all news data(image & text)
 *  
 */
import 'dart:io';
import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/model/newsmodel.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

//! all all news Data in firebase
addNewsData(context) {
  final _key = GlobalKey<FormState>();
  String _newsText;
  File _newsImage;

  return showDialog(
    context: context,
    builder: (context) {
      return Form(
        key: _key,
        child: AlertDialog(
          elevation: 4,
          contentPadding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: <Widget>[
            //!Action Button
            FlatButton.icon(
              icon: Icon(Icons.cancel),
              label: Text("Cancle"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton.icon(
                icon: Icon(Icons.save),
                label: Text("Save"),
                onPressed: () {
                  if (_key.currentState.validate() && _newsImage!=null) {
                    _key.currentState.save();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CircularProgressIndicator(
                              backgroundColor: reuse.getBGColor(),
                            ),
                          ),
                        );
                      },
                    );
                    //!Api
                    baseAPIDB.addNewsData(
                        "news", NewsModel(_newsText, _newsImage), context);
                  }else{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            elevation: 0,
                            content: Text("Enter details"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  }
                }
            )
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: reuse.getBGColor(),
                  onPressed: () async {
                    //!Image Picker
                    _newsImage = await FilePicker.getFile(
                        type: FileType.IMAGE, fileExtension: '.png');
                    print(_newsImage.path);
                  },
                ),
                //!IF Image is Selected then show here
                (_newsImage != null) ? Image.file(_newsImage) : Text(""),
                TextFormField(
                  maxLines: 2,
                  decoration: reuse.getInputPostDecoration('Message..'),
                  onSaved: (val) {
                    _newsText = val;
                  },
                  validator: (value){
                    return (value.isEmpty)?'Enter details':null;
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//!add news Image in firebase

addNewsImage(context) {
  final _key = GlobalKey<FormState>();
  String _newsText;
  File _newsImage;

  return showDialog(
    context: context,
    builder: (context) {
      return Form(
        key: _key,
        child: AlertDialog(
          elevation: 4,
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: <Widget>[
            //!Action Button
            FlatButton.icon(
              icon: Icon(Icons.cancel),
              label: Text("Cancle"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.save),
              label: Text("Save"),
              onPressed: () {
                _key.currentState.save();
                if (_newsImage != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CircularProgressIndicator(
                            backgroundColor: reuse.getBGColor(),
                          ),
                        ),
                      );
                    },
                  );
                  //!Api
                  baseAPIDB.addNewsImage(
                      "news", NewsModel(_newsText, _newsImage), context);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 0,
                          content: Text("Select Image"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },);
                }
              },
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //!button
                RaisedButton(
                  child: Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: reuse.getBGColor(),
                  onPressed: () async {
                    //!Image Picker
                    _newsImage = await FilePicker.getFile(
                        type: FileType.IMAGE, fileExtension: '.png');
                    print(_newsImage.path);
                  },
                ),
                //!IF Image is Selected then show here
                (_newsImage != null) ? Image.file(_newsImage) : Text(""),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//!add news text in firebase

addNewsText(context) {
  final _key = GlobalKey<FormState>();
  String _newsText;
  File _newsImage;

  return showDialog(
    context: context,
    builder: (context) {
      return Form(
        key: _key,
        child: AlertDialog(
          elevation: 4,
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: <Widget>[
            //!Action Button
            FlatButton.icon(
              icon: Icon(Icons.cancel),
              label: Text("Cancle"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.save),
              label: Text("Save"),
              onPressed: () async {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  baseAPIDB.addNewsText(
                      "news", NewsModel(_newsText, _newsImage), context);
                  //!Show loading when data is add
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CircularProgressIndicator(
                            backgroundColor: reuse.getBGColor(),
                          ),
                        ),
                      );
                    },
                  );
                  //!Api

                }
              },
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLines: 2,
                  decoration: reuse.getInputPostDecoration('Message..'),
                  onSaved: (val) {
                    _newsText = val;
                  },
                  validator: (value) {
                    return (value.isEmpty) ? 'Enter details' : null;
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
