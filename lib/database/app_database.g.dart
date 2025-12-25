// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FieldsTable extends Fields with TableInfo<$FieldsTable, Field> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _userAccountIdMeta = const VerificationMeta(
    'userAccountId',
  );
  @override
  late final GeneratedColumn<String> userAccountId = GeneratedColumn<String>(
    'user_account_id',
    aliasedName,
    false,
    check: () => ComparableExpr(
      StringExpressionOperators(userAccountId).trim().length,
    ).isBiggerOrEqualValue(Fields.MINIMUM_LENGTH_OF_USER_ACCOUNT_ID),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          StringExpressionOperators(name).trim().length,
        ).isBiggerOrEqualValue(Fields.MINIMUM_LENGTH_OF_NAME) &
        ComparableExpr(
          name.length,
        ).isSmallerOrEqualValue(Fields.MAXIMUM_LENGTH_OF_NAME),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>(
        'last_modification_at',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(lastModificationAt).isBiggerOrEqual(creationAt),
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          usageCount,
        ).isBiggerOrEqualValue(Fields.MINIMUM_USAGE_COUNT) &
        ComparableExpr(
          usageCount,
        ).isSmallerOrEqualValue(Fields.MAXIMUM_USAGE_COUNT),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(Fields.DEFAULT_USAGE_COUNT),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(color).isBiggerOrEqualValue(Fields.MINIMUM_COLOR) &
        ComparableExpr(color).isSmallerOrEqualValue(Fields.MAXIMUM_COLOR),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(Fields.DEFAULT_COLOR),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userAccountId,
    name,
    creationAt,
    lastModificationAt,
    usageCount,
    color,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fields';
  @override
  VerificationContext validateIntegrity(
    Insertable<Field> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_account_id')) {
      context.handle(
        _userAccountIdMeta,
        userAccountId.isAcceptableOrUnknown(
          data['user_account_id']!,
          _userAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userAccountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
        _lastModificationAtMeta,
        lastModificationAt.isAcceptableOrUnknown(
          data['last_modification_at']!,
          _lastModificationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userAccountId, name},
  ];
  @override
  Field map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Field(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_account_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
      lastModificationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modification_at'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
    );
  }

  @override
  $FieldsTable createAlias(String alias) {
    return $FieldsTable(attachedDatabase, alias);
  }
}

