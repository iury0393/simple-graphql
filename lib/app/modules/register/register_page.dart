import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_graphql/app/modules/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ModularState<RegisterPage, RegisterBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: Icon(Icons.arrow_back, size: 25),
                  ),
                ),
                Image.asset('assets/img3.jpg'),
                Text(
                  'Simple GraphQl Register',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                    mainController: controller.textFirstNameController,
                    isPassword: false,
                    hint: 'Nome',
                    formKey: controller.formKey,
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                    mainController: controller.textLastNameController,
                    isPassword: false,
                    hint: 'Sobrenome',
                    formKey: controller.formKey,
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                    mainController: controller.textEmailController,
                    isPassword: false,
                    hint: 'Email',
                    formKey: controller.formKey,
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                    mainController: controller.textPasswordController,
                    isPassword: true,
                    hint: 'Senha',
                    formKey: controller.formKey,
                    prefixIcon: Icon(Icons.lock_open, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 42.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: IconButton(
                    icon: Icon(FeatherIcons.check),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        var result = await controller.doRegister();
                        print(result);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildTextFormField extends StatefulWidget {
  final TextEditingController mainController;
  final bool isPassword;
  final String hint;
  final GlobalKey<FormState> formKey;
  final Icon prefixIcon;

  const BuildTextFormField({
    required this.mainController,
    required this.isPassword,
    required this.hint,
    required this.formKey,
    required this.prefixIcon,
  });
  @override
  _BuildTextFormFieldState createState() => _BuildTextFormFieldState();
}

class _BuildTextFormFieldState extends State<BuildTextFormField> {
  bool _errorDisplayed = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      controller: widget.mainController,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                })
            : null,
      ),
      onFieldSubmitted: (text) {
        if (_errorDisplayed) {
          widget.formKey.currentState?.validate();
        }
      },
      validator: (text) {
        if (widget.mainController.text.trim().isEmpty) {
          _errorDisplayed = true;
          _displayToast();
          return '';
        }

        _errorDisplayed = false;
        return null;
      },
    );
  }

  _displayToast({String message = 'O campos não podem estar vazios'}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
