import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../models/credential.dart';
import 'credential_view.dart';

class Search extends StatefulWidget {
  final List<Credential> credentialSource;

  const Search(this.credentialSource, {Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textSearch = TextEditingController();

  List<Credential> credentialSearch;

  @override
  void initState() {
    super.initState();
    resetSource();
  }

  ///Sets [List<Credential>] from its original state
  void resetSource() {
    credentialSearch = widget.credentialSource;
  }

  ///Checks if the [List<Credential>] contains the text
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
              updateList(text);
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
                        textSearch.clear();
                        resetSource();
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
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    final account = credentialSearch[index];

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
    );
  }
}
