import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/credential.dart';
import '../models/data/credentials.dart';
import '../models/enum/enums.dart';
import '../screens/credential_add.dart';
import 'credential_view.dart';
import 'drawer.dart';
import 'search.dart';

class Home extends StatefulWidget {
  //Usually you get this from a server so we'll use this as our example
  List<Credential> credentialsSource = sourceCredentials;

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  List<Credential> credentials;
  SortType sorting;

  @override
  void initState() {
    super.initState();
    resetSource();
  }

  ///Sets [List<Credential>] from its original state
  void resetSource() {
    credentials = widget.credentialsSource;
  }

  ///Sort [List<Credential>] depending on [SortType]
  void sortCredentials() {
    if (sorting == SortType.Alphabetical) {
      credentials.sort((a, b) => a.name.compareTo(b.name));
    } else if (sorting == SortType.Chronological) {
      credentials.sort((a, b) => b.time.compareTo(a.time));
    }
  }

  ///Add returned [Credential] to [List<Credential>] then refresh [ListView]
  void addCredential(BuildContext context) async {
    final credential = await Navigator.push<Credential>(
      context,
      MaterialPageRoute(
        builder: (context) => CredentialAdd(),
      ),
    );

    //This is where you usually add the new credential to a database or server
    //1. We add it to the 'source'
    //2. We get a copy of the source
    //3. Sort our copy if possible
    //4. Display a SnackBar
    //5. Refresh ListView
    //TODO: Transition to Provider state management
    if (credential != null) {
      credentials.add(credential);

      resetSource();

      if (sorting != null) {
        sortCredentials();
      }

      final messenger = ScaffoldMessenger.of(context);

      messenger.showSnackBar(
        SnackBar(
          content: Text("Account created!"),
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingHome = PaddingManager.home(size);

    final theme = Theme.of(context);
    final colorPrimary = theme.primaryColor;
    final styleTitle = theme.textTheme.headline6;
    final styleSubtitle = theme.textTheme.bodyText2;

    final count = credentials.length;

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
                  builder: (context) => Search(widget.credentialsSource),
                ),
              );
            },
          ),
        ),
        actions: <Widget>[
          Semantics(
            button: true,
            hint: "Show sort options",
            label: "Sort option",
            child: PopupMenuButton<SortType>(
              icon: Icon(Icons.arrow_drop_down),
              onSelected: (value) {
                sorting = value;

                setState(() {
                  sortCredentials();
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
      //TODO: Add FAB animation to add screen
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add account",
        onPressed: () {
          addCredential(context);
        },
      ),
      body: Padding(
        padding: paddingHome,
        child: RefreshIndicator(
          color: colorPrimary,
          key: keyRefresh,
          onRefresh: () {
            setState(() {});
            return Future.delayed(const Duration(seconds: 1))
                .then((value) => null);
          },
          //TODO: Instead of showing text indicating empty state make it more lively by using an image or animation
          child: count == 0
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Text("No accounts found!"),
                )
              : Semantics(
                  hint: "Scroll up/down to view more",
                  label: "List of your accounts",
                  child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) {
                      final account = credentials[index];

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CredentialView(account),
                              ),
                            );
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
