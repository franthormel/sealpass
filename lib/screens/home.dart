import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/data/credentials.dart';
import '../models/enum/enums.dart';
import 'search.dart';

class Home extends StatefulWidget {
  //Usually you get this from a server so we'll use this models.data as our example

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final credentials = sourceCredentials;

  SearchType searchType;

  ///Sort [List<Credential>] depending on [SearchType]
  void sortCredentials() {
    if (searchType == SearchType.Alphabetical) {
      credentials.sort((a, b) => a.company.compareTo(b.company));
    } else if (searchType == SearchType.Chronological) {
      credentials.sort((a, b) => b.time.compareTo(a.time));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.home(size);

    final theme = Theme.of(context);
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
          PopupMenuButton<SearchType>(
            icon: Icon(Icons.arrow_drop_down),
            onSelected: (value) {
              searchType = value;

              setState(() {
                sortCredentials();
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<SearchType>>[
              PopupMenuItem<SearchType>(
                value: SearchType.Alphabetical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.sort_by_alpha),
                    Text("Alphabetically"),
                  ],
                ),
              ),
              PopupMenuItem<SearchType>(
                value: SearchType.Chronological,
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
        onPressed: () {},
      ),
      body: Padding(
        padding: padding,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final c = sourceCredentials[index];

            //TODO: Add method for viewing credential details
            return ListTile(
              onTap: () {},
              title: Text(
                c.company,
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
    );
  }
}
