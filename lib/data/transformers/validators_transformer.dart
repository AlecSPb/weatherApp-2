import 'dart:async';

class Validators {
  final validateRequired =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError("Please enter a valid value.");
    } else {
      sink.add(value);
    }
  });
}
