import 'package:flutter/material.dart';

import 'account.dart';
import 'data/accounts.dart';

class AccountsModel extends ChangeNotifier {
  List<Account> _accounts = sourceOfAccounts;

  List<Account> get accounts => _accounts;

  /// Append [account] to current list of accounts
  void add(Account account) {
    _accounts.add(account);
    notifyListeners();
  }

  /// Delete [account] from the current list of accounts
  void delete(Account account) {
    _accounts.remove(account);
    notifyListeners();
  }

  /// Overwrites the [old] account with [edit]
  void edit(Account old, Account edit) {
    final index = _accounts.indexOf(old);

    if (index != -1) {
      _accounts[index] = edit;
    }

    notifyListeners();
  }
}
