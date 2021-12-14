import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/padding.dart';
import '../models/account.dart';
import '../models/enums.dart';
import '../models/provider.dart';
import 'account_view.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textSearch = TextEditingController();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  late List<Account> accounts;

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  Future<AccountOptions?> displayAccountViewPage(Account account) async {
    return await Navigator.push<AccountOptions>(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(account),
      ),
    );
  }

  void displaySnackBarThenRefresh(String text) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            hideSnackbar(messenger);
          },
        ),
      ),
    );

    refresh();
  }

  void fetchAccounts() {
    accounts = Provider.of<AccountsModel>(context, listen: false).accounts;
  }

  void hideSnackbar([ScaffoldMessengerState? messenger]) {
    final scaffold = messenger ?? ScaffoldMessenger.of(context);

    scaffold.hideCurrentSnackBar();
  }

  void notifyWithCleanup(String text) {
    displaySnackBarThenRefresh(text);
    fetchAccounts();
    textSearch.clear();
  }

  void refresh() {
    keyRefresh.currentState!.show();
  }

  void view(Account account) async {
    hideSnackbar();

    await viewPage(account);
  }

  Future<void> viewPage(Account account) async {
    final view = await displayAccountViewPage(account);

    switch (view) {
      case AccountOptions.edit:
        notifyWithCleanup("Account edited for ${account.name}!");
        break;
      case AccountOptions.delete:
        notifyWithCleanup("Account deleted for ${account.name}!");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.homeSearch(size);

    final theme = Theme.of(context);
    final colorPrimary = theme.primaryColor;
    final styleTitle = theme.textTheme.headline6;
    final styleSubtitle = theme.textTheme.bodyText2;

    final count = accounts.length;

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          currentValueLength: textSearch.text.length,
          focusable: true,
          hint: "Tap to search",
          label: "Search field",
          multiline: false,
          textField: true,
          child: TextField(
            autofocus: true,
            controller: textSearch,
            onChanged: (text) {
              setState(() {
                fetchAccounts();
                accounts = accounts.where((a) => a.contains(text)).toList();
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Name or email",
              labelText: "Search for your account",
            ),
          ),
        ),
        actions: <Widget>[
          Semantics(
            button: true,
            enabled: textSearch.text.isNotEmpty,
            hint: "Tap to clear search field",
            label: "Clear search field button",
            child: IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: "Clear",
              onPressed: textSearch.text.isNotEmpty
                  ? () {
                      setState(() {
                        fetchAccounts();
                        textSearch.clear();
                      });
                    }
                  : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        child: count == 0
            ? const Align(
                alignment: Alignment.topCenter,
                child: Text("No accounts found!"),
              )
            : Semantics(
                hint: "Scroll up/down to view more",
                label: "List of your accounts",
                child: RefreshIndicator(
                  color: colorPrimary,
                  key: keyRefresh,
                  onRefresh: () {
                    setState(() {});
                    return Future.delayed(const Duration(seconds: 2))
                        .then((value) => null);
                  },
                  child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) {
                      final account = accounts[index];

                      return Semantics(
                        hint: "Tap to view details",
                        label: "Account details",
                        child: ListTile(
                          title: Text(
                            account.name,
                            style: styleTitle,
                          ),
                          subtitle: Text(
                            account.username,
                            style: styleSubtitle,
                          ),
                          onTap: () {
                            view(account);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
