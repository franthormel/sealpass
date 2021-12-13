import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/padding.dart';
import '../models/account.dart';
import '../models/enums.dart';
import '../models/provider.dart';
import '../screens/account_add.dart';
import 'account_view.dart';
import 'drawer.dart';
import 'search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  late List<Account> accounts;
  SortType? sorting;

  ///Add returned [Account] to [List<Account>] then refresh [ListView]
  void add(AccountsModel provider) async {
    final account = await Navigator.push<Account>(
      context,
      MaterialPageRoute(
        builder: (context) => AccountAdd(),
      ),
    );

    //This is where you usually add the new account to a database or server
    //1. We add it to the 'source'
    //2. Sort our copy if possible
    //3. Display a SnackBar
    if (account != null) {
      provider.add(account);

      if (sorting != null) {
        sort();
      }

      notify("Account created for ${account.name}!");
    }
  }

  ///Displays a [SnackBar] then refreshes the [ListView]
  ///
  /// The [String] parameter is used as the [SnackBar]'s label
  void notify(String text) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            messenger.hideCurrentSnackBar();
          },
        ),
      ),
    );

    keyRefresh.currentState!.show();
  }

  ///Sort [List<Account>] depending on [SortType]
  void sort([SortType? value]) {
    if (value != null) {
      sorting = value;
    }

    if (sorting == SortType.Alphabetical) {
      accounts.sort((a, b) => a.name.compareTo(b.name));
    } else if (sorting == SortType.Chronological) {
      accounts.sort((a, b) => b.time.compareTo(a.time));
    }
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
  ///
  /// If possible, sorts
  void view(Account account) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final view = await Navigator.push<AccountOptions>(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(account),
      ),
    );

    //Show a SnackBar then refresh the ListView to notify the user
    //that the change they made has been processed!
    if (view != null) {
      if (view == AccountOptions.Edit) {
        notify("Account edited for ${account.name}!");
      } else if (view == AccountOptions.Delete) {
        notify("Account deleted for ${account.name}!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountsModel>(context);

    accounts = provider.accounts;

    final count = accounts.length;

    final size = MediaQuery.of(context).size;
    final paddingHome = PaddingManager.homeSearch(size);

    final theme = Theme.of(context);
    final color = theme.primaryColor;
    final styleTitle = theme.textTheme.headline6;
    final styleSubtitle = theme.textTheme.bodyText2;

    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Semantics(
          hint: "Tap to search for an account",
          label: "Search area",
          child: GestureDetector(
            child: Text("Search for your account"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
          ),
        ),
        actions: <Widget>[
          Semantics(
            button: true,
            hint: "Show sort options",
            label: "Sort options",
            child: PopupMenuButton<SortType>(
              icon: Icon(Icons.arrow_drop_down),
              tooltip: "Sort options",
              onSelected: (value) {
                setState(() {
                  sort(value);
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<SortType>>[
                PopupMenuItem<SortType>(
                  value: SortType.Alphabetical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.sort_by_alpha),
                      Text("Alphabetically"),
                    ],
                  ),
                ),
                PopupMenuItem<SortType>(
                  value: SortType.Chronological,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.schedule),
                      Text("Recently Used"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add account",
        onPressed: () {
          add(provider);
        },
      ),
      body: Padding(
        padding: paddingHome,
        child: count == 0
            ? Align(
                alignment: Alignment.topCenter,
                child: Text("No accounts found!"),
              )
            : Semantics(
                hint: "Scroll up/down to view more",
                label: "List of your accounts",
                child: RefreshIndicator(
                  color: color,
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
