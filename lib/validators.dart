class Validators {
  static String emailValidator(String value) {
    Pattern pattern =
        r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$';

    RegExp regex = new RegExp(pattern);
    if (value.length < 3 || value.length > 24) {
      return 'Email must containt from 3 to 24 characters';
    } else if (!regex.hasMatch(value)) {
      return 'Incorrect email';
    } else {
      return null;
    }
  }

  static String passwordValidator(String value) {
    Pattern pattern = r'^[a-zA-Z0-9_.]*$';
    RegExp regex = new RegExp(pattern);
    if (value.length < 6 || value.length > 13) {
      return 'Password must containt from 6 to 13 characters';
    } else if (!regex.hasMatch(value)) {
      return 'Incorrect password';
    } else {
      return null;
    }
  }

  static String nameValidator(String value) {
    if (value.length < 1 || value.length > 50) {
      return 'Name must containt from 1 to 50 characters';
    } else {
      return null;
    }
  }

  static String surnameValidator(String value) {
    if (value.length < 1 || value.length > 50) {
      return 'Surname must containt from 1 to 50 characters';
    } else {
      return null;
    }
  }
}
