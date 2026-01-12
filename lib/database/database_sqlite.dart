import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQULITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 2,
      onConfigure: (db) async {
        print('onConfigure sendo chamado');
        await db.execute('PRAGMA foreing_keys = ON');
      },
      // chamado só no momento de criação do bd, quando baixa o app
      onCreate: (Database db, int version) {
        final batch = db.batch();

        batch.execute('''
          create table teste(
            id Integer primary key autoincrement,
            nome varchar(200)
          )
        ''');

        batch.execute('''
          create table produto(
            id Integer primary key autoincrement,
            nome varchar(200)            
          )
        ''');

        // batch.execute('''
        //   create table categoria(
        //     id Integer primary key autoincrement,
        //     nome varchar(200)
        //   )
        // ''');

        batch.commit();
      },
      // chamado quando houver alteração no version incremental (1 -> 2)
      onUpgrade: (Database db, int oldVersion, int version) {
        print('onUpgrade chamado');
        final batch = db.batch();

        if (oldVersion == 1) {
          batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
          ''');
          // batch.execute('''
          //   create table categoria(
          //     id Integer primary key autoincrement,
          //     nome varchar(200)
          //   )
          // ''');
        }

        // if (oldVersion == 2) {
        //   batch.execute('''
        //     create table categoria(
        //       id Integer primary key autoincrement,
        //       nome varchar(200)
        //     )
        //   ''');
        // }

        batch.commit();
      },
      // chamado quando houver alteração no version decremental (2 -> 1)
      onDowngrade: (Database db, int oldVersion, int version) {
        print('onDowngrade chamado');
        final batch = db.batch();

        if (oldVersion == 3) {
          batch.execute('''
            drop table categoria;
          ''');
        }

        batch.commit();
      },
    );
  }
}
