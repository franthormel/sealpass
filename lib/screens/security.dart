import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import 'home.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final sizeIcon = SizeManager.iconFinger(size);
    final sizeLogo = SizeManager.logo(size);

    final styleTitle = theme.textTheme.headline4;
    final styleSubtitle = theme.textTheme.subtitle1;

    final padding = PaddingManager.security(size);

    return Scaffold(
      body: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Divider(
              color: Colors.transparent,
            ),
            Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  width: sizeLogo.width,
                  height: sizeLogo.height,
                ),
                Text(
                  "Sealpass",
                  style: styleTitle,
                ),
                Text(
                  "Unlock Using Your Fingerprint",
                  style: styleSubtitle,
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.fingerprint),
              iconSize: sizeIcon,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
              tooltip: "",
            ),
          ],
        ),
      ),
    );
  }
}
