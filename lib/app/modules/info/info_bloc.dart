import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_graphql/app/shared/graphQLConf.dart';
import 'package:simple_graphql/app/shared/query_mutation.dart';
import 'package:simple_graphql/app/shared/user.dart';

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

  Future getUsers() async {
    var resultado;
    _showLoadingBS.sink.add(true);
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(addMutation.getUsers()),
          onCompleted: (dynamic resultData) {
            resultado = resultData['users'];
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
      _usersBS.sink.add(resultado);
      _showLoadingBS.sink.add(false);
    } catch (e) {
      _showLoadingBS.sink.add(false);
      print(e);
    }
  }

  BehaviorSubject<bool> get showLoadingOutput => _showLoadingBS;

  BehaviorSubject<List<dynamic>> get usersOutput => _usersBS;
}
