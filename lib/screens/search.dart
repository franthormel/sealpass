import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/padding.dart';
import '../models/account.dart';
import '../models/enums.dart';
import '../models/provider.dart';
import 'account_view.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textSearch = TextEditingController();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  List<Account> accounts;

  @override
  void initState() {
    super.initState();
    sourceAccounts();
  }

  ///Displays a [SnackBar] then refreshes the [ListView]
  ///
  /// The [String] parameter is used as the [SnackBar]'s label
  void notifyRefresh(String text) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            messenger.hideCurrentSnackBar();
          },
        ),
      ),
    );

    keyRefresh.currentState.show();
  }

  ///Sets current list of accounts
  ///
  /// This is called everytime [TextField]'s text is changed per tap or
  ///
  /// when clear button is tapped.
  void sourceAccounts() {
    accounts = Provider.of<AccountsModel>(context, listen: false).source;
  }

  ///Pushes a [AccountView] page
  ///
  /// Closes any active [SnackBar] before pushing [AccountView] page
  ///
  /// The [Account] details are displayed on [AccountView] page
  ///
  /// After the [AccountView] page has been dismissed
  ///
  /// Display a [SnackBar] and refreshes the [ListView]
  void viewAccount(Account account) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final view = await Navigator.push<ViewOptions>(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(account),
      ),
    );

    //Show a SnackBar then refresh the ListView to notify the user
    //that the change they made has been processed!
    if (view != null) {
      if (view == ViewOptions.Edit) {
        notifyRefresh("Account edited for ${account.name}!");
      } else if (view == ViewOptions.Delete) {
        notifyRefresh("Account deleted for ${account.name}!");
      }
      sourceAccounts();
      textSearch.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.home(size);

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
                sourceAccounts();
                accounts =
                    accounts.where((a) => a.searchContains(text)).toList();
              });
            },
            decoration: InputDecoration(
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
              icon: Icon(Icons.delete_outline),
              tooltip: "Clear",
              onPressed: textSearch.text.isNotEmpty
                  ? () {
                      setState(() {
                        sourceAccounts();
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
        //TODO: Instead of showing text indicating empty state make it more lively by using an image or animation
        child: count == 0
            ? Align(
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
                            viewAccount(account);
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
