import 'package:flutter_test/flutter_test.dart';
import 'package:sealpass/models/account.dart';

void main() {
  group(
    "Account contains",
    () {
      test(
        "Text with the same casing is PRESENT in name, address or username",
        () {
          final account = Account.now(
            name: "Example",
            address: "https://www.example.com",
            username: "account@email.com",
            password: "P@s\$word",
          );

          expect(account.contains("Example"), true);

          expect(account.contains("example"), true);
          expect(account.contains("www.example.com"), true);

          expect(account.contains("account"), true);
          expect(account.contains("email"), true);
          expect(account.contains("account@email"), true);
          expect(account.contains("account@email.com"), true);
        },
      );

      test(
        "Text with different casing is NOT PRESENT in name, address or username",
        () {
          final account = Account.now(
            name: "Example",
            address: "https://www.example.com",
            username: "account@email.com",
            password: "P@s\$word",
          );

          expect(account.contains("EXAMPLE"), true);
          expect(account.contains("ExAmpLE"), true);

          expect(account.contains("ACCOUNT"), true);
          expect(account.contains("EmAiL"), true);
          expect(account.contains("ACCOUNT@emAiL"), true);
          expect(account.contains("ACCOUNT@emAiL.COM"), true);
        },
      );

      test(
        "Text with the same casing is NOT PRESENT in name, address or username",
        () {
          final account = Account.now(
            name: "Example",
            address: "https://www.example.com",
            username: "account@email.com",
            password: "P@s\$word",
          );

          expect(account.contains("Other"), false);

          expect(account.contains("other"), false);
          expect(account.contains("www.other.com"), false);

          expect(account.contains("user"), false);
          expect(account.contains("sample"), false);
          expect(account.contains("user@sample"), false);
          expect(account.contains("user@sample.com"), false);
        },
      );

      test(
        "Text with different casing is NOT PRESENT in name, address or username",
        () {
          final account = Account.now(
            name: "Example",
            address: "https://www.example.com",
            username: "account@email.com",
            password: "P@s\$word",
          );

          expect(account.contains("OtHEr"), false);
          expect(account.contains("wWW.OthER.cOm"), false);

          expect(account.contains("UsEr"), false);
          expect(account.contains("SAmPlE"), false);
          expect(account.contains("USer@sAmPLE"), false);
          expect(account.contains("uSSERR@EEMMAiLL.moc"), false);
        },
      );
    },
  );
}
