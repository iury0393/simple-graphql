import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_graphql/app/shared/graphQLConf.dart';
import 'package:simple_graphql/app/shared/query_mutation.dart';

class RegisterBloc extends Disposable {
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  @override
  void dispose() {}

  Future<dynamic> doRegister() async {
    var resultado;
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addMutation.register()),
        variables: {
          "firstName": textFirstNameController.text,
          "lastName": textLastNameController.text,
          "email": textEmailController.text,
          "password": textPasswordController.text,
        },
        onCompleted: (dynamic resultData) {
          resultado = resultData;
        },
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    }

    if (result.isLoading) {
      print('Loading');
    }

    if (result.isNotLoading) {
      print('Not Loading');
    }

    if (result.isConcrete) {
      print('Sucesso');
    }

    return resultado;
  }
}
