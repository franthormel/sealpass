import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/credential.dart';
import '../models/data/credentials.dart';
import '../models/enum/enums.dart';
import '../screens/credential_add.dart';
import 'search.dart';

class Home extends StatefulWidget {
  //Usually you get this from a server so we'll use this models.data as our example

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final credentials = sourceCredentials;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  SortType sorting;

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

    if (credential != null) {
      credentials.add(credential);

      if (sorting != null) {
        sortCredentials();
      }

      keyRefresh.currentState.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.home(size);

    final theme = Theme.of(context);
    final colorRefresh = theme.primaryColor;
    final styleTitle = theme.textTheme.headline6;
    final styleSubtitle = theme.textTheme.bodyText2;

    return Scaffold(
      appBar: AppBar(
        //TODO: Transform this into a drawer
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          tooltip: "Menu",
        ),
        title: GestureDetector(
          child: Text("Search for account"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(),
              ),
            );
          },
        ),
        actions: <Widget>[
          PopupMenuButton<SortType>(
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
        ],
      ),
      //TODO: Add FAB animation to add screen
      //TODO: Add method for add screen
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addCredential(context);
        },
      ),
      body: Padding(
        padding: padding,
        child: RefreshIndicator(
          color: colorRefresh,
          key: keyRefresh,
          onRefresh: () {
            setState(() {});
            return Future.delayed(const Duration(seconds: 1)).then((value) {
              final messenger = ScaffoldMessenger.of(context);

              messenger.showSnackBar(
                (SnackBar(
                  content: Text("Account created!"),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                    },
                  ),
                )),
              );
            });
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              final c = credentials[index];

              //TODO: Add method for viewing credential details
              return ListTile(
                onTap: () {},
                title: Text(
                  c.name,
                  style: styleTitle,
                ),
                subtitle: Text(
                  c.username,
                  style: styleSubtitle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
