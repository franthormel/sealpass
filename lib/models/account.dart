import 'package:intl/intl.dart';

class Account {
  final String name;
  final String address;

  final String username;
  final String password;

  final DateTime time;

  const Account({
    required this.name,
    required this.address,
    required this.username,
    required this.password,
    required this.time,
  });

  Account.now({
    required this.name,
    required this.address,
    required this.username,
    required this.password,
  }) : time = DateTime.now();

  /// Returns [true] if either [name], [address] or [username] property contains [text]
  bool contains(String text) {
    final search = text.toLowerCase();

    final nameHasText = name.toLowerCase().contains(search);
    final addressHasText = address.toLowerCase().contains(search);
    final usernameHasText = username.toLowerCase().contains(search);

    final hasText = nameHasText || addressHasText || usernameHasText;

    return hasText;
  }

  /// Returns formatted [DateTime] as 'M d, YYYY H:MM'
  ///
  ///* January 1, 2001 01:10
  ///* February 2, 2002 02:20
  ///* March 3, 2003 03:30
  get timeFormatted => DateFormat.yMMMMd().add_Hm().format(time);
}
