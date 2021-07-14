import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginBloc extends Disposable {
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {}
}
