import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_graphql/app/shared/graphQLConf.dart';
import 'package:simple_graphql/app/shared/query_mutation.dart';

class InfoBloc extends Disposable {
  BehaviorSubject<bool> _showLoadingBS = BehaviorSubject();
  BehaviorSubject<List<dynamic>> _usersBS = BehaviorSubject();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  @override
  void dispose() {
    _usersBS.close();
    _showLoadingBS.close();
  }

  Future<void> getUsers() async {
    late List<dynamic> resultado;
    _showLoadingBS.sink.add(true);
    try {
      final GraphQLClient _client = graphQLConfiguration.clientToQuery();
      final QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(addMutation.getUsers()),
          onCompleted: (dynamic resultData) {
            resultado = resultData['users'];
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
      _usersBS.sink.add(resultado);
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

  BehaviorSubject<List<dynamic>> get usersOutput => _usersBS;
}
