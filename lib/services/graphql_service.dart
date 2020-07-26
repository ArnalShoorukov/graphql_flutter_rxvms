import 'package:flutter_graphql/models/welcome.dart';
import 'package:graphql/client.dart';
class GraphQLService {
  GraphQLClient _client;

  GraphQLService() {
    HttpLink link = HttpLink(uri: 'https://rickandmortyapi.com/graphql/');

    _client = GraphQLClient(link: link, cache: InMemoryCache());
  }

  Future<Characters> performQuery(String query,

      {Map<String, dynamic> variables}) async {
    QueryOptions options =
    QueryOptions(documentNode: gql(query), variables: variables);

    final result = await _client.query(options);

    Welcome  responseModel = Welcome.fromJson(result.data);
    return responseModel.data;
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
    MutationOptions(documentNode: gql(query), variables: variables);

    final result = await _client.mutate(options);

    return result;
  }
}