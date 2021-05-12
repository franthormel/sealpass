import 'package:flutter/material.dart';

import 'account.dart';
import 'data/accounts.dart';
import 'enums.dart';

class AccountsModel extends ChangeNotifier {
  //Usually we store/retrieve this from a server so we'll use this as our example
  List<Account> _accounts = sourceOfAccounts;

  //How the ListView in Home will be displayed
  DisplayType _display = DisplayType.Simple;

  ///Returns current [DisplayType] value
  DisplayType get display => _display;

  ///Returns current list of accounts
  List<Account> get source => _accounts;

  ///Changes the current value for [DisplayType]
  void changeDisplayType(DisplayType type) {
    _display = type;
    notifyListeners();
  }

  ///Append an [Account] to current list of accounts
  void accountAdd(Account account) {
    _accounts.add(account);
    notifyListeners();
  }

  ///Delete an [Account] from current list of accounts
  void accountDelete(Account account) {
    _accounts.remove(account);
    notifyListeners();
  }

  ///Overwrites the old [Account] with the edit [Account]
  void accountEdit(Account old, Account edit) {
    final index = _accounts.indexOf(old);

    if (index != -1) {
      _accounts[index] = edit;
    }

    notifyListeners();
  }
}
