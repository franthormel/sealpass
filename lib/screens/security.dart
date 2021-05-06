import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';

class SecurityScreen extends StatelessWidget {
  static const logo = "assets/images/logo.png";
  static const title = "Sealpass";
  static const subtitle = "Unlock Using Your Fingerprint";

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
                  logo,
                  width: sizeLogo.width,
                  height: sizeLogo.height,
                ),
                Text(
                  title,
                  style: styleTitle,
                ),
                Text(
                  subtitle,
                  style: styleSubtitle,
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.fingerprint),
              iconSize: sizeIcon,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
