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

  Credential.now({
    this.name,
    this.address,
    this.username,
    this.password,
  }) : time = DateTime.now();
}