class Field extends DataClass implements Insertable<Field> {
  final String id;
  final String userAccountId;
  final String name;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  final int usageCount;
  final int color;
  const Field({
    required this.id,
    required this.userAccountId,
    required this.name,
    required this.creationAt,
    required this.lastModificationAt,
    required this.usageCount,
    required this.color,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_account_id'] = Variable<String>(userAccountId);
    map['name'] = Variable<String>(name);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    map['usage_count'] = Variable<int>(usageCount);
    map['color'] = Variable<int>(color);
    return map;
  }

  FieldsCompanion toCompanion(bool nullToAbsent) {
    return FieldsCompanion(
      id: Value(id),
      userAccountId: Value(userAccountId),
      name: Value(name),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
      usageCount: Value(usageCount),
      color: Value(color),
    );
  }

  factory Field.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Field(
      id: serializer.fromJson<String>(json['id']),
      userAccountId: serializer.fromJson<String>(json['userAccountId']),
      name: serializer.fromJson<String>(json['name']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt: serializer.fromJson<DateTime>(
        json['lastModificationAt'],
      ),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userAccountId': serializer.toJson<String>(userAccountId),
      'name': serializer.toJson<String>(name),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
      'usageCount': serializer.toJson<int>(usageCount),
      'color': serializer.toJson<int>(color),
    };
  }

  Field copyWith({
    String? id,
    String? userAccountId,
    String? name,
    DateTime? creationAt,
    DateTime? lastModificationAt,
    int? usageCount,
    int? color,
  }) => Field(
    id: id ?? this.id,
    userAccountId: userAccountId ?? this.userAccountId,
    name: name ?? this.name,
    creationAt: creationAt ?? this.creationAt,
    lastModificationAt: lastModificationAt ?? this.lastModificationAt,
    usageCount: usageCount ?? this.usageCount,
    color: color ?? this.color,
  );
  Field copyWithCompanion(FieldsCompanion data) {
    return Field(
      id: data.id.present ? data.id.value : this.id,
      userAccountId: data.userAccountId.present
          ? data.userAccountId.value
          : this.userAccountId,
      name: data.name.present ? data.name.value : this.name,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
      lastModificationAt: data.lastModificationAt.present
          ? data.lastModificationAt.value
          : this.lastModificationAt,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Field(')
          ..write('id: $id, ')
          ..write('userAccountId: $userAccountId, ')
          ..write('name: $name, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('usageCount: $usageCount, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userAccountId,
    name,
    creationAt,
    lastModificationAt,
    usageCount,
    color,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Field &&
          other.id == this.id &&
          other.userAccountId == this.userAccountId &&
          other.name == this.name &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt &&
          other.usageCount == this.usageCount &&
          other.color == this.color);
}

class FieldsCompanion extends UpdateCompanion<Field> {
  final Value<String> id;
  final Value<String> userAccountId;
  final Value<String> name;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> usageCount;
  final Value<int> color;
  final Value<int> rowid;
  const FieldsCompanion({
    this.id = const Value.absent(),
    this.userAccountId = const Value.absent(),
    this.name = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FieldsCompanion.insert({
    this.id = const Value.absent(),
    required String userAccountId,
    required String name,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.usageCount = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userAccountId = Value(userAccountId),
       name = Value(name),
       creationAt = Value(creationAt),
       lastModificationAt = Value(lastModificationAt);
  static Insertable<Field> custom({
    Expression<String>? id,
    Expression<String>? userAccountId,
    Expression<String>? name,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? usageCount,
    Expression<int>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userAccountId != null) 'user_account_id': userAccountId,
      if (name != null) 'name': name,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (usageCount != null) 'usage_count': usageCount,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FieldsCompanion copyWith({
    Value<String>? id,
    Value<String>? userAccountId,
    Value<String>? name,
    Value<DateTime>? creationAt,
    Value<DateTime>? lastModificationAt,
    Value<int>? usageCount,
    Value<int>? color,
    Value<int>? rowid,
  }) {
    return FieldsCompanion(
      id: id ?? this.id,
      userAccountId: userAccountId ?? this.userAccountId,
      name: name ?? this.name,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      usageCount: usageCount ?? this.usageCount,
      color: color ?? this.color,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userAccountId.present) {
      map['user_account_id'] = Variable<String>(userAccountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] = Variable<DateTime>(
        lastModificationAt.value,
      );
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldsCompanion(')
          ..write('id: $id, ')
          ..write('userAccountId: $userAccountId, ')
          ..write('name: $name, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('usageCount: $usageCount, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FieldListsTable extends FieldLists
    with TableInfo<$FieldListsTable, FieldList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _fieldIdMeta = const VerificationMeta(
    'fieldId',
  );
  @override
  late final GeneratedColumn<String> fieldId = GeneratedColumn<String>(
    'field_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fields (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          StringExpressionOperators(name).trim().length,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_LENGTH_OF_NAME) &
        ComparableExpr(
          name.length,
        ).isSmallerOrEqualValue(FieldLists.MAXIMUM_LENGTH_OF_NAME),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>(
        'last_modification_at',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(lastModificationAt).isBiggerOrEqual(creationAt),
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _languageTagMeta = const VerificationMeta(
    'languageTag',
  );
  @override
  late final GeneratedColumn<String> languageTag = GeneratedColumn<String>(
    'language_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkTypeMeta = const VerificationMeta(
    'checkType',
  );
  @override
  late final GeneratedColumn<int> checkType = GeneratedColumn<int>(
    'check_type',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(checkType).isBiggerOrEqualValue(0) &
        ComparableExpr(
          checkType,
        ).isSmallerOrEqualValue(CheckType.DO_NOT_IGNORE_CASE.index),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(CheckType.NON_STRICT_IGNORE_CASE.index),
  );
  static const VerificationMeta _sortByMeta = const VerificationMeta('sortBy');
  @override
  late final GeneratedColumn<int> sortBy = GeneratedColumn<int>(
    'sort_by',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(sortBy).isBiggerOrEqualValue(0) &
        ComparableExpr(sortBy).isSmallerThanValue(SortBy.MAX.index),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(SortBy.CREATION_DATE_DESC.index),
  );
  static const VerificationMeta _doesReadAnswerMeta = const VerificationMeta(
    'doesReadAnswer',
  );
  @override
  late final GeneratedColumn<bool> doesReadAnswer = GeneratedColumn<bool>(
    'does_read_answer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("does_read_answer" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          usageCount,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_USAGE_COUNT) &
        ComparableExpr(
          usageCount,
        ).isSmallerOrEqualValue(FieldLists.MAXIMUM_USAGE_COUNT),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(color).isBiggerOrEqualValue(FieldLists.MINIMUM_COLOR) &
        ComparableExpr(color).isSmallerOrEqualValue(FieldLists.MAXIMUM_COLOR),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(FieldLists.MAXIMUM_COLOR),
  );
  static const VerificationMeta _emulationNumberOfQuestionsMeta =
      const VerificationMeta('emulationNumberOfQuestions');
  @override
  late final GeneratedColumn<int> emulationNumberOfQuestions =
      GeneratedColumn<int>(
        'emulation_number_of_questions',
        aliasedName,
        true,
        check: () =>
            ComparableExpr(emulationNumberOfQuestions).isBiggerOrEqualValue(
              FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS,
            ) &
            ComparableExpr(emulationNumberOfQuestions).isSmallerOrEqualValue(
              FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS,
            ),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _emulationDaysMeta = const VerificationMeta(
    'emulationDays',
  );
  @override
  late final GeneratedColumn<String> emulationDays = GeneratedColumn<String>(
    'emulation_days',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _testsReadingQuestionLetterDurationMeta =
      const VerificationMeta('testsReadingQuestionLetterDuration');
  @override
  late final GeneratedColumn<int> testsReadingQuestionLetterDuration =
      GeneratedColumn<int>(
        'tests_reading_question_letter_duration',
        aliasedName,
        true,
        check: () => ComparableExpr(
          testsReadingQuestionLetterDuration,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _testsFindingAnswerDurationMeta =
      const VerificationMeta('testsFindingAnswerDuration');
  @override
  late final GeneratedColumn<int> testsFindingAnswerDuration =
      GeneratedColumn<int>(
        'tests_finding_answer_duration',
        aliasedName,
        true,
        check: () => ComparableExpr(
          testsFindingAnswerDuration,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _testsTypingAnswerLetterDurationMeta =
      const VerificationMeta('testsTypingAnswerLetterDuration');
  @override
  late final GeneratedColumn<int> testsTypingAnswerLetterDuration =
      GeneratedColumn<int>(
        'tests_typing_answer_letter_duration',
        aliasedName,
        true,
        check: () => ComparableExpr(
          testsTypingAnswerLetterDuration,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta
  _studyTillCorrectReadingQuestionLetterDurationMeta = const VerificationMeta(
    'studyTillCorrectReadingQuestionLetterDuration',
  );
  @override
  late final GeneratedColumn<int>
  studyTillCorrectReadingQuestionLetterDuration = GeneratedColumn<int>(
    'study_till_correct_reading_question_letter_duration',
    aliasedName,
    true,
    check: () => ComparableExpr(
      studyTillCorrectReadingQuestionLetterDuration,
    ).isBiggerOrEqualValue(FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studyTillCorrectFindingAnswerDurationMeta =
      const VerificationMeta('studyTillCorrectFindingAnswerDuration');
  @override
  late final GeneratedColumn<int> studyTillCorrectFindingAnswerDuration =
      GeneratedColumn<int>(
        'study_till_correct_finding_answer_duration',
        aliasedName,
        true,
        check: () => ComparableExpr(
          studyTillCorrectFindingAnswerDuration,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta
  _studyTillCorrectTypingAnswerLetterDurationMeta = const VerificationMeta(
    'studyTillCorrectTypingAnswerLetterDuration',
  );
  @override
  late final GeneratedColumn<int> studyTillCorrectTypingAnswerLetterDuration =
      GeneratedColumn<int>(
        'study_till_correct_typing_answer_letter_duration',
        aliasedName,
        true,
        check: () => ComparableExpr(
          studyTillCorrectTypingAnswerLetterDuration,
        ).isBiggerOrEqualValue(FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _testsTimeOfAnswerActionMeta =
      const VerificationMeta('testsTimeOfAnswerAction');
  @override
  late final GeneratedColumn<int> testsTimeOfAnswerAction =
      GeneratedColumn<int>(
        'tests_time_of_answer_action',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(testsTimeOfAnswerAction).isBiggerOrEqualValue(0) &
            ComparableExpr(
              testsTimeOfAnswerAction,
            ).isSmallerThanValue(TimeOfAnswerAction.MAX.index),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(TimeOfAnswerAction.NOTIFY.index),
      );
  static const VerificationMeta _doesObfuscateQuestionMeta =
      const VerificationMeta('doesObfuscateQuestion');
  @override
  late final GeneratedColumn<bool> doesObfuscateQuestion =
      GeneratedColumn<bool>(
        'does_obfuscate_question',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("does_obfuscate_question" IN (0, 1))',
        ),
        defaultValue: Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldId,
    name,
    creationAt,
    lastModificationAt,
    languageTag,
    checkType,
    sortBy,
    doesReadAnswer,
    usageCount,
    color,
    emulationNumberOfQuestions,
    emulationDays,
    testsReadingQuestionLetterDuration,
    testsFindingAnswerDuration,
    testsTypingAnswerLetterDuration,
    studyTillCorrectReadingQuestionLetterDuration,
    studyTillCorrectFindingAnswerDuration,
    studyTillCorrectTypingAnswerLetterDuration,
    testsTimeOfAnswerAction,
    doesObfuscateQuestion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_lists';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldList> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_id')) {
      context.handle(
        _fieldIdMeta,
        fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
        _lastModificationAtMeta,
        lastModificationAt.isAcceptableOrUnknown(
          data['last_modification_at']!,
          _lastModificationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    if (data.containsKey('language_tag')) {
      context.handle(
        _languageTagMeta,
        languageTag.isAcceptableOrUnknown(
          data['language_tag']!,
          _languageTagMeta,
        ),
      );
    }
    if (data.containsKey('check_type')) {
      context.handle(
        _checkTypeMeta,
        checkType.isAcceptableOrUnknown(data['check_type']!, _checkTypeMeta),
      );
    }
    if (data.containsKey('sort_by')) {
      context.handle(
        _sortByMeta,
        sortBy.isAcceptableOrUnknown(data['sort_by']!, _sortByMeta),
      );
    }
    if (data.containsKey('does_read_answer')) {
      context.handle(
        _doesReadAnswerMeta,
        doesReadAnswer.isAcceptableOrUnknown(
          data['does_read_answer']!,
          _doesReadAnswerMeta,
        ),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('emulation_number_of_questions')) {
      context.handle(
        _emulationNumberOfQuestionsMeta,
        emulationNumberOfQuestions.isAcceptableOrUnknown(
          data['emulation_number_of_questions']!,
          _emulationNumberOfQuestionsMeta,
        ),
      );
    }
    if (data.containsKey('emulation_days')) {
      context.handle(
        _emulationDaysMeta,
        emulationDays.isAcceptableOrUnknown(
          data['emulation_days']!,
          _emulationDaysMeta,
        ),
      );
    }
    if (data.containsKey('tests_reading_question_letter_duration')) {
      context.handle(
        _testsReadingQuestionLetterDurationMeta,
        testsReadingQuestionLetterDuration.isAcceptableOrUnknown(
          data['tests_reading_question_letter_duration']!,
          _testsReadingQuestionLetterDurationMeta,
        ),
      );
    }
    if (data.containsKey('tests_finding_answer_duration')) {
      context.handle(
        _testsFindingAnswerDurationMeta,
        testsFindingAnswerDuration.isAcceptableOrUnknown(
          data['tests_finding_answer_duration']!,
          _testsFindingAnswerDurationMeta,
        ),
      );
    }
    if (data.containsKey('tests_typing_answer_letter_duration')) {
      context.handle(
        _testsTypingAnswerLetterDurationMeta,
        testsTypingAnswerLetterDuration.isAcceptableOrUnknown(
          data['tests_typing_answer_letter_duration']!,
          _testsTypingAnswerLetterDurationMeta,
        ),
      );
    }
    if (data.containsKey(
      'study_till_correct_reading_question_letter_duration',
    )) {
      context.handle(
        _studyTillCorrectReadingQuestionLetterDurationMeta,
        studyTillCorrectReadingQuestionLetterDuration.isAcceptableOrUnknown(
          data['study_till_correct_reading_question_letter_duration']!,
          _studyTillCorrectReadingQuestionLetterDurationMeta,
        ),
      );
    }
    if (data.containsKey('study_till_correct_finding_answer_duration')) {
      context.handle(
        _studyTillCorrectFindingAnswerDurationMeta,
        studyTillCorrectFindingAnswerDuration.isAcceptableOrUnknown(
          data['study_till_correct_finding_answer_duration']!,
          _studyTillCorrectFindingAnswerDurationMeta,
        ),
      );
    }
    if (data.containsKey('study_till_correct_typing_answer_letter_duration')) {
      context.handle(
        _studyTillCorrectTypingAnswerLetterDurationMeta,
        studyTillCorrectTypingAnswerLetterDuration.isAcceptableOrUnknown(
          data['study_till_correct_typing_answer_letter_duration']!,
          _studyTillCorrectTypingAnswerLetterDurationMeta,
        ),
      );
    }
    if (data.containsKey('tests_time_of_answer_action')) {
      context.handle(
        _testsTimeOfAnswerActionMeta,
        testsTimeOfAnswerAction.isAcceptableOrUnknown(
          data['tests_time_of_answer_action']!,
          _testsTimeOfAnswerActionMeta,
        ),
      );
    }
    if (data.containsKey('does_obfuscate_question')) {
      context.handle(
        _doesObfuscateQuestionMeta,
        doesObfuscateQuestion.isAcceptableOrUnknown(
          data['does_obfuscate_question']!,
          _doesObfuscateQuestionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {fieldId, name},
  ];
  @override
  FieldList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldList(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
      lastModificationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modification_at'],
      )!,
      languageTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_tag'],
      ),
      checkType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_type'],
      )!,
      sortBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_by'],
      )!,
      doesReadAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}does_read_answer'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      emulationNumberOfQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}emulation_number_of_questions'],
      ),
      emulationDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emulation_days'],
      ),
      testsReadingQuestionLetterDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tests_reading_question_letter_duration'],
      ),
      testsFindingAnswerDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tests_finding_answer_duration'],
      ),
      testsTypingAnswerLetterDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tests_typing_answer_letter_duration'],
      ),
      studyTillCorrectReadingQuestionLetterDuration: attachedDatabase
          .typeMapping
          .read(
            DriftSqlType.int,
            data['${effectivePrefix}study_till_correct_reading_question_letter_duration'],
          ),
      studyTillCorrectFindingAnswerDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_till_correct_finding_answer_duration'],
      ),
      studyTillCorrectTypingAnswerLetterDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_till_correct_typing_answer_letter_duration'],
      ),
      testsTimeOfAnswerAction: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tests_time_of_answer_action'],
      )!,
      doesObfuscateQuestion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}does_obfuscate_question'],
      )!,
    );
  }

  @override
  $FieldListsTable createAlias(String alias) {
    return $FieldListsTable(attachedDatabase, alias);
  }
}

class FieldList extends DataClass implements Insertable<FieldList> {
  final String id;
  final String fieldId;
  final String name;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  final String? languageTag;
  final int checkType;
  final int sortBy;
  final bool doesReadAnswer;
  final int usageCount;
  final int color;
  final int? emulationNumberOfQuestions;
  final String? emulationDays;
  final int? testsReadingQuestionLetterDuration;
  final int? testsFindingAnswerDuration;
  final int? testsTypingAnswerLetterDuration;
  final int? studyTillCorrectReadingQuestionLetterDuration;
  final int? studyTillCorrectFindingAnswerDuration;
  final int? studyTillCorrectTypingAnswerLetterDuration;
  final int testsTimeOfAnswerAction;
  final bool doesObfuscateQuestion;
  const FieldList({
    required this.id,
    required this.fieldId,
    required this.name,
    required this.creationAt,
    required this.lastModificationAt,
    this.languageTag,
    required this.checkType,
    required this.sortBy,
    required this.doesReadAnswer,
    required this.usageCount,
    required this.color,
    this.emulationNumberOfQuestions,
    this.emulationDays,
    this.testsReadingQuestionLetterDuration,
    this.testsFindingAnswerDuration,
    this.testsTypingAnswerLetterDuration,
    this.studyTillCorrectReadingQuestionLetterDuration,
    this.studyTillCorrectFindingAnswerDuration,
    this.studyTillCorrectTypingAnswerLetterDuration,
    required this.testsTimeOfAnswerAction,
    required this.doesObfuscateQuestion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_id'] = Variable<String>(fieldId);
    map['name'] = Variable<String>(name);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    if (!nullToAbsent || languageTag != null) {
      map['language_tag'] = Variable<String>(languageTag);
    }
    map['check_type'] = Variable<int>(checkType);
    map['sort_by'] = Variable<int>(sortBy);
    map['does_read_answer'] = Variable<bool>(doesReadAnswer);
    map['usage_count'] = Variable<int>(usageCount);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || emulationNumberOfQuestions != null) {
      map['emulation_number_of_questions'] = Variable<int>(
        emulationNumberOfQuestions,
      );
    }
    if (!nullToAbsent || emulationDays != null) {
      map['emulation_days'] = Variable<String>(emulationDays);
    }
    if (!nullToAbsent || testsReadingQuestionLetterDuration != null) {
      map['tests_reading_question_letter_duration'] = Variable<int>(
        testsReadingQuestionLetterDuration,
      );
    }
    if (!nullToAbsent || testsFindingAnswerDuration != null) {
      map['tests_finding_answer_duration'] = Variable<int>(
        testsFindingAnswerDuration,
      );
    }
    if (!nullToAbsent || testsTypingAnswerLetterDuration != null) {
      map['tests_typing_answer_letter_duration'] = Variable<int>(
        testsTypingAnswerLetterDuration,
      );
    }
    if (!nullToAbsent ||
        studyTillCorrectReadingQuestionLetterDuration != null) {
      map['study_till_correct_reading_question_letter_duration'] =
          Variable<int>(studyTillCorrectReadingQuestionLetterDuration);
    }
    if (!nullToAbsent || studyTillCorrectFindingAnswerDuration != null) {
      map['study_till_correct_finding_answer_duration'] = Variable<int>(
        studyTillCorrectFindingAnswerDuration,
      );
    }
    if (!nullToAbsent || studyTillCorrectTypingAnswerLetterDuration != null) {
      map['study_till_correct_typing_answer_letter_duration'] = Variable<int>(
        studyTillCorrectTypingAnswerLetterDuration,
      );
    }
    map['tests_time_of_answer_action'] = Variable<int>(testsTimeOfAnswerAction);
    map['does_obfuscate_question'] = Variable<bool>(doesObfuscateQuestion);
    return map;
  }

  FieldListsCompanion toCompanion(bool nullToAbsent) {
    return FieldListsCompanion(
      id: Value(id),
      fieldId: Value(fieldId),
      name: Value(name),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
      languageTag: languageTag == null && nullToAbsent
          ? const Value.absent()
          : Value(languageTag),
      checkType: Value(checkType),
      sortBy: Value(sortBy),
      doesReadAnswer: Value(doesReadAnswer),
      usageCount: Value(usageCount),
      color: Value(color),
      emulationNumberOfQuestions:
          emulationNumberOfQuestions == null && nullToAbsent
          ? const Value.absent()
          : Value(emulationNumberOfQuestions),
      emulationDays: emulationDays == null && nullToAbsent
          ? const Value.absent()
          : Value(emulationDays),
      testsReadingQuestionLetterDuration:
          testsReadingQuestionLetterDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(testsReadingQuestionLetterDuration),
      testsFindingAnswerDuration:
          testsFindingAnswerDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(testsFindingAnswerDuration),
      testsTypingAnswerLetterDuration:
          testsTypingAnswerLetterDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(testsTypingAnswerLetterDuration),
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(studyTillCorrectReadingQuestionLetterDuration),
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(studyTillCorrectFindingAnswerDuration),
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(studyTillCorrectTypingAnswerLetterDuration),
      testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
      doesObfuscateQuestion: Value(doesObfuscateQuestion),
    );
  }

  factory FieldList.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldList(
      id: serializer.fromJson<String>(json['id']),
      fieldId: serializer.fromJson<String>(json['fieldId']),
      name: serializer.fromJson<String>(json['name']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt: serializer.fromJson<DateTime>(
        json['lastModificationAt'],
      ),
      languageTag: serializer.fromJson<String?>(json['languageTag']),
      checkType: serializer.fromJson<int>(json['checkType']),
      sortBy: serializer.fromJson<int>(json['sortBy']),
      doesReadAnswer: serializer.fromJson<bool>(json['doesReadAnswer']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      color: serializer.fromJson<int>(json['color']),
      emulationNumberOfQuestions: serializer.fromJson<int?>(
        json['emulationNumberOfQuestions'],
      ),
      emulationDays: serializer.fromJson<String?>(json['emulationDays']),
      testsReadingQuestionLetterDuration: serializer.fromJson<int?>(
        json['testsReadingQuestionLetterDuration'],
      ),
      testsFindingAnswerDuration: serializer.fromJson<int?>(
        json['testsFindingAnswerDuration'],
      ),
      testsTypingAnswerLetterDuration: serializer.fromJson<int?>(
        json['testsTypingAnswerLetterDuration'],
      ),
      studyTillCorrectReadingQuestionLetterDuration: serializer.fromJson<int?>(
        json['studyTillCorrectReadingQuestionLetterDuration'],
      ),
      studyTillCorrectFindingAnswerDuration: serializer.fromJson<int?>(
        json['studyTillCorrectFindingAnswerDuration'],
      ),
      studyTillCorrectTypingAnswerLetterDuration: serializer.fromJson<int?>(
        json['studyTillCorrectTypingAnswerLetterDuration'],
      ),
      testsTimeOfAnswerAction: serializer.fromJson<int>(
        json['testsTimeOfAnswerAction'],
      ),
      doesObfuscateQuestion: serializer.fromJson<bool>(
        json['doesObfuscateQuestion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldId': serializer.toJson<String>(fieldId),
      'name': serializer.toJson<String>(name),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
      'languageTag': serializer.toJson<String?>(languageTag),
      'checkType': serializer.toJson<int>(checkType),
      'sortBy': serializer.toJson<int>(sortBy),
      'doesReadAnswer': serializer.toJson<bool>(doesReadAnswer),
      'usageCount': serializer.toJson<int>(usageCount),
      'color': serializer.toJson<int>(color),
      'emulationNumberOfQuestions': serializer.toJson<int?>(
        emulationNumberOfQuestions,
      ),
      'emulationDays': serializer.toJson<String?>(emulationDays),
      'testsReadingQuestionLetterDuration': serializer.toJson<int?>(
        testsReadingQuestionLetterDuration,
      ),
      'testsFindingAnswerDuration': serializer.toJson<int?>(
        testsFindingAnswerDuration,
      ),
      'testsTypingAnswerLetterDuration': serializer.toJson<int?>(
        testsTypingAnswerLetterDuration,
      ),
      'studyTillCorrectReadingQuestionLetterDuration': serializer.toJson<int?>(
        studyTillCorrectReadingQuestionLetterDuration,
      ),
      'studyTillCorrectFindingAnswerDuration': serializer.toJson<int?>(
        studyTillCorrectFindingAnswerDuration,
      ),
      'studyTillCorrectTypingAnswerLetterDuration': serializer.toJson<int?>(
        studyTillCorrectTypingAnswerLetterDuration,
      ),
      'testsTimeOfAnswerAction': serializer.toJson<int>(
        testsTimeOfAnswerAction,
      ),
      'doesObfuscateQuestion': serializer.toJson<bool>(doesObfuscateQuestion),
    };
  }

  FieldList copyWith({
    String? id,
    String? fieldId,
    String? name,
    DateTime? creationAt,
    DateTime? lastModificationAt,
    Value<String?> languageTag = const Value.absent(),
    int? checkType,
    int? sortBy,
    bool? doesReadAnswer,
    int? usageCount,
    int? color,
    Value<int?> emulationNumberOfQuestions = const Value.absent(),
    Value<String?> emulationDays = const Value.absent(),
    Value<int?> testsReadingQuestionLetterDuration = const Value.absent(),
    Value<int?> testsFindingAnswerDuration = const Value.absent(),
    Value<int?> testsTypingAnswerLetterDuration = const Value.absent(),
    Value<int?> studyTillCorrectReadingQuestionLetterDuration =
        const Value.absent(),
    Value<int?> studyTillCorrectFindingAnswerDuration = const Value.absent(),
    Value<int?> studyTillCorrectTypingAnswerLetterDuration =
        const Value.absent(),
    int? testsTimeOfAnswerAction,
    bool? doesObfuscateQuestion,
  }) => FieldList(
    id: id ?? this.id,
    fieldId: fieldId ?? this.fieldId,
    name: name ?? this.name,
    creationAt: creationAt ?? this.creationAt,
    lastModificationAt: lastModificationAt ?? this.lastModificationAt,
    languageTag: languageTag.present ? languageTag.value : this.languageTag,
    checkType: checkType ?? this.checkType,
    sortBy: sortBy ?? this.sortBy,
    doesReadAnswer: doesReadAnswer ?? this.doesReadAnswer,
    usageCount: usageCount ?? this.usageCount,
    color: color ?? this.color,
    emulationNumberOfQuestions: emulationNumberOfQuestions.present
        ? emulationNumberOfQuestions.value
        : this.emulationNumberOfQuestions,
    emulationDays: emulationDays.present
        ? emulationDays.value
        : this.emulationDays,
    testsReadingQuestionLetterDuration:
        testsReadingQuestionLetterDuration.present
        ? testsReadingQuestionLetterDuration.value
        : this.testsReadingQuestionLetterDuration,
    testsFindingAnswerDuration: testsFindingAnswerDuration.present
        ? testsFindingAnswerDuration.value
        : this.testsFindingAnswerDuration,
    testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration.present
        ? testsTypingAnswerLetterDuration.value
        : this.testsTypingAnswerLetterDuration,
    studyTillCorrectReadingQuestionLetterDuration:
        studyTillCorrectReadingQuestionLetterDuration.present
        ? studyTillCorrectReadingQuestionLetterDuration.value
        : this.studyTillCorrectReadingQuestionLetterDuration,
    studyTillCorrectFindingAnswerDuration:
        studyTillCorrectFindingAnswerDuration.present
        ? studyTillCorrectFindingAnswerDuration.value
        : this.studyTillCorrectFindingAnswerDuration,
    studyTillCorrectTypingAnswerLetterDuration:
        studyTillCorrectTypingAnswerLetterDuration.present
        ? studyTillCorrectTypingAnswerLetterDuration.value
        : this.studyTillCorrectTypingAnswerLetterDuration,
    testsTimeOfAnswerAction:
        testsTimeOfAnswerAction ?? this.testsTimeOfAnswerAction,
    doesObfuscateQuestion: doesObfuscateQuestion ?? this.doesObfuscateQuestion,
  );
  FieldList copyWithCompanion(FieldListsCompanion data) {
    return FieldList(
      id: data.id.present ? data.id.value : this.id,
      fieldId: data.fieldId.present ? data.fieldId.value : this.fieldId,
      name: data.name.present ? data.name.value : this.name,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
      lastModificationAt: data.lastModificationAt.present
          ? data.lastModificationAt.value
          : this.lastModificationAt,
      languageTag: data.languageTag.present
          ? data.languageTag.value
          : this.languageTag,
      checkType: data.checkType.present ? data.checkType.value : this.checkType,
      sortBy: data.sortBy.present ? data.sortBy.value : this.sortBy,
      doesReadAnswer: data.doesReadAnswer.present
          ? data.doesReadAnswer.value
          : this.doesReadAnswer,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      color: data.color.present ? data.color.value : this.color,
      emulationNumberOfQuestions: data.emulationNumberOfQuestions.present
          ? data.emulationNumberOfQuestions.value
          : this.emulationNumberOfQuestions,
      emulationDays: data.emulationDays.present
          ? data.emulationDays.value
          : this.emulationDays,
      testsReadingQuestionLetterDuration:
          data.testsReadingQuestionLetterDuration.present
          ? data.testsReadingQuestionLetterDuration.value
          : this.testsReadingQuestionLetterDuration,
      testsFindingAnswerDuration: data.testsFindingAnswerDuration.present
          ? data.testsFindingAnswerDuration.value
          : this.testsFindingAnswerDuration,
      testsTypingAnswerLetterDuration:
          data.testsTypingAnswerLetterDuration.present
          ? data.testsTypingAnswerLetterDuration.value
          : this.testsTypingAnswerLetterDuration,
      studyTillCorrectReadingQuestionLetterDuration:
          data.studyTillCorrectReadingQuestionLetterDuration.present
          ? data.studyTillCorrectReadingQuestionLetterDuration.value
          : this.studyTillCorrectReadingQuestionLetterDuration,
      studyTillCorrectFindingAnswerDuration:
          data.studyTillCorrectFindingAnswerDuration.present
          ? data.studyTillCorrectFindingAnswerDuration.value
          : this.studyTillCorrectFindingAnswerDuration,
      studyTillCorrectTypingAnswerLetterDuration:
          data.studyTillCorrectTypingAnswerLetterDuration.present
          ? data.studyTillCorrectTypingAnswerLetterDuration.value
          : this.studyTillCorrectTypingAnswerLetterDuration,
      testsTimeOfAnswerAction: data.testsTimeOfAnswerAction.present
          ? data.testsTimeOfAnswerAction.value
          : this.testsTimeOfAnswerAction,
      doesObfuscateQuestion: data.doesObfuscateQuestion.present
          ? data.doesObfuscateQuestion.value
          : this.doesObfuscateQuestion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldList(')
          ..write('id: $id, ')
          ..write('fieldId: $fieldId, ')
          ..write('name: $name, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('languageTag: $languageTag, ')
          ..write('checkType: $checkType, ')
          ..write('sortBy: $sortBy, ')
          ..write('doesReadAnswer: $doesReadAnswer, ')
          ..write('usageCount: $usageCount, ')
          ..write('color: $color, ')
          ..write('emulationNumberOfQuestions: $emulationNumberOfQuestions, ')
          ..write('emulationDays: $emulationDays, ')
          ..write(
            'testsReadingQuestionLetterDuration: $testsReadingQuestionLetterDuration, ',
          )
          ..write('testsFindingAnswerDuration: $testsFindingAnswerDuration, ')
          ..write(
            'testsTypingAnswerLetterDuration: $testsTypingAnswerLetterDuration, ',
          )
          ..write(
            'studyTillCorrectReadingQuestionLetterDuration: $studyTillCorrectReadingQuestionLetterDuration, ',
          )
          ..write(
            'studyTillCorrectFindingAnswerDuration: $studyTillCorrectFindingAnswerDuration, ',
          )
          ..write(
            'studyTillCorrectTypingAnswerLetterDuration: $studyTillCorrectTypingAnswerLetterDuration, ',
          )
          ..write('testsTimeOfAnswerAction: $testsTimeOfAnswerAction, ')
          ..write('doesObfuscateQuestion: $doesObfuscateQuestion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    fieldId,
    name,
    creationAt,
    lastModificationAt,
    languageTag,
    checkType,
    sortBy,
    doesReadAnswer,
    usageCount,
    color,
    emulationNumberOfQuestions,
    emulationDays,
    testsReadingQuestionLetterDuration,
    testsFindingAnswerDuration,
    testsTypingAnswerLetterDuration,
    studyTillCorrectReadingQuestionLetterDuration,
    studyTillCorrectFindingAnswerDuration,
    studyTillCorrectTypingAnswerLetterDuration,
    testsTimeOfAnswerAction,
    doesObfuscateQuestion,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldList &&
          other.id == this.id &&
          other.fieldId == this.fieldId &&
          other.name == this.name &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt &&
          other.languageTag == this.languageTag &&
          other.checkType == this.checkType &&
          other.sortBy == this.sortBy &&
          other.doesReadAnswer == this.doesReadAnswer &&
          other.usageCount == this.usageCount &&
          other.color == this.color &&
          other.emulationNumberOfQuestions == this.emulationNumberOfQuestions &&
          other.emulationDays == this.emulationDays &&
          other.testsReadingQuestionLetterDuration ==
              this.testsReadingQuestionLetterDuration &&
          other.testsFindingAnswerDuration == this.testsFindingAnswerDuration &&
          other.testsTypingAnswerLetterDuration ==
              this.testsTypingAnswerLetterDuration &&
          other.studyTillCorrectReadingQuestionLetterDuration ==
              this.studyTillCorrectReadingQuestionLetterDuration &&
          other.studyTillCorrectFindingAnswerDuration ==
              this.studyTillCorrectFindingAnswerDuration &&
          other.studyTillCorrectTypingAnswerLetterDuration ==
              this.studyTillCorrectTypingAnswerLetterDuration &&
          other.testsTimeOfAnswerAction == this.testsTimeOfAnswerAction &&
          other.doesObfuscateQuestion == this.doesObfuscateQuestion);
}

class FieldListsCompanion extends UpdateCompanion<FieldList> {
  final Value<String> id;
  final Value<String> fieldId;
  final Value<String> name;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<String?> languageTag;
  final Value<int> checkType;
  final Value<int> sortBy;
  final Value<bool> doesReadAnswer;
  final Value<int> usageCount;
  final Value<int> color;
  final Value<int?> emulationNumberOfQuestions;
  final Value<String?> emulationDays;
  final Value<int?> testsReadingQuestionLetterDuration;
  final Value<int?> testsFindingAnswerDuration;
  final Value<int?> testsTypingAnswerLetterDuration;
  final Value<int?> studyTillCorrectReadingQuestionLetterDuration;
  final Value<int?> studyTillCorrectFindingAnswerDuration;
  final Value<int?> studyTillCorrectTypingAnswerLetterDuration;
  final Value<int> testsTimeOfAnswerAction;
  final Value<bool> doesObfuscateQuestion;
  final Value<int> rowid;
  const FieldListsCompanion({
    this.id = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.name = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.languageTag = const Value.absent(),
    this.checkType = const Value.absent(),
    this.sortBy = const Value.absent(),
    this.doesReadAnswer = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.color = const Value.absent(),
    this.emulationNumberOfQuestions = const Value.absent(),
    this.emulationDays = const Value.absent(),
    this.testsReadingQuestionLetterDuration = const Value.absent(),
    this.testsFindingAnswerDuration = const Value.absent(),
    this.testsTypingAnswerLetterDuration = const Value.absent(),
    this.studyTillCorrectReadingQuestionLetterDuration = const Value.absent(),
    this.studyTillCorrectFindingAnswerDuration = const Value.absent(),
    this.studyTillCorrectTypingAnswerLetterDuration = const Value.absent(),
    this.testsTimeOfAnswerAction = const Value.absent(),
    this.doesObfuscateQuestion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FieldListsCompanion.insert({
    this.id = const Value.absent(),
    required String fieldId,
    required String name,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.languageTag = const Value.absent(),
    this.checkType = const Value.absent(),
    this.sortBy = const Value.absent(),
    this.doesReadAnswer = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.color = const Value.absent(),
    this.emulationNumberOfQuestions = const Value.absent(),
    this.emulationDays = const Value.absent(),
    this.testsReadingQuestionLetterDuration = const Value.absent(),
    this.testsFindingAnswerDuration = const Value.absent(),
    this.testsTypingAnswerLetterDuration = const Value.absent(),
    this.studyTillCorrectReadingQuestionLetterDuration = const Value.absent(),
    this.studyTillCorrectFindingAnswerDuration = const Value.absent(),
    this.studyTillCorrectTypingAnswerLetterDuration = const Value.absent(),
    this.testsTimeOfAnswerAction = const Value.absent(),
    this.doesObfuscateQuestion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : fieldId = Value(fieldId),
       name = Value(name),
       creationAt = Value(creationAt),
       lastModificationAt = Value(lastModificationAt);
  static Insertable<FieldList> custom({
    Expression<String>? id,
    Expression<String>? fieldId,
    Expression<String>? name,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<String>? languageTag,
    Expression<int>? checkType,
    Expression<int>? sortBy,
    Expression<bool>? doesReadAnswer,
    Expression<int>? usageCount,
    Expression<int>? color,
    Expression<int>? emulationNumberOfQuestions,
    Expression<String>? emulationDays,
    Expression<int>? testsReadingQuestionLetterDuration,
    Expression<int>? testsFindingAnswerDuration,
    Expression<int>? testsTypingAnswerLetterDuration,
    Expression<int>? studyTillCorrectReadingQuestionLetterDuration,
    Expression<int>? studyTillCorrectFindingAnswerDuration,
    Expression<int>? studyTillCorrectTypingAnswerLetterDuration,
    Expression<int>? testsTimeOfAnswerAction,
    Expression<bool>? doesObfuscateQuestion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldId != null) 'field_id': fieldId,
      if (name != null) 'name': name,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (languageTag != null) 'language_tag': languageTag,
      if (checkType != null) 'check_type': checkType,
      if (sortBy != null) 'sort_by': sortBy,
      if (doesReadAnswer != null) 'does_read_answer': doesReadAnswer,
      if (usageCount != null) 'usage_count': usageCount,
      if (color != null) 'color': color,
      if (emulationNumberOfQuestions != null)
        'emulation_number_of_questions': emulationNumberOfQuestions,
      if (emulationDays != null) 'emulation_days': emulationDays,
      if (testsReadingQuestionLetterDuration != null)
        'tests_reading_question_letter_duration':
            testsReadingQuestionLetterDuration,
      if (testsFindingAnswerDuration != null)
        'tests_finding_answer_duration': testsFindingAnswerDuration,
      if (testsTypingAnswerLetterDuration != null)
        'tests_typing_answer_letter_duration': testsTypingAnswerLetterDuration,
      if (studyTillCorrectReadingQuestionLetterDuration != null)
        'study_till_correct_reading_question_letter_duration':
            studyTillCorrectReadingQuestionLetterDuration,
      if (studyTillCorrectFindingAnswerDuration != null)
        'study_till_correct_finding_answer_duration':
            studyTillCorrectFindingAnswerDuration,
      if (studyTillCorrectTypingAnswerLetterDuration != null)
        'study_till_correct_typing_answer_letter_duration':
            studyTillCorrectTypingAnswerLetterDuration,
      if (testsTimeOfAnswerAction != null)
        'tests_time_of_answer_action': testsTimeOfAnswerAction,
      if (doesObfuscateQuestion != null)
        'does_obfuscate_question': doesObfuscateQuestion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FieldListsCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldId,
    Value<String>? name,
    Value<DateTime>? creationAt,
    Value<DateTime>? lastModificationAt,
    Value<String?>? languageTag,
    Value<int>? checkType,
    Value<int>? sortBy,
    Value<bool>? doesReadAnswer,
    Value<int>? usageCount,
    Value<int>? color,
    Value<int?>? emulationNumberOfQuestions,
    Value<String?>? emulationDays,
    Value<int?>? testsReadingQuestionLetterDuration,
    Value<int?>? testsFindingAnswerDuration,
    Value<int?>? testsTypingAnswerLetterDuration,
    Value<int?>? studyTillCorrectReadingQuestionLetterDuration,
    Value<int?>? studyTillCorrectFindingAnswerDuration,
    Value<int?>? studyTillCorrectTypingAnswerLetterDuration,
    Value<int>? testsTimeOfAnswerAction,
    Value<bool>? doesObfuscateQuestion,
    Value<int>? rowid,
  }) {
    return FieldListsCompanion(
      id: id ?? this.id,
      fieldId: fieldId ?? this.fieldId,
      name: name ?? this.name,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      languageTag: languageTag ?? this.languageTag,
      checkType: checkType ?? this.checkType,
      sortBy: sortBy ?? this.sortBy,
      doesReadAnswer: doesReadAnswer ?? this.doesReadAnswer,
      usageCount: usageCount ?? this.usageCount,
      color: color ?? this.color,
      emulationNumberOfQuestions:
          emulationNumberOfQuestions ?? this.emulationNumberOfQuestions,
      emulationDays: emulationDays ?? this.emulationDays,
      testsReadingQuestionLetterDuration:
          testsReadingQuestionLetterDuration ??
          this.testsReadingQuestionLetterDuration,
      testsFindingAnswerDuration:
          testsFindingAnswerDuration ?? this.testsFindingAnswerDuration,
      testsTypingAnswerLetterDuration:
          testsTypingAnswerLetterDuration ??
          this.testsTypingAnswerLetterDuration,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration ??
          this.studyTillCorrectReadingQuestionLetterDuration,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration ??
          this.studyTillCorrectFindingAnswerDuration,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration ??
          this.studyTillCorrectTypingAnswerLetterDuration,
      testsTimeOfAnswerAction:
          testsTimeOfAnswerAction ?? this.testsTimeOfAnswerAction,
      doesObfuscateQuestion:
          doesObfuscateQuestion ?? this.doesObfuscateQuestion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldId.present) {
      map['field_id'] = Variable<String>(fieldId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] = Variable<DateTime>(
        lastModificationAt.value,
      );
    }
    if (languageTag.present) {
      map['language_tag'] = Variable<String>(languageTag.value);
    }
    if (checkType.present) {
      map['check_type'] = Variable<int>(checkType.value);
    }
    if (sortBy.present) {
      map['sort_by'] = Variable<int>(sortBy.value);
    }
    if (doesReadAnswer.present) {
      map['does_read_answer'] = Variable<bool>(doesReadAnswer.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (emulationNumberOfQuestions.present) {
      map['emulation_number_of_questions'] = Variable<int>(
        emulationNumberOfQuestions.value,
      );
    }
    if (emulationDays.present) {
      map['emulation_days'] = Variable<String>(emulationDays.value);
    }
    if (testsReadingQuestionLetterDuration.present) {
      map['tests_reading_question_letter_duration'] = Variable<int>(
        testsReadingQuestionLetterDuration.value,
      );
    }
    if (testsFindingAnswerDuration.present) {
      map['tests_finding_answer_duration'] = Variable<int>(
        testsFindingAnswerDuration.value,
      );
    }
    if (testsTypingAnswerLetterDuration.present) {
      map['tests_typing_answer_letter_duration'] = Variable<int>(
        testsTypingAnswerLetterDuration.value,
      );
    }
    if (studyTillCorrectReadingQuestionLetterDuration.present) {
      map['study_till_correct_reading_question_letter_duration'] =
          Variable<int>(studyTillCorrectReadingQuestionLetterDuration.value);
    }
    if (studyTillCorrectFindingAnswerDuration.present) {
      map['study_till_correct_finding_answer_duration'] = Variable<int>(
        studyTillCorrectFindingAnswerDuration.value,
      );
    }
    if (studyTillCorrectTypingAnswerLetterDuration.present) {
      map['study_till_correct_typing_answer_letter_duration'] = Variable<int>(
        studyTillCorrectTypingAnswerLetterDuration.value,
      );
    }
    if (testsTimeOfAnswerAction.present) {
      map['tests_time_of_answer_action'] = Variable<int>(
        testsTimeOfAnswerAction.value,
      );
    }
    if (doesObfuscateQuestion.present) {
      map['does_obfuscate_question'] = Variable<bool>(
        doesObfuscateQuestion.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldListsCompanion(')
          ..write('id: $id, ')
          ..write('fieldId: $fieldId, ')
          ..write('name: $name, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('languageTag: $languageTag, ')
          ..write('checkType: $checkType, ')
          ..write('sortBy: $sortBy, ')
          ..write('doesReadAnswer: $doesReadAnswer, ')
          ..write('usageCount: $usageCount, ')
          ..write('color: $color, ')
          ..write('emulationNumberOfQuestions: $emulationNumberOfQuestions, ')
          ..write('emulationDays: $emulationDays, ')
          ..write(
            'testsReadingQuestionLetterDuration: $testsReadingQuestionLetterDuration, ',
          )
          ..write('testsFindingAnswerDuration: $testsFindingAnswerDuration, ')
          ..write(
            'testsTypingAnswerLetterDuration: $testsTypingAnswerLetterDuration, ',
          )
          ..write(
            'studyTillCorrectReadingQuestionLetterDuration: $studyTillCorrectReadingQuestionLetterDuration, ',
          )
          ..write(
            'studyTillCorrectFindingAnswerDuration: $studyTillCorrectFindingAnswerDuration, ',
          )
          ..write(
            'studyTillCorrectTypingAnswerLetterDuration: $studyTillCorrectTypingAnswerLetterDuration, ',
          )
          ..write('testsTimeOfAnswerAction: $testsTimeOfAnswerAction, ')
          ..write('doesObfuscateQuestion: $doesObfuscateQuestion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntrysTable extends Entrys with TableInfo<$EntrysTable, Entry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntrysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _fieldListIdMeta = const VerificationMeta(
    'fieldListId',
  );
  @override
  late final GeneratedColumn<String> fieldListId = GeneratedColumn<String>(
    'field_list_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES field_lists (id)',
    ),
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          StringExpressionOperators(answer).trim().length,
        ).isBiggerOrEqualValue(Entrys.minimumTextLength) &
        ComparableExpr(
          answer.length,
        ).isSmallerOrEqualValue(Entrys.maximumTextLength),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          StringExpressionOperators(question).trim().length,
        ).isBiggerOrEqualValue(Entrys.minimumTextLength) &
        ComparableExpr(
          question.length,
        ).isSmallerOrEqualValue(Entrys.maximumTextLength),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>(
        'last_modification_at',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(lastModificationAt).isBiggerOrEqual(creationAt),
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          order,
        ).isSmallerOrEqualValue(Entrys.ORDER_MAXIMUM_VALUE) &
        ComparableExpr(order).isBiggerOrEqualValue(Entrys.ORDER_MINIMUM_VALUE),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(Entrys.ORDER_MINIMUM_VALUE),
  );
  static const VerificationMeta _didAskedAtCurrentTestRoundMeta =
      const VerificationMeta('didAskedAtCurrentTestRound');
  @override
  late final GeneratedColumn<bool> didAskedAtCurrentTestRound =
      GeneratedColumn<bool>(
        'did_asked_at_current_test_round',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("did_asked_at_current_test_round" IN (0, 1))',
        ),
        defaultValue: Constant(true),
      );
  static const VerificationMeta _emulatedCreatedAtMeta = const VerificationMeta(
    'emulatedCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> emulatedCreatedAt =
      GeneratedColumn<DateTime>(
        'emulated_created_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<int> rank = GeneratedColumn<int>(
    'rank',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(rank).isSmallerOrEqualValue(Rank.vital.index) &
        ComparableExpr(rank).isBiggerOrEqualValue(Rank.low.index),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(Rank.normal.index),
  );
  static const VerificationMeta _askedCountMeta = const VerificationMeta(
    'askedCount',
  );
  @override
  late final GeneratedColumn<BigInt> askedCount = GeneratedColumn<BigInt>(
    'asked_count',
    aliasedName,
    false,
    check: () => ComparableExpr(
      askedCount,
    ).isBiggerOrEqualValue(Entrys.ASKED_COUNT_MINIMUM_VALUE),
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultValue: Constant(Entrys.ASKED_COUNT_MINIMUM_VALUE),
  );
  static const VerificationMeta _wronglyAnsweredCountMeta =
      const VerificationMeta('wronglyAnsweredCount');
  @override
  late final GeneratedColumn<BigInt> wronglyAnsweredCount =
      GeneratedColumn<BigInt>(
        'wrongly_answered_count',
        aliasedName,
        false,
        check: () => ComparableExpr(
          wronglyAnsweredCount,
        ).isBiggerOrEqualValue(Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE),
        type: DriftSqlType.bigInt,
        requiredDuringInsert: false,
        defaultValue: Constant(Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldListId,
    answer,
    question,
    creationAt,
    lastModificationAt,
    order,
    didAskedAtCurrentTestRound,
    emulatedCreatedAt,
    rank,
    askedCount,
    wronglyAnsweredCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entrys';
  @override
  VerificationContext validateIntegrity(
    Insertable<Entry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_list_id')) {
      context.handle(
        _fieldListIdMeta,
        fieldListId.isAcceptableOrUnknown(
          data['field_list_id']!,
          _fieldListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldListIdMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
        _lastModificationAtMeta,
        lastModificationAt.isAcceptableOrUnknown(
          data['last_modification_at']!,
          _lastModificationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('did_asked_at_current_test_round')) {
      context.handle(
        _didAskedAtCurrentTestRoundMeta,
        didAskedAtCurrentTestRound.isAcceptableOrUnknown(
          data['did_asked_at_current_test_round']!,
          _didAskedAtCurrentTestRoundMeta,
        ),
      );
    }
    if (data.containsKey('emulated_created_at')) {
      context.handle(
        _emulatedCreatedAtMeta,
        emulatedCreatedAt.isAcceptableOrUnknown(
          data['emulated_created_at']!,
          _emulatedCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    }
    if (data.containsKey('asked_count')) {
      context.handle(
        _askedCountMeta,
        askedCount.isAcceptableOrUnknown(data['asked_count']!, _askedCountMeta),
      );
    }
    if (data.containsKey('wrongly_answered_count')) {
      context.handle(
        _wronglyAnsweredCountMeta,
        wronglyAnsweredCount.isAcceptableOrUnknown(
          data['wrongly_answered_count']!,
          _wronglyAnsweredCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {fieldListId, answer, question},
  ];
  @override
  Entry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldListId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_list_id'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
      lastModificationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modification_at'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      didAskedAtCurrentTestRound: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}did_asked_at_current_test_round'],
      )!,
      emulatedCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}emulated_created_at'],
      ),
      rank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rank'],
      )!,
      askedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}asked_count'],
      )!,
      wronglyAnsweredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}wrongly_answered_count'],
      )!,
    );
  }

  @override
  $EntrysTable createAlias(String alias) {
    return $EntrysTable(attachedDatabase, alias);
  }
}

class Entry extends DataClass implements Insertable<Entry> {
  final String id;
  final String fieldListId;
  final String answer;
  final String question;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  final int order;
  final bool didAskedAtCurrentTestRound;
  final DateTime? emulatedCreatedAt;
  final int rank;
  final BigInt askedCount;
  final BigInt wronglyAnsweredCount;
  const Entry({
    required this.id,
    required this.fieldListId,
    required this.answer,
    required this.question,
    required this.creationAt,
    required this.lastModificationAt,
    required this.order,
    required this.didAskedAtCurrentTestRound,
    this.emulatedCreatedAt,
    required this.rank,
    required this.askedCount,
    required this.wronglyAnsweredCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_list_id'] = Variable<String>(fieldListId);
    map['answer'] = Variable<String>(answer);
    map['question'] = Variable<String>(question);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    map['order'] = Variable<int>(order);
    map['did_asked_at_current_test_round'] = Variable<bool>(
      didAskedAtCurrentTestRound,
    );
    if (!nullToAbsent || emulatedCreatedAt != null) {
      map['emulated_created_at'] = Variable<DateTime>(emulatedCreatedAt);
    }
    map['rank'] = Variable<int>(rank);
    map['asked_count'] = Variable<BigInt>(askedCount);
    map['wrongly_answered_count'] = Variable<BigInt>(wronglyAnsweredCount);
    return map;
  }

  EntrysCompanion toCompanion(bool nullToAbsent) {
    return EntrysCompanion(
      id: Value(id),
      fieldListId: Value(fieldListId),
      answer: Value(answer),
      question: Value(question),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
      order: Value(order),
      didAskedAtCurrentTestRound: Value(didAskedAtCurrentTestRound),
      emulatedCreatedAt: emulatedCreatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(emulatedCreatedAt),
      rank: Value(rank),
      askedCount: Value(askedCount),
      wronglyAnsweredCount: Value(wronglyAnsweredCount),
    );
  }

  factory Entry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<String>(json['id']),
      fieldListId: serializer.fromJson<String>(json['fieldListId']),
      answer: serializer.fromJson<String>(json['answer']),
      question: serializer.fromJson<String>(json['question']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt: serializer.fromJson<DateTime>(
        json['lastModificationAt'],
      ),
      order: serializer.fromJson<int>(json['order']),
      didAskedAtCurrentTestRound: serializer.fromJson<bool>(
        json['didAskedAtCurrentTestRound'],
      ),
      emulatedCreatedAt: serializer.fromJson<DateTime?>(
        json['emulatedCreatedAt'],
      ),
      rank: serializer.fromJson<int>(json['rank']),
      askedCount: serializer.fromJson<BigInt>(json['askedCount']),
      wronglyAnsweredCount: serializer.fromJson<BigInt>(
        json['wronglyAnsweredCount'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldListId': serializer.toJson<String>(fieldListId),
      'answer': serializer.toJson<String>(answer),
      'question': serializer.toJson<String>(question),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
      'order': serializer.toJson<int>(order),
      'didAskedAtCurrentTestRound': serializer.toJson<bool>(
        didAskedAtCurrentTestRound,
      ),
      'emulatedCreatedAt': serializer.toJson<DateTime?>(emulatedCreatedAt),
      'rank': serializer.toJson<int>(rank),
      'askedCount': serializer.toJson<BigInt>(askedCount),
      'wronglyAnsweredCount': serializer.toJson<BigInt>(wronglyAnsweredCount),
    };
  }

  Entry copyWith({
    String? id,
    String? fieldListId,
    String? answer,
    String? question,
    DateTime? creationAt,
    DateTime? lastModificationAt,
    int? order,
    bool? didAskedAtCurrentTestRound,
    Value<DateTime?> emulatedCreatedAt = const Value.absent(),
    int? rank,
    BigInt? askedCount,
    BigInt? wronglyAnsweredCount,
  }) => Entry(
    id: id ?? this.id,
    fieldListId: fieldListId ?? this.fieldListId,
    answer: answer ?? this.answer,
    question: question ?? this.question,
    creationAt: creationAt ?? this.creationAt,
    lastModificationAt: lastModificationAt ?? this.lastModificationAt,
    order: order ?? this.order,
    didAskedAtCurrentTestRound:
        didAskedAtCurrentTestRound ?? this.didAskedAtCurrentTestRound,
    emulatedCreatedAt: emulatedCreatedAt.present
        ? emulatedCreatedAt.value
        : this.emulatedCreatedAt,
    rank: rank ?? this.rank,
    askedCount: askedCount ?? this.askedCount,
    wronglyAnsweredCount: wronglyAnsweredCount ?? this.wronglyAnsweredCount,
  );
  Entry copyWithCompanion(EntrysCompanion data) {
    return Entry(
      id: data.id.present ? data.id.value : this.id,
      fieldListId: data.fieldListId.present
          ? data.fieldListId.value
          : this.fieldListId,
      answer: data.answer.present ? data.answer.value : this.answer,
      question: data.question.present ? data.question.value : this.question,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
      lastModificationAt: data.lastModificationAt.present
          ? data.lastModificationAt.value
          : this.lastModificationAt,
      order: data.order.present ? data.order.value : this.order,
      didAskedAtCurrentTestRound: data.didAskedAtCurrentTestRound.present
          ? data.didAskedAtCurrentTestRound.value
          : this.didAskedAtCurrentTestRound,
      emulatedCreatedAt: data.emulatedCreatedAt.present
          ? data.emulatedCreatedAt.value
          : this.emulatedCreatedAt,
      rank: data.rank.present ? data.rank.value : this.rank,
      askedCount: data.askedCount.present
          ? data.askedCount.value
          : this.askedCount,
      wronglyAnsweredCount: data.wronglyAnsweredCount.present
          ? data.wronglyAnsweredCount.value
          : this.wronglyAnsweredCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('answer: $answer, ')
          ..write('question: $question, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('order: $order, ')
          ..write('didAskedAtCurrentTestRound: $didAskedAtCurrentTestRound, ')
          ..write('emulatedCreatedAt: $emulatedCreatedAt, ')
          ..write('rank: $rank, ')
          ..write('askedCount: $askedCount, ')
          ..write('wronglyAnsweredCount: $wronglyAnsweredCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fieldListId,
    answer,
    question,
    creationAt,
    lastModificationAt,
    order,
    didAskedAtCurrentTestRound,
    emulatedCreatedAt,
    rank,
    askedCount,
    wronglyAnsweredCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.fieldListId == this.fieldListId &&
          other.answer == this.answer &&
          other.question == this.question &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt &&
          other.order == this.order &&
          other.didAskedAtCurrentTestRound == this.didAskedAtCurrentTestRound &&
          other.emulatedCreatedAt == this.emulatedCreatedAt &&
          other.rank == this.rank &&
          other.askedCount == this.askedCount &&
          other.wronglyAnsweredCount == this.wronglyAnsweredCount);
}

class EntrysCompanion extends UpdateCompanion<Entry> {
  final Value<String> id;
  final Value<String> fieldListId;
  final Value<String> answer;
  final Value<String> question;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> order;
  final Value<bool> didAskedAtCurrentTestRound;
  final Value<DateTime?> emulatedCreatedAt;
  final Value<int> rank;
  final Value<BigInt> askedCount;
  final Value<BigInt> wronglyAnsweredCount;
  final Value<int> rowid;
  const EntrysCompanion({
    this.id = const Value.absent(),
    this.fieldListId = const Value.absent(),
    this.answer = const Value.absent(),
    this.question = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.order = const Value.absent(),
    this.didAskedAtCurrentTestRound = const Value.absent(),
    this.emulatedCreatedAt = const Value.absent(),
    this.rank = const Value.absent(),
    this.askedCount = const Value.absent(),
    this.wronglyAnsweredCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntrysCompanion.insert({
    this.id = const Value.absent(),
    required String fieldListId,
    required String answer,
    required String question,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.order = const Value.absent(),
    this.didAskedAtCurrentTestRound = const Value.absent(),
    this.emulatedCreatedAt = const Value.absent(),
    this.rank = const Value.absent(),
    this.askedCount = const Value.absent(),
    this.wronglyAnsweredCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : fieldListId = Value(fieldListId),
       answer = Value(answer),
       question = Value(question),
       creationAt = Value(creationAt),
       lastModificationAt = Value(lastModificationAt);
  static Insertable<Entry> custom({
    Expression<String>? id,
    Expression<String>? fieldListId,
    Expression<String>? answer,
    Expression<String>? question,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? order,
    Expression<bool>? didAskedAtCurrentTestRound,
    Expression<DateTime>? emulatedCreatedAt,
    Expression<int>? rank,
    Expression<BigInt>? askedCount,
    Expression<BigInt>? wronglyAnsweredCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldListId != null) 'field_list_id': fieldListId,
      if (answer != null) 'answer': answer,
      if (question != null) 'question': question,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (order != null) 'order': order,
      if (didAskedAtCurrentTestRound != null)
        'did_asked_at_current_test_round': didAskedAtCurrentTestRound,
      if (emulatedCreatedAt != null) 'emulated_created_at': emulatedCreatedAt,
      if (rank != null) 'rank': rank,
      if (askedCount != null) 'asked_count': askedCount,
      if (wronglyAnsweredCount != null)
        'wrongly_answered_count': wronglyAnsweredCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntrysCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldListId,
    Value<String>? answer,
    Value<String>? question,
    Value<DateTime>? creationAt,
    Value<DateTime>? lastModificationAt,
    Value<int>? order,
    Value<bool>? didAskedAtCurrentTestRound,
    Value<DateTime?>? emulatedCreatedAt,
    Value<int>? rank,
    Value<BigInt>? askedCount,
    Value<BigInt>? wronglyAnsweredCount,
    Value<int>? rowid,
  }) {
    return EntrysCompanion(
      id: id ?? this.id,
      fieldListId: fieldListId ?? this.fieldListId,
      answer: answer ?? this.answer,
      question: question ?? this.question,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      order: order ?? this.order,
      didAskedAtCurrentTestRound:
          didAskedAtCurrentTestRound ?? this.didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt ?? this.emulatedCreatedAt,
      rank: rank ?? this.rank,
      askedCount: askedCount ?? this.askedCount,
      wronglyAnsweredCount: wronglyAnsweredCount ?? this.wronglyAnsweredCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldListId.present) {
      map['field_list_id'] = Variable<String>(fieldListId.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] = Variable<DateTime>(
        lastModificationAt.value,
      );
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (didAskedAtCurrentTestRound.present) {
      map['did_asked_at_current_test_round'] = Variable<bool>(
        didAskedAtCurrentTestRound.value,
      );
    }
    if (emulatedCreatedAt.present) {
      map['emulated_created_at'] = Variable<DateTime>(emulatedCreatedAt.value);
    }
    if (rank.present) {
      map['rank'] = Variable<int>(rank.value);
    }
    if (askedCount.present) {
      map['asked_count'] = Variable<BigInt>(askedCount.value);
    }
    if (wronglyAnsweredCount.present) {
      map['wrongly_answered_count'] = Variable<BigInt>(
        wronglyAnsweredCount.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntrysCompanion(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('answer: $answer, ')
          ..write('question: $question, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('order: $order, ')
          ..write('didAskedAtCurrentTestRound: $didAskedAtCurrentTestRound, ')
          ..write('emulatedCreatedAt: $emulatedCreatedAt, ')
          ..write('rank: $rank, ')
          ..write('askedCount: $askedCount, ')
          ..write('wronglyAnsweredCount: $wronglyAnsweredCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FieldNotesTable extends FieldNotes
    with TableInfo<$FieldNotesTable, FieldNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _fieldIdMeta = const VerificationMeta(
    'fieldId',
  );
  @override
  late final GeneratedColumn<String> fieldId = GeneratedColumn<String>(
    'field_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fields (id)',
    ),
  );
  static const VerificationMeta _texTMeta = const VerificationMeta('texT');
  @override
  late final GeneratedColumn<String> texT = GeneratedColumn<String>(
    'tex_t',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          StringExpressionOperators(texT).trim().length,
        ).isBiggerOrEqualValue(FieldNotes.MINIMUM_LENGTH_OF_TEXT) &
        ComparableExpr(
          texT.length,
        ).isSmallerOrEqualValue(FieldNotes.MAXIMUM_LENGTH_OF_TEXT),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>(
        'last_modification_at',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(lastModificationAt).isBiggerOrEqual(creationAt),
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldId,
    texT,
    creationAt,
    lastModificationAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_id')) {
      context.handle(
        _fieldIdMeta,
        fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldIdMeta);
    }
    if (data.containsKey('tex_t')) {
      context.handle(
        _texTMeta,
        texT.isAcceptableOrUnknown(data['tex_t']!, _texTMeta),
      );
    } else if (isInserting) {
      context.missing(_texTMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
        _lastModificationAtMeta,
        lastModificationAt.isAcceptableOrUnknown(
          data['last_modification_at']!,
          _lastModificationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_id'],
      )!,
      texT: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tex_t'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
      lastModificationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modification_at'],
      )!,
    );
  }

  @override
  $FieldNotesTable createAlias(String alias) {
    return $FieldNotesTable(attachedDatabase, alias);
  }
}

class FieldNote extends DataClass implements Insertable<FieldNote> {
  final String id;
  final String fieldId;
  final String texT;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  const FieldNote({
    required this.id,
    required this.fieldId,
    required this.texT,
    required this.creationAt,
    required this.lastModificationAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_id'] = Variable<String>(fieldId);
    map['tex_t'] = Variable<String>(texT);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    return map;
  }

  FieldNotesCompanion toCompanion(bool nullToAbsent) {
    return FieldNotesCompanion(
      id: Value(id),
      fieldId: Value(fieldId),
      texT: Value(texT),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
    );
  }

  factory FieldNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldNote(
      id: serializer.fromJson<String>(json['id']),
      fieldId: serializer.fromJson<String>(json['fieldId']),
      texT: serializer.fromJson<String>(json['texT']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt: serializer.fromJson<DateTime>(
        json['lastModificationAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldId': serializer.toJson<String>(fieldId),
      'texT': serializer.toJson<String>(texT),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
    };
  }

  FieldNote copyWith({
    String? id,
    String? fieldId,
    String? texT,
    DateTime? creationAt,
    DateTime? lastModificationAt,
  }) => FieldNote(
    id: id ?? this.id,
    fieldId: fieldId ?? this.fieldId,
    texT: texT ?? this.texT,
    creationAt: creationAt ?? this.creationAt,
    lastModificationAt: lastModificationAt ?? this.lastModificationAt,
  );
  FieldNote copyWithCompanion(FieldNotesCompanion data) {
    return FieldNote(
      id: data.id.present ? data.id.value : this.id,
      fieldId: data.fieldId.present ? data.fieldId.value : this.fieldId,
      texT: data.texT.present ? data.texT.value : this.texT,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
      lastModificationAt: data.lastModificationAt.present
          ? data.lastModificationAt.value
          : this.lastModificationAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldNote(')
          ..write('id: $id, ')
          ..write('fieldId: $fieldId, ')
          ..write('texT: $texT, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fieldId, texT, creationAt, lastModificationAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldNote &&
          other.id == this.id &&
          other.fieldId == this.fieldId &&
          other.texT == this.texT &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt);
}

class FieldNotesCompanion extends UpdateCompanion<FieldNote> {
  final Value<String> id;
  final Value<String> fieldId;
  final Value<String> texT;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> rowid;
  const FieldNotesCompanion({
    this.id = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.texT = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FieldNotesCompanion.insert({
    this.id = const Value.absent(),
    required String fieldId,
    required String texT,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.rowid = const Value.absent(),
  }) : fieldId = Value(fieldId),
       texT = Value(texT),
       creationAt = Value(creationAt),
       lastModificationAt = Value(lastModificationAt);
  static Insertable<FieldNote> custom({
    Expression<String>? id,
    Expression<String>? fieldId,
    Expression<String>? texT,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldId != null) 'field_id': fieldId,
      if (texT != null) 'tex_t': texT,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FieldNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldId,
    Value<String>? texT,
    Value<DateTime>? creationAt,
    Value<DateTime>? lastModificationAt,
    Value<int>? rowid,
  }) {
    return FieldNotesCompanion(
      id: id ?? this.id,
      fieldId: fieldId ?? this.fieldId,
      texT: texT ?? this.texT,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldId.present) {
      map['field_id'] = Variable<String>(fieldId.value);
    }
    if (texT.present) {
      map['tex_t'] = Variable<String>(texT.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] = Variable<DateTime>(
        lastModificationAt.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldNotesCompanion(')
          ..write('id: $id, ')
          ..write('fieldId: $fieldId, ')
          ..write('texT: $texT, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FieldListNotesTable extends FieldListNotes
    with TableInfo<$FieldListNotesTable, FieldListNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldListNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _fieldListIdMeta = const VerificationMeta(
    'fieldListId',
  );
  @override
  late final GeneratedColumn<String> fieldListId = GeneratedColumn<String>(
    'field_list_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES field_lists (id)',
    ),
  );
  static const VerificationMeta _texTMeta = const VerificationMeta('texT');
  @override
  late final GeneratedColumn<String> texT = GeneratedColumn<String>(
    'tex_t',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          StringExpressionOperators(texT).trim().length,
        ).isBiggerOrEqualValue(FieldListNotes.MINIMUM_LENGTH_OF_TEXT) &
        ComparableExpr(
          texT.length,
        ).isSmallerOrEqualValue(FieldListNotes.MAXIMUM_LENGTH_OF_TEXT),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>(
        'last_modification_at',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(lastModificationAt).isBiggerOrEqual(creationAt),
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldListId,
    texT,
    creationAt,
    lastModificationAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_list_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldListNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_list_id')) {
      context.handle(
        _fieldListIdMeta,
        fieldListId.isAcceptableOrUnknown(
          data['field_list_id']!,
          _fieldListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldListIdMeta);
    }
    if (data.containsKey('tex_t')) {
      context.handle(
        _texTMeta,
        texT.isAcceptableOrUnknown(data['tex_t']!, _texTMeta),
      );
    } else if (isInserting) {
      context.missing(_texTMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
        _lastModificationAtMeta,
        lastModificationAt.isAcceptableOrUnknown(
          data['last_modification_at']!,
          _lastModificationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldListNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldListNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldListId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_list_id'],
      )!,
      texT: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tex_t'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
      lastModificationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modification_at'],
      )!,
    );
  }

  @override
  $FieldListNotesTable createAlias(String alias) {
    return $FieldListNotesTable(attachedDatabase, alias);
  }
}

class FieldListNote extends DataClass implements Insertable<FieldListNote> {
  final String id;
  final String fieldListId;
  final String texT;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  const FieldListNote({
    required this.id,
    required this.fieldListId,
    required this.texT,
    required this.creationAt,
    required this.lastModificationAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_list_id'] = Variable<String>(fieldListId);
    map['tex_t'] = Variable<String>(texT);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    return map;
  }

  FieldListNotesCompanion toCompanion(bool nullToAbsent) {
    return FieldListNotesCompanion(
      id: Value(id),
      fieldListId: Value(fieldListId),
      texT: Value(texT),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
    );
  }

  factory FieldListNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldListNote(
      id: serializer.fromJson<String>(json['id']),
      fieldListId: serializer.fromJson<String>(json['fieldListId']),
      texT: serializer.fromJson<String>(json['texT']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt: serializer.fromJson<DateTime>(
        json['lastModificationAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldListId': serializer.toJson<String>(fieldListId),
      'texT': serializer.toJson<String>(texT),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
    };
  }

  FieldListNote copyWith({
    String? id,
    String? fieldListId,
    String? texT,
    DateTime? creationAt,
    DateTime? lastModificationAt,
  }) => FieldListNote(
    id: id ?? this.id,
    fieldListId: fieldListId ?? this.fieldListId,
    texT: texT ?? this.texT,
    creationAt: creationAt ?? this.creationAt,
    lastModificationAt: lastModificationAt ?? this.lastModificationAt,
  );
  FieldListNote copyWithCompanion(FieldListNotesCompanion data) {
    return FieldListNote(
      id: data.id.present ? data.id.value : this.id,
      fieldListId: data.fieldListId.present
          ? data.fieldListId.value
          : this.fieldListId,
      texT: data.texT.present ? data.texT.value : this.texT,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
      lastModificationAt: data.lastModificationAt.present
          ? data.lastModificationAt.value
          : this.lastModificationAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldListNote(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('texT: $texT, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fieldListId, texT, creationAt, lastModificationAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldListNote &&
          other.id == this.id &&
          other.fieldListId == this.fieldListId &&
          other.texT == this.texT &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt);
}

class FieldListNotesCompanion extends UpdateCompanion<FieldListNote> {
  final Value<String> id;
  final Value<String> fieldListId;
  final Value<String> texT;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> rowid;
  const FieldListNotesCompanion({
    this.id = const Value.absent(),
    this.fieldListId = const Value.absent(),
    this.texT = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FieldListNotesCompanion.insert({
    this.id = const Value.absent(),
    required String fieldListId,
    required String texT,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.rowid = const Value.absent(),
  }) : fieldListId = Value(fieldListId),
       texT = Value(texT),
       creationAt = Value(creationAt),
       lastModificationAt = Value(lastModificationAt);
  static Insertable<FieldListNote> custom({
    Expression<String>? id,
    Expression<String>? fieldListId,
    Expression<String>? texT,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldListId != null) 'field_list_id': fieldListId,
      if (texT != null) 'tex_t': texT,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FieldListNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldListId,
    Value<String>? texT,
    Value<DateTime>? creationAt,
    Value<DateTime>? lastModificationAt,
    Value<int>? rowid,
  }) {
    return FieldListNotesCompanion(
      id: id ?? this.id,
      fieldListId: fieldListId ?? this.fieldListId,
      texT: texT ?? this.texT,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldListId.present) {
      map['field_list_id'] = Variable<String>(fieldListId.value);
    }
    if (texT.present) {
      map['tex_t'] = Variable<String>(texT.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] = Variable<DateTime>(
        lastModificationAt.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldListNotesCompanion(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('texT: $texT, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _fieldListIdMeta = const VerificationMeta(
    'fieldListId',
  );
  @override
  late final GeneratedColumn<String> fieldListId = GeneratedColumn<String>(
    'field_list_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES field_lists (id)',
    ),
  );
  static const VerificationMeta _currentQuestionCounterMeta =
      const VerificationMeta('currentQuestionCounter');
  @override
  late final GeneratedColumn<int> currentQuestionCounter = GeneratedColumn<int>(
    'current_question_counter',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          currentQuestionCounter,
        ).isBiggerOrEqualValue(Sessions.MINIMUM_CURRENT_QUESTION_COUNTER) &
        ComparableExpr(
          currentQuestionCounter,
        ).isSmallerOrEqualValue(Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triesNumberMeta = const VerificationMeta(
    'triesNumber',
  );
  @override
  late final GeneratedColumn<int> triesNumber = GeneratedColumn<int>(
    'tries_number',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          triesNumber,
        ).isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_NUMBER) &
        ComparableExpr(
          triesNumber,
        ).isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_NUMBER),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triesCounterMeta = const VerificationMeta(
    'triesCounter',
  );
  @override
  late final GeneratedColumn<int> triesCounter = GeneratedColumn<int>(
    'tries_counter',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          triesCounter,
        ).isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_COUNTER) &
        ComparableExpr(
          triesCounter,
        ).isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_COUNTER) &
        ComparableExpr(triesCounter).isSmallerThan(triesNumber),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _elapsedTimeMeta = const VerificationMeta(
    'elapsedTime',
  );
  @override
  late final GeneratedColumn<int> elapsedTime = GeneratedColumn<int>(
    'elapsed_time',
    aliasedName,
    false,
    check: () => ComparableExpr(
      elapsedTime,
    ).isBiggerOrEqualValue(Sessions.MINIMUM_ELAPSED_TIME),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _lastCheckedAnswerResultMeta =
      const VerificationMeta('lastCheckedAnswerResult');
  @override
  late final GeneratedColumn<bool> lastCheckedAnswerResult =
      GeneratedColumn<bool>(
        'last_checked_answer_result',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("last_checked_answer_result" IN (0, 1))',
        ),
        defaultValue: Constant(false),
      );
  static const VerificationMeta _shouldCheckAnAnswerMeta =
      const VerificationMeta('shouldCheckAnAnswer');
  @override
  late final GeneratedColumn<bool> shouldCheckAnAnswer = GeneratedColumn<bool>(
    'should_check_an_answer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("should_check_an_answer" IN (0, 1))',
    ),
    defaultValue: Constant(true),
  );
  static const VerificationMeta _currentHintCounterMeta =
      const VerificationMeta('currentHintCounter');
  @override
  late final GeneratedColumn<int> currentHintCounter = GeneratedColumn<int>(
    'current_hint_counter',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          currentHintCounter,
        ).isBiggerOrEqualValue(Sessions.MINIMUM_CURRENT_HINT_COUNTER) &
        ComparableExpr(
          currentHintCounter,
        ).isSmallerOrEqualValue(Sessions.MAXIMUM_CURRENT_HINT_COUNTER),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>(
        'last_modification_at',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(lastModificationAt).isBiggerOrEqual(creationAt),
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldListId,
    currentQuestionCounter,
    triesNumber,
    triesCounter,
    elapsedTime,
    isCompleted,
    lastCheckedAnswerResult,
    shouldCheckAnAnswer,
    currentHintCounter,
    creationAt,
    lastModificationAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_list_id')) {
      context.handle(
        _fieldListIdMeta,
        fieldListId.isAcceptableOrUnknown(
          data['field_list_id']!,
          _fieldListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldListIdMeta);
    }
    if (data.containsKey('current_question_counter')) {
      context.handle(
        _currentQuestionCounterMeta,
        currentQuestionCounter.isAcceptableOrUnknown(
          data['current_question_counter']!,
          _currentQuestionCounterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentQuestionCounterMeta);
    }
    if (data.containsKey('tries_number')) {
      context.handle(
        _triesNumberMeta,
        triesNumber.isAcceptableOrUnknown(
          data['tries_number']!,
          _triesNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triesNumberMeta);
    }
    if (data.containsKey('tries_counter')) {
      context.handle(
        _triesCounterMeta,
        triesCounter.isAcceptableOrUnknown(
          data['tries_counter']!,
          _triesCounterMeta,
        ),
      );
    }
    if (data.containsKey('elapsed_time')) {
      context.handle(
        _elapsedTimeMeta,
        elapsedTime.isAcceptableOrUnknown(
          data['elapsed_time']!,
          _elapsedTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_elapsedTimeMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('last_checked_answer_result')) {
      context.handle(
        _lastCheckedAnswerResultMeta,
        lastCheckedAnswerResult.isAcceptableOrUnknown(
          data['last_checked_answer_result']!,
          _lastCheckedAnswerResultMeta,
        ),
      );
    }
    if (data.containsKey('should_check_an_answer')) {
      context.handle(
        _shouldCheckAnAnswerMeta,
        shouldCheckAnAnswer.isAcceptableOrUnknown(
          data['should_check_an_answer']!,
          _shouldCheckAnAnswerMeta,
        ),
      );
    }
    if (data.containsKey('current_hint_counter')) {
      context.handle(
        _currentHintCounterMeta,
        currentHintCounter.isAcceptableOrUnknown(
          data['current_hint_counter']!,
          _currentHintCounterMeta,
        ),
      );
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
        _lastModificationAtMeta,
        lastModificationAt.isAcceptableOrUnknown(
          data['last_modification_at']!,
          _lastModificationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldListId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_list_id'],
      )!,
      currentQuestionCounter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_question_counter'],
      )!,
      triesNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tries_number'],
      )!,
      triesCounter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tries_counter'],
      )!,
      elapsedTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_time'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      lastCheckedAnswerResult: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}last_checked_answer_result'],
      )!,
      shouldCheckAnAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}should_check_an_answer'],
      )!,
      currentHintCounter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_hint_counter'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
      lastModificationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modification_at'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String fieldListId;
  final int currentQuestionCounter;
  final int triesNumber;
  final int triesCounter;
  final int elapsedTime;
  final bool isCompleted;
  final bool lastCheckedAnswerResult;
  final bool shouldCheckAnAnswer;
  final int currentHintCounter;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  const Session({
    required this.id,
    required this.fieldListId,
    required this.currentQuestionCounter,
    required this.triesNumber,
    required this.triesCounter,
    required this.elapsedTime,
    required this.isCompleted,
    required this.lastCheckedAnswerResult,
    required this.shouldCheckAnAnswer,
    required this.currentHintCounter,
    required this.creationAt,
    required this.lastModificationAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_list_id'] = Variable<String>(fieldListId);
    map['current_question_counter'] = Variable<int>(currentQuestionCounter);
    map['tries_number'] = Variable<int>(triesNumber);
    map['tries_counter'] = Variable<int>(triesCounter);
    map['elapsed_time'] = Variable<int>(elapsedTime);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['last_checked_answer_result'] = Variable<bool>(lastCheckedAnswerResult);
    map['should_check_an_answer'] = Variable<bool>(shouldCheckAnAnswer);
    map['current_hint_counter'] = Variable<int>(currentHintCounter);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      fieldListId: Value(fieldListId),
      currentQuestionCounter: Value(currentQuestionCounter),
      triesNumber: Value(triesNumber),
      triesCounter: Value(triesCounter),
      elapsedTime: Value(elapsedTime),
      isCompleted: Value(isCompleted),
      lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
      shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
      currentHintCounter: Value(currentHintCounter),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      fieldListId: serializer.fromJson<String>(json['fieldListId']),
      currentQuestionCounter: serializer.fromJson<int>(
        json['currentQuestionCounter'],
      ),
      triesNumber: serializer.fromJson<int>(json['triesNumber']),
      triesCounter: serializer.fromJson<int>(json['triesCounter']),
      elapsedTime: serializer.fromJson<int>(json['elapsedTime']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      lastCheckedAnswerResult: serializer.fromJson<bool>(
        json['lastCheckedAnswerResult'],
      ),
      shouldCheckAnAnswer: serializer.fromJson<bool>(
        json['shouldCheckAnAnswer'],
      ),
      currentHintCounter: serializer.fromJson<int>(json['currentHintCounter']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt: serializer.fromJson<DateTime>(
        json['lastModificationAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldListId': serializer.toJson<String>(fieldListId),
      'currentQuestionCounter': serializer.toJson<int>(currentQuestionCounter),
      'triesNumber': serializer.toJson<int>(triesNumber),
      'triesCounter': serializer.toJson<int>(triesCounter),
      'elapsedTime': serializer.toJson<int>(elapsedTime),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'lastCheckedAnswerResult': serializer.toJson<bool>(
        lastCheckedAnswerResult,
      ),
      'shouldCheckAnAnswer': serializer.toJson<bool>(shouldCheckAnAnswer),
      'currentHintCounter': serializer.toJson<int>(currentHintCounter),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
    };
  }

  Session copyWith({
    String? id,
    String? fieldListId,
    int? currentQuestionCounter,
    int? triesNumber,
    int? triesCounter,
    int? elapsedTime,
    bool? isCompleted,
    bool? lastCheckedAnswerResult,
    bool? shouldCheckAnAnswer,
    int? currentHintCounter,
    DateTime? creationAt,
    DateTime? lastModificationAt,
  }) => Session(
    id: id ?? this.id,
    fieldListId: fieldListId ?? this.fieldListId,
    currentQuestionCounter:
        currentQuestionCounter ?? this.currentQuestionCounter,
    triesNumber: triesNumber ?? this.triesNumber,
    triesCounter: triesCounter ?? this.triesCounter,
    elapsedTime: elapsedTime ?? this.elapsedTime,
    isCompleted: isCompleted ?? this.isCompleted,
    lastCheckedAnswerResult:
        lastCheckedAnswerResult ?? this.lastCheckedAnswerResult,
    shouldCheckAnAnswer: shouldCheckAnAnswer ?? this.shouldCheckAnAnswer,
    currentHintCounter: currentHintCounter ?? this.currentHintCounter,
    creationAt: creationAt ?? this.creationAt,
    lastModificationAt: lastModificationAt ?? this.lastModificationAt,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      fieldListId: data.fieldListId.present
          ? data.fieldListId.value
          : this.fieldListId,
      currentQuestionCounter: data.currentQuestionCounter.present
          ? data.currentQuestionCounter.value
          : this.currentQuestionCounter,
      triesNumber: data.triesNumber.present
          ? data.triesNumber.value
          : this.triesNumber,
      triesCounter: data.triesCounter.present
          ? data.triesCounter.value
          : this.triesCounter,
      elapsedTime: data.elapsedTime.present
          ? data.elapsedTime.value
          : this.elapsedTime,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      lastCheckedAnswerResult: data.lastCheckedAnswerResult.present
          ? data.lastCheckedAnswerResult.value
          : this.lastCheckedAnswerResult,
      shouldCheckAnAnswer: data.shouldCheckAnAnswer.present
          ? data.shouldCheckAnAnswer.value
          : this.shouldCheckAnAnswer,
      currentHintCounter: data.currentHintCounter.present
          ? data.currentHintCounter.value
          : this.currentHintCounter,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
      lastModificationAt: data.lastModificationAt.present
          ? data.lastModificationAt.value
          : this.lastModificationAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('currentQuestionCounter: $currentQuestionCounter, ')
          ..write('triesNumber: $triesNumber, ')
          ..write('triesCounter: $triesCounter, ')
          ..write('elapsedTime: $elapsedTime, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastCheckedAnswerResult: $lastCheckedAnswerResult, ')
          ..write('shouldCheckAnAnswer: $shouldCheckAnAnswer, ')
          ..write('currentHintCounter: $currentHintCounter, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fieldListId,
    currentQuestionCounter,
    triesNumber,
    triesCounter,
    elapsedTime,
    isCompleted,
    lastCheckedAnswerResult,
    shouldCheckAnAnswer,
    currentHintCounter,
    creationAt,
    lastModificationAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.fieldListId == this.fieldListId &&
          other.currentQuestionCounter == this.currentQuestionCounter &&
          other.triesNumber == this.triesNumber &&
          other.triesCounter == this.triesCounter &&
          other.elapsedTime == this.elapsedTime &&
          other.isCompleted == this.isCompleted &&
          other.lastCheckedAnswerResult == this.lastCheckedAnswerResult &&
          other.shouldCheckAnAnswer == this.shouldCheckAnAnswer &&
          other.currentHintCounter == this.currentHintCounter &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> fieldListId;
  final Value<int> currentQuestionCounter;
  final Value<int> triesNumber;
  final Value<int> triesCounter;
  final Value<int> elapsedTime;
  final Value<bool> isCompleted;
  final Value<bool> lastCheckedAnswerResult;
  final Value<bool> shouldCheckAnAnswer;
  final Value<int> currentHintCounter;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.fieldListId = const Value.absent(),
    this.currentQuestionCounter = const Value.absent(),
    this.triesNumber = const Value.absent(),
    this.triesCounter = const Value.absent(),
    this.elapsedTime = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.lastCheckedAnswerResult = const Value.absent(),
    this.shouldCheckAnAnswer = const Value.absent(),
    this.currentHintCounter = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required String fieldListId,
    required int currentQuestionCounter,
    required int triesNumber,
    this.triesCounter = const Value.absent(),
    required int elapsedTime,
    this.isCompleted = const Value.absent(),
    this.lastCheckedAnswerResult = const Value.absent(),
    this.shouldCheckAnAnswer = const Value.absent(),
    this.currentHintCounter = const Value.absent(),
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.rowid = const Value.absent(),
  }) : fieldListId = Value(fieldListId),
       currentQuestionCounter = Value(currentQuestionCounter),
       triesNumber = Value(triesNumber),
       elapsedTime = Value(elapsedTime),
       creationAt = Value(creationAt),
       lastModificationAt = Value(lastModificationAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? fieldListId,
    Expression<int>? currentQuestionCounter,
    Expression<int>? triesNumber,
    Expression<int>? triesCounter,
    Expression<int>? elapsedTime,
    Expression<bool>? isCompleted,
    Expression<bool>? lastCheckedAnswerResult,
    Expression<bool>? shouldCheckAnAnswer,
    Expression<int>? currentHintCounter,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldListId != null) 'field_list_id': fieldListId,
      if (currentQuestionCounter != null)
        'current_question_counter': currentQuestionCounter,
      if (triesNumber != null) 'tries_number': triesNumber,
      if (triesCounter != null) 'tries_counter': triesCounter,
      if (elapsedTime != null) 'elapsed_time': elapsedTime,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (lastCheckedAnswerResult != null)
        'last_checked_answer_result': lastCheckedAnswerResult,
      if (shouldCheckAnAnswer != null)
        'should_check_an_answer': shouldCheckAnAnswer,
      if (currentHintCounter != null)
        'current_hint_counter': currentHintCounter,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldListId,
    Value<int>? currentQuestionCounter,
    Value<int>? triesNumber,
    Value<int>? triesCounter,
    Value<int>? elapsedTime,
    Value<bool>? isCompleted,
    Value<bool>? lastCheckedAnswerResult,
    Value<bool>? shouldCheckAnAnswer,
    Value<int>? currentHintCounter,
    Value<DateTime>? creationAt,
    Value<DateTime>? lastModificationAt,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      fieldListId: fieldListId ?? this.fieldListId,
      currentQuestionCounter:
          currentQuestionCounter ?? this.currentQuestionCounter,
      triesNumber: triesNumber ?? this.triesNumber,
      triesCounter: triesCounter ?? this.triesCounter,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isCompleted: isCompleted ?? this.isCompleted,
      lastCheckedAnswerResult:
          lastCheckedAnswerResult ?? this.lastCheckedAnswerResult,
      shouldCheckAnAnswer: shouldCheckAnAnswer ?? this.shouldCheckAnAnswer,
      currentHintCounter: currentHintCounter ?? this.currentHintCounter,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldListId.present) {
      map['field_list_id'] = Variable<String>(fieldListId.value);
    }
    if (currentQuestionCounter.present) {
      map['current_question_counter'] = Variable<int>(
        currentQuestionCounter.value,
      );
    }
    if (triesNumber.present) {
      map['tries_number'] = Variable<int>(triesNumber.value);
    }
    if (triesCounter.present) {
      map['tries_counter'] = Variable<int>(triesCounter.value);
    }
    if (elapsedTime.present) {
      map['elapsed_time'] = Variable<int>(elapsedTime.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (lastCheckedAnswerResult.present) {
      map['last_checked_answer_result'] = Variable<bool>(
        lastCheckedAnswerResult.value,
      );
    }
    if (shouldCheckAnAnswer.present) {
      map['should_check_an_answer'] = Variable<bool>(shouldCheckAnAnswer.value);
    }
    if (currentHintCounter.present) {
      map['current_hint_counter'] = Variable<int>(currentHintCounter.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] = Variable<DateTime>(
        lastModificationAt.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('currentQuestionCounter: $currentQuestionCounter, ')
          ..write('triesNumber: $triesNumber, ')
          ..write('triesCounter: $triesCounter, ')
          ..write('elapsedTime: $elapsedTime, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastCheckedAnswerResult: $lastCheckedAnswerResult, ')
          ..write('shouldCheckAnAnswer: $shouldCheckAnAnswer, ')
          ..write('currentHintCounter: $currentHintCounter, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionEntrysTable extends SessionEntrys
    with TableInfo<$SessionEntrysTable, SessionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionEntrysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entrys (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sessionId, entryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_entrys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, entryId};
  @override
  SessionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionEntry(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
    );
  }

  @override
  $SessionEntrysTable createAlias(String alias) {
    return $SessionEntrysTable(attachedDatabase, alias);
  }
}

class SessionEntry extends DataClass implements Insertable<SessionEntry> {
  final String sessionId;
  final String entryId;
  const SessionEntry({required this.sessionId, required this.entryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['entry_id'] = Variable<String>(entryId);
    return map;
  }

  SessionEntrysCompanion toCompanion(bool nullToAbsent) {
    return SessionEntrysCompanion(
      sessionId: Value(sessionId),
      entryId: Value(entryId),
    );
  }

  factory SessionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionEntry(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      entryId: serializer.fromJson<String>(json['entryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'entryId': serializer.toJson<String>(entryId),
    };
  }

  SessionEntry copyWith({String? sessionId, String? entryId}) => SessionEntry(
    sessionId: sessionId ?? this.sessionId,
    entryId: entryId ?? this.entryId,
  );
  SessionEntry copyWithCompanion(SessionEntrysCompanion data) {
    return SessionEntry(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionEntry(')
          ..write('sessionId: $sessionId, ')
          ..write('entryId: $entryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionId, entryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionEntry &&
          other.sessionId == this.sessionId &&
          other.entryId == this.entryId);
}

class SessionEntrysCompanion extends UpdateCompanion<SessionEntry> {
  final Value<String> sessionId;
  final Value<String> entryId;
  final Value<int> rowid;
  const SessionEntrysCompanion({
    this.sessionId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionEntrysCompanion.insert({
    required String sessionId,
    required String entryId,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       entryId = Value(entryId);
  static Insertable<SessionEntry> custom({
    Expression<String>? sessionId,
    Expression<String>? entryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (entryId != null) 'entry_id': entryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionEntrysCompanion copyWith({
    Value<String>? sessionId,
    Value<String>? entryId,
    Value<int>? rowid,
  }) {
    return SessionEntrysCompanion(
      sessionId: sessionId ?? this.sessionId,
      entryId: entryId ?? this.entryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionEntrysCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('entryId: $entryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TestSessionsTable extends TestSessions
    with TableInfo<$TestSessionsTable, TestSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _wrongAnswerCounterMeta =
      const VerificationMeta('wrongAnswerCounter');
  @override
  late final GeneratedColumn<int> wrongAnswerCounter = GeneratedColumn<int>(
    'wrong_answer_counter',
    aliasedName,
    false,
    check: () =>
        ComparableExpr(
          wrongAnswerCounter,
        ).isBiggerOrEqualValue(TestSessions.MINIMUM_WRONG_ANSWER_COUNTER) &
        ComparableExpr(
          wrongAnswerCounter,
        ).isSmallerOrEqualValue(TestSessions.MAXIMUM_WRONG_ANSWER_COUNTER),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _lastAnswerMeta = const VerificationMeta(
    'lastAnswer',
  );
  @override
  late final GeneratedColumn<String> lastAnswer = GeneratedColumn<String>(
    'last_answer',
    aliasedName,
    true,
    check: () => ComparableExpr(
      StringExpressionOperators(lastAnswer).trim().length,
    ).isBiggerOrEqualValue(TestSessions.MINIMUM_LAST_ANSWER),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    wrongAnswerCounter,
    lastAnswer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('wrong_answer_counter')) {
      context.handle(
        _wrongAnswerCounterMeta,
        wrongAnswerCounter.isAcceptableOrUnknown(
          data['wrong_answer_counter']!,
          _wrongAnswerCounterMeta,
        ),
      );
    }
    if (data.containsKey('last_answer')) {
      context.handle(
        _lastAnswerMeta,
        lastAnswer.isAcceptableOrUnknown(data['last_answer']!, _lastAnswerMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId};
  @override
  TestSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestSession(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      wrongAnswerCounter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_answer_counter'],
      )!,
      lastAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_answer'],
      ),
    );
  }

  @override
  $TestSessionsTable createAlias(String alias) {
    return $TestSessionsTable(attachedDatabase, alias);
  }
}

class TestSession extends DataClass implements Insertable<TestSession> {
  final String sessionId;
  final int wrongAnswerCounter;
  final String? lastAnswer;
  const TestSession({
    required this.sessionId,
    required this.wrongAnswerCounter,
    this.lastAnswer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['wrong_answer_counter'] = Variable<int>(wrongAnswerCounter);
    if (!nullToAbsent || lastAnswer != null) {
      map['last_answer'] = Variable<String>(lastAnswer);
    }
    return map;
  }

  TestSessionsCompanion toCompanion(bool nullToAbsent) {
    return TestSessionsCompanion(
      sessionId: Value(sessionId),
      wrongAnswerCounter: Value(wrongAnswerCounter),
      lastAnswer: lastAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAnswer),
    );
  }

  factory TestSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestSession(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      wrongAnswerCounter: serializer.fromJson<int>(json['wrongAnswerCounter']),
      lastAnswer: serializer.fromJson<String?>(json['lastAnswer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'wrongAnswerCounter': serializer.toJson<int>(wrongAnswerCounter),
      'lastAnswer': serializer.toJson<String?>(lastAnswer),
    };
  }

  TestSession copyWith({
    String? sessionId,
    int? wrongAnswerCounter,
    Value<String?> lastAnswer = const Value.absent(),
  }) => TestSession(
    sessionId: sessionId ?? this.sessionId,
    wrongAnswerCounter: wrongAnswerCounter ?? this.wrongAnswerCounter,
    lastAnswer: lastAnswer.present ? lastAnswer.value : this.lastAnswer,
  );
  TestSession copyWithCompanion(TestSessionsCompanion data) {
    return TestSession(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      wrongAnswerCounter: data.wrongAnswerCounter.present
          ? data.wrongAnswerCounter.value
          : this.wrongAnswerCounter,
      lastAnswer: data.lastAnswer.present
          ? data.lastAnswer.value
          : this.lastAnswer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestSession(')
          ..write('sessionId: $sessionId, ')
          ..write('wrongAnswerCounter: $wrongAnswerCounter, ')
          ..write('lastAnswer: $lastAnswer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionId, wrongAnswerCounter, lastAnswer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestSession &&
          other.sessionId == this.sessionId &&
          other.wrongAnswerCounter == this.wrongAnswerCounter &&
          other.lastAnswer == this.lastAnswer);
}

class TestSessionsCompanion extends UpdateCompanion<TestSession> {
  final Value<String> sessionId;
  final Value<int> wrongAnswerCounter;
  final Value<String?> lastAnswer;
  final Value<int> rowid;
  const TestSessionsCompanion({
    this.sessionId = const Value.absent(),
    this.wrongAnswerCounter = const Value.absent(),
    this.lastAnswer = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TestSessionsCompanion.insert({
    required String sessionId,
    this.wrongAnswerCounter = const Value.absent(),
    this.lastAnswer = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId);
  static Insertable<TestSession> custom({
    Expression<String>? sessionId,
    Expression<int>? wrongAnswerCounter,
    Expression<String>? lastAnswer,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (wrongAnswerCounter != null)
        'wrong_answer_counter': wrongAnswerCounter,
      if (lastAnswer != null) 'last_answer': lastAnswer,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TestSessionsCompanion copyWith({
    Value<String>? sessionId,
    Value<int>? wrongAnswerCounter,
    Value<String?>? lastAnswer,
    Value<int>? rowid,
  }) {
    return TestSessionsCompanion(
      sessionId: sessionId ?? this.sessionId,
      wrongAnswerCounter: wrongAnswerCounter ?? this.wrongAnswerCounter,
      lastAnswer: lastAnswer ?? this.lastAnswer,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (wrongAnswerCounter.present) {
      map['wrong_answer_counter'] = Variable<int>(wrongAnswerCounter.value);
    }
    if (lastAnswer.present) {
      map['last_answer'] = Variable<String>(lastAnswer.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestSessionsCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('wrongAnswerCounter: $wrongAnswerCounter, ')
          ..write('lastAnswer: $lastAnswer, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WrongAnswersTable extends WrongAnswers
    with TableInfo<$WrongAnswersTable, WrongAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WrongAnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entrys (id)',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    check: () => ComparableExpr(
      StringExpressionOperators(value).trim().length,
    ).isBiggerOrEqualValue(WrongAnswers.MINIMUM_VALUE_LENGTH),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationAtMeta = const VerificationMeta(
    'creationAt',
  );
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
    'creation_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    entryId,
    value,
    creationAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wrong_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<WrongAnswer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
        _creationAtMeta,
        creationAt.isAcceptableOrUnknown(data['creation_at']!, _creationAtMeta),
      );
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WrongAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WrongAnswer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      creationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_at'],
      )!,
    );
  }

  @override
  $WrongAnswersTable createAlias(String alias) {
    return $WrongAnswersTable(attachedDatabase, alias);
  }
}

class WrongAnswer extends DataClass implements Insertable<WrongAnswer> {
  final String id;
  final String sessionId;
  final String entryId;
  final String value;
  final DateTime creationAt;
  const WrongAnswer({
    required this.id,
    required this.sessionId,
    required this.entryId,
    required this.value,
    required this.creationAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['entry_id'] = Variable<String>(entryId);
    map['value'] = Variable<String>(value);
    map['creation_at'] = Variable<DateTime>(creationAt);
    return map;
  }

  WrongAnswersCompanion toCompanion(bool nullToAbsent) {
    return WrongAnswersCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      entryId: Value(entryId),
      value: Value(value),
      creationAt: Value(creationAt),
    );
  }

  factory WrongAnswer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WrongAnswer(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      entryId: serializer.fromJson<String>(json['entryId']),
      value: serializer.fromJson<String>(json['value']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'entryId': serializer.toJson<String>(entryId),
      'value': serializer.toJson<String>(value),
      'creationAt': serializer.toJson<DateTime>(creationAt),
    };
  }

  WrongAnswer copyWith({
    String? id,
    String? sessionId,
    String? entryId,
    String? value,
    DateTime? creationAt,
  }) => WrongAnswer(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    entryId: entryId ?? this.entryId,
    value: value ?? this.value,
    creationAt: creationAt ?? this.creationAt,
  );
  WrongAnswer copyWithCompanion(WrongAnswersCompanion data) {
    return WrongAnswer(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      value: data.value.present ? data.value.value : this.value,
      creationAt: data.creationAt.present
          ? data.creationAt.value
          : this.creationAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WrongAnswer(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('entryId: $entryId, ')
          ..write('value: $value, ')
          ..write('creationAt: $creationAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, entryId, value, creationAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswer &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.entryId == this.entryId &&
          other.value == this.value &&
          other.creationAt == this.creationAt);
}

class WrongAnswersCompanion extends UpdateCompanion<WrongAnswer> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> entryId;
  final Value<String> value;
  final Value<DateTime> creationAt;
  final Value<int> rowid;
  const WrongAnswersCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.value = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WrongAnswersCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required String entryId,
    required String value,
    required DateTime creationAt,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       entryId = Value(entryId),
       value = Value(value),
       creationAt = Value(creationAt);
  static Insertable<WrongAnswer> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? entryId,
    Expression<String>? value,
    Expression<DateTime>? creationAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (entryId != null) 'entry_id': entryId,
      if (value != null) 'value': value,
      if (creationAt != null) 'creation_at': creationAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WrongAnswersCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? entryId,
    Value<String>? value,
    Value<DateTime>? creationAt,
    Value<int>? rowid,
  }) {
    return WrongAnswersCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      entryId: entryId ?? this.entryId,
      value: value ?? this.value,
      creationAt: creationAt ?? this.creationAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WrongAnswersCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('entryId: $entryId, ')
          ..write('value: $value, ')
          ..write('creationAt: $creationAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FieldsTable fields = $FieldsTable(this);
  late final $FieldListsTable fieldLists = $FieldListsTable(this);
  late final $EntrysTable entrys = $EntrysTable(this);
  late final $FieldNotesTable fieldNotes = $FieldNotesTable(this);
  late final $FieldListNotesTable fieldListNotes = $FieldListNotesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionEntrysTable sessionEntrys = $SessionEntrysTable(this);
  late final $TestSessionsTable testSessions = $TestSessionsTable(this);
  late final $WrongAnswersTable wrongAnswers = $WrongAnswersTable(this);
  late final EntrysDao entrysDao = EntrysDao(this as AppDatabase);
  late final FieldListsDao fieldListsDao = FieldListsDao(this as AppDatabase);
  late final FieldsDao fieldsDao = FieldsDao(this as AppDatabase);
  late final FieldNotesDao fieldNotesDao = FieldNotesDao(this as AppDatabase);
  late final FieldListNotesDao fieldListNotesDao = FieldListNotesDao(
    this as AppDatabase,
  );
  late final SessionsDao sessionsDao = SessionsDao(this as AppDatabase);
  late final SessionEntrysDao sessionEntrysDao = SessionEntrysDao(
    this as AppDatabase,
  );
  late final TestSessionsDao testSessionsDao = TestSessionsDao(
    this as AppDatabase,
  );
  late final WrongAnswersDao wrongAnswersDao = WrongAnswersDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    fields,
    fieldLists,
    entrys,
    fieldNotes,
    fieldListNotes,
    sessions,
    sessionEntrys,
    testSessions,
    wrongAnswers,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$FieldsTableCreateCompanionBuilder =
    FieldsCompanion Function({
      Value<String> id,
      required String userAccountId,
      required String name,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      Value<int> usageCount,
      Value<int> color,
      Value<int> rowid,
    });
typedef $$FieldsTableUpdateCompanionBuilder =
    FieldsCompanion Function({
      Value<String> id,
      Value<String> userAccountId,
      Value<String> name,
      Value<DateTime> creationAt,
      Value<DateTime> lastModificationAt,
      Value<int> usageCount,
      Value<int> color,
      Value<int> rowid,
    });

final class $$FieldsTableReferences
    extends BaseReferences<_$AppDatabase, $FieldsTable, Field> {
  $$FieldsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FieldListsTable, List<FieldList>>
  _fieldListsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fieldLists,
    aliasName: $_aliasNameGenerator(db.fields.id, db.fieldLists.fieldId),
  );

  $$FieldListsTableProcessedTableManager get fieldListsRefs {
    final manager = $$FieldListsTableTableManager(
      $_db,
      $_db.fieldLists,
    ).filter((f) => f.fieldId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fieldListsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FieldNotesTable, List<FieldNote>>
  _fieldNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fieldNotes,
    aliasName: $_aliasNameGenerator(db.fields.id, db.fieldNotes.fieldId),
  );

  $$FieldNotesTableProcessedTableManager get fieldNotesRefs {
    final manager = $$FieldNotesTableTableManager(
      $_db,
      $_db.fieldNotes,
    ).filter((f) => f.fieldId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fieldNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FieldsTableFilterComposer
    extends Composer<_$AppDatabase, $FieldsTable> {
  $$FieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userAccountId => $composableBuilder(
    column: $table.userAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> fieldListsRefs(
    Expression<bool> Function($$FieldListsTableFilterComposer f) f,
  ) {
    final $$FieldListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.fieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableFilterComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fieldNotesRefs(
    Expression<bool> Function($$FieldNotesTableFilterComposer f) f,
  ) {
    final $$FieldNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fieldNotes,
      getReferencedColumn: (t) => t.fieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldNotesTableFilterComposer(
            $db: $db,
            $table: $db.fieldNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldsTable> {
  $$FieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userAccountId => $composableBuilder(
    column: $table.userAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldsTable> {
  $$FieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userAccountId => $composableBuilder(
    column: $table.userAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  Expression<T> fieldListsRefs<T extends Object>(
    Expression<T> Function($$FieldListsTableAnnotationComposer a) f,
  ) {
    final $$FieldListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.fieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableAnnotationComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fieldNotesRefs<T extends Object>(
    Expression<T> Function($$FieldNotesTableAnnotationComposer a) f,
  ) {
    final $$FieldNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fieldNotes,
      getReferencedColumn: (t) => t.fieldId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.fieldNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FieldsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldsTable,
          Field,
          $$FieldsTableFilterComposer,
          $$FieldsTableOrderingComposer,
          $$FieldsTableAnnotationComposer,
          $$FieldsTableCreateCompanionBuilder,
          $$FieldsTableUpdateCompanionBuilder,
          (Field, $$FieldsTableReferences),
          Field,
          PrefetchHooks Function({bool fieldListsRefs, bool fieldNotesRefs})
        > {
  $$FieldsTableTableManager(_$AppDatabase db, $FieldsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userAccountId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<DateTime> lastModificationAt = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldsCompanion(
                id: id,
                userAccountId: userAccountId,
                name: name,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                usageCount: usageCount,
                color: color,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String userAccountId,
                required String name,
                required DateTime creationAt,
                required DateTime lastModificationAt,
                Value<int> usageCount = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldsCompanion.insert(
                id: id,
                userAccountId: userAccountId,
                name: name,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                usageCount: usageCount,
                color: color,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FieldsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({fieldListsRefs = false, fieldNotesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fieldListsRefs) db.fieldLists,
                    if (fieldNotesRefs) db.fieldNotes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fieldListsRefs)
                        await $_getPrefetchedData<
                          Field,
                          $FieldsTable,
                          FieldList
                        >(
                          currentTable: table,
                          referencedTable: $$FieldsTableReferences
                              ._fieldListsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FieldsTableReferences(
                                db,
                                table,
                                p0,
                              ).fieldListsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fieldId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fieldNotesRefs)
                        await $_getPrefetchedData<
                          Field,
                          $FieldsTable,
                          FieldNote
                        >(
                          currentTable: table,
                          referencedTable: $$FieldsTableReferences
                              ._fieldNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FieldsTableReferences(
                                db,
                                table,
                                p0,
                              ).fieldNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fieldId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldsTable,
      Field,
      $$FieldsTableFilterComposer,
      $$FieldsTableOrderingComposer,
      $$FieldsTableAnnotationComposer,
      $$FieldsTableCreateCompanionBuilder,
      $$FieldsTableUpdateCompanionBuilder,
      (Field, $$FieldsTableReferences),
      Field,
      PrefetchHooks Function({bool fieldListsRefs, bool fieldNotesRefs})
    >;
typedef $$FieldListsTableCreateCompanionBuilder =
    FieldListsCompanion Function({
      Value<String> id,
      required String fieldId,
      required String name,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      Value<String?> languageTag,
      Value<int> checkType,
      Value<int> sortBy,
      Value<bool> doesReadAnswer,
      Value<int> usageCount,
      Value<int> color,
      Value<int?> emulationNumberOfQuestions,
      Value<String?> emulationDays,
      Value<int?> testsReadingQuestionLetterDuration,
      Value<int?> testsFindingAnswerDuration,
      Value<int?> testsTypingAnswerLetterDuration,
      Value<int?> studyTillCorrectReadingQuestionLetterDuration,
      Value<int?> studyTillCorrectFindingAnswerDuration,
      Value<int?> studyTillCorrectTypingAnswerLetterDuration,
      Value<int> testsTimeOfAnswerAction,
      Value<bool> doesObfuscateQuestion,
      Value<int> rowid,
    });
typedef $$FieldListsTableUpdateCompanionBuilder =
    FieldListsCompanion Function({
      Value<String> id,
      Value<String> fieldId,
      Value<String> name,
      Value<DateTime> creationAt,
      Value<DateTime> lastModificationAt,
      Value<String?> languageTag,
      Value<int> checkType,
      Value<int> sortBy,
      Value<bool> doesReadAnswer,
      Value<int> usageCount,
      Value<int> color,
      Value<int?> emulationNumberOfQuestions,
      Value<String?> emulationDays,
      Value<int?> testsReadingQuestionLetterDuration,
      Value<int?> testsFindingAnswerDuration,
      Value<int?> testsTypingAnswerLetterDuration,
      Value<int?> studyTillCorrectReadingQuestionLetterDuration,
      Value<int?> studyTillCorrectFindingAnswerDuration,
      Value<int?> studyTillCorrectTypingAnswerLetterDuration,
      Value<int> testsTimeOfAnswerAction,
      Value<bool> doesObfuscateQuestion,
      Value<int> rowid,
    });

final class $$FieldListsTableReferences
    extends BaseReferences<_$AppDatabase, $FieldListsTable, FieldList> {
  $$FieldListsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FieldsTable _fieldIdTable(_$AppDatabase db) => db.fields.createAlias(
    $_aliasNameGenerator(db.fieldLists.fieldId, db.fields.id),
  );

  $$FieldsTableProcessedTableManager get fieldId {
    final $_column = $_itemColumn<String>('field_id')!;

    final manager = $$FieldsTableTableManager(
      $_db,
      $_db.fields,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EntrysTable, List<Entry>> _entrysRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.entrys,
    aliasName: $_aliasNameGenerator(db.fieldLists.id, db.entrys.fieldListId),
  );

  $$EntrysTableProcessedTableManager get entrysRefs {
    final manager = $$EntrysTableTableManager(
      $_db,
      $_db.entrys,
    ).filter((f) => f.fieldListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entrysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FieldListNotesTable, List<FieldListNote>>
  _fieldListNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fieldListNotes,
    aliasName: $_aliasNameGenerator(
      db.fieldLists.id,
      db.fieldListNotes.fieldListId,
    ),
  );

  $$FieldListNotesTableProcessedTableManager get fieldListNotesRefs {
    final manager = $$FieldListNotesTableTableManager(
      $_db,
      $_db.fieldListNotes,
    ).filter((f) => f.fieldListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fieldListNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(db.fieldLists.id, db.sessions.fieldListId),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.fieldListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FieldListsTableFilterComposer
    extends Composer<_$AppDatabase, $FieldListsTable> {
  $$FieldListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageTag => $composableBuilder(
    column: $table.languageTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkType => $composableBuilder(
    column: $table.checkType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortBy => $composableBuilder(
    column: $table.sortBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get doesReadAnswer => $composableBuilder(
    column: $table.doesReadAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get emulationNumberOfQuestions => $composableBuilder(
    column: $table.emulationNumberOfQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emulationDays => $composableBuilder(
    column: $table.emulationDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get testsReadingQuestionLetterDuration =>
      $composableBuilder(
        column: $table.testsReadingQuestionLetterDuration,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get testsFindingAnswerDuration => $composableBuilder(
    column: $table.testsFindingAnswerDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get testsTypingAnswerLetterDuration => $composableBuilder(
    column: $table.testsTypingAnswerLetterDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studyTillCorrectReadingQuestionLetterDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectReadingQuestionLetterDuration,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get studyTillCorrectFindingAnswerDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectFindingAnswerDuration,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get studyTillCorrectTypingAnswerLetterDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectTypingAnswerLetterDuration,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get testsTimeOfAnswerAction => $composableBuilder(
    column: $table.testsTimeOfAnswerAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get doesObfuscateQuestion => $composableBuilder(
    column: $table.doesObfuscateQuestion,
    builder: (column) => ColumnFilters(column),
  );

  $$FieldsTableFilterComposer get fieldId {
    final $$FieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.fields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldsTableFilterComposer(
            $db: $db,
            $table: $db.fields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> entrysRefs(
    Expression<bool> Function($$EntrysTableFilterComposer f) f,
  ) {
    final $$EntrysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.fieldListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableFilterComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fieldListNotesRefs(
    Expression<bool> Function($$FieldListNotesTableFilterComposer f) f,
  ) {
    final $$FieldListNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fieldListNotes,
      getReferencedColumn: (t) => t.fieldListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListNotesTableFilterComposer(
            $db: $db,
            $table: $db.fieldListNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.fieldListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FieldListsTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldListsTable> {
  $$FieldListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageTag => $composableBuilder(
    column: $table.languageTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkType => $composableBuilder(
    column: $table.checkType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortBy => $composableBuilder(
    column: $table.sortBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get doesReadAnswer => $composableBuilder(
    column: $table.doesReadAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get emulationNumberOfQuestions => $composableBuilder(
    column: $table.emulationNumberOfQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emulationDays => $composableBuilder(
    column: $table.emulationDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get testsReadingQuestionLetterDuration =>
      $composableBuilder(
        column: $table.testsReadingQuestionLetterDuration,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get testsFindingAnswerDuration => $composableBuilder(
    column: $table.testsFindingAnswerDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get testsTypingAnswerLetterDuration =>
      $composableBuilder(
        column: $table.testsTypingAnswerLetterDuration,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get studyTillCorrectReadingQuestionLetterDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectReadingQuestionLetterDuration,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get studyTillCorrectFindingAnswerDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectFindingAnswerDuration,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get studyTillCorrectTypingAnswerLetterDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectTypingAnswerLetterDuration,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get testsTimeOfAnswerAction => $composableBuilder(
    column: $table.testsTimeOfAnswerAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get doesObfuscateQuestion => $composableBuilder(
    column: $table.doesObfuscateQuestion,
    builder: (column) => ColumnOrderings(column),
  );

  $$FieldsTableOrderingComposer get fieldId {
    final $$FieldsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.fields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldsTableOrderingComposer(
            $db: $db,
            $table: $db.fields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldListsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldListsTable> {
  $$FieldListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageTag => $composableBuilder(
    column: $table.languageTag,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checkType =>
      $composableBuilder(column: $table.checkType, builder: (column) => column);

  GeneratedColumn<int> get sortBy =>
      $composableBuilder(column: $table.sortBy, builder: (column) => column);

  GeneratedColumn<bool> get doesReadAnswer => $composableBuilder(
    column: $table.doesReadAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get emulationNumberOfQuestions => $composableBuilder(
    column: $table.emulationNumberOfQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emulationDays => $composableBuilder(
    column: $table.emulationDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get testsReadingQuestionLetterDuration =>
      $composableBuilder(
        column: $table.testsReadingQuestionLetterDuration,
        builder: (column) => column,
      );

  GeneratedColumn<int> get testsFindingAnswerDuration => $composableBuilder(
    column: $table.testsFindingAnswerDuration,
    builder: (column) => column,
  );

  GeneratedColumn<int> get testsTypingAnswerLetterDuration =>
      $composableBuilder(
        column: $table.testsTypingAnswerLetterDuration,
        builder: (column) => column,
      );

  GeneratedColumn<int> get studyTillCorrectReadingQuestionLetterDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectReadingQuestionLetterDuration,
        builder: (column) => column,
      );

  GeneratedColumn<int> get studyTillCorrectFindingAnswerDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectFindingAnswerDuration,
        builder: (column) => column,
      );

  GeneratedColumn<int> get studyTillCorrectTypingAnswerLetterDuration =>
      $composableBuilder(
        column: $table.studyTillCorrectTypingAnswerLetterDuration,
        builder: (column) => column,
      );

  GeneratedColumn<int> get testsTimeOfAnswerAction => $composableBuilder(
    column: $table.testsTimeOfAnswerAction,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get doesObfuscateQuestion => $composableBuilder(
    column: $table.doesObfuscateQuestion,
    builder: (column) => column,
  );

  $$FieldsTableAnnotationComposer get fieldId {
    final $$FieldsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.fields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldsTableAnnotationComposer(
            $db: $db,
            $table: $db.fields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> entrysRefs<T extends Object>(
    Expression<T> Function($$EntrysTableAnnotationComposer a) f,
  ) {
    final $$EntrysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.fieldListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableAnnotationComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fieldListNotesRefs<T extends Object>(
    Expression<T> Function($$FieldListNotesTableAnnotationComposer a) f,
  ) {
    final $$FieldListNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fieldListNotes,
      getReferencedColumn: (t) => t.fieldListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.fieldListNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.fieldListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FieldListsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldListsTable,
          FieldList,
          $$FieldListsTableFilterComposer,
          $$FieldListsTableOrderingComposer,
          $$FieldListsTableAnnotationComposer,
          $$FieldListsTableCreateCompanionBuilder,
          $$FieldListsTableUpdateCompanionBuilder,
          (FieldList, $$FieldListsTableReferences),
          FieldList,
          PrefetchHooks Function({
            bool fieldId,
            bool entrysRefs,
            bool fieldListNotesRefs,
            bool sessionsRefs,
          })
        > {
  $$FieldListsTableTableManager(_$AppDatabase db, $FieldListsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<DateTime> lastModificationAt = const Value.absent(),
                Value<String?> languageTag = const Value.absent(),
                Value<int> checkType = const Value.absent(),
                Value<int> sortBy = const Value.absent(),
                Value<bool> doesReadAnswer = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int?> emulationNumberOfQuestions = const Value.absent(),
                Value<String?> emulationDays = const Value.absent(),
                Value<int?> testsReadingQuestionLetterDuration =
                    const Value.absent(),
                Value<int?> testsFindingAnswerDuration = const Value.absent(),
                Value<int?> testsTypingAnswerLetterDuration =
                    const Value.absent(),
                Value<int?> studyTillCorrectReadingQuestionLetterDuration =
                    const Value.absent(),
                Value<int?> studyTillCorrectFindingAnswerDuration =
                    const Value.absent(),
                Value<int?> studyTillCorrectTypingAnswerLetterDuration =
                    const Value.absent(),
                Value<int> testsTimeOfAnswerAction = const Value.absent(),
                Value<bool> doesObfuscateQuestion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldListsCompanion(
                id: id,
                fieldId: fieldId,
                name: name,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                languageTag: languageTag,
                checkType: checkType,
                sortBy: sortBy,
                doesReadAnswer: doesReadAnswer,
                usageCount: usageCount,
                color: color,
                emulationNumberOfQuestions: emulationNumberOfQuestions,
                emulationDays: emulationDays,
                testsReadingQuestionLetterDuration:
                    testsReadingQuestionLetterDuration,
                testsFindingAnswerDuration: testsFindingAnswerDuration,
                testsTypingAnswerLetterDuration:
                    testsTypingAnswerLetterDuration,
                studyTillCorrectReadingQuestionLetterDuration:
                    studyTillCorrectReadingQuestionLetterDuration,
                studyTillCorrectFindingAnswerDuration:
                    studyTillCorrectFindingAnswerDuration,
                studyTillCorrectTypingAnswerLetterDuration:
                    studyTillCorrectTypingAnswerLetterDuration,
                testsTimeOfAnswerAction: testsTimeOfAnswerAction,
                doesObfuscateQuestion: doesObfuscateQuestion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String fieldId,
                required String name,
                required DateTime creationAt,
                required DateTime lastModificationAt,
                Value<String?> languageTag = const Value.absent(),
                Value<int> checkType = const Value.absent(),
                Value<int> sortBy = const Value.absent(),
                Value<bool> doesReadAnswer = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int?> emulationNumberOfQuestions = const Value.absent(),
                Value<String?> emulationDays = const Value.absent(),
                Value<int?> testsReadingQuestionLetterDuration =
                    const Value.absent(),
                Value<int?> testsFindingAnswerDuration = const Value.absent(),
                Value<int?> testsTypingAnswerLetterDuration =
                    const Value.absent(),
                Value<int?> studyTillCorrectReadingQuestionLetterDuration =
                    const Value.absent(),
                Value<int?> studyTillCorrectFindingAnswerDuration =
                    const Value.absent(),
                Value<int?> studyTillCorrectTypingAnswerLetterDuration =
                    const Value.absent(),
                Value<int> testsTimeOfAnswerAction = const Value.absent(),
                Value<bool> doesObfuscateQuestion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldListsCompanion.insert(
                id: id,
                fieldId: fieldId,
                name: name,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                languageTag: languageTag,
                checkType: checkType,
                sortBy: sortBy,
                doesReadAnswer: doesReadAnswer,
                usageCount: usageCount,
                color: color,
                emulationNumberOfQuestions: emulationNumberOfQuestions,
                emulationDays: emulationDays,
                testsReadingQuestionLetterDuration:
                    testsReadingQuestionLetterDuration,
                testsFindingAnswerDuration: testsFindingAnswerDuration,
                testsTypingAnswerLetterDuration:
                    testsTypingAnswerLetterDuration,
                studyTillCorrectReadingQuestionLetterDuration:
                    studyTillCorrectReadingQuestionLetterDuration,
                studyTillCorrectFindingAnswerDuration:
                    studyTillCorrectFindingAnswerDuration,
                studyTillCorrectTypingAnswerLetterDuration:
                    studyTillCorrectTypingAnswerLetterDuration,
                testsTimeOfAnswerAction: testsTimeOfAnswerAction,
                doesObfuscateQuestion: doesObfuscateQuestion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FieldListsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fieldId = false,
                entrysRefs = false,
                fieldListNotesRefs = false,
                sessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (entrysRefs) db.entrys,
                    if (fieldListNotesRefs) db.fieldListNotes,
                    if (sessionsRefs) db.sessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fieldId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fieldId,
                                    referencedTable: $$FieldListsTableReferences
                                        ._fieldIdTable(db),
                                    referencedColumn:
                                        $$FieldListsTableReferences
                                            ._fieldIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (entrysRefs)
                        await $_getPrefetchedData<
                          FieldList,
                          $FieldListsTable,
                          Entry
                        >(
                          currentTable: table,
                          referencedTable: $$FieldListsTableReferences
                              ._entrysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FieldListsTableReferences(
                                db,
                                table,
                                p0,
                              ).entrysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fieldListId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fieldListNotesRefs)
                        await $_getPrefetchedData<
                          FieldList,
                          $FieldListsTable,
                          FieldListNote
                        >(
                          currentTable: table,
                          referencedTable: $$FieldListsTableReferences
                              ._fieldListNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FieldListsTableReferences(
                                db,
                                table,
                                p0,
                              ).fieldListNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fieldListId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sessionsRefs)
                        await $_getPrefetchedData<
                          FieldList,
                          $FieldListsTable,
                          Session
                        >(
                          currentTable: table,
                          referencedTable: $$FieldListsTableReferences
                              ._sessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FieldListsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fieldListId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FieldListsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldListsTable,
      FieldList,
      $$FieldListsTableFilterComposer,
      $$FieldListsTableOrderingComposer,
      $$FieldListsTableAnnotationComposer,
      $$FieldListsTableCreateCompanionBuilder,
      $$FieldListsTableUpdateCompanionBuilder,
      (FieldList, $$FieldListsTableReferences),
      FieldList,
      PrefetchHooks Function({
        bool fieldId,
        bool entrysRefs,
        bool fieldListNotesRefs,
        bool sessionsRefs,
      })
    >;
typedef $$EntrysTableCreateCompanionBuilder =
    EntrysCompanion Function({
      Value<String> id,
      required String fieldListId,
      required String answer,
      required String question,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      Value<int> order,
      Value<bool> didAskedAtCurrentTestRound,
      Value<DateTime?> emulatedCreatedAt,
      Value<int> rank,
      Value<BigInt> askedCount,
      Value<BigInt> wronglyAnsweredCount,
      Value<int> rowid,
    });
typedef $$EntrysTableUpdateCompanionBuilder =
    EntrysCompanion Function({
      Value<String> id,
      Value<String> fieldListId,
      Value<String> answer,
      Value<String> question,
      Value<DateTime> creationAt,
      Value<DateTime> lastModificationAt,
      Value<int> order,
      Value<bool> didAskedAtCurrentTestRound,
      Value<DateTime?> emulatedCreatedAt,
      Value<int> rank,
      Value<BigInt> askedCount,
      Value<BigInt> wronglyAnsweredCount,
      Value<int> rowid,
    });

final class $$EntrysTableReferences
    extends BaseReferences<_$AppDatabase, $EntrysTable, Entry> {
  $$EntrysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FieldListsTable _fieldListIdTable(_$AppDatabase db) =>
      db.fieldLists.createAlias(
        $_aliasNameGenerator(db.entrys.fieldListId, db.fieldLists.id),
      );

  $$FieldListsTableProcessedTableManager get fieldListId {
    final $_column = $_itemColumn<String>('field_list_id')!;

    final manager = $$FieldListsTableTableManager(
      $_db,
      $_db.fieldLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SessionEntrysTable, List<SessionEntry>>
  _sessionEntrysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionEntrys,
    aliasName: $_aliasNameGenerator(db.entrys.id, db.sessionEntrys.entryId),
  );

  $$SessionEntrysTableProcessedTableManager get sessionEntrysRefs {
    final manager = $$SessionEntrysTableTableManager(
      $_db,
      $_db.sessionEntrys,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionEntrysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WrongAnswersTable, List<WrongAnswer>>
  _wrongAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wrongAnswers,
    aliasName: $_aliasNameGenerator(db.entrys.id, db.wrongAnswers.entryId),
  );

  $$WrongAnswersTableProcessedTableManager get wrongAnswersRefs {
    final manager = $$WrongAnswersTableTableManager(
      $_db,
      $_db.wrongAnswers,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_wrongAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntrysTableFilterComposer
    extends Composer<_$AppDatabase, $EntrysTable> {
  $$EntrysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get didAskedAtCurrentTestRound => $composableBuilder(
    column: $table.didAskedAtCurrentTestRound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get emulatedCreatedAt => $composableBuilder(
    column: $table.emulatedCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get askedCount => $composableBuilder(
    column: $table.askedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get wronglyAnsweredCount => $composableBuilder(
    column: $table.wronglyAnsweredCount,
    builder: (column) => ColumnFilters(column),
  );

  $$FieldListsTableFilterComposer get fieldListId {
    final $$FieldListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableFilterComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sessionEntrysRefs(
    Expression<bool> Function($$SessionEntrysTableFilterComposer f) f,
  ) {
    final $$SessionEntrysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionEntrys,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionEntrysTableFilterComposer(
            $db: $db,
            $table: $db.sessionEntrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wrongAnswersRefs(
    Expression<bool> Function($$WrongAnswersTableFilterComposer f) f,
  ) {
    final $$WrongAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wrongAnswers,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WrongAnswersTableFilterComposer(
            $db: $db,
            $table: $db.wrongAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntrysTableOrderingComposer
    extends Composer<_$AppDatabase, $EntrysTable> {
  $$EntrysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get didAskedAtCurrentTestRound => $composableBuilder(
    column: $table.didAskedAtCurrentTestRound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get emulatedCreatedAt => $composableBuilder(
    column: $table.emulatedCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get askedCount => $composableBuilder(
    column: $table.askedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get wronglyAnsweredCount => $composableBuilder(
    column: $table.wronglyAnsweredCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$FieldListsTableOrderingComposer get fieldListId {
    final $$FieldListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableOrderingComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntrysTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntrysTable> {
  $$EntrysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get didAskedAtCurrentTestRound => $composableBuilder(
    column: $table.didAskedAtCurrentTestRound,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get emulatedCreatedAt => $composableBuilder(
    column: $table.emulatedCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<BigInt> get askedCount => $composableBuilder(
    column: $table.askedCount,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get wronglyAnsweredCount => $composableBuilder(
    column: $table.wronglyAnsweredCount,
    builder: (column) => column,
  );

  $$FieldListsTableAnnotationComposer get fieldListId {
    final $$FieldListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableAnnotationComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sessionEntrysRefs<T extends Object>(
    Expression<T> Function($$SessionEntrysTableAnnotationComposer a) f,
  ) {
    final $$SessionEntrysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionEntrys,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionEntrysTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionEntrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wrongAnswersRefs<T extends Object>(
    Expression<T> Function($$WrongAnswersTableAnnotationComposer a) f,
  ) {
    final $$WrongAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wrongAnswers,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WrongAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.wrongAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntrysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntrysTable,
          Entry,
          $$EntrysTableFilterComposer,
          $$EntrysTableOrderingComposer,
          $$EntrysTableAnnotationComposer,
          $$EntrysTableCreateCompanionBuilder,
          $$EntrysTableUpdateCompanionBuilder,
          (Entry, $$EntrysTableReferences),
          Entry,
          PrefetchHooks Function({
            bool fieldListId,
            bool sessionEntrysRefs,
            bool wrongAnswersRefs,
          })
        > {
  $$EntrysTableTableManager(_$AppDatabase db, $EntrysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntrysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntrysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntrysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldListId = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<DateTime> lastModificationAt = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> didAskedAtCurrentTestRound = const Value.absent(),
                Value<DateTime?> emulatedCreatedAt = const Value.absent(),
                Value<int> rank = const Value.absent(),
                Value<BigInt> askedCount = const Value.absent(),
                Value<BigInt> wronglyAnsweredCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntrysCompanion(
                id: id,
                fieldListId: fieldListId,
                answer: answer,
                question: question,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                order: order,
                didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
                emulatedCreatedAt: emulatedCreatedAt,
                rank: rank,
                askedCount: askedCount,
                wronglyAnsweredCount: wronglyAnsweredCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String fieldListId,
                required String answer,
                required String question,
                required DateTime creationAt,
                required DateTime lastModificationAt,
                Value<int> order = const Value.absent(),
                Value<bool> didAskedAtCurrentTestRound = const Value.absent(),
                Value<DateTime?> emulatedCreatedAt = const Value.absent(),
                Value<int> rank = const Value.absent(),
                Value<BigInt> askedCount = const Value.absent(),
                Value<BigInt> wronglyAnsweredCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntrysCompanion.insert(
                id: id,
                fieldListId: fieldListId,
                answer: answer,
                question: question,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                order: order,
                didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
                emulatedCreatedAt: emulatedCreatedAt,
                rank: rank,
                askedCount: askedCount,
                wronglyAnsweredCount: wronglyAnsweredCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EntrysTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fieldListId = false,
                sessionEntrysRefs = false,
                wrongAnswersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionEntrysRefs) db.sessionEntrys,
                    if (wrongAnswersRefs) db.wrongAnswers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fieldListId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fieldListId,
                                    referencedTable: $$EntrysTableReferences
                                        ._fieldListIdTable(db),
                                    referencedColumn: $$EntrysTableReferences
                                        ._fieldListIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionEntrysRefs)
                        await $_getPrefetchedData<
                          Entry,
                          $EntrysTable,
                          SessionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$EntrysTableReferences
                              ._sessionEntrysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntrysTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionEntrysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (wrongAnswersRefs)
                        await $_getPrefetchedData<
                          Entry,
                          $EntrysTable,
                          WrongAnswer
                        >(
                          currentTable: table,
                          referencedTable: $$EntrysTableReferences
                              ._wrongAnswersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntrysTableReferences(
                                db,
                                table,
                                p0,
                              ).wrongAnswersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EntrysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntrysTable,
      Entry,
      $$EntrysTableFilterComposer,
      $$EntrysTableOrderingComposer,
      $$EntrysTableAnnotationComposer,
      $$EntrysTableCreateCompanionBuilder,
      $$EntrysTableUpdateCompanionBuilder,
      (Entry, $$EntrysTableReferences),
      Entry,
      PrefetchHooks Function({
        bool fieldListId,
        bool sessionEntrysRefs,
        bool wrongAnswersRefs,
      })
    >;
typedef $$FieldNotesTableCreateCompanionBuilder =
    FieldNotesCompanion Function({
      Value<String> id,
      required String fieldId,
      required String texT,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      Value<int> rowid,
    });
typedef $$FieldNotesTableUpdateCompanionBuilder =
    FieldNotesCompanion Function({
      Value<String> id,
      Value<String> fieldId,
      Value<String> texT,
      Value<DateTime> creationAt,
      Value<DateTime> lastModificationAt,
      Value<int> rowid,
    });

final class $$FieldNotesTableReferences
    extends BaseReferences<_$AppDatabase, $FieldNotesTable, FieldNote> {
  $$FieldNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FieldsTable _fieldIdTable(_$AppDatabase db) => db.fields.createAlias(
    $_aliasNameGenerator(db.fieldNotes.fieldId, db.fields.id),
  );

  $$FieldsTableProcessedTableManager get fieldId {
    final $_column = $_itemColumn<String>('field_id')!;

    final manager = $$FieldsTableTableManager(
      $_db,
      $_db.fields,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FieldNotesTableFilterComposer
    extends Composer<_$AppDatabase, $FieldNotesTable> {
  $$FieldNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get texT => $composableBuilder(
    column: $table.texT,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FieldsTableFilterComposer get fieldId {
    final $$FieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.fields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldsTableFilterComposer(
            $db: $db,
            $table: $db.fields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldNotesTable> {
  $$FieldNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get texT => $composableBuilder(
    column: $table.texT,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FieldsTableOrderingComposer get fieldId {
    final $$FieldsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.fields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldsTableOrderingComposer(
            $db: $db,
            $table: $db.fields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldNotesTable> {
  $$FieldNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get texT =>
      $composableBuilder(column: $table.texT, builder: (column) => column);

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => column,
  );

  $$FieldsTableAnnotationComposer get fieldId {
    final $$FieldsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldId,
      referencedTable: $db.fields,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldsTableAnnotationComposer(
            $db: $db,
            $table: $db.fields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldNotesTable,
          FieldNote,
          $$FieldNotesTableFilterComposer,
          $$FieldNotesTableOrderingComposer,
          $$FieldNotesTableAnnotationComposer,
          $$FieldNotesTableCreateCompanionBuilder,
          $$FieldNotesTableUpdateCompanionBuilder,
          (FieldNote, $$FieldNotesTableReferences),
          FieldNote,
          PrefetchHooks Function({bool fieldId})
        > {
  $$FieldNotesTableTableManager(_$AppDatabase db, $FieldNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldId = const Value.absent(),
                Value<String> texT = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<DateTime> lastModificationAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldNotesCompanion(
                id: id,
                fieldId: fieldId,
                texT: texT,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String fieldId,
                required String texT,
                required DateTime creationAt,
                required DateTime lastModificationAt,
                Value<int> rowid = const Value.absent(),
              }) => FieldNotesCompanion.insert(
                id: id,
                fieldId: fieldId,
                texT: texT,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FieldNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fieldId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fieldId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fieldId,
                                referencedTable: $$FieldNotesTableReferences
                                    ._fieldIdTable(db),
                                referencedColumn: $$FieldNotesTableReferences
                                    ._fieldIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FieldNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldNotesTable,
      FieldNote,
      $$FieldNotesTableFilterComposer,
      $$FieldNotesTableOrderingComposer,
      $$FieldNotesTableAnnotationComposer,
      $$FieldNotesTableCreateCompanionBuilder,
      $$FieldNotesTableUpdateCompanionBuilder,
      (FieldNote, $$FieldNotesTableReferences),
      FieldNote,
      PrefetchHooks Function({bool fieldId})
    >;
typedef $$FieldListNotesTableCreateCompanionBuilder =
    FieldListNotesCompanion Function({
      Value<String> id,
      required String fieldListId,
      required String texT,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      Value<int> rowid,
    });
typedef $$FieldListNotesTableUpdateCompanionBuilder =
    FieldListNotesCompanion Function({
      Value<String> id,
      Value<String> fieldListId,
      Value<String> texT,
      Value<DateTime> creationAt,
      Value<DateTime> lastModificationAt,
      Value<int> rowid,
    });

final class $$FieldListNotesTableReferences
    extends BaseReferences<_$AppDatabase, $FieldListNotesTable, FieldListNote> {
  $$FieldListNotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FieldListsTable _fieldListIdTable(_$AppDatabase db) =>
      db.fieldLists.createAlias(
        $_aliasNameGenerator(db.fieldListNotes.fieldListId, db.fieldLists.id),
      );

  $$FieldListsTableProcessedTableManager get fieldListId {
    final $_column = $_itemColumn<String>('field_list_id')!;

    final manager = $$FieldListsTableTableManager(
      $_db,
      $_db.fieldLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FieldListNotesTableFilterComposer
    extends Composer<_$AppDatabase, $FieldListNotesTable> {
  $$FieldListNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get texT => $composableBuilder(
    column: $table.texT,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FieldListsTableFilterComposer get fieldListId {
    final $$FieldListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableFilterComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldListNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldListNotesTable> {
  $$FieldListNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get texT => $composableBuilder(
    column: $table.texT,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FieldListsTableOrderingComposer get fieldListId {
    final $$FieldListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableOrderingComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldListNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldListNotesTable> {
  $$FieldListNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get texT =>
      $composableBuilder(column: $table.texT, builder: (column) => column);

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => column,
  );

  $$FieldListsTableAnnotationComposer get fieldListId {
    final $$FieldListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableAnnotationComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FieldListNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldListNotesTable,
          FieldListNote,
          $$FieldListNotesTableFilterComposer,
          $$FieldListNotesTableOrderingComposer,
          $$FieldListNotesTableAnnotationComposer,
          $$FieldListNotesTableCreateCompanionBuilder,
          $$FieldListNotesTableUpdateCompanionBuilder,
          (FieldListNote, $$FieldListNotesTableReferences),
          FieldListNote,
          PrefetchHooks Function({bool fieldListId})
        > {
  $$FieldListNotesTableTableManager(
    _$AppDatabase db,
    $FieldListNotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldListNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldListNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldListNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldListId = const Value.absent(),
                Value<String> texT = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<DateTime> lastModificationAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldListNotesCompanion(
                id: id,
                fieldListId: fieldListId,
                texT: texT,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String fieldListId,
                required String texT,
                required DateTime creationAt,
                required DateTime lastModificationAt,
                Value<int> rowid = const Value.absent(),
              }) => FieldListNotesCompanion.insert(
                id: id,
                fieldListId: fieldListId,
                texT: texT,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FieldListNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fieldListId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fieldListId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fieldListId,
                                referencedTable: $$FieldListNotesTableReferences
                                    ._fieldListIdTable(db),
                                referencedColumn:
                                    $$FieldListNotesTableReferences
                                        ._fieldListIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FieldListNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldListNotesTable,
      FieldListNote,
      $$FieldListNotesTableFilterComposer,
      $$FieldListNotesTableOrderingComposer,
      $$FieldListNotesTableAnnotationComposer,
      $$FieldListNotesTableCreateCompanionBuilder,
      $$FieldListNotesTableUpdateCompanionBuilder,
      (FieldListNote, $$FieldListNotesTableReferences),
      FieldListNote,
      PrefetchHooks Function({bool fieldListId})
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> id,
      required String fieldListId,
      required int currentQuestionCounter,
      required int triesNumber,
      Value<int> triesCounter,
      required int elapsedTime,
      Value<bool> isCompleted,
      Value<bool> lastCheckedAnswerResult,
      Value<bool> shouldCheckAnAnswer,
      Value<int> currentHintCounter,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      Value<int> rowid,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> id,
      Value<String> fieldListId,
      Value<int> currentQuestionCounter,
      Value<int> triesNumber,
      Value<int> triesCounter,
      Value<int> elapsedTime,
      Value<bool> isCompleted,
      Value<bool> lastCheckedAnswerResult,
      Value<bool> shouldCheckAnAnswer,
      Value<int> currentHintCounter,
      Value<DateTime> creationAt,
      Value<DateTime> lastModificationAt,
      Value<int> rowid,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FieldListsTable _fieldListIdTable(_$AppDatabase db) =>
      db.fieldLists.createAlias(
        $_aliasNameGenerator(db.sessions.fieldListId, db.fieldLists.id),
      );

  $$FieldListsTableProcessedTableManager get fieldListId {
    final $_column = $_itemColumn<String>('field_list_id')!;

    final manager = $$FieldListsTableTableManager(
      $_db,
      $_db.fieldLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SessionEntrysTable, List<SessionEntry>>
  _sessionEntrysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionEntrys,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.sessionEntrys.sessionId),
  );

  $$SessionEntrysTableProcessedTableManager get sessionEntrysRefs {
    final manager = $$SessionEntrysTableTableManager(
      $_db,
      $_db.sessionEntrys,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionEntrysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TestSessionsTable, List<TestSession>>
  _testSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testSessions,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.testSessions.sessionId),
  );

  $$TestSessionsTableProcessedTableManager get testSessionsRefs {
    final manager = $$TestSessionsTableTableManager(
      $_db,
      $_db.testSessions,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_testSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WrongAnswersTable, List<WrongAnswer>>
  _wrongAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wrongAnswers,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.wrongAnswers.sessionId),
  );

  $$WrongAnswersTableProcessedTableManager get wrongAnswersRefs {
    final manager = $$WrongAnswersTableTableManager(
      $_db,
      $_db.wrongAnswers,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_wrongAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentQuestionCounter => $composableBuilder(
    column: $table.currentQuestionCounter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get triesNumber => $composableBuilder(
    column: $table.triesNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get triesCounter => $composableBuilder(
    column: $table.triesCounter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedTime => $composableBuilder(
    column: $table.elapsedTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lastCheckedAnswerResult => $composableBuilder(
    column: $table.lastCheckedAnswerResult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get shouldCheckAnAnswer => $composableBuilder(
    column: $table.shouldCheckAnAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentHintCounter => $composableBuilder(
    column: $table.currentHintCounter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FieldListsTableFilterComposer get fieldListId {
    final $$FieldListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableFilterComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sessionEntrysRefs(
    Expression<bool> Function($$SessionEntrysTableFilterComposer f) f,
  ) {
    final $$SessionEntrysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionEntrys,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionEntrysTableFilterComposer(
            $db: $db,
            $table: $db.sessionEntrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> testSessionsRefs(
    Expression<bool> Function($$TestSessionsTableFilterComposer f) f,
  ) {
    final $$TestSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testSessions,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestSessionsTableFilterComposer(
            $db: $db,
            $table: $db.testSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wrongAnswersRefs(
    Expression<bool> Function($$WrongAnswersTableFilterComposer f) f,
  ) {
    final $$WrongAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wrongAnswers,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WrongAnswersTableFilterComposer(
            $db: $db,
            $table: $db.wrongAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentQuestionCounter => $composableBuilder(
    column: $table.currentQuestionCounter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get triesNumber => $composableBuilder(
    column: $table.triesNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get triesCounter => $composableBuilder(
    column: $table.triesCounter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedTime => $composableBuilder(
    column: $table.elapsedTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lastCheckedAnswerResult => $composableBuilder(
    column: $table.lastCheckedAnswerResult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get shouldCheckAnAnswer => $composableBuilder(
    column: $table.shouldCheckAnAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentHintCounter => $composableBuilder(
    column: $table.currentHintCounter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FieldListsTableOrderingComposer get fieldListId {
    final $$FieldListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableOrderingComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentQuestionCounter => $composableBuilder(
    column: $table.currentQuestionCounter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get triesNumber => $composableBuilder(
    column: $table.triesNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get triesCounter => $composableBuilder(
    column: $table.triesCounter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedTime => $composableBuilder(
    column: $table.elapsedTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lastCheckedAnswerResult => $composableBuilder(
    column: $table.lastCheckedAnswerResult,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get shouldCheckAnAnswer => $composableBuilder(
    column: $table.shouldCheckAnAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentHintCounter => $composableBuilder(
    column: $table.currentHintCounter,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModificationAt => $composableBuilder(
    column: $table.lastModificationAt,
    builder: (column) => column,
  );

  $$FieldListsTableAnnotationComposer get fieldListId {
    final $$FieldListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldListId,
      referencedTable: $db.fieldLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldListsTableAnnotationComposer(
            $db: $db,
            $table: $db.fieldLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sessionEntrysRefs<T extends Object>(
    Expression<T> Function($$SessionEntrysTableAnnotationComposer a) f,
  ) {
    final $$SessionEntrysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionEntrys,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionEntrysTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionEntrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> testSessionsRefs<T extends Object>(
    Expression<T> Function($$TestSessionsTableAnnotationComposer a) f,
  ) {
    final $$TestSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testSessions,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.testSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wrongAnswersRefs<T extends Object>(
    Expression<T> Function($$WrongAnswersTableAnnotationComposer a) f,
  ) {
    final $$WrongAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wrongAnswers,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WrongAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.wrongAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({
            bool fieldListId,
            bool sessionEntrysRefs,
            bool testSessionsRefs,
            bool wrongAnswersRefs,
          })
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldListId = const Value.absent(),
                Value<int> currentQuestionCounter = const Value.absent(),
                Value<int> triesNumber = const Value.absent(),
                Value<int> triesCounter = const Value.absent(),
                Value<int> elapsedTime = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> lastCheckedAnswerResult = const Value.absent(),
                Value<bool> shouldCheckAnAnswer = const Value.absent(),
                Value<int> currentHintCounter = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<DateTime> lastModificationAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                fieldListId: fieldListId,
                currentQuestionCounter: currentQuestionCounter,
                triesNumber: triesNumber,
                triesCounter: triesCounter,
                elapsedTime: elapsedTime,
                isCompleted: isCompleted,
                lastCheckedAnswerResult: lastCheckedAnswerResult,
                shouldCheckAnAnswer: shouldCheckAnAnswer,
                currentHintCounter: currentHintCounter,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String fieldListId,
                required int currentQuestionCounter,
                required int triesNumber,
                Value<int> triesCounter = const Value.absent(),
                required int elapsedTime,
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> lastCheckedAnswerResult = const Value.absent(),
                Value<bool> shouldCheckAnAnswer = const Value.absent(),
                Value<int> currentHintCounter = const Value.absent(),
                required DateTime creationAt,
                required DateTime lastModificationAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                fieldListId: fieldListId,
                currentQuestionCounter: currentQuestionCounter,
                triesNumber: triesNumber,
                triesCounter: triesCounter,
                elapsedTime: elapsedTime,
                isCompleted: isCompleted,
                lastCheckedAnswerResult: lastCheckedAnswerResult,
                shouldCheckAnAnswer: shouldCheckAnAnswer,
                currentHintCounter: currentHintCounter,
                creationAt: creationAt,
                lastModificationAt: lastModificationAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fieldListId = false,
                sessionEntrysRefs = false,
                testSessionsRefs = false,
                wrongAnswersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionEntrysRefs) db.sessionEntrys,
                    if (testSessionsRefs) db.testSessions,
                    if (wrongAnswersRefs) db.wrongAnswers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fieldListId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fieldListId,
                                    referencedTable: $$SessionsTableReferences
                                        ._fieldListIdTable(db),
                                    referencedColumn: $$SessionsTableReferences
                                        ._fieldListIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionEntrysRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          SessionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._sessionEntrysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionEntrysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (testSessionsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          TestSession
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._testSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).testSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (wrongAnswersRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          WrongAnswer
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._wrongAnswersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).wrongAnswersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({
        bool fieldListId,
        bool sessionEntrysRefs,
        bool testSessionsRefs,
        bool wrongAnswersRefs,
      })
    >;
typedef $$SessionEntrysTableCreateCompanionBuilder =
    SessionEntrysCompanion Function({
      required String sessionId,
      required String entryId,
      Value<int> rowid,
    });
typedef $$SessionEntrysTableUpdateCompanionBuilder =
    SessionEntrysCompanion Function({
      Value<String> sessionId,
      Value<String> entryId,
      Value<int> rowid,
    });

final class $$SessionEntrysTableReferences
    extends BaseReferences<_$AppDatabase, $SessionEntrysTable, SessionEntry> {
  $$SessionEntrysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.sessionEntrys.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EntrysTable _entryIdTable(_$AppDatabase db) => db.entrys.createAlias(
    $_aliasNameGenerator(db.sessionEntrys.entryId, db.entrys.id),
  );

  $$EntrysTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$EntrysTableTableManager(
      $_db,
      $_db.entrys,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionEntrysTableFilterComposer
    extends Composer<_$AppDatabase, $SessionEntrysTable> {
  $$SessionEntrysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntrysTableFilterComposer get entryId {
    final $$EntrysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableFilterComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionEntrysTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionEntrysTable> {
  $$SessionEntrysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntrysTableOrderingComposer get entryId {
    final $$EntrysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableOrderingComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionEntrysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionEntrysTable> {
  $$SessionEntrysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntrysTableAnnotationComposer get entryId {
    final $$EntrysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableAnnotationComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionEntrysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionEntrysTable,
          SessionEntry,
          $$SessionEntrysTableFilterComposer,
          $$SessionEntrysTableOrderingComposer,
          $$SessionEntrysTableAnnotationComposer,
          $$SessionEntrysTableCreateCompanionBuilder,
          $$SessionEntrysTableUpdateCompanionBuilder,
          (SessionEntry, $$SessionEntrysTableReferences),
          SessionEntry,
          PrefetchHooks Function({bool sessionId, bool entryId})
        > {
  $$SessionEntrysTableTableManager(_$AppDatabase db, $SessionEntrysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionEntrysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionEntrysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionEntrysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionEntrysCompanion(
                sessionId: sessionId,
                entryId: entryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required String entryId,
                Value<int> rowid = const Value.absent(),
              }) => SessionEntrysCompanion.insert(
                sessionId: sessionId,
                entryId: entryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionEntrysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$SessionEntrysTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$SessionEntrysTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$SessionEntrysTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$SessionEntrysTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionEntrysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionEntrysTable,
      SessionEntry,
      $$SessionEntrysTableFilterComposer,
      $$SessionEntrysTableOrderingComposer,
      $$SessionEntrysTableAnnotationComposer,
      $$SessionEntrysTableCreateCompanionBuilder,
      $$SessionEntrysTableUpdateCompanionBuilder,
      (SessionEntry, $$SessionEntrysTableReferences),
      SessionEntry,
      PrefetchHooks Function({bool sessionId, bool entryId})
    >;
typedef $$TestSessionsTableCreateCompanionBuilder =
    TestSessionsCompanion Function({
      required String sessionId,
      Value<int> wrongAnswerCounter,
      Value<String?> lastAnswer,
      Value<int> rowid,
    });
typedef $$TestSessionsTableUpdateCompanionBuilder =
    TestSessionsCompanion Function({
      Value<String> sessionId,
      Value<int> wrongAnswerCounter,
      Value<String?> lastAnswer,
      Value<int> rowid,
    });

final class $$TestSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $TestSessionsTable, TestSession> {
  $$TestSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.testSessions.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TestSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $TestSessionsTable> {
  $$TestSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get wrongAnswerCounter => $composableBuilder(
    column: $table.wrongAnswerCounter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastAnswer => $composableBuilder(
    column: $table.lastAnswer,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TestSessionsTable> {
  $$TestSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get wrongAnswerCounter => $composableBuilder(
    column: $table.wrongAnswerCounter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastAnswer => $composableBuilder(
    column: $table.lastAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestSessionsTable> {
  $$TestSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get wrongAnswerCounter => $composableBuilder(
    column: $table.wrongAnswerCounter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastAnswer => $composableBuilder(
    column: $table.lastAnswer,
    builder: (column) => column,
  );

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TestSessionsTable,
          TestSession,
          $$TestSessionsTableFilterComposer,
          $$TestSessionsTableOrderingComposer,
          $$TestSessionsTableAnnotationComposer,
          $$TestSessionsTableCreateCompanionBuilder,
          $$TestSessionsTableUpdateCompanionBuilder,
          (TestSession, $$TestSessionsTableReferences),
          TestSession,
          PrefetchHooks Function({bool sessionId})
        > {
  $$TestSessionsTableTableManager(_$AppDatabase db, $TestSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<int> wrongAnswerCounter = const Value.absent(),
                Value<String?> lastAnswer = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestSessionsCompanion(
                sessionId: sessionId,
                wrongAnswerCounter: wrongAnswerCounter,
                lastAnswer: lastAnswer,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                Value<int> wrongAnswerCounter = const Value.absent(),
                Value<String?> lastAnswer = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TestSessionsCompanion.insert(
                sessionId: sessionId,
                wrongAnswerCounter: wrongAnswerCounter,
                lastAnswer: lastAnswer,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TestSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$TestSessionsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$TestSessionsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TestSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TestSessionsTable,
      TestSession,
      $$TestSessionsTableFilterComposer,
      $$TestSessionsTableOrderingComposer,
      $$TestSessionsTableAnnotationComposer,
      $$TestSessionsTableCreateCompanionBuilder,
      $$TestSessionsTableUpdateCompanionBuilder,
      (TestSession, $$TestSessionsTableReferences),
      TestSession,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$WrongAnswersTableCreateCompanionBuilder =
    WrongAnswersCompanion Function({
      Value<String> id,
      required String sessionId,
      required String entryId,
      required String value,
      required DateTime creationAt,
      Value<int> rowid,
    });
typedef $$WrongAnswersTableUpdateCompanionBuilder =
    WrongAnswersCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> entryId,
      Value<String> value,
      Value<DateTime> creationAt,
      Value<int> rowid,
    });

final class $$WrongAnswersTableReferences
    extends BaseReferences<_$AppDatabase, $WrongAnswersTable, WrongAnswer> {
  $$WrongAnswersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.wrongAnswers.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EntrysTable _entryIdTable(_$AppDatabase db) => db.entrys.createAlias(
    $_aliasNameGenerator(db.wrongAnswers.entryId, db.entrys.id),
  );

  $$EntrysTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$EntrysTableTableManager(
      $_db,
      $_db.entrys,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WrongAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $WrongAnswersTable> {
  $$WrongAnswersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntrysTableFilterComposer get entryId {
    final $$EntrysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableFilterComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WrongAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $WrongAnswersTable> {
  $$WrongAnswersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntrysTableOrderingComposer get entryId {
    final $$EntrysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableOrderingComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WrongAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WrongAnswersTable> {
  $$WrongAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get creationAt => $composableBuilder(
    column: $table.creationAt,
    builder: (column) => column,
  );

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntrysTableAnnotationComposer get entryId {
    final $$EntrysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entrys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrysTableAnnotationComposer(
            $db: $db,
            $table: $db.entrys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WrongAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WrongAnswersTable,
          WrongAnswer,
          $$WrongAnswersTableFilterComposer,
          $$WrongAnswersTableOrderingComposer,
          $$WrongAnswersTableAnnotationComposer,
          $$WrongAnswersTableCreateCompanionBuilder,
          $$WrongAnswersTableUpdateCompanionBuilder,
          (WrongAnswer, $$WrongAnswersTableReferences),
          WrongAnswer,
          PrefetchHooks Function({bool sessionId, bool entryId})
        > {
  $$WrongAnswersTableTableManager(_$AppDatabase db, $WrongAnswersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WrongAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WrongAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WrongAnswersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> creationAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WrongAnswersCompanion(
                id: id,
                sessionId: sessionId,
                entryId: entryId,
                value: value,
                creationAt: creationAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String sessionId,
                required String entryId,
                required String value,
                required DateTime creationAt,
                Value<int> rowid = const Value.absent(),
              }) => WrongAnswersCompanion.insert(
                id: id,
                sessionId: sessionId,
                entryId: entryId,
                value: value,
                creationAt: creationAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WrongAnswersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$WrongAnswersTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$WrongAnswersTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$WrongAnswersTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$WrongAnswersTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WrongAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WrongAnswersTable,
      WrongAnswer,
      $$WrongAnswersTableFilterComposer,
      $$WrongAnswersTableOrderingComposer,
      $$WrongAnswersTableAnnotationComposer,
      $$WrongAnswersTableCreateCompanionBuilder,
      $$WrongAnswersTableUpdateCompanionBuilder,
      (WrongAnswer, $$WrongAnswersTableReferences),
      WrongAnswer,
      PrefetchHooks Function({bool sessionId, bool entryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db, _db.fieldLists);
  $$EntrysTableTableManager get entrys =>
      $$EntrysTableTableManager(_db, _db.entrys);
  $$FieldNotesTableTableManager get fieldNotes =>
      $$FieldNotesTableTableManager(_db, _db.fieldNotes);
  $$FieldListNotesTableTableManager get fieldListNotes =>
      $$FieldListNotesTableTableManager(_db, _db.fieldListNotes);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SessionEntrysTableTableManager get sessionEntrys =>
      $$SessionEntrysTableTableManager(_db, _db.sessionEntrys);
  $$TestSessionsTableTableManager get testSessions =>
      $$TestSessionsTableTableManager(_db, _db.testSessions);
  $$WrongAnswersTableTableManager get wrongAnswers =>
      $$WrongAnswersTableTableManager(_db, _db.wrongAnswers);
}
