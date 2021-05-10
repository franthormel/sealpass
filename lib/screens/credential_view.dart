import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../manager/padding.dart';
import '../models/credential.dart';

class CredentialView extends StatefulWidget {
  final Credential credential;

  CredentialView(this.credential, {Key key}) : super(key: key);

  @override
  _CredentialViewState createState() => _CredentialViewState();
}

class _CredentialViewState extends State<CredentialView> {
  final textName = TextEditingController();
  final textAddress = TextEditingController();
  final textUsername = TextEditingController();
  final textPassword = TextEditingController();
  final textTime = TextEditingController();

  bool maskPassword = true;

  @override
  void initState() {
    super.initState();

    //Display credential details
    textName.text = widget.credential.name;
    textAddress.text = widget.credential.address;
    textUsername.text = widget.credential.username;
    textPassword.text = widget.credential.password;
    textTime.text = widget.credential.timeFormat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.credential(size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("View information"),
        actions: <Widget>[
          Semantics(
            button: true,
            hint: "Tap to view options",
            label: "Options",
            child: IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: "More options",
              //TODO: Show popupmenu edit and delete
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            //Name
            Semantics(
              readOnly: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Name"),
                  ),
                  TextField(
                    controller: textName,
                    enabled: false,
                  ),
                ],
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .1,
              ),
            ),
            //Address
            Semantics(
              readOnly: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Address"),
                  ),
                  Stack(
                    children: <Widget>[
                      TextField(
                        controller: textAddress,
                        enabled: false,
                      ),
                      Semantics(
                        button: true,
                        hint: "Tap to view",
                        label: "View address button",
                        link: true,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            tooltip: "Open",
                            icon: Icon(Icons.open_in_new),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .1,
              ),
            ),
            //Username
            Semantics(
              readOnly: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Username"),
                  ),
                  Stack(
                    children: <Widget>[
                      TextField(
                        controller: textUsername,
                        enabled: false,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Semantics(
                          button: true,
                          hint: "Tap to copy username",
                          label: "Copy username button",
                          child: IconButton(
                            icon: Icon(Icons.copy),
                            tooltip: "Copy username",
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                text: textUsername.text,
                              ));

                              final messenger = ScaffoldMessenger.of(context);

                              messenger.showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Copied username to clipboard!"),
                                  action: SnackBarAction(
                                    label: "DISMISS",
                                    onPressed: () {
                                      messenger.hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .1,
              ),
            ),
            //Password
            Semantics(
              readOnly: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password"),
                  ),
                  Stack(
                    children: <Widget>[
                      Semantics(
                        obscured: maskPassword,
                        child: TextField(
                          controller: textPassword,
                          obscureText: maskPassword,
                          enabled: false,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Semantics(
                            button: true,
                            hint: maskPassword
                                ? "Tap to show password"
                                : "Tap to hide password",
                            label: "Obscure password button",
                            child: IconButton(
                              icon: maskPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
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
                          Semantics(
                            button: true,
                            hint: "Tap to copy password",
                            label: "Copy password button",
                            child: IconButton(
                              tooltip: "Copy password",
                              icon: Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                  text: textPassword.text,
                                ));

                                final messenger = ScaffoldMessenger.of(context);

                                messenger.showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Copied password to clipboard!"),
                                    action: SnackBarAction(
                                      label: "DISMISS",
                                      onPressed: () {
                                        messenger.hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
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
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .1,
              ),
            ),
            //Timestamp
            Semantics(
              readOnly: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Timestamp"),
                  ),
                  TextField(
                    controller: textTime,
                    enabled: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
