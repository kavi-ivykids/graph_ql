import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink =
      HttpLink('https://books-demo-apollo-server.herokuapp.com/');
  GraphQLClient clientTOQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}
