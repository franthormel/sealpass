import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../manager/padding.dart';
import '../models/account.dart';
import '../models/enums.dart';
import '../models/provider.dart';

class AccountView extends StatefulWidget {
  final Account account;

  const AccountView(this.account, {Key? key}) : super(key: key);

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

  bool editing = false;
  bool obscured = true;

  @override
  void initState() {
    super.initState();
    displayDetails();
  }

  void callOptions(AccountOptions options) {
    if (options == AccountOptions.edit) {
      setState(() {
        editing = true;
      });
    } else if (options == AccountOptions.delete) {
      delete();
    }
  }

  /// Copies the text into the [Clipboard] then displays a [SnackBar]
  void copyNotify(TextEditingController controller, String text) {
    Clipboard.setData(ClipboardData(
      text: controller.text,
    ));

    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text("Copied $text to clipboard!"),
        action: SnackBarAction(
          label: "DISMISS",
          onPressed: () {
            messenger.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final colorCancel = theme.primaryColor;
        final colorDelete = theme.errorColor;

        return AlertDialog(
          content: const Text("Deleting an account cannot be undone!"),
          title: const Text(
            "Confirm Delete",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
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

      provider.delete(widget.account);

      Navigator.pop<AccountOptions>(context, AccountOptions.delete);
    }
  }

  void displayDetails() {
    textName.text = widget.account.name;
    textAddress.text = widget.account.address;
    textUsername.text = widget.account.username;
    textPassword.text = widget.account.password;
    textTime.text = widget.account.timeFormatted;
  }

  void edit() {
    if (keyForm.currentState!.validate()) {
      final provider = Provider.of<AccountsModel>(context, listen: false);
      final account = Account.now(
        name: textName.text,
        address: textAddress.text,
        username: textUsername.text,
        password: textPassword.text,
      );

      provider.edit(widget.account, account);

      Navigator.pop<AccountOptions>(context, AccountOptions.edit);
    }
  }

  String? fieldValidator(String? input) {
    String? value;

    if (input == null || input.isEmpty) {
      value = "This field is required";
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.account(size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: editing
            ? const Text("Edit information")
            : const Text("View information"),
        actions: <Widget>[
          editing
              ? Semantics(
                  button: true,
                  hint: "Tap to edit",
                  label: "Edit button",
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: "Edit account",
                    onPressed: edit,
                  ),
                )
              : Semantics(
                  button: true,
                  hint: "Tap to view options",
                  label: "Options",
                  child: PopupMenuButton<AccountOptions>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      callOptions(value);
                    },
                    itemBuilder: (context) => <PopupMenuEntry<AccountOptions>>[
                      PopupMenuItem<AccountOptions>(
                        value: AccountOptions.edit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Icon(Icons.edit_outlined),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem<AccountOptions>(
                        value: AccountOptions.delete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Name"),
                    ),
                    TextFormField(
                      controller: textName,
                      enabled: editing,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Example",
                      ),
                      validator: fieldValidator,
                    ),
                  ],
                ),
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Address
              Semantics(
                readOnly: true,
                child: Column(
                  children: <Widget>[
                    const Align(
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
                          decoration: const InputDecoration(
                            hintText: "https://www.example.com",
                          ),
                          validator: fieldValidator,
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
                                icon: const Icon(Icons.open_in_new),
                                onPressed: () {},
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Username
              Semantics(
                readOnly: true,
                child: Column(
                  children: <Widget>[
                    const Align(
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
                          decoration: const InputDecoration(
                            hintText: "account@email.com",
                          ),
                          validator: fieldValidator,
                        ),
                        if (!editing)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Semantics(
                              button: true,
                              hint: "Tap to copy username",
                              label: "Copy username button",
                              child: IconButton(
                                icon: const Icon(Icons.copy),
                                tooltip: "Copy username",
                                onPressed: () {
                                  copyNotify(textUsername, "username");
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Password
              Semantics(
                readOnly: true,
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Password"),
                    ),
                    Stack(
                      children: <Widget>[
                        Semantics(
                          obscured: obscured,
                          child: TextFormField(
                            controller: textPassword,
                            enabled: editing,
                            obscureText: obscured,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: fieldValidator,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Semantics(
                              button: true,
                              hint: obscured
                                  ? "Tap to show password"
                                  : "Tap to hide password",
                              label: "Obscure password button",
                              child: IconButton(
                                icon: obscured
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                                tooltip: obscured
                                    ? "Show password"
                                    : "Hide password",
                                onPressed: () {
                                  setState(() {
                                    obscured = !obscured;
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
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    copyNotify(textPassword, "password");
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
              const Flexible(
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
                      const Align(
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
