import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';

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
    final dimensions = SizeManager.profilePicture(size);

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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                          //You could place a profile picture here if you want
                          Semantics(
                            image: true,
                            label: "Profile picture",
                            child: Container(
                              height: dimensions,
                              width: dimensions,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFA7A9DC),
                                    Color(0xFF5053B9),
                                    Color(0xFF292B66),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(
                  Icons.lock,
                  color: colorPrimary,
                ),
                title: Text("Seal passwords"),
                //TODO: Log out
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
