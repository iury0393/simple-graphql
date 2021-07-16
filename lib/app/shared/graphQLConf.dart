import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static const _hasuraSecret =
      'epIv4TiVwq87oGJW5q7KfCm77QlL620heg4VMikGAu2tWK6RSQtWJL5Rgmu0FJqd';
  static HttpLink link = HttpLink(
      "https://simple-api-crud.hasura.app/v1/graphql",
      defaultHeaders: {
        'Content-Type': 'application/json',
        'x-hasura-admin-secret': _hasuraSecret
      });

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }
}
