import 'dart:async';

mixin Validators {

  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phoneNumber, sink) {
    if (phoneNumber.length >= 8) {
      sink.add(phoneNumber);
    } else {
      sink.addError('Enter a Valid Phone Number');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length >= 3) {
      sink.add(name);
    } else {
      sink.addError('Enter a Valid Name');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError('Enter a Valid Password');
    }
  });

  final authCheck =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (auth, sink) {
    if (auth == true) {
      sink.add(true);
    } else {
      sink.add(false);
      sink.addError('Must be Authenticated');
    }
  });
}
