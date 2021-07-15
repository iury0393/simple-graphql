import 'package:flutter_modular/flutter_modular.dart';

import 'modules/info/info_module.dart';
import 'modules/login/login_module.dart';
import 'modules/register/register_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
    ModuleRoute('/info', module: InfoModule()),
  ];
}
