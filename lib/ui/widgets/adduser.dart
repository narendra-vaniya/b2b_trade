import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:flutter/material.dart';

addUser(context) {
  final _key = GlobalKey<FormState>();
  String _email;
  String _pwd;

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

                if(_key.currentState.validate()){
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
                  baseAPIDB.createUser(context, "users", _email, _pwd);
                }

              },
            )
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: reuse.getPlaceholderStyle()),
                  onSaved: (v) => _email = v,
                  validator: (value){
                    return (value.isEmpty)?'Enter email':null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: reuse.getPlaceholderStyle()),
                  onSaved: (v) => _pwd = v,
                  validator: (value){
                    return (value.isEmpty)?'Enter password':null;
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
