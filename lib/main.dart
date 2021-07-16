import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/shared/graphQLConf.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() async {
  await initHiveForFlutter();
  runApp(
    GraphQLProvider(
      client: graphQLConfiguration.client,
      child: CacheProvider(
        child: ModularApp(
          module: AppModule(),
          child: AppWidget(),
        ),
      ),
    ),
  );
}
