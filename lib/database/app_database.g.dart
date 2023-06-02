// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EntryTextsTable extends EntryTexts
    with TableInfo<$EntryTextsTable, EntryText> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryTextsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      check: () =>
          value
              .trim()
              .length
              .isBiggerOrEqualValue(EntryTexts.MINIMUM_VALUE_LENGTH) &
          value.length.isSmallerOrEqualValue(EntryTexts.MAXIMUM_VALUE_LENGTH),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? 'entry_texts';
  @override
  String get actualTableName => 'entry_texts';
  @override
  VerificationContext validateIntegrity(Insertable<EntryText> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryText map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryText(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $EntryTextsTable createAlias(String alias) {
    return $EntryTextsTable(attachedDatabase, alias);
  }
}

class EntryText extends DataClass implements Insertable<EntryText> {
  final String id;
  final String value;
  const EntryText({required this.id, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  EntryTextsCompanion toCompanion(bool nullToAbsent) {
    return EntryTextsCompanion(
      id: Value(id),
      value: Value(value),
    );
  }

  factory EntryText.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryText(
      id: serializer.fromJson<String>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  EntryText copyWith({String? id, String? value}) => EntryText(
        id: id ?? this.id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('EntryText(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryText && other.id == this.id && other.value == this.value);
}

class EntryTextsCompanion extends UpdateCompanion<EntryText> {
  final Value<String> id;
  final Value<String> value;
  const EntryTextsCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  EntryTextsCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<EntryText> custom({
    Expression<String>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  EntryTextsCompanion copyWith({Value<String>? id, Value<String>? value}) {
    return EntryTextsCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryTextsCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _questionTypeMeta =
      const VerificationMeta('questionType');
  @override
  late final GeneratedColumn<int> questionType = GeneratedColumn<int>(
      'question_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, questionType, address];
  @override
  String get aliasedName => _alias ?? 'questions';
  @override
  String get actualTableName => 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<Question> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_type')) {
      context.handle(
          _questionTypeMeta,
          questionType.isAcceptableOrUnknown(
              data['question_type']!, _questionTypeMeta));
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {questionType, address},
      ];
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      questionType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_type'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final String id;
  final int questionType;
  final String address;
  const Question(
      {required this.id, required this.questionType, required this.address});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_type'] = Variable<int>(questionType);
    map['address'] = Variable<String>(address);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      questionType: Value(questionType),
      address: Value(address),
    );
  }

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<String>(json['id']),
      questionType: serializer.fromJson<int>(json['questionType']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionType': serializer.toJson<int>(questionType),
      'address': serializer.toJson<String>(address),
    };
  }

  Question copyWith({String? id, int? questionType, String? address}) =>
      Question(
        id: id ?? this.id,
        questionType: questionType ?? this.questionType,
        address: address ?? this.address,
      );
  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('questionType: $questionType, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionType, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.questionType == this.questionType &&
          other.address == this.address);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<String> id;
  final Value<int> questionType;
  final Value<String> address;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.questionType = const Value.absent(),
    this.address = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int questionType,
    required String address,
  })  : questionType = Value(questionType),
        address = Value(address);
  static Insertable<Question> custom({
    Expression<String>? id,
    Expression<int>? questionType,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionType != null) 'question_type': questionType,
      if (address != null) 'address': address,
    });
  }

  QuestionsCompanion copyWith(
      {Value<String>? id, Value<int>? questionType, Value<String>? address}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      questionType: questionType ?? this.questionType,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<int>(questionType.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('questionType: $questionType, ')
          ..write('address: $address')
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
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _fieldListIdMeta =
      const VerificationMeta('fieldListId');
  @override
  late final GeneratedColumn<String> fieldListId = GeneratedColumn<String>(
      'field_list_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _answerIdMeta =
      const VerificationMeta('answerId');
  @override
  late final GeneratedColumn<String> answerId = GeneratedColumn<String>(
      'answer_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationAtMeta =
      const VerificationMeta('creationAt');
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
      'creation_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>('last_modification_at', aliasedName, false,
          check: () => lastModificationAt.isBiggerOrEqual(creationAt),
          type: DriftSqlType.dateTime,
          requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      check: () =>
          order.isSmallerOrEqualValue(Entrys.ORDER_MAXIMUM_VALUE) &
          order.isBiggerOrEqualValue(Entrys.ORDER_MINIMUM_VALUE),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _didAskedAtCurrentTestRoundMeta =
      const VerificationMeta('didAskedAtCurrentTestRound');
  @override
  late final GeneratedColumn<bool> didAskedAtCurrentTestRound =
      GeneratedColumn<bool>(
          'did_asked_at_current_test_round', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite:
                'CHECK ("did_asked_at_current_test_round" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _emulatedCreatedAtMeta =
      const VerificationMeta('emulatedCreatedAt');
  @override
  late final GeneratedColumn<DateTime> emulatedCreatedAt =
      GeneratedColumn<DateTime>('emulated_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<int> rank = GeneratedColumn<int>(
      'rank', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _askedCountMeta =
      const VerificationMeta('askedCount');
  @override
  late final GeneratedColumn<int> askedCount = GeneratedColumn<int>(
      'asked_count', aliasedName, false,
      check: () =>
          askedCount.isSmallerOrEqualValue(Entrys.ASKED_COUNT_MAXIMUM_VALUE) &
          askedCount.isBiggerOrEqualValue(Entrys.ASKED_COUNT_MINIMUM_VALUE),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _wronglyAnsweredCountMeta =
      const VerificationMeta('wronglyAnsweredCount');
  @override
  late final GeneratedColumn<int> wronglyAnsweredCount = GeneratedColumn<int>(
      'wrongly_answered_count', aliasedName, false,
      check: () =>
          wronglyAnsweredCount.isSmallerOrEqualValue(
              Entrys.WRONGLY_ANSWERED_COUNT_MAXIMUM_VALUE) &
          wronglyAnsweredCount.isBiggerOrEqualValue(
              Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fieldListId,
        answerId,
        questionId,
        creationAt,
        lastModificationAt,
        order,
        didAskedAtCurrentTestRound,
        emulatedCreatedAt,
        rank,
        askedCount,
        wronglyAnsweredCount
      ];
  @override
  String get aliasedName => _alias ?? 'entrys';
  @override
  String get actualTableName => 'entrys';
  @override
  VerificationContext validateIntegrity(Insertable<Entry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_list_id')) {
      context.handle(
          _fieldListIdMeta,
          fieldListId.isAcceptableOrUnknown(
              data['field_list_id']!, _fieldListIdMeta));
    } else if (isInserting) {
      context.missing(_fieldListIdMeta);
    }
    if (data.containsKey('answer_id')) {
      context.handle(_answerIdMeta,
          answerId.isAcceptableOrUnknown(data['answer_id']!, _answerIdMeta));
    } else if (isInserting) {
      context.missing(_answerIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
          _creationAtMeta,
          creationAt.isAcceptableOrUnknown(
              data['creation_at']!, _creationAtMeta));
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
          _lastModificationAtMeta,
          lastModificationAt.isAcceptableOrUnknown(
              data['last_modification_at']!, _lastModificationAtMeta));
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('did_asked_at_current_test_round')) {
      context.handle(
          _didAskedAtCurrentTestRoundMeta,
          didAskedAtCurrentTestRound.isAcceptableOrUnknown(
              data['did_asked_at_current_test_round']!,
              _didAskedAtCurrentTestRoundMeta));
    } else if (isInserting) {
      context.missing(_didAskedAtCurrentTestRoundMeta);
    }
    if (data.containsKey('emulated_created_at')) {
      context.handle(
          _emulatedCreatedAtMeta,
          emulatedCreatedAt.isAcceptableOrUnknown(
              data['emulated_created_at']!, _emulatedCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_emulatedCreatedAtMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
          _rankMeta, rank.isAcceptableOrUnknown(data['rank']!, _rankMeta));
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    if (data.containsKey('asked_count')) {
      context.handle(
          _askedCountMeta,
          askedCount.isAcceptableOrUnknown(
              data['asked_count']!, _askedCountMeta));
    } else if (isInserting) {
      context.missing(_askedCountMeta);
    }
    if (data.containsKey('wrongly_answered_count')) {
      context.handle(
          _wronglyAnsweredCountMeta,
          wronglyAnsweredCount.isAcceptableOrUnknown(
              data['wrongly_answered_count']!, _wronglyAnsweredCountMeta));
    } else if (isInserting) {
      context.missing(_wronglyAnsweredCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {fieldListId, answerId, questionId},
      ];
  @override
  Entry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fieldListId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_list_id'])!,
      answerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      creationAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_at'])!,
      lastModificationAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_modification_at'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      didAskedAtCurrentTestRound: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}did_asked_at_current_test_round'])!,
      emulatedCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}emulated_created_at'])!,
      rank: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rank'])!,
      askedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asked_count'])!,
      wronglyAnsweredCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}wrongly_answered_count'])!,
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
  final String answerId;
  final String questionId;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  final int order;
  final bool didAskedAtCurrentTestRound;
  final DateTime emulatedCreatedAt;
  final int rank;
  final int askedCount;
  final int wronglyAnsweredCount;
  const Entry(
      {required this.id,
      required this.fieldListId,
      required this.answerId,
      required this.questionId,
      required this.creationAt,
      required this.lastModificationAt,
      required this.order,
      required this.didAskedAtCurrentTestRound,
      required this.emulatedCreatedAt,
      required this.rank,
      required this.askedCount,
      required this.wronglyAnsweredCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_list_id'] = Variable<String>(fieldListId);
    map['answer_id'] = Variable<String>(answerId);
    map['question_id'] = Variable<String>(questionId);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    map['order'] = Variable<int>(order);
    map['did_asked_at_current_test_round'] =
        Variable<bool>(didAskedAtCurrentTestRound);
    map['emulated_created_at'] = Variable<DateTime>(emulatedCreatedAt);
    map['rank'] = Variable<int>(rank);
    map['asked_count'] = Variable<int>(askedCount);
    map['wrongly_answered_count'] = Variable<int>(wronglyAnsweredCount);
    return map;
  }

  EntrysCompanion toCompanion(bool nullToAbsent) {
    return EntrysCompanion(
      id: Value(id),
      fieldListId: Value(fieldListId),
      answerId: Value(answerId),
      questionId: Value(questionId),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
      order: Value(order),
      didAskedAtCurrentTestRound: Value(didAskedAtCurrentTestRound),
      emulatedCreatedAt: Value(emulatedCreatedAt),
      rank: Value(rank),
      askedCount: Value(askedCount),
      wronglyAnsweredCount: Value(wronglyAnsweredCount),
    );
  }

  factory Entry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<String>(json['id']),
      fieldListId: serializer.fromJson<String>(json['fieldListId']),
      answerId: serializer.fromJson<String>(json['answerId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt:
          serializer.fromJson<DateTime>(json['lastModificationAt']),
      order: serializer.fromJson<int>(json['order']),
      didAskedAtCurrentTestRound:
          serializer.fromJson<bool>(json['didAskedAtCurrentTestRound']),
      emulatedCreatedAt:
          serializer.fromJson<DateTime>(json['emulatedCreatedAt']),
      rank: serializer.fromJson<int>(json['rank']),
      askedCount: serializer.fromJson<int>(json['askedCount']),
      wronglyAnsweredCount:
          serializer.fromJson<int>(json['wronglyAnsweredCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldListId': serializer.toJson<String>(fieldListId),
      'answerId': serializer.toJson<String>(answerId),
      'questionId': serializer.toJson<String>(questionId),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
      'order': serializer.toJson<int>(order),
      'didAskedAtCurrentTestRound':
          serializer.toJson<bool>(didAskedAtCurrentTestRound),
      'emulatedCreatedAt': serializer.toJson<DateTime>(emulatedCreatedAt),
      'rank': serializer.toJson<int>(rank),
      'askedCount': serializer.toJson<int>(askedCount),
      'wronglyAnsweredCount': serializer.toJson<int>(wronglyAnsweredCount),
    };
  }

  Entry copyWith(
          {String? id,
          String? fieldListId,
          String? answerId,
          String? questionId,
          DateTime? creationAt,
          DateTime? lastModificationAt,
          int? order,
          bool? didAskedAtCurrentTestRound,
          DateTime? emulatedCreatedAt,
          int? rank,
          int? askedCount,
          int? wronglyAnsweredCount}) =>
      Entry(
        id: id ?? this.id,
        fieldListId: fieldListId ?? this.fieldListId,
        answerId: answerId ?? this.answerId,
        questionId: questionId ?? this.questionId,
        creationAt: creationAt ?? this.creationAt,
        lastModificationAt: lastModificationAt ?? this.lastModificationAt,
        order: order ?? this.order,
        didAskedAtCurrentTestRound:
            didAskedAtCurrentTestRound ?? this.didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt ?? this.emulatedCreatedAt,
        rank: rank ?? this.rank,
        askedCount: askedCount ?? this.askedCount,
        wronglyAnsweredCount: wronglyAnsweredCount ?? this.wronglyAnsweredCount,
      );
  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('answerId: $answerId, ')
          ..write('questionId: $questionId, ')
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
      answerId,
      questionId,
      creationAt,
      lastModificationAt,
      order,
      didAskedAtCurrentTestRound,
      emulatedCreatedAt,
      rank,
      askedCount,
      wronglyAnsweredCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.fieldListId == this.fieldListId &&
          other.answerId == this.answerId &&
          other.questionId == this.questionId &&
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
  final Value<String> answerId;
  final Value<String> questionId;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> order;
  final Value<bool> didAskedAtCurrentTestRound;
  final Value<DateTime> emulatedCreatedAt;
  final Value<int> rank;
  final Value<int> askedCount;
  final Value<int> wronglyAnsweredCount;
  const EntrysCompanion({
    this.id = const Value.absent(),
    this.fieldListId = const Value.absent(),
    this.answerId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.order = const Value.absent(),
    this.didAskedAtCurrentTestRound = const Value.absent(),
    this.emulatedCreatedAt = const Value.absent(),
    this.rank = const Value.absent(),
    this.askedCount = const Value.absent(),
    this.wronglyAnsweredCount = const Value.absent(),
  });
  EntrysCompanion.insert({
    this.id = const Value.absent(),
    required String fieldListId,
    required String answerId,
    required String questionId,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    required int order,
    required bool didAskedAtCurrentTestRound,
    required DateTime emulatedCreatedAt,
    required int rank,
    required int askedCount,
    required int wronglyAnsweredCount,
  })  : fieldListId = Value(fieldListId),
        answerId = Value(answerId),
        questionId = Value(questionId),
        creationAt = Value(creationAt),
        lastModificationAt = Value(lastModificationAt),
        order = Value(order),
        didAskedAtCurrentTestRound = Value(didAskedAtCurrentTestRound),
        emulatedCreatedAt = Value(emulatedCreatedAt),
        rank = Value(rank),
        askedCount = Value(askedCount),
        wronglyAnsweredCount = Value(wronglyAnsweredCount);
  static Insertable<Entry> custom({
    Expression<String>? id,
    Expression<String>? fieldListId,
    Expression<String>? answerId,
    Expression<String>? questionId,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? order,
    Expression<bool>? didAskedAtCurrentTestRound,
    Expression<DateTime>? emulatedCreatedAt,
    Expression<int>? rank,
    Expression<int>? askedCount,
    Expression<int>? wronglyAnsweredCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldListId != null) 'field_list_id': fieldListId,
      if (answerId != null) 'answer_id': answerId,
      if (questionId != null) 'question_id': questionId,
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
    });
  }

  EntrysCompanion copyWith(
      {Value<String>? id,
      Value<String>? fieldListId,
      Value<String>? answerId,
      Value<String>? questionId,
      Value<DateTime>? creationAt,
      Value<DateTime>? lastModificationAt,
      Value<int>? order,
      Value<bool>? didAskedAtCurrentTestRound,
      Value<DateTime>? emulatedCreatedAt,
      Value<int>? rank,
      Value<int>? askedCount,
      Value<int>? wronglyAnsweredCount}) {
    return EntrysCompanion(
      id: id ?? this.id,
      fieldListId: fieldListId ?? this.fieldListId,
      answerId: answerId ?? this.answerId,
      questionId: questionId ?? this.questionId,
      creationAt: creationAt ?? this.creationAt,
      lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      order: order ?? this.order,
      didAskedAtCurrentTestRound:
          didAskedAtCurrentTestRound ?? this.didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt ?? this.emulatedCreatedAt,
      rank: rank ?? this.rank,
      askedCount: askedCount ?? this.askedCount,
      wronglyAnsweredCount: wronglyAnsweredCount ?? this.wronglyAnsweredCount,
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
    if (answerId.present) {
      map['answer_id'] = Variable<String>(answerId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] =
          Variable<DateTime>(lastModificationAt.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (didAskedAtCurrentTestRound.present) {
      map['did_asked_at_current_test_round'] =
          Variable<bool>(didAskedAtCurrentTestRound.value);
    }
    if (emulatedCreatedAt.present) {
      map['emulated_created_at'] = Variable<DateTime>(emulatedCreatedAt.value);
    }
    if (rank.present) {
      map['rank'] = Variable<int>(rank.value);
    }
    if (askedCount.present) {
      map['asked_count'] = Variable<int>(askedCount.value);
    }
    if (wronglyAnsweredCount.present) {
      map['wrongly_answered_count'] = Variable<int>(wronglyAnsweredCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntrysCompanion(')
          ..write('id: $id, ')
          ..write('fieldListId: $fieldListId, ')
          ..write('answerId: $answerId, ')
          ..write('questionId: $questionId, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _fieldIdMeta =
      const VerificationMeta('fieldId');
  @override
  late final GeneratedColumn<String> fieldId = GeneratedColumn<String>(
      'field_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      check: () =>
          name
              .trim()
              .length
              .isBiggerOrEqualValue(FieldLists.MINIMUM_LENGTH_OF_NAME) &
          name.length.isSmallerOrEqualValue(FieldLists.MAXIMUM_LENGTH_OF_NAME),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _creationAtMeta =
      const VerificationMeta('creationAt');
  @override
  late final GeneratedColumn<DateTime> creationAt = GeneratedColumn<DateTime>(
      'creation_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>('last_modification_at', aliasedName, false,
          check: () => lastModificationAt.isBiggerOrEqual(creationAt),
          type: DriftSqlType.dateTime,
          requiredDuringInsert: true);
  static const VerificationMeta _languageTagMeta =
      const VerificationMeta('languageTag');
  @override
  late final GeneratedColumn<String> languageTag = GeneratedColumn<String>(
      'language_tag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _checkTypeMeta =
      const VerificationMeta('checkType');
  @override
  late final GeneratedColumn<int> checkType = GeneratedColumn<int>(
      'check_type', aliasedName, false,
      check: () =>
          checkType.isBiggerOrEqualValue(0) &
          checkType.isSmallerThanValue(CheckType.MAX.index),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(CheckType.NON_STRICT_IGNORE_CASE.index));
  static const VerificationMeta _sortByMeta = const VerificationMeta('sortBy');
  @override
  late final GeneratedColumn<int> sortBy = GeneratedColumn<int>(
      'sort_by', aliasedName, false,
      check: () =>
          sortBy.isBiggerOrEqualValue(0) &
          sortBy.isSmallerThanValue(SortBy.MAX.index),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(SortBy.CREATION_DATE_DESC.index));
  static const VerificationMeta _doesReadAnswerMeta =
      const VerificationMeta('doesReadAnswer');
  @override
  late final GeneratedColumn<bool> doesReadAnswer =
      GeneratedColumn<bool>('does_read_answer', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("does_read_answer" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  static const VerificationMeta _usageCountMeta =
      const VerificationMeta('usageCount');
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
      'usage_count', aliasedName, false,
      check: () =>
          usageCount.isBiggerOrEqualValue(FieldLists.MINIMUM_USAGE_COUNT) &
          usageCount.isSmallerOrEqualValue(FieldLists.MAXIMUM_USAGE_COUNT),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      check: () =>
          color.isBiggerOrEqualValue(FieldLists.MINIMUM_COLOR) &
          color.isSmallerOrEqualValue(FieldLists.MAXIMUM_COLOR),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(FieldLists.MAXIMUM_COLOR));
  static const VerificationMeta _emulationNumberOfQuestionsMeta =
      const VerificationMeta('emulationNumberOfQuestions');
  @override
  late final GeneratedColumn<int> emulationNumberOfQuestions =
      GeneratedColumn<int>(
          'emulation_number_of_questions', aliasedName, true,
          check: () =>
              emulationNumberOfQuestions.isBiggerOrEqualValue(
                  FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS) &
              emulationNumberOfQuestions.isSmallerOrEqualValue(
                  FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta _emulationDaysMeta =
      const VerificationMeta('emulationDays');
  @override
  late final GeneratedColumn<String> emulationDays = GeneratedColumn<String>(
      'emulation_days', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _testsReadingQuestionLetterDurationMeta =
      const VerificationMeta('testsReadingQuestionLetterDuration');
  @override
  late final GeneratedColumn<int> testsReadingQuestionLetterDuration =
      GeneratedColumn<int>(
          'tests_reading_question_letter_duration', aliasedName, true,
          check: () => testsReadingQuestionLetterDuration
              .isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta _testsFindingAnswerDurationMeta =
      const VerificationMeta('testsFindingAnswerDuration');
  @override
  late final GeneratedColumn<int> testsFindingAnswerDuration =
      GeneratedColumn<int>(
          'tests_finding_answer_duration', aliasedName, true,
          check: () => testsFindingAnswerDuration
              .isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta _testsTypingAnswerLetterDurationMeta =
      const VerificationMeta('testsTypingAnswerLetterDuration');
  @override
  late final GeneratedColumn<int> testsTypingAnswerLetterDuration =
      GeneratedColumn<int>(
          'tests_typing_answer_letter_duration', aliasedName, true,
          check: () => testsTypingAnswerLetterDuration
              .isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta
      _studyTillCorrectReadingQuestionLetterDurationMeta =
      const VerificationMeta('studyTillCorrectReadingQuestionLetterDuration');
  @override
  late final GeneratedColumn<int>
      studyTillCorrectReadingQuestionLetterDuration = GeneratedColumn<int>(
          'study_till_correct_reading_question_letter_duration',
          aliasedName,
          true,
          check: () => studyTillCorrectReadingQuestionLetterDuration
              .isBiggerOrEqualValue(
                  FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta _studyTillCorrectFindingAnswerDurationMeta =
      const VerificationMeta('studyTillCorrectFindingAnswerDuration');
  @override
  late final GeneratedColumn<int> studyTillCorrectFindingAnswerDuration =
      GeneratedColumn<int>(
          'study_till_correct_finding_answer_duration', aliasedName, true,
          check: () =>
              studyTillCorrectFindingAnswerDuration.isBiggerOrEqualValue(
                  FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta
      _studyTillCorrectTypingAnswerLetterDurationMeta =
      const VerificationMeta('studyTillCorrectTypingAnswerLetterDuration');
  @override
  late final GeneratedColumn<int> studyTillCorrectTypingAnswerLetterDuration =
      GeneratedColumn<int>(
          'study_till_correct_typing_answer_letter_duration', aliasedName, true,
          check: () =>
              studyTillCorrectTypingAnswerLetterDuration.isBiggerOrEqualValue(
                  FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS),
          type: DriftSqlType.int,
          requiredDuringInsert: false);
  static const VerificationMeta _testsTimeOfAnswerActionMeta =
      const VerificationMeta('testsTimeOfAnswerAction');
  @override
  late final GeneratedColumn<int> testsTimeOfAnswerAction =
      GeneratedColumn<int>('tests_time_of_answer_action', aliasedName, false,
          check: () =>
              testsTimeOfAnswerAction.isBiggerOrEqualValue(0) &
              testsTimeOfAnswerAction
                  .isSmallerThanValue(TimeOfAnswerAction.MAX.index),
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: Constant(TimeOfAnswerAction.NOTIFY.index));
  static const VerificationMeta _doesObfuscateQuestionMeta =
      const VerificationMeta('doesObfuscateQuestion');
  @override
  late final GeneratedColumn<bool> doesObfuscateQuestion =
      GeneratedColumn<bool>('does_obfuscate_question', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("does_obfuscate_question" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
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
        doesObfuscateQuestion
      ];
  @override
  String get aliasedName => _alias ?? 'field_lists';
  @override
  String get actualTableName => 'field_lists';
  @override
  VerificationContext validateIntegrity(Insertable<FieldList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_id')) {
      context.handle(_fieldIdMeta,
          fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta));
    } else if (isInserting) {
      context.missing(_fieldIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('creation_at')) {
      context.handle(
          _creationAtMeta,
          creationAt.isAcceptableOrUnknown(
              data['creation_at']!, _creationAtMeta));
    } else if (isInserting) {
      context.missing(_creationAtMeta);
    }
    if (data.containsKey('last_modification_at')) {
      context.handle(
          _lastModificationAtMeta,
          lastModificationAt.isAcceptableOrUnknown(
              data['last_modification_at']!, _lastModificationAtMeta));
    } else if (isInserting) {
      context.missing(_lastModificationAtMeta);
    }
    if (data.containsKey('language_tag')) {
      context.handle(
          _languageTagMeta,
          languageTag.isAcceptableOrUnknown(
              data['language_tag']!, _languageTagMeta));
    }
    if (data.containsKey('check_type')) {
      context.handle(_checkTypeMeta,
          checkType.isAcceptableOrUnknown(data['check_type']!, _checkTypeMeta));
    }
    if (data.containsKey('sort_by')) {
      context.handle(_sortByMeta,
          sortBy.isAcceptableOrUnknown(data['sort_by']!, _sortByMeta));
    }
    if (data.containsKey('does_read_answer')) {
      context.handle(
          _doesReadAnswerMeta,
          doesReadAnswer.isAcceptableOrUnknown(
              data['does_read_answer']!, _doesReadAnswerMeta));
    }
    if (data.containsKey('usage_count')) {
      context.handle(
          _usageCountMeta,
          usageCount.isAcceptableOrUnknown(
              data['usage_count']!, _usageCountMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('emulation_number_of_questions')) {
      context.handle(
          _emulationNumberOfQuestionsMeta,
          emulationNumberOfQuestions.isAcceptableOrUnknown(
              data['emulation_number_of_questions']!,
              _emulationNumberOfQuestionsMeta));
    }
    if (data.containsKey('emulation_days')) {
      context.handle(
          _emulationDaysMeta,
          emulationDays.isAcceptableOrUnknown(
              data['emulation_days']!, _emulationDaysMeta));
    }
    if (data.containsKey('tests_reading_question_letter_duration')) {
      context.handle(
          _testsReadingQuestionLetterDurationMeta,
          testsReadingQuestionLetterDuration.isAcceptableOrUnknown(
              data['tests_reading_question_letter_duration']!,
              _testsReadingQuestionLetterDurationMeta));
    }
    if (data.containsKey('tests_finding_answer_duration')) {
      context.handle(
          _testsFindingAnswerDurationMeta,
          testsFindingAnswerDuration.isAcceptableOrUnknown(
              data['tests_finding_answer_duration']!,
              _testsFindingAnswerDurationMeta));
    }
    if (data.containsKey('tests_typing_answer_letter_duration')) {
      context.handle(
          _testsTypingAnswerLetterDurationMeta,
          testsTypingAnswerLetterDuration.isAcceptableOrUnknown(
              data['tests_typing_answer_letter_duration']!,
              _testsTypingAnswerLetterDurationMeta));
    }
    if (data
        .containsKey('study_till_correct_reading_question_letter_duration')) {
      context.handle(
          _studyTillCorrectReadingQuestionLetterDurationMeta,
          studyTillCorrectReadingQuestionLetterDuration.isAcceptableOrUnknown(
              data['study_till_correct_reading_question_letter_duration']!,
              _studyTillCorrectReadingQuestionLetterDurationMeta));
    }
    if (data.containsKey('study_till_correct_finding_answer_duration')) {
      context.handle(
          _studyTillCorrectFindingAnswerDurationMeta,
          studyTillCorrectFindingAnswerDuration.isAcceptableOrUnknown(
              data['study_till_correct_finding_answer_duration']!,
              _studyTillCorrectFindingAnswerDurationMeta));
    }
    if (data.containsKey('study_till_correct_typing_answer_letter_duration')) {
      context.handle(
          _studyTillCorrectTypingAnswerLetterDurationMeta,
          studyTillCorrectTypingAnswerLetterDuration.isAcceptableOrUnknown(
              data['study_till_correct_typing_answer_letter_duration']!,
              _studyTillCorrectTypingAnswerLetterDurationMeta));
    }
    if (data.containsKey('tests_time_of_answer_action')) {
      context.handle(
          _testsTimeOfAnswerActionMeta,
          testsTimeOfAnswerAction.isAcceptableOrUnknown(
              data['tests_time_of_answer_action']!,
              _testsTimeOfAnswerActionMeta));
    }
    if (data.containsKey('does_obfuscate_question')) {
      context.handle(
          _doesObfuscateQuestionMeta,
          doesObfuscateQuestion.isAcceptableOrUnknown(
              data['does_obfuscate_question']!, _doesObfuscateQuestionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldList(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fieldId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      creationAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_at'])!,
      lastModificationAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_modification_at'])!,
      languageTag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_tag']),
      checkType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}check_type'])!,
      sortBy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_by'])!,
      doesReadAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}does_read_answer'])!,
      usageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_count'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      emulationNumberOfQuestions: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}emulation_number_of_questions']),
      emulationDays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emulation_days']),
      testsReadingQuestionLetterDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tests_reading_question_letter_duration']),
      testsFindingAnswerDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tests_finding_answer_duration']),
      testsTypingAnswerLetterDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tests_typing_answer_letter_duration']),
      studyTillCorrectReadingQuestionLetterDuration:
          attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data[
                  '${effectivePrefix}study_till_correct_reading_question_letter_duration']),
      studyTillCorrectFindingAnswerDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}study_till_correct_finding_answer_duration']),
      studyTillCorrectTypingAnswerLetterDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data[
              '${effectivePrefix}study_till_correct_typing_answer_letter_duration']),
      testsTimeOfAnswerAction: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tests_time_of_answer_action'])!,
      doesObfuscateQuestion: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}does_obfuscate_question'])!,
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
  const FieldList(
      {required this.id,
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
      required this.doesObfuscateQuestion});
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
      map['emulation_number_of_questions'] =
          Variable<int>(emulationNumberOfQuestions);
    }
    if (!nullToAbsent || emulationDays != null) {
      map['emulation_days'] = Variable<String>(emulationDays);
    }
    if (!nullToAbsent || testsReadingQuestionLetterDuration != null) {
      map['tests_reading_question_letter_duration'] =
          Variable<int>(testsReadingQuestionLetterDuration);
    }
    if (!nullToAbsent || testsFindingAnswerDuration != null) {
      map['tests_finding_answer_duration'] =
          Variable<int>(testsFindingAnswerDuration);
    }
    if (!nullToAbsent || testsTypingAnswerLetterDuration != null) {
      map['tests_typing_answer_letter_duration'] =
          Variable<int>(testsTypingAnswerLetterDuration);
    }
    if (!nullToAbsent ||
        studyTillCorrectReadingQuestionLetterDuration != null) {
      map['study_till_correct_reading_question_letter_duration'] =
          Variable<int>(studyTillCorrectReadingQuestionLetterDuration);
    }
    if (!nullToAbsent || studyTillCorrectFindingAnswerDuration != null) {
      map['study_till_correct_finding_answer_duration'] =
          Variable<int>(studyTillCorrectFindingAnswerDuration);
    }
    if (!nullToAbsent || studyTillCorrectTypingAnswerLetterDuration != null) {
      map['study_till_correct_typing_answer_letter_duration'] =
          Variable<int>(studyTillCorrectTypingAnswerLetterDuration);
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

  factory FieldList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldList(
      id: serializer.fromJson<String>(json['id']),
      fieldId: serializer.fromJson<String>(json['fieldId']),
      name: serializer.fromJson<String>(json['name']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt:
          serializer.fromJson<DateTime>(json['lastModificationAt']),
      languageTag: serializer.fromJson<String?>(json['languageTag']),
      checkType: serializer.fromJson<int>(json['checkType']),
      sortBy: serializer.fromJson<int>(json['sortBy']),
      doesReadAnswer: serializer.fromJson<bool>(json['doesReadAnswer']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      color: serializer.fromJson<int>(json['color']),
      emulationNumberOfQuestions:
          serializer.fromJson<int?>(json['emulationNumberOfQuestions']),
      emulationDays: serializer.fromJson<String?>(json['emulationDays']),
      testsReadingQuestionLetterDuration:
          serializer.fromJson<int?>(json['testsReadingQuestionLetterDuration']),
      testsFindingAnswerDuration:
          serializer.fromJson<int?>(json['testsFindingAnswerDuration']),
      testsTypingAnswerLetterDuration:
          serializer.fromJson<int?>(json['testsTypingAnswerLetterDuration']),
      studyTillCorrectReadingQuestionLetterDuration: serializer.fromJson<int?>(
          json['studyTillCorrectReadingQuestionLetterDuration']),
      studyTillCorrectFindingAnswerDuration: serializer
          .fromJson<int?>(json['studyTillCorrectFindingAnswerDuration']),
      studyTillCorrectTypingAnswerLetterDuration: serializer
          .fromJson<int?>(json['studyTillCorrectTypingAnswerLetterDuration']),
      testsTimeOfAnswerAction:
          serializer.fromJson<int>(json['testsTimeOfAnswerAction']),
      doesObfuscateQuestion:
          serializer.fromJson<bool>(json['doesObfuscateQuestion']),
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
      'emulationNumberOfQuestions':
          serializer.toJson<int?>(emulationNumberOfQuestions),
      'emulationDays': serializer.toJson<String?>(emulationDays),
      'testsReadingQuestionLetterDuration':
          serializer.toJson<int?>(testsReadingQuestionLetterDuration),
      'testsFindingAnswerDuration':
          serializer.toJson<int?>(testsFindingAnswerDuration),
      'testsTypingAnswerLetterDuration':
          serializer.toJson<int?>(testsTypingAnswerLetterDuration),
      'studyTillCorrectReadingQuestionLetterDuration': serializer
          .toJson<int?>(studyTillCorrectReadingQuestionLetterDuration),
      'studyTillCorrectFindingAnswerDuration':
          serializer.toJson<int?>(studyTillCorrectFindingAnswerDuration),
      'studyTillCorrectTypingAnswerLetterDuration':
          serializer.toJson<int?>(studyTillCorrectTypingAnswerLetterDuration),
      'testsTimeOfAnswerAction':
          serializer.toJson<int>(testsTimeOfAnswerAction),
      'doesObfuscateQuestion': serializer.toJson<bool>(doesObfuscateQuestion),
    };
  }

  FieldList copyWith(
          {String? id,
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
          Value<int?> studyTillCorrectFindingAnswerDuration =
              const Value.absent(),
          Value<int?> studyTillCorrectTypingAnswerLetterDuration =
              const Value.absent(),
          int? testsTimeOfAnswerAction,
          bool? doesObfuscateQuestion}) =>
      FieldList(
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
        emulationDays:
            emulationDays.present ? emulationDays.value : this.emulationDays,
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
        doesObfuscateQuestion:
            doesObfuscateQuestion ?? this.doesObfuscateQuestion,
      );
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
              'testsReadingQuestionLetterDuration: $testsReadingQuestionLetterDuration, ')
          ..write('testsFindingAnswerDuration: $testsFindingAnswerDuration, ')
          ..write(
              'testsTypingAnswerLetterDuration: $testsTypingAnswerLetterDuration, ')
          ..write(
              'studyTillCorrectReadingQuestionLetterDuration: $studyTillCorrectReadingQuestionLetterDuration, ')
          ..write(
              'studyTillCorrectFindingAnswerDuration: $studyTillCorrectFindingAnswerDuration, ')
          ..write(
              'studyTillCorrectTypingAnswerLetterDuration: $studyTillCorrectTypingAnswerLetterDuration, ')
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
        doesObfuscateQuestion
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
  })  : fieldId = Value(fieldId),
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
    });
  }

  FieldListsCompanion copyWith(
      {Value<String>? id,
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
      Value<bool>? doesObfuscateQuestion}) {
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
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration ??
          this.testsReadingQuestionLetterDuration,
      testsFindingAnswerDuration:
          testsFindingAnswerDuration ?? this.testsFindingAnswerDuration,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration ??
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
      map['last_modification_at'] =
          Variable<DateTime>(lastModificationAt.value);
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
      map['emulation_number_of_questions'] =
          Variable<int>(emulationNumberOfQuestions.value);
    }
    if (emulationDays.present) {
      map['emulation_days'] = Variable<String>(emulationDays.value);
    }
    if (testsReadingQuestionLetterDuration.present) {
      map['tests_reading_question_letter_duration'] =
          Variable<int>(testsReadingQuestionLetterDuration.value);
    }
    if (testsFindingAnswerDuration.present) {
      map['tests_finding_answer_duration'] =
          Variable<int>(testsFindingAnswerDuration.value);
    }
    if (testsTypingAnswerLetterDuration.present) {
      map['tests_typing_answer_letter_duration'] =
          Variable<int>(testsTypingAnswerLetterDuration.value);
    }
    if (studyTillCorrectReadingQuestionLetterDuration.present) {
      map['study_till_correct_reading_question_letter_duration'] =
          Variable<int>(studyTillCorrectReadingQuestionLetterDuration.value);
    }
    if (studyTillCorrectFindingAnswerDuration.present) {
      map['study_till_correct_finding_answer_duration'] =
          Variable<int>(studyTillCorrectFindingAnswerDuration.value);
    }
    if (studyTillCorrectTypingAnswerLetterDuration.present) {
      map['study_till_correct_typing_answer_letter_duration'] =
          Variable<int>(studyTillCorrectTypingAnswerLetterDuration.value);
    }
    if (testsTimeOfAnswerAction.present) {
      map['tests_time_of_answer_action'] =
          Variable<int>(testsTimeOfAnswerAction.value);
    }
    if (doesObfuscateQuestion.present) {
      map['does_obfuscate_question'] =
          Variable<bool>(doesObfuscateQuestion.value);
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
              'testsReadingQuestionLetterDuration: $testsReadingQuestionLetterDuration, ')
          ..write('testsFindingAnswerDuration: $testsFindingAnswerDuration, ')
          ..write(
              'testsTypingAnswerLetterDuration: $testsTypingAnswerLetterDuration, ')
          ..write(
              'studyTillCorrectReadingQuestionLetterDuration: $studyTillCorrectReadingQuestionLetterDuration, ')
          ..write(
              'studyTillCorrectFindingAnswerDuration: $studyTillCorrectFindingAnswerDuration, ')
          ..write(
              'studyTillCorrectTypingAnswerLetterDuration: $studyTillCorrectTypingAnswerLetterDuration, ')
          ..write('testsTimeOfAnswerAction: $testsTimeOfAnswerAction, ')
          ..write('doesObfuscateQuestion: $doesObfuscateQuestion')
          ..write(')'))
        .toString();
  }
}

class $FieldsTable extends Fields with TableInfo<$FieldsTable, Field> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _userAccountIdMeta =
      const VerificationMeta('userAccountId');
  @override
  late final GeneratedColumn<String> userAccountId = GeneratedColumn<String>(
      'user_account_id', aliasedName, false,
      check: () => userAccountId
          .trim()
          .length
          .isBiggerOrEqualValue(Fields.MINIMUM_LENGTH_OF_USER_ACCOUNT_ID),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      check: () =>
          name
              .trim()
              .length
              .isBiggerOrEqualValue(Fields.MINIMUM_LENGTH_OF_NAME) &
          name.length.isSmallerOrEqualValue(Fields.MAXIMUM_LENGTH_OF_NAME),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userAccountId, name];
  @override
  String get aliasedName => _alias ?? 'fields';
  @override
  String get actualTableName => 'fields';
  @override
  VerificationContext validateIntegrity(Insertable<Field> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_account_id')) {
      context.handle(
          _userAccountIdMeta,
          userAccountId.isAcceptableOrUnknown(
              data['user_account_id']!, _userAccountIdMeta));
    } else if (isInserting) {
      context.missing(_userAccountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Field map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Field(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}user_account_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
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
  const Field(
      {required this.id, required this.userAccountId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_account_id'] = Variable<String>(userAccountId);
    map['name'] = Variable<String>(name);
    return map;
  }

  FieldsCompanion toCompanion(bool nullToAbsent) {
    return FieldsCompanion(
      id: Value(id),
      userAccountId: Value(userAccountId),
      name: Value(name),
    );
  }

  factory Field.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Field(
      id: serializer.fromJson<String>(json['id']),
      userAccountId: serializer.fromJson<String>(json['userAccountId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userAccountId': serializer.toJson<String>(userAccountId),
      'name': serializer.toJson<String>(name),
    };
  }

  Field copyWith({String? id, String? userAccountId, String? name}) => Field(
        id: id ?? this.id,
        userAccountId: userAccountId ?? this.userAccountId,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Field(')
          ..write('id: $id, ')
          ..write('userAccountId: $userAccountId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userAccountId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Field &&
          other.id == this.id &&
          other.userAccountId == this.userAccountId &&
          other.name == this.name);
}

class FieldsCompanion extends UpdateCompanion<Field> {
  final Value<String> id;
  final Value<String> userAccountId;
  final Value<String> name;
  const FieldsCompanion({
    this.id = const Value.absent(),
    this.userAccountId = const Value.absent(),
    this.name = const Value.absent(),
  });
  FieldsCompanion.insert({
    this.id = const Value.absent(),
    required String userAccountId,
    required String name,
  })  : userAccountId = Value(userAccountId),
        name = Value(name);
  static Insertable<Field> custom({
    Expression<String>? id,
    Expression<String>? userAccountId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userAccountId != null) 'user_account_id': userAccountId,
      if (name != null) 'name': name,
    });
  }

  FieldsCompanion copyWith(
      {Value<String>? id, Value<String>? userAccountId, Value<String>? name}) {
    return FieldsCompanion(
      id: id ?? this.id,
      userAccountId: userAccountId ?? this.userAccountId,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldsCompanion(')
          ..write('id: $id, ')
          ..write('userAccountId: $userAccountId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EntryTextsTable entryTexts = $EntryTextsTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $EntrysTable entrys = $EntrysTable(this);
  late final $FieldListsTable fieldLists = $FieldListsTable(this);
  late final $FieldsTable fields = $FieldsTable(this);
  late final EntryTextsDao entryTextsDao = EntryTextsDao(this as AppDatabase);
  late final QuestionsDao questionsDao = QuestionsDao(this as AppDatabase);
  late final EntrysDao entrysDao = EntrysDao(this as AppDatabase);
  late final FieldListsDao fieldListsDao = FieldListsDao(this as AppDatabase);
  late final FieldsDao fieldsDao = FieldsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [entryTexts, questions, entrys, fieldLists, fields];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
