import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/credential.dart';

class CredentialAdd extends StatefulWidget {
  const CredentialAdd({Key key}) : super(key: key);

  @override
  _CredentialAddState createState() => _CredentialAddState();
}

class _CredentialAddState extends State<CredentialAdd> {
  final keyForm = GlobalKey<FormState>();
  final textName = TextEditingController();
  final textAddress = TextEditingController();
  final textUsername = TextEditingController();
  final textPassword = TextEditingController();

  bool visiblePassword = true;

  void sampleInput() {
    textName.text = "Google";
    textAddress.text = "accounts.google.com";
    textUsername.text = "sample@gmail.com";
    textPassword.text = "P@s\$w0rd";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final padding = PaddingManager.credentialAdd(size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add account"),
        actions: <Widget>[
          //FOR SAMPLING ONLY!!!
          IconButton(
            icon: Icon(Icons.article_outlined),
            tooltip: "Sample",
            onPressed: () {
              sampleInput();
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              //Validate form
              if (keyForm.currentState.validate()) {
                final name = textName.text;
                final address = textAddress.text;
                final username = textUsername.text;
                final password = textPassword.text;

                final credential = Credential.now(
                  name: name,
                  address: address,
                  username: username,
                  password: password,
                );

                Navigator.pop<Credential>(context, credential);
              }
            },
            tooltip: "Add",
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        //TODO: Put max limits on input
        //TODO: When the keyboard 'check' key is pressed make the focused TextFormField move to the next one
        child: Form(
          key: keyForm,
          child: Column(
            children: <Widget>[
              //Name
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Name"),
                  ),
                  TextFormField(
                    controller: textName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Example",
                    ),
                  ),
                ],
              ),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Address
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Address"),
                  ),
                  TextFormField(
                    controller: textAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Address is required";
                      }
                      //TODO: Check if valid URL
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "www.example.com",
                    ),
                  ),
                ],
              ),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Username
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Username"),
                  ),
                  TextFormField(
                    controller: textUsername,
                    decoration: InputDecoration(
                      hintText: "user@example.com",
                    ),
                  ),
                ],
              ),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Password
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password"),
                  ),
                  Stack(
                    children: <Widget>[
                      TextFormField(
                        controller: textPassword,
                        obscureText: visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "password",
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: visiblePassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              visiblePassword = !visiblePassword;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
