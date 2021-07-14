import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_graphql/app/modules/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset('assets/img.jpg'),
                Text(
                  'Simple GraphQl Login',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                    mainController: controller.textEmailController,
                    secondController: controller.textPasswordController,
                    isPassword: false,
                    hint: 'Email',
                    formKey: controller.formKey,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                    mainController: controller.textPasswordController,
                    secondController: controller.textEmailController,
                    isPassword: true,
                    hint: 'Senha',
                    formKey: controller.formKey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        icon: Icon(FeatherIcons.logIn),
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            var result = await controller.doLogin();
                            print(result['login']['token']);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
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
                        icon: Icon(FeatherIcons.checkCircle),
                        onPressed: () => Modular.to.pushNamed('/register'),
                      ),
                    ),
                  ],
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
  final TextEditingController secondController;
  final bool isPassword;
  final String hint;
  final GlobalKey<FormState> formKey;

  const BuildTextFormField({
    required this.mainController,
    required this.secondController,
    required this.isPassword,
    required this.hint,
    required this.formKey,
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
        prefixIcon: widget.isPassword
            ? Icon(Icons.lock_open, color: Colors.black)
            : Icon(Icons.mail, color: Colors.black),
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
        if (widget.mainController.text.trim().isEmpty &&
            widget.secondController.text.trim().isEmpty) {
          _errorDisplayed = true;
          _displayToast();
          return '';
        }

        if (widget.mainController.text.trim().isEmpty) {
          _errorDisplayed = true;
          widget.isPassword
              ? _displayToast(message: 'A senha não pode estar vazia')
              : _displayToast(message: 'O Usuário não pode estar vazio');
          return '';
        }

        if (widget.isPassword) {
          if (widget.mainController.text.length < 4) {
            _errorDisplayed = true;
            _displayToast(
                message: 'A senha não pode ser menor que 4 caracteres');
            return '';
          }
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
