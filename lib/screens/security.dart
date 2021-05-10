import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import 'home.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final sizeLogo = SizeManager.logo(size);
    final sizeIcon = SizeManager.iconFinger(size);
    final padding = PaddingManager.security(size);

    final styleTitle = theme.textTheme.headline4;
    final styleSubtitle = theme.textTheme.subtitle1;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: padding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: .1,
                ),
              ),
              Column(
                children: <Widget>[
                  Semantics(
                    image: true,
                    label: "Logo",
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: sizeLogo.width,
                      height: sizeLogo.height,
                    ),
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
              Semantics(
                button: true,
                hint: "Directs to homepage",
                child: IconButton(
                  icon: Icon(Icons.fingerprint),
                  iconSize: sizeIcon,
                  tooltip: "Unlock using fingerprint",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
