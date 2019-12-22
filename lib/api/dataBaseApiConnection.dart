/*
 * This is database api file
 * Here all data base method add ,delete ,fetch
 *  Firebase db,Firebase storage
 * 
*/

import 'dart:io';

import 'package:b2b_trade/model/newsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataBaseAPI {
  //!Variables
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  final _storage = FirebaseStorage.instance.ref();
  StorageUploadTask _task;

  //!Get all number of user
   Stream<QuerySnapshot> getAllUserLength(){

    return  _db.collection("users").snapshots();

  }
  //!Add news Data (Image and text)
  void addNewsData(coll, NewsModel data, context) async {

    _task = _storage
        .child("images/" + data.getnewsImage.path.split('/').last)
        .putFile(
          data.getnewsImage,
        );

    StorageTaskSnapshot _imageurl = await _task.onComplete;

    print("uploaded..");
    _imageurl.ref.getDownloadURL().then((val) {
      _db.collection('$coll').add({
        'newsImage': val,
        'newsText': data.getnewsText,
      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        print("Success.");
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  //!Add news Data(Image)
  void addNewsImage(coll, NewsModel data, context) async {
    _task = _storage
        .child("images/" + data.getnewsImage.path.split('/').last)
        .putFile(data.getnewsImage);

    StorageTaskSnapshot _s = await _task.onComplete;
    _s.ref.getDownloadURL().then((val) {
      _db.collection(coll).add({'newsImage': val, 'newsText': null});
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  //!Add news Data(text)
  void addNewsText(coll, NewsModel data, context) async {
    print("s");
    _db.collection(coll)
        .add({'newsImage': null, 'newsText': data.getnewsText}).catchError((e) {
      print(e);
    }).whenComplete(() {
      print("ss");
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  //!Fetch all news data form firebase
  Stream<QuerySnapshot> getNewsData(coll) {
    return _db.collection('$coll').snapshots();
  }

  //!Get current user info who is login
  Future<FirebaseUser> getCurrentUser() {
    return _auth.currentUser();
  }

   getUser()async{
     FirebaseUser _user = await _auth.currentUser();
     return (_user!=null)?true:false;
  }
  //!Delete data
  deleteNews(context, coll, id) async {
    await _db.collection(coll).document(id).delete().whenComplete(() {
      print("delete");
      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
  }

  //!Sign in to firebase
  Future<AuthResult> signIn(context, e, p) async {

    showerror(context,a){
      Navigator.pop(context);
      return showDialog(context: context,
      builder:(context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Retry"),
              onPressed: ()=>Navigator.pop(context),
            )
          ],
          elevation: 2,
          content: Text(a),
        );
      } );
    }
     try {
       AuthResult result = await _auth.signInWithEmailAndPassword(
           email: e, password: p).then((data) async {

         QuerySnapshot _userdata = await _db.collection("users").where(
             'email', isEqualTo: e).getDocuments();
         var id = _userdata.documents[0].documentID.toString();
         _db.collection("users").document(id).updateData({'auth': "noauth"});
         return data;
       });


     }catch(e){
        switch(e.code){
          case 'ERROR_WRONG_PASSWORD':
            showerror(context,"Password does not match.");
                break;
          default:
            showerror(context,"Something went to wrong.");
            break;
        }
      }


    }


  //!Create user
  void createUser(context, coll, e, p) async {

    FirebaseApp app = await FirebaseApp.configure(
        name: 'Secondary', options: await FirebaseApp.instance.options);
    FirebaseAuth.fromApp(app)
        .createUserWithEmailAndPassword(email: e, password: p)
        .then((result) {
      _db.collection(coll).add({
        'email': result.user.email,
        'password': p,
        'auth': "auth",
        'status': "user"
      }).catchError((e) {
        print(e);
      }).then((e) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  //!Change the user session
  void changeUserSession(id, value) async {
    await _db.collection("users").document(id).updateData({'auth': value});
  }

  //!Delete user
  void deleteUser(context, coll, id) async {
    _db.collection(coll).document(id).delete().whenComplete(() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("User deleted.."),
      ));
    });
  }

  //!check user

  Future<bool> checkUser(useremail) async {
    print("check user");

    QuerySnapshot a = await _db
        .collection("users")
        .where('email', isEqualTo: useremail)
        .getDocuments();

    print("data = ${a.documents.length}");
    return (a.documents.isEmpty) ? false : true;
  }

  //!Check Auth
  checkAuth(e) async {
    print("auth");
    QuerySnapshot a = await _db
        .collection("users")
        .where('email', isEqualTo: e)
        .getDocuments();
    print("data2 = ${a.documents.length}");
    return (a.documents.length == 0 || a == null)
        ? null
        : a.documents[0]['auth'];
  }

  //!check Status
  Future<bool> checkStatus(e) async {
    QuerySnapshot a = await _db
        .collection("users")
        .where('email', isEqualTo: e)
        .getDocuments();
    print(a.documents[0]['status']);
    return (a.documents[0]['status'] == "admin") ? true : false;
    //return (a.documents.isEmpty)?null:a.documents[0]['status'];
  }

  //! Fetch all users
  Stream<QuerySnapshot> getAllUsers(coll) {
    return _db.collection(coll).orderBy('email').snapshots();
  }

  //!Sign out
  Future<void> signout() async{
     FirebaseUser user = await _auth.currentUser();
    QuerySnapshot _userdata = await _db.collection("users").where(
        'email', isEqualTo: user.email).getDocuments();
    var id = _userdata.documents[0].documentID.toString();
    _db.collection("users").document(id).updateData({'auth': "auth"}).whenComplete(()async{
      return await _auth.signOut();
    });


  }
}

DataBaseAPI baseAPIDB = DataBaseAPI();
