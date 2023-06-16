import 'package:flutter/material.dart';
import 'package:graph_ql/data/network/services/graphql_services.dart';
import 'package:graph_ql/repository/models/books/books_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BookModel>? _books;
  GraphQLServices _graphQLServices = GraphQLServices();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    _books = null;
    _books = await _graphQLServices.getBooks(limit: 5);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: _books == null
              ? const Center(child: CircularProgressIndicator())
              : _books!.isEmpty
                  ? const Center(
                      child: Text('No books'),
                    )
                  : ListView.builder(
                      itemCount: _books!.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.book),
                        title: Text(
                            '${_books![index].title} by ${_books![index].author}'),
                        subtitle: Text('Released ${_books![index].year}'),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _graphQLServices.deleteBooks(
                                id: _books![index].id!);
                            _load();
                          },
                        ),
                      ),
                    ),
        ));
  }

  @override
  void didChangeDependencies() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    super.didChangeDependencies();
  }
}
