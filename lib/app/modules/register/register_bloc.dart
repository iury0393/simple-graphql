import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterBloc extends Disposable {
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {}
}
