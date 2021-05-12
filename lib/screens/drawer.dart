import 'package:flutter/material.dart';

import '../manager/padding.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({Key key}) : super(key: key);

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  bool expandDisplayType = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.header(size);

    final theme = Theme.of(context);
    final colorPrimary = theme.primaryColor;
    final styleHeader = theme.textTheme.headline5;
    final styleSubtitle = theme.textTheme.bodyText2;

    return Semantics(
      button: true,
      hint: "Display menu",
      label: "Menu button",
      child: Drawer(
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: colorPrimary,
                  ),
                  child: Padding(
                    padding: padding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sealpass",
                          style: styleHeader,
                        ),
                        Text(
                          "account@email.com",
                          style: styleSubtitle,
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.list,
                    color: colorPrimary,
                  ),
                  title: Text("Display List Type"),
                  //TODO: Show dialog for display types
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
