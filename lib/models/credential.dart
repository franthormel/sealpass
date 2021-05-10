import 'package:intl/intl.dart';

class Credential {
  final String name;
  final String address;

  final String username;
  final String password;

  final DateTime time;

  const Credential({
    this.name,
    this.address,
    this.username,
    this.password,
    this.time,
  });

  ///Create an instance of [Credential] wherein the [time] property
  ///
  /// is set to [DateTime.now()]
  Credential.now({
    this.name,
    this.address,
    this.username,
    this.password,
  }) : time = DateTime.now();

  ///Returns [true] if either [name] or [username] property contains
  ///
  /// the [String] parameter
  bool searchContains(String text) {
    //Make sure to normalize all strings involved by either
    //using toLowerCase() or toUpperCase()
    final search = text.toLowerCase();
    return name.toLowerCase().contains(search) ||
        username.toLowerCase().contains(search);
  }

  ///Returns formatted [DateTime] as 'M d, YYYY'
  ///
  /// Example:
  ///
  ///* January 1, 2001 01:10
  ///* February 2, 2002 02:20
  ///* March 3, 2003 03:30
  String timeFormat() {
    return DateFormat.yMMMMd().add_Hm().format(time);
  }
}
