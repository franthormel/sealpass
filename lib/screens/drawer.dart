import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final photo = SizeManager.profile(size);
    final padding = PaddingManager.header(size);

    final theme = Theme.of(context);
    final colorAccent = theme.accentColor;
    final colorPrimary = theme.primaryColor;
    final styleHeader = theme.textTheme.headline5;
    final styleSubtitle = theme.textTheme.bodyText2;

    return Semantics(
      button: true,
      hint: "Display menu",
      label: "Menu button",
      child: Drawer(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: colorPrimary,
                  ),
                  child: Padding(
                    padding: padding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
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
                        Container(
                          height: photo,
                          width: photo,
                          decoration: BoxDecoration(
                            color: colorAccent,
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xFFFCE891),
                                Color(0xFFF49C06),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.lock, color: colorPrimary),
                title: Text("Seal Passwords"),
                onTap: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName('/'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
