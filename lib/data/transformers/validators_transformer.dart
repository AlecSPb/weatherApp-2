import 'dart:async';

class Validators {
  final validateRequired =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError("Bitte dieses Feld ausfüllen.");
    } else {
      sink.add(value);
    }
  });
}
