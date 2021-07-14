import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_graphql/app/modules/register/register_bloc.dart';
import 'package:simple_graphql/app/modules/register/register_page.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => RegisterPage()),
  ];
}
