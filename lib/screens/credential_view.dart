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
          IconButton(
            icon: Icon(Icons.more_vert),
            tooltip: "More options",
            //TODO: Show popupmenu edit and delete
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            //Name
            Column(
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
                Stack(
                  children: <Widget>[
                    TextField(
                      controller: textAddress,
                      enabled: false,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        tooltip: "Open",
                        icon: Icon(Icons.open_in_new),
                        onPressed: () {
                          //TODO: Launch this address to browser
                        },
                      ),
                    ),
                  ],
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
                Stack(
                  children: <Widget>[
                    TextField(
                      controller: textUsername,
                      enabled: false,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        tooltip: "Copy username",
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                            text: textUsername.text,
                          ));

                          final messenger = ScaffoldMessenger.of(context);

                          messenger.showSnackBar(
                            SnackBar(
                              content: Text("Copied username to clipboard!"),
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
                    TextField(
                      controller: textPassword,
                      obscureText: maskPassword,
                      enabled: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          tooltip:
                              maskPassword ? "Show password" : "Hide password",
                          icon: maskPassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              maskPassword = !maskPassword;
                            });
                          },
                        ),
                        IconButton(
                          tooltip: "Copy password",
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                              text: textPassword.text,
                            ));

                            final messenger = ScaffoldMessenger.of(context);

                            messenger.showSnackBar(
                              SnackBar(
                                content: Text("Copied password to clipboard!"),
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .1,
              ),
            ),
            //Timestamp
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Timestamp"),
                ),
                TextFormField(
                  controller: textTime,
                  enabled: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
