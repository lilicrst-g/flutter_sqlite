import 'package:flutter/material.dart';
import 'package:flutter_sqlite_example/database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await DatabaseSqLite().openConnection();

    database.rawInsert('insert into teste values(null, ?)', ['Rita']);
    // database.rawUpdate('update teste set nome = ? where id = ?', ['Lis', 1]);
    // database.rawDelete('delete from teste where id = ?', [3]);
    // var result = await database.rawQuery('select * from teste');
    // print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Container(),
    );
  }
}
