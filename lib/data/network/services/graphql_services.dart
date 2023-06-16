import 'package:graph_ql/data/network/configs/graph_config.dart';
import 'package:graph_ql/repository/models/books/books_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLServices {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientTOQuery();

  // get books
  Future<List<BookModel>> getBooks({required int limit}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            query Query(\$limit: Int) {
              getBooks(limit: $limit) {
                _id
                author
                title
                year
              }
            }
""",
          ),
          variables: {
            "limit": limit,
          },
        ),
      );

      if (result.hasException) throw Exception(result.exception);

      List? res = result.data?['getBooks'];

      if (res == null || res.isEmpty) {
        return [];
      }

      List<BookModel> books =
          res.map((book) => BookModel.fromJson(book)).toList();
      return [];
    } catch (error) {
      throw Exception(error);
    }
  }

  //delete a book

  Future<bool> deleteBooks({required String id}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation Mutation(\$id: ID!){
              deleteBook(ID: \$id)
            }
""",
          ),
          variables: {
            "id": id,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  //create a book

  Future<bool> createBook({
    required String title,
    required String author,
    required int year,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation Mutation(\$id: ID!){
              createBook(bookInput: \$bookInput)
            }
""",
          ),
          variables: {
            "bookinput": {
              "author": author,
              "title": title,
              "year": year,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  //create a book

  Future<bool> updateBook({
    required String id,
    required String title,
    required String author,
    required int year,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation Mutation(\$id: ID!, \$bookInput: BookInput){
              updateBook(ID: \$id, bookInput: \$bookInput)
            }
""",
          ),
          variables: {
            "id": id,
            "bookinput": {
              "author": author,
              "title": title,
              "year": year,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (error) {
      return false;
    }
  }
}
