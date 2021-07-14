import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_graphql/app/modules/login/login_bloc.dart';

import 'login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
  ];
}
