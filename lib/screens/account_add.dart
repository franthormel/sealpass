import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/account.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({Key key}) : super(key: key);

  @override
  _AccountAddState createState() => _AccountAddState();
}

class _AccountAddState extends State<AccountAdd> {
  final keyForm = GlobalKey<FormState>();
  final textName = TextEditingController();
  final textAddress = TextEditingController();
  final textUsername = TextEditingController();
  final textPassword = TextEditingController();

  bool maskPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.account(size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add an account"),
        actions: <Widget>[
          //FOR SAMPLING ONLY!!!
          Semantics(
            button: true,
            hint: "Tap to fill with sample",
            label: "Sample button",
            child: IconButton(
              icon: Icon(Icons.description_outlined),
              tooltip: "Sample",
              onPressed: () {
                textName.text = "Google";
                textAddress.text = "accounts.google.com";
                textUsername.text = "sample@gmail.com";
                textPassword.text = "P@s\$w0rd";
              },
            ),
          ),
          Semantics(
            button: true,
            hint: "Tap to add account",
            label: "Add account button",
            child: IconButton(
              icon: Icon(Icons.check),
              tooltip: "Add",
              onPressed: () {
                if (keyForm.currentState.validate()) {
                  final account = Account.now(
                    name: textName.text,
                    address: textAddress.text,
                    username: textUsername.text,
                    password: textPassword.text,
                  );

                  Navigator.pop<Account>(context, account);
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        //TODO: Put max limit on input
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
                  Semantics(
                    currentValueLength: textName.text.length,
                    hint: "Enter account name",
                    label: "Name text field",
                    multiline: false,
                    textField: true,
                    child: TextFormField(
                      autofocus: true,
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
                  Semantics(
                    currentValueLength: textAddress.text.length,
                    hint: "Enter web address",
                    label: "Address text field",
                    multiline: false,
                    textField: true,
                    child: TextFormField(
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
                  Semantics(
                    currentValueLength: textUsername.text.length,
                    hint: "Enter username",
                    label: "Username text field",
                    multiline: false,
                    textField: true,
                    child: TextFormField(
                      controller: textUsername,
                      decoration: InputDecoration(
                        hintText: "user@example.com",
                      ),
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
                      Semantics(
                        currentValueLength: textPassword.text.length,
                        hint: "Enter account password",
                        label: "Password text field",
                        multiline: false,
                        textField: true,
                        child: TextFormField(
                          controller: textPassword,
                          obscureText: maskPassword,
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
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Semantics(
                          button: true,
                          hint: maskPassword
                              ? "Tap to show password"
                              : "Tap to hide password",
                          label: "Obscure password button",
                          child: IconButton(
                            icon: maskPassword
                                ? Icon(Icons.visibility_outlined)
                                : Icon(Icons.visibility_off_outlined),
                            tooltip: maskPassword
                                ? "Show password"
                                : "Hide password",
                            onPressed: () {
                              setState(() {
                                maskPassword = !maskPassword;
                              });
                            },
                          ),
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
