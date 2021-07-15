import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_graphql/app/shared/graphQLConf.dart';
import 'package:simple_graphql/app/shared/query_mutation.dart';

class RegisterBloc extends Disposable {
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BehaviorSubject<String> _navigateToNextPageBS = BehaviorSubject();
  BehaviorSubject<bool> _showLoadingBS = BehaviorSubject();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  @override
  void dispose() {
    _navigateToNextPageBS.close();
    _showLoadingBS.close();
  }

  Future<dynamic> doRegister() async {
    var resultado;
    _showLoadingBS.sink.add(true);
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(addMutation.register()),
          variables: {
            "input": {
              "firstName": textFirstNameController.text,
              "lastName": textLastNameController.text,
              "email": textEmailController.text,
              "password": textPasswordController.text
            }
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

      if (resultado['createUser']['id'] != '') {
        Fluttertoast.showToast(
            msg: 'Registrado com sucesso',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
      }

      _showLoadingBS.sink.add(false);
      return resultado;
    } catch (e) {
      _showLoadingBS.sink.add(false);
      print(e);
    }
  }

  BehaviorSubject<bool> get showLoadingOutput => _showLoadingBS;
}
