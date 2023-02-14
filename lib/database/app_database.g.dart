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
      check: () => creationAt.isSmallerThanValue(clock.now().toUtc()),
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true);
  static const VerificationMeta _lastModificationAtMeta =
      const VerificationMeta('lastModificationAt');
  @override
  late final GeneratedColumn<DateTime> lastModificationAt =
      GeneratedColumn<DateTime>('last_modification_at', aliasedName, false,
          check: () =>
              lastModificationAt.isSmallerThanValue(clock.now().toUtc()) &
              lastModificationAt.isBiggerOrEqual(creationAt),
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
    required int rank,
    required int askedCount,
    required int wronglyAnsweredCount,
  })  : fieldListId = Value(fieldListId),
        answerId = Value(answerId),
        questionId = Value(questionId),
        creationAt = Value(creationAt),
        lastModificationAt = Value(lastModificationAt),
        order = Value(order),
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
          ..write('rank: $rank, ')
          ..write('askedCount: $askedCount, ')
          ..write('wronglyAnsweredCount: $wronglyAnsweredCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EntryTextsTable entryTexts = $EntryTextsTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $EntrysTable entrys = $EntrysTable(this);
  late final EntryTextsDao entryTextsDao = EntryTextsDao(this as AppDatabase);
  late final QuestionsDao questionsDao = QuestionsDao(this as AppDatabase);
  late final EntrysDao entrysDao = EntrysDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [entryTexts, questions, entrys];
}
