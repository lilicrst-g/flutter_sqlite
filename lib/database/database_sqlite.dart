import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  Future<void> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQULITE_EXAMPLE');

    await openDatabase(
      databaseFinalPath,
      version: 1,
      // chamado só no momento de criação do bd, quando baixa o app
      onCreate: (Database db, int version) {
        final batch = db.batch();

        batch.execute('''
          create table teste(
            id Integer primary key autoincrement,
            nome varchar(200)
          )
        ''');
        batch.commit();
      },
      // chamado quando houver alteração no version incremental (1 -> 2)
      onUpgrade: (Database db, int oldVersion, int version) {},
      // chamado quando houver alteração no version decremental (2 -> 1)
      onDowngrade: (Database db, int oldVersion, int version) {},
    );
  }
}
