// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorQuizDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$QuizDatabaseBuilder databaseBuilder(String name) =>
      _$QuizDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$QuizDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$QuizDatabaseBuilder(null);
}

class _$QuizDatabaseBuilder {
  _$QuizDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$QuizDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$QuizDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<QuizDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$QuizDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$QuizDatabase extends QuizDatabase {
  _$QuizDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  QuizDao _quizDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `QuizQuestion` (`id` INTEGER, `question` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuizQuestionOption` (`id` INTEGER, `option1` TEXT, `option2` TEXT, `option3` TEXT, `option4` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuizAnswer` (`id` INTEGER, `answer` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuizDetails` (`id` INTEGER, `question` TEXT, `option1` TEXT, `option2` TEXT, `option3` TEXT, `option4` TEXT, `answer` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  QuizDao get quizDao {
    return _quizDaoInstance ??= _$QuizDao(database, changeListener);
  }
}

class _$QuizDao extends QuizDao {
  _$QuizDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<QuizQuestion>> getAllQuestion() {
    return _queryAdapter.queryListStream('SELECT * from QuizQuestion',
        queryableName: 'QuizQuestion',
        isView: false,
        mapper: (Map<String, dynamic> row) => QuizQuestion(
            id: row['id'] as int, question: row['question'] as String));
  }

  @override
  Stream<List<QuizDetails>> getAllData() {
    return _queryAdapter.queryListStream(
        'SELECT QuizQuestion.question, QuizQuestionOption.option1,QuizQuestionOption.option2,QuizQuestionOption.option3,QuizQuestionOption.option4,QuizAnswer.answer FROM QuizQuestion INNER JOIN QuizQuestionOption ON QuizQuestion.id = QuizQuestionOption.id INNER JOIN QuizAnswer ON QuizQuestion.id = QuizAnswer.id',
        queryableName: 'QuizDetails',
        isView: false,
        mapper: (Map<String, dynamic> row) => QuizDetails(
            id: row['id'] as int,
            question: row['question'] as String,
            option1: row['option1'] as String,
            option2: row['option2'] as String,
            option3: row['option3'] as String,
            option4: row['option4'] as String,
            answer: row['answer'] as String));
  }
}
