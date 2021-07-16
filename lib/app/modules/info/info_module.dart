import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_graphql/app/modules/info/info_bloc.dart';
import 'package:simple_graphql/app/modules/info/info_page.dart';

class InfoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => InfoBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => InfoPage()),
  ];
}
