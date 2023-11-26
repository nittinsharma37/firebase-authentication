import 'package:flutter/material.dart';
import '../model/signinresult.dart';

void snackbarHandler(SignInResult result, ScaffoldMessengerState snackbar,
    String customMessage) {
  if (result.error != null) {
    snackbar.showSnackBar(SnackBar(content: Text('${result.error}')));
  } else {
    if (customMessage != '') {
      snackbar.showSnackBar(SnackBar(content: Text(customMessage)));
    }
  }
}
