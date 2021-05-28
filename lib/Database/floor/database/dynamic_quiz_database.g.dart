// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_quiz_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorDynamicQuizDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DynamicQuizDatabaseBuilder databaseBuilder(String name) =>
      _$DynamicQuizDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DynamicQuizDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$DynamicQuizDatabaseBuilder(null);
}

class _$DynamicQuizDatabaseBuilder {
  _$DynamicQuizDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$DynamicQuizDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DynamicQuizDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DynamicQuizDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$DynamicQuizDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DynamicQuizDatabase extends DynamicQuizDatabase {
  _$DynamicQuizDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DynamicQuizDao _dynamicQuizDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuizData` (`id` INTEGER, `question` TEXT, `option1` TEXT, `option2` TEXT, `option3` TEXT, `option4` TEXT, `answer` TEXT, `type` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DynamicQuizDao get dynamicQuizDao {
    return _dynamicQuizDaoInstance ??=
        _$DynamicQuizDao(database, changeListener);
  }
}

class _$DynamicQuizDao extends DynamicQuizDao {
  _$DynamicQuizDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<QuizData>> getAllData() {
    return _queryAdapter.queryListStream('SELECT * from DynamicQuiz',
        queryableName: 'QuizData',
        isView: false,
        mapper: (Map<String, dynamic> row) => QuizData(
            id: row['id'] as int,
            question: row['question'] as String,
            option1: row['option1'] as String,
            option2: row['option2'] as String,
            option3: row['option3'] as String,
            option4: row['option4'] as String,
            answer: row['answer'] as String,
            type: row['type'] as String));
  }
}
