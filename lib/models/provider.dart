import 'package:flutter/material.dart';

import 'account.dart';
import 'data/accounts.dart';

class AccountsModel extends ChangeNotifier {
  List<Account> _accounts = sourceOfAccounts;

  ///Returns current list of accounts
  List<Account> get accounts => _accounts;

  ///Append an [Account] to current list of accounts
  void add(Account account) {
    _accounts.add(account);
    notifyListeners();
  }

  ///Delete an [Account] from the current list of accounts
  void delete(Account account) {
    _accounts.remove(account);
    notifyListeners();
  }

  ///Overwrites the old [Account] with the edited [Account]
  void edit(Account old, Account edit) {
    final index = _accounts.indexOf(old);

    if (index != -1) {
      _accounts[index] = edit;
    }

    notifyListeners();
  }
}
