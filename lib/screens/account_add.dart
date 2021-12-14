import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/account.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({Key? key}) : super(key: key);

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

  bool get accountFormIsValid => keyForm.currentState!.validate();

  String? fieldValidator(String? input) {
    String? value;

    if (input == null || input.isEmpty) {
      value = "This field is required";
    }

    return value;
  }

  /// Returns an [Account] to the previous route if [Form] is valid
  void popValidForm() {
    if (accountFormIsValid) {
      popCreatedAccount();
    }
  }

  /// Creates an [Account] from the [Form] and pops it back to the previous route
  void popCreatedAccount() {
    final account = Account.now(
      name: textName.text,
      address: textAddress.text,
      username: textUsername.text,
      password: textPassword.text,
    );

    Navigator.pop<Account>(context, account);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.account(size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add an account"),
        actions: <Widget>[
          Semantics(
            button: true,
            hint: "Tap to add account",
            label: "Add account button",
            child: IconButton(
              icon: const Icon(Icons.check),
              tooltip: "Add",
              onPressed: popValidForm,
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
              Column(
                children: <Widget>[
                  const Align(
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
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Example",
                      ),
                      validator: fieldValidator,
                    ),
                  ),
                ],
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Address
              Column(
                children: <Widget>[
                  const Align(
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
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "https://www.example.com",
                      ),
                      validator: fieldValidator,
                    ),
                  ),
                ],
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Username
              Column(
                children: <Widget>[
                  const Align(
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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "account@email.com",
                      ),
                      validator: fieldValidator,
                    ),
                  ),
                ],
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              //Password
              Column(
                children: <Widget>[
                  const Align(
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
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: fieldValidator,
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
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
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
