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

  BehaviorSubject<bool> _showLoadingBS = BehaviorSubject();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  @override
  void dispose() {
    _showLoadingBS.close();
  }

  Future<void> doRegister() async {
    late dynamic resultado;
    _showLoadingBS.sink.add(true);
    try {
      final GraphQLClient _client = graphQLConfiguration.clientToQuery();
      final QueryResult result = await _client.mutate(
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
        debugPrint(result.exception.toString());
      }

      if (result.isLoading) {
        debugPrint("Loading");
      }

      if (result.isNotLoading) {
        debugPrint("Not Loading");
      }

      if (result.isConcrete) {
        debugPrint("Sucesso");
      }

      if (resultado['insert_users_one']['id'] != '') {
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
    } catch (e) {
      _showLoadingBS.sink.add(false);
      Fluttertoast.showToast(
          msg: 'Erro em algum lugar',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  BehaviorSubject<bool> get showLoadingOutput => _showLoadingBS;
}
