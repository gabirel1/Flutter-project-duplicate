import 'package:email_validator/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/Tools/utils.dart';

void main() {
  test('MyPlatform test', () {
    expect(MyPlatform.isAndroid(), false);
    expect(MyPlatform.isIOS(), false);
    expect(MyPlatform.isWeb(), false);
    expect(MyPlatform.getPlatform(), 'Unknown');
  });
  test('MyUtils test', () {
    expect(
      MyUtils.checkFormValidity('email@domain.com', 'password', 'password'),
      true,
    );
    expect(MyUtils.checkFormValidity('', 'password', 'password'), false);
    expect(MyUtils.checkFormValidity('email', '', 'password'), false);
    expect(MyUtils.checkFormValidity('email', 'password', ''), false);
    expect(MyUtils.checkFormValidity('', '', ''), false);
  });
  test('MyEmailValidator test', () {
    expect(EmailValidator.validate('email'), false);
    expect(EmailValidator.validate('email@'), false);
    expect(EmailValidator.validate('email@domain'), false);
    expect(EmailValidator.validate('email@domain.'), false);
    expect(EmailValidator.validate('email@domain.com'), true);
  });
}
