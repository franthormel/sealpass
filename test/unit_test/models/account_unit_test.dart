import 'package:test/test.dart';
import 'package:sealpass/models/account.dart';

void main() {
  final account = Account.now(
    name: "Example",
    address: "https://www.example.com",
    username: "account@email.com",
    password: "P@s\$word",
  );

  group(
    "Account",
    () {
      test(
        "contains returns true when expected",
        () {
          const strings = [
            "Example",
            "example",
            "www.example.com",
            "account",
            "email",
            "account@email",
            "account@email.com",
            "EXAMPLE",
            "ExAmpLE",
            "ACCOUNT",
            "EmAiL",
            "ACCOUNT@emAiL",
            "ACCOUNT@emAiL.COM",
          ];

          for (final text in strings) {
            final result = account.contains(text);
            const expected = true;

            expect(result, expected);
          }
        },
      );

      test(
        "contains returns false when expected",
        () {
          const strings = [
            "Other",
            "other",
            "www.other.com",
            "user",
            "sample",
            "user@sample",
            "user@sample.com",
            "OtHEr",
            "wWW.OthER.cOm",
            "UsEr",
            "SAmPlE",
            "USer@sAmPLE",
            "uSSERR@EEMMAiLL.moc",
          ];

          for (final text in strings) {
            final result = account.contains(text);
            const expected = false;

            expect(result, expected);
          }
        },
      );
    },
  );
}
