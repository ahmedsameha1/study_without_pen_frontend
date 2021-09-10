import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/user_account.dart';

main() {
  group("id tests", () {
   test("id isn't empty", () {
    expect(() => UserAccount(""), throwsArgumentError);
   });
   test("id doesn't contain any whitespace characters", () {
     expect(() => UserAccount(" "), throwsArgumentError);
     expect(() => UserAccount("\t"), throwsArgumentError);
     expect(() => UserAccount("\n"), throwsArgumentError);
     expect(() => UserAccount("f\t"), throwsArgumentError);
     expect(() => UserAccount("f "), throwsArgumentError);
     expect(() => UserAccount("\nf "), throwsArgumentError);
     expect(() => UserAccount("\tf"), throwsArgumentError);
     expect(() => UserAccount("f\tf"), throwsArgumentError);
     expect(() => UserAccount("f"), returnsNormally);
   });
  });
}