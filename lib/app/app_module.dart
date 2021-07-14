import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_graphql/app/modules/register/register_module.dart';

import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
  ];
}
