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

  void addThenNotify(AccountsModel provider) async {
    final account = await createAccountViaPage();

    if (account != null) {
      provider.add(account);

      if (sorting != null) {
        sortByType();
      }

      displaySnackBarThenRefresh("Account created for ${account.name}!");
    }
  }

  Future<Account?> createAccountViaPage() async {
    return await Navigator.push<Account>(
      context,
      MaterialPageRoute(
        builder: (context) => const AccountAdd(),
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

  Future<AccountOptions?> displayAccountViewPage(Account account) async {
    return await Navigator.push<AccountOptions>(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(account),
      ),
    );
  }

  void hideSnackbar([ScaffoldMessengerState? messenger]) {
    final scaffold = messenger ?? ScaffoldMessenger.of(context);

    scaffold.hideCurrentSnackBar();
  }

  void refresh() {
    keyRefresh.currentState!.show();
  }

  void sortAlphabetically() {
    accounts.sort((a, b) => a.name.compareTo(b.name));
  }

  void sortChronologically() {
    accounts.sort((a, b) => b.time.compareTo(a.time));
  }

  void sortByType([SortType? value]) {
    if (value != null) {
      sorting = value;
    }

    switch (sorting) {
      case SortType.alphabetical:
        sortAlphabetically();
        break;
      case SortType.chronological:
        sortChronologically();
        break;
      default:
    }
  }

  void view(Account account) async {
    hideSnackbar();

    await viewPage(account);
  }

  Future<void> viewPage(Account account) async {
    final view = await displayAccountViewPage(account);

    switch (view) {
      case AccountOptions.edit:
        displaySnackBarThenRefresh("Account edited for ${account.name}!");
        break;
      case AccountOptions.delete:
        displaySnackBarThenRefresh("Account deleted for ${account.name}!");
        break;
      default:
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
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: Semantics(
          hint: "Tap to search for an account",
          label: "Search area",
          child: GestureDetector(
            child: const Text("Search for your account"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Search(),
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
              icon: const Icon(Icons.arrow_drop_down),
              tooltip: "Sort options",
              onSelected: (value) {
                setState(() {
                  sortByType(value);
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<SortType>>[
                PopupMenuItem<SortType>(
                  value: SortType.alphabetical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Icon(Icons.sort_by_alpha),
                      Text("Alphabetically"),
                    ],
                  ),
                ),
                PopupMenuItem<SortType>(
                  value: SortType.chronological,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
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
        child: const Icon(Icons.add),
        tooltip: "Add account",
        onPressed: () {
          addThenNotify(provider);
        },
      ),
      body: Padding(
        padding: paddingHome,
        child: count == 0
            ? const Align(
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
