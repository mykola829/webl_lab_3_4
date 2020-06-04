import 'package:adityagurjar/validators.dart';
import 'package:test/test.dart';

void main() {
  test('too short or too long email returns error string', () {
    final result = Validators.emailValidator('12456');
    expect(result, 'Email must containt from 3 to 24 characters');
  });

  test('too short or too long password returns error string', () {
    final result = Validators.passwordValidator('');
    expect(result, 'Password must containt from 6 to 13 characters');
  });

  test('too short or too long name returns error string', () {
    final result = Validators.nameValidator('');
    expect(result, 'Name must containt from 1 to 50 characters');
  });

  test('too short or too long surname returns error string', () {
    final result = Validators.surnameValidator('');
    expect(result, 'Surname must containt from 1 to 50 characters');
  });

  test('email contains not allowed characters', () {
    final result = Validators.emailValidator('1235@|');
    expect(result, 'Incorrect email');
  });

  test('password contains not allowed characters', () {
    final result = Validators.passwordValidator('123456@|');
    expect(result, 'Incorrect password');
  });

  test('correct email', () {
    final result = Validators.emailValidator('mykola829@gmail.com');
    expect(result, null);
  });

  test('correct password', () {
    final result = Validators.passwordValidator('123456');
    expect(result, null);
  });

  test('correct name', () {
    final result = Validators.nameValidator('Mykola');
    expect(result, null);
  });

  test('correct surname', () {
    final result = Validators.surnameValidator('Romanyshyn');
    expect(result, null);
  });
}
