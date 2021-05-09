import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/credential.dart';
import 'credential_view.dart';

class Search extends StatefulWidget {
  //Original
  final List<Credential> credentialSource;

  const Search(this.credentialSource, {Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //Use this for building or rebuilding, just make sure to set it back again from
  //the source if the [TextField] is empty or reset
  List<Credential> credentialSearch;

  final textSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    resetSource();
  }

  void resetSource() {
    credentialSearch = widget.credentialSource;
  }

  void updateList(String text) {
    setState(() {
      resetSource();

      if (text.isNotEmpty) {
        credentialSearch = credentialSearch
            .where((credential) => credential.searchContains(text))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.home(size);

    final theme = Theme.of(context);
    final styleTitle = theme.textTheme.headline6;
    final styleSubtitle = theme.textTheme.bodyText2;

    final count = credentialSearch.length;

    return Scaffold(
      appBar: AppBar(
        //TODO: Put limit to max characters
        title: TextField(
          autofocus: true,
          controller: textSearch,
          onChanged: (text) {
            updateList(text);
          },
          decoration: InputDecoration(
            labelText: "Search for your account",
            hintText: "Name or email",
            border: InputBorder.none,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline),
            tooltip: "Clear",
            onPressed: textSearch.text.isNotEmpty
                ? () {
                    textSearch.clear();
                    updateList(textSearch.text);
                  }
                : null,
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        child: count == 0
            ? Align(
                alignment: Alignment.topCenter,
                child: Text("No accounts found!"),
              )
            : ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  final account = credentialSearch[index];

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CredentialView(account),
                        ),
                      );
                    },
                    title: Text(
                      account.name,
                      style: styleTitle,
                    ),
                    subtitle: Text(
                      account.username,
                      style: styleSubtitle,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
