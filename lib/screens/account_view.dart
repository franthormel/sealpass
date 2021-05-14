import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../manager/padding.dart';
import '../models/account.dart';
import '../models/enums.dart';
import '../models/provider.dart';

class AccountView extends StatefulWidget {
  final Account account;

  AccountView(this.account, {Key key}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final keyForm = GlobalKey<FormState>();
  final textName = TextEditingController();
  final textAddress = TextEditingController();
  final textUsername = TextEditingController();
  final textPassword = TextEditingController();
  final textTime = TextEditingController();

  bool maskPassword = true;

  bool editing = false;

  @override
  void initState() {
    super.initState();

    //Display account details
    textName.text = widget.account.name;
    textAddress.text = widget.account.address;
    textUsername.text = widget.account.username;
    textPassword.text = widget.account.password;
    textTime.text = widget.account.timeFormat();
  }

  ///Returns an [Account] given the text values for each [TextFormField]
  ///
  /// Used when editing
  Account accountNew() {
    return Account.now(
      name: textName.text,
      address: textAddress.text,
      username: textUsername.text,
      password: textPassword.text,
    );
  }

  ///Updates the old [Account] from the current list of accounts with new properties
  void actionEdit() {
    if (keyForm.currentState.validate()) {
      final account = accountNew();

      final provider = Provider.of<AccountsModel>(context, listen: false);

      provider.accountEdit(widget.account, account);

      Navigator.pop<ViewOptions>(context, ViewOptions.Edit);
    }
  }

  ///Delete the [Account] from the current list of accounts
  void actionDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final colorCancel = theme.primaryColor;
        final colorDelete = theme.errorColor;

        return AlertDialog(
          title: Text(
            "Confirm Delete",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text("Deleting an account cannot be undone!"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "CANCEL",
                style: TextStyle(
                  color: colorCancel,
                ),
              ),
              onPressed: () {
                Navigator.pop<bool>(context, false);
              },
            ),
            TextButton(
              child: Text(
                "DELETE",
                style: TextStyle(
                  color: colorDelete,
                ),
              ),
              onPressed: () {
                Navigator.pop<bool>(context, true);
              },
            ),
          ],
        );
      },
    );

    if (confirm != null && confirm) {
      final provider = Provider.of<AccountsModel>(context, listen: false);

      provider.accountDelete(widget.account);

      Navigator.pop<ViewOptions>(context, ViewOptions.Delete);
    }
  }

  ///Call the method according to [ViewOptions] value
  void callOptions(ViewOptions options) {
    if (options == ViewOptions.Edit) {
      switchToEditingMode();
    } else if (options == ViewOptions.Delete) {
      actionDelete();
    }
  }

  ///Sets editing [bool] value to [true]
  ///
  /// Hides all unimportant widgets, enables all [TextFormFields] and changes
  ///
  /// action button
  void switchToEditingMode() {
    setState(() {
      editing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.account(size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: editing ? Text("Edit information") : Text("View information"),
        actions: <Widget>[
          editing
              ? Semantics(
                  button: true,
                  hint: "Tap to edit",
                  label: "Edit button",
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: "Edit account",
                    onPressed: actionEdit,
                  ),
                )
              : Semantics(
                  button: true,
                  hint: "Tap to view options",
                  label: "Options",
                  child: PopupMenuButton<ViewOptions>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) {
                      callOptions(value);
                    },
                    itemBuilder: (context) => <PopupMenuEntry<ViewOptions>>[
                      PopupMenuItem<ViewOptions>(
                        value: ViewOptions.Edit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.edit_outlined),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem<ViewOptions>(
                        value: ViewOptions.Delete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.delete_forever_outlined),
                            Text("Delete"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: padding,
        child: Form(
          key: keyForm,
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
                    TextFormField(
                      controller: textName,
                      enabled: editing,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Example",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
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
                        TextFormField(
                          controller: textAddress,
                          enabled: editing,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "https://www.example.com",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Address is required";
                            }
                            return null;
                          },
                        ),
                        if (!editing)
                          Semantics(
                            button: true,
                            hint: "Tap to view",
                            label: "View address button",
                            link: true,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                tooltip: "Open URL",
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
                        TextFormField(
                          controller: textUsername,
                          enabled: editing,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "user@example.com",
                          ),
                        ),
                        if (!editing)
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

                                  final messenger =
                                      ScaffoldMessenger.of(context);

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
                          child: TextFormField(
                            controller: textPassword,
                            enabled: editing,
                            obscureText: maskPassword,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
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
                            if (!editing)
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

                                    final messenger =
                                        ScaffoldMessenger.of(context);

                                    messenger.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Copied password to clipboard!"),
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
              if (!editing)
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
                        enabled: editing,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
