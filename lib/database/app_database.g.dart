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
  final Value<int> rowid;
  const EntryTextsCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryTextsCompanion.insert({
    this.id = const Value.absent(),
    required String value,
    this.rowid = const Value.absent(),
  }) : value = Value(value);
  static Insertable<EntryText> custom({
    Expression<String>? id,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryTextsCompanion copyWith(
      {Value<String>? id, Value<String>? value, Value<int>? rowid}) {
    return EntryTextsCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryTextsCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
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
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.questionType = const Value.absent(),
    this.address = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int questionType,
    required String address,
    this.rowid = const Value.absent(),
  })  : questionType = Value(questionType),
        address = Value(address);
  static Insertable<Question> custom({
    Expression<String>? id,
    Expression<int>? questionType,
    Expression<String>? address,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionType != null) 'question_type': questionType,
      if (address != null) 'address': address,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith(
      {Value<String>? id,
      Value<int>? questionType,
      Value<String>? address,
      Value<int>? rowid}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      questionType: questionType ?? this.questionType,
      address: address ?? this.address,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('questionType: $questionType, ')
          ..write('address: $address, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _usageCountMeta =
      const VerificationMeta('usageCount');
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
      'usage_count', aliasedName, false,
      check: () =>
          usageCount.isBiggerOrEqualValue(Fields.MINIMUM_USAGE_COUNT) &
          usageCount.isSmallerOrEqualValue(Fields.MAXIMUM_USAGE_COUNT),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(Fields.DEFAULT_USAGE_COUNT));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      check: () =>
          color.isBiggerOrEqualValue(Fields.MINIMUM_COLOR) &
          color.isSmallerOrEqualValue(Fields.MAXIMUM_COLOR),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(Fields.DEFAULT_COLOR));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userAccountId,
        name,
        creationAt,
        lastModificationAt,
        usageCount,
        color
      ];
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
      creationAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_at'])!,
      lastModificationAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_modification_at'])!,
      usageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_count'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
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
  const Field(
      {required this.id,
      required this.userAccountId,
      required this.name,
      required this.creationAt,
      required this.lastModificationAt,
      required this.usageCount,
      required this.color});
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

  factory Field.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Field(
      id: serializer.fromJson<String>(json['id']),
      userAccountId: serializer.fromJson<String>(json['userAccountId']),
      name: serializer.fromJson<String>(json['name']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt:
          serializer.fromJson<DateTime>(json['lastModificationAt']),
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

  Field copyWith(
          {String? id,
          String? userAccountId,
          String? name,
          DateTime? creationAt,
          DateTime? lastModificationAt,
          int? usageCount,
          int? color}) =>
      Field(
        id: id ?? this.id,
        userAccountId: userAccountId ?? this.userAccountId,
        name: name ?? this.name,
        creationAt: creationAt ?? this.creationAt,
        lastModificationAt: lastModificationAt ?? this.lastModificationAt,
        usageCount: usageCount ?? this.usageCount,
        color: color ?? this.color,
      );
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
  int get hashCode => Object.hash(id, userAccountId, name, creationAt,
      lastModificationAt, usageCount, color);
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
  })  : userAccountId = Value(userAccountId),
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

  FieldsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userAccountId,
      Value<String>? name,
      Value<DateTime>? creationAt,
      Value<DateTime>? lastModificationAt,
      Value<int>? usageCount,
      Value<int>? color,
      Value<int>? rowid}) {
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
      map['last_modification_at'] =
          Variable<DateTime>(lastModificationAt.value);
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
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _fieldIdMeta =
      const VerificationMeta('fieldId');
  @override
  late final GeneratedColumn<String> fieldId = GeneratedColumn<String>(
      'field_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fields (id)'));
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
  late final GeneratedColumn<bool> doesReadAnswer = GeneratedColumn<bool>(
      'does_read_answer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("does_read_answer" IN (0, 1))'),
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
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("does_obfuscate_question" IN (0, 1))'),
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
      Value<bool>? doesObfuscateQuestion,
      Value<int>? rowid}) {
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
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _fieldListIdMeta =
      const VerificationMeta('fieldListId');
  @override
  late final GeneratedColumn<String> fieldListId = GeneratedColumn<String>(
      'field_list_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES field_lists (id)'));
  static const VerificationMeta _answerIdMeta =
      const VerificationMeta('answerId');
  @override
  late final GeneratedColumn<String> answerId = GeneratedColumn<String>(
      'answer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES entry_texts (id)'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES questions (id)'));
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
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("did_asked_at_current_test_round" IN (0, 1))'));
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
  final Value<int> rowid;
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
    this.rowid = const Value.absent(),
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
    this.rowid = const Value.absent(),
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
    Expression<int>? rowid,
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
      if (rowid != null) 'rowid': rowid,
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
      Value<int>? wronglyAnsweredCount,
      Value<int>? rowid}) {
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
          ..write('answerId: $answerId, ')
          ..write('questionId: $questionId, ')
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

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _relationalIdMeta =
      const VerificationMeta('relationalId');
  @override
  late final GeneratedColumn<String> relationalId = GeneratedColumn<String>(
      'relational_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _texTMeta = const VerificationMeta('texT');
  @override
  late final GeneratedColumn<String> texT = GeneratedColumn<String>(
      'tex_t', aliasedName, false,
      check: () =>
          texT
              .trim()
              .length
              .isBiggerOrEqualValue(Notes.MINIMUM_LENGTH_OF_TEXT) &
          texT.length.isSmallerOrEqualValue(Notes.MAXIMUM_LENGTH_OF_TEXT),
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, relationalId, texT, creationAt, lastModificationAt];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('relational_id')) {
      context.handle(
          _relationalIdMeta,
          relationalId.isAcceptableOrUnknown(
              data['relational_id']!, _relationalIdMeta));
    } else if (isInserting) {
      context.missing(_relationalIdMeta);
    }
    if (data.containsKey('tex_t')) {
      context.handle(
          _texTMeta, texT.isAcceptableOrUnknown(data['tex_t']!, _texTMeta));
    } else if (isInserting) {
      context.missing(_texTMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      relationalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relational_id'])!,
      texT: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tex_t'])!,
      creationAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_at'])!,
      lastModificationAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_modification_at'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String relationalId;
  final String texT;
  final DateTime creationAt;
  final DateTime lastModificationAt;
  const Note(
      {required this.id,
      required this.relationalId,
      required this.texT,
      required this.creationAt,
      required this.lastModificationAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['relational_id'] = Variable<String>(relationalId);
    map['tex_t'] = Variable<String>(texT);
    map['creation_at'] = Variable<DateTime>(creationAt);
    map['last_modification_at'] = Variable<DateTime>(lastModificationAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      relationalId: Value(relationalId),
      texT: Value(texT),
      creationAt: Value(creationAt),
      lastModificationAt: Value(lastModificationAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      relationalId: serializer.fromJson<String>(json['relationalId']),
      texT: serializer.fromJson<String>(json['texT']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt:
          serializer.fromJson<DateTime>(json['lastModificationAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'relationalId': serializer.toJson<String>(relationalId),
      'texT': serializer.toJson<String>(texT),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
    };
  }

  Note copyWith(
          {String? id,
          String? relationalId,
          String? texT,
          DateTime? creationAt,
          DateTime? lastModificationAt}) =>
      Note(
        id: id ?? this.id,
        relationalId: relationalId ?? this.relationalId,
        texT: texT ?? this.texT,
        creationAt: creationAt ?? this.creationAt,
        lastModificationAt: lastModificationAt ?? this.lastModificationAt,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('relationalId: $relationalId, ')
          ..write('texT: $texT, ')
          ..write('creationAt: $creationAt, ')
          ..write('lastModificationAt: $lastModificationAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, relationalId, texT, creationAt, lastModificationAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.relationalId == this.relationalId &&
          other.texT == this.texT &&
          other.creationAt == this.creationAt &&
          other.lastModificationAt == this.lastModificationAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> relationalId;
  final Value<String> texT;
  final Value<DateTime> creationAt;
  final Value<DateTime> lastModificationAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.relationalId = const Value.absent(),
    this.texT = const Value.absent(),
    this.creationAt = const Value.absent(),
    this.lastModificationAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String relationalId,
    required String texT,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    this.rowid = const Value.absent(),
  })  : relationalId = Value(relationalId),
        texT = Value(texT),
        creationAt = Value(creationAt),
        lastModificationAt = Value(lastModificationAt);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? relationalId,
    Expression<String>? texT,
    Expression<DateTime>? creationAt,
    Expression<DateTime>? lastModificationAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (relationalId != null) 'relational_id': relationalId,
      if (texT != null) 'tex_t': texT,
      if (creationAt != null) 'creation_at': creationAt,
      if (lastModificationAt != null)
        'last_modification_at': lastModificationAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? id,
      Value<String>? relationalId,
      Value<String>? texT,
      Value<DateTime>? creationAt,
      Value<DateTime>? lastModificationAt,
      Value<int>? rowid}) {
    return NotesCompanion(
      id: id ?? this.id,
      relationalId: relationalId ?? this.relationalId,
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
    if (relationalId.present) {
      map['relational_id'] = Variable<String>(relationalId.value);
    }
    if (texT.present) {
      map['tex_t'] = Variable<String>(texT.value);
    }
    if (creationAt.present) {
      map['creation_at'] = Variable<DateTime>(creationAt.value);
    }
    if (lastModificationAt.present) {
      map['last_modification_at'] =
          Variable<DateTime>(lastModificationAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('relationalId: $relationalId, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _fieldListIdMeta =
      const VerificationMeta('fieldListId');
  @override
  late final GeneratedColumn<String> fieldListId = GeneratedColumn<String>(
      'field_list_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES field_lists (id)'));
  static const VerificationMeta _currentQuestionCounterMeta =
      const VerificationMeta('currentQuestionCounter');
  @override
  late final GeneratedColumn<int> currentQuestionCounter = GeneratedColumn<int>(
      'current_question_counter', aliasedName, false,
      check: () =>
          currentQuestionCounter
              .isBiggerOrEqualValue(Sessions.MINIMUM_CURRENT_QUESTION_COUNTER) &
          currentQuestionCounter
              .isSmallerOrEqualValue(Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _triesNumberMeta =
      const VerificationMeta('triesNumber');
  @override
  late final GeneratedColumn<int> triesNumber = GeneratedColumn<int>(
      'tries_number', aliasedName, false,
      check: () =>
          triesNumber.isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_NUMBER) &
          triesNumber.isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_NUMBER),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _triesCounterMeta =
      const VerificationMeta('triesCounter');
  @override
  late final GeneratedColumn<int> triesCounter = GeneratedColumn<int>(
      'tries_counter', aliasedName, false,
      check: () =>
          triesCounter.isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_COUNTER) &
          triesCounter.isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_COUNTER) &
          triesCounter.isSmallerThan(triesNumber),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _elapsedTimeMeta =
      const VerificationMeta('elapsedTime');
  @override
  late final GeneratedColumn<int> elapsedTime = GeneratedColumn<int>(
      'elapsed_time', aliasedName, false,
      check: () =>
          elapsedTime.isBiggerOrEqualValue(Sessions.MINIMUM_ELAPSED_TIME),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _lastCheckedAnswerResultMeta =
      const VerificationMeta('lastCheckedAnswerResult');
  @override
  late final GeneratedColumn<bool> lastCheckedAnswerResult =
      GeneratedColumn<bool>('last_checked_answer_result', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("last_checked_answer_result" IN (0, 1))'),
          defaultValue: Constant(false));
  static const VerificationMeta _shouldCheckAnAnswerMeta =
      const VerificationMeta('shouldCheckAnAnswer');
  @override
  late final GeneratedColumn<bool> shouldCheckAnAnswer = GeneratedColumn<bool>(
      'should_check_an_answer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("should_check_an_answer" IN (0, 1))'),
      defaultValue: Constant(true));
  static const VerificationMeta _currentHintCounterMeta =
      const VerificationMeta('currentHintCounter');
  @override
  late final GeneratedColumn<int> currentHintCounter = GeneratedColumn<int>(
      'current_hint_counter', aliasedName, false,
      check: () =>
          currentHintCounter
              .isBiggerOrEqualValue(Sessions.MINIMUM_CURRENT_HINT_COUNTER) &
          currentHintCounter
              .isSmallerOrEqualValue(Sessions.MAXIMUM_CURRENT_HINT_COUNTER),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
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
        lastModificationAt
      ];
  @override
  String get aliasedName => _alias ?? 'sessions';
  @override
  String get actualTableName => 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
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
    if (data.containsKey('current_question_counter')) {
      context.handle(
          _currentQuestionCounterMeta,
          currentQuestionCounter.isAcceptableOrUnknown(
              data['current_question_counter']!, _currentQuestionCounterMeta));
    } else if (isInserting) {
      context.missing(_currentQuestionCounterMeta);
    }
    if (data.containsKey('tries_number')) {
      context.handle(
          _triesNumberMeta,
          triesNumber.isAcceptableOrUnknown(
              data['tries_number']!, _triesNumberMeta));
    } else if (isInserting) {
      context.missing(_triesNumberMeta);
    }
    if (data.containsKey('tries_counter')) {
      context.handle(
          _triesCounterMeta,
          triesCounter.isAcceptableOrUnknown(
              data['tries_counter']!, _triesCounterMeta));
    }
    if (data.containsKey('elapsed_time')) {
      context.handle(
          _elapsedTimeMeta,
          elapsedTime.isAcceptableOrUnknown(
              data['elapsed_time']!, _elapsedTimeMeta));
    } else if (isInserting) {
      context.missing(_elapsedTimeMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('last_checked_answer_result')) {
      context.handle(
          _lastCheckedAnswerResultMeta,
          lastCheckedAnswerResult.isAcceptableOrUnknown(
              data['last_checked_answer_result']!,
              _lastCheckedAnswerResultMeta));
    }
    if (data.containsKey('should_check_an_answer')) {
      context.handle(
          _shouldCheckAnAnswerMeta,
          shouldCheckAnAnswer.isAcceptableOrUnknown(
              data['should_check_an_answer']!, _shouldCheckAnAnswerMeta));
    }
    if (data.containsKey('current_hint_counter')) {
      context.handle(
          _currentHintCounterMeta,
          currentHintCounter.isAcceptableOrUnknown(
              data['current_hint_counter']!, _currentHintCounterMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fieldListId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_list_id'])!,
      currentQuestionCounter: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}current_question_counter'])!,
      triesNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tries_number'])!,
      triesCounter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tries_counter'])!,
      elapsedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}elapsed_time'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      lastCheckedAnswerResult: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}last_checked_answer_result'])!,
      shouldCheckAnAnswer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}should_check_an_answer'])!,
      currentHintCounter: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_hint_counter'])!,
      creationAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_at'])!,
      lastModificationAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_modification_at'])!,
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
  const Session(
      {required this.id,
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
      required this.lastModificationAt});
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

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      fieldListId: serializer.fromJson<String>(json['fieldListId']),
      currentQuestionCounter:
          serializer.fromJson<int>(json['currentQuestionCounter']),
      triesNumber: serializer.fromJson<int>(json['triesNumber']),
      triesCounter: serializer.fromJson<int>(json['triesCounter']),
      elapsedTime: serializer.fromJson<int>(json['elapsedTime']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      lastCheckedAnswerResult:
          serializer.fromJson<bool>(json['lastCheckedAnswerResult']),
      shouldCheckAnAnswer:
          serializer.fromJson<bool>(json['shouldCheckAnAnswer']),
      currentHintCounter: serializer.fromJson<int>(json['currentHintCounter']),
      creationAt: serializer.fromJson<DateTime>(json['creationAt']),
      lastModificationAt:
          serializer.fromJson<DateTime>(json['lastModificationAt']),
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
      'lastCheckedAnswerResult':
          serializer.toJson<bool>(lastCheckedAnswerResult),
      'shouldCheckAnAnswer': serializer.toJson<bool>(shouldCheckAnAnswer),
      'currentHintCounter': serializer.toJson<int>(currentHintCounter),
      'creationAt': serializer.toJson<DateTime>(creationAt),
      'lastModificationAt': serializer.toJson<DateTime>(lastModificationAt),
    };
  }

  Session copyWith(
          {String? id,
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
          DateTime? lastModificationAt}) =>
      Session(
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
      lastModificationAt);
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
  })  : fieldListId = Value(fieldListId),
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

  SessionsCompanion copyWith(
      {Value<String>? id,
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
      Value<int>? rowid}) {
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
      map['current_question_counter'] =
          Variable<int>(currentQuestionCounter.value);
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
      map['last_checked_answer_result'] =
          Variable<bool>(lastCheckedAnswerResult.value);
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
      map['last_modification_at'] =
          Variable<DateTime>(lastModificationAt.value);
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
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES entrys (id)'));
  @override
  List<GeneratedColumn> get $columns => [sessionId, entryId];
  @override
  String get aliasedName => _alias ?? 'session_entrys';
  @override
  String get actualTableName => 'session_entrys';
  @override
  VerificationContext validateIntegrity(Insertable<SessionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
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
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
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

  factory SessionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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
  })  : sessionId = Value(sessionId),
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

  SessionEntrysCompanion copyWith(
      {Value<String>? sessionId, Value<String>? entryId, Value<int>? rowid}) {
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
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _wrongAnswerCounterMeta =
      const VerificationMeta('wrongAnswerCounter');
  @override
  late final GeneratedColumn<int> wrongAnswerCounter = GeneratedColumn<int>(
      'wrong_answer_counter', aliasedName, false,
      check: () =>
          wrongAnswerCounter
              .isBiggerOrEqualValue(TestSessions.MINIMUM_WRONG_ANSWER_COUNTER) &
          wrongAnswerCounter
              .isSmallerOrEqualValue(TestSessions.MAXIMUM_WRONG_ANSWER_COUNTER),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _lastAnswerMeta =
      const VerificationMeta('lastAnswer');
  @override
  late final GeneratedColumn<String> lastAnswer = GeneratedColumn<String>(
      'last_answer', aliasedName, true,
      check: () => lastAnswer
          .trim()
          .length
          .isBiggerOrEqualValue(TestSessions.MINIMUM_LAST_ANSWER),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [sessionId, wrongAnswerCounter, lastAnswer];
  @override
  String get aliasedName => _alias ?? 'test_sessions';
  @override
  String get actualTableName => 'test_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<TestSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('wrong_answer_counter')) {
      context.handle(
          _wrongAnswerCounterMeta,
          wrongAnswerCounter.isAcceptableOrUnknown(
              data['wrong_answer_counter']!, _wrongAnswerCounterMeta));
    }
    if (data.containsKey('last_answer')) {
      context.handle(
          _lastAnswerMeta,
          lastAnswer.isAcceptableOrUnknown(
              data['last_answer']!, _lastAnswerMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId};
  @override
  TestSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestSession(
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      wrongAnswerCounter: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}wrong_answer_counter'])!,
      lastAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_answer']),
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
  const TestSession(
      {required this.sessionId,
      required this.wrongAnswerCounter,
      this.lastAnswer});
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

  factory TestSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  TestSession copyWith(
          {String? sessionId,
          int? wrongAnswerCounter,
          Value<String?> lastAnswer = const Value.absent()}) =>
      TestSession(
        sessionId: sessionId ?? this.sessionId,
        wrongAnswerCounter: wrongAnswerCounter ?? this.wrongAnswerCounter,
        lastAnswer: lastAnswer.present ? lastAnswer.value : this.lastAnswer,
      );
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

  TestSessionsCompanion copyWith(
      {Value<String>? sessionId,
      Value<int>? wrongAnswerCounter,
      Value<String?>? lastAnswer,
      Value<int>? rowid}) {
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
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES entrys (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      check: () => value
          .trim()
          .length
          .isBiggerOrEqualValue(WrongAnswers.MINIMUM_VALUE_LENGTH),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, entryId, value];
  @override
  String get aliasedName => _alias ?? 'wrong_answers';
  @override
  String get actualTableName => 'wrong_answers';
  @override
  VerificationContext validateIntegrity(Insertable<WrongAnswer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
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
  WrongAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WrongAnswer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
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
  const WrongAnswer(
      {required this.id,
      required this.sessionId,
      required this.entryId,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['entry_id'] = Variable<String>(entryId);
    map['value'] = Variable<String>(value);
    return map;
  }

  WrongAnswersCompanion toCompanion(bool nullToAbsent) {
    return WrongAnswersCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      entryId: Value(entryId),
      value: Value(value),
    );
  }

  factory WrongAnswer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WrongAnswer(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      entryId: serializer.fromJson<String>(json['entryId']),
      value: serializer.fromJson<String>(json['value']),
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
    };
  }

  WrongAnswer copyWith(
          {String? id, String? sessionId, String? entryId, String? value}) =>
      WrongAnswer(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        entryId: entryId ?? this.entryId,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('WrongAnswer(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('entryId: $entryId, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, entryId, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswer &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.entryId == this.entryId &&
          other.value == this.value);
}

class WrongAnswersCompanion extends UpdateCompanion<WrongAnswer> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> entryId;
  final Value<String> value;
  final Value<int> rowid;
  const WrongAnswersCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WrongAnswersCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required String entryId,
    required String value,
    this.rowid = const Value.absent(),
  })  : sessionId = Value(sessionId),
        entryId = Value(entryId),
        value = Value(value);
  static Insertable<WrongAnswer> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? entryId,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (entryId != null) 'entry_id': entryId,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WrongAnswersCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? entryId,
      Value<String>? value,
      Value<int>? rowid}) {
    return WrongAnswersCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      entryId: entryId ?? this.entryId,
      value: value ?? this.value,
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $EntryTextsTable entryTexts = $EntryTextsTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $FieldsTable fields = $FieldsTable(this);
  late final $FieldListsTable fieldLists = $FieldListsTable(this);
  late final $EntrysTable entrys = $EntrysTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionEntrysTable sessionEntrys = $SessionEntrysTable(this);
  late final $TestSessionsTable testSessions = $TestSessionsTable(this);
  late final $WrongAnswersTable wrongAnswers = $WrongAnswersTable(this);
  late final EntryTextsDao entryTextsDao = EntryTextsDao(this as AppDatabase);
  late final QuestionsDao questionsDao = QuestionsDao(this as AppDatabase);
  late final EntrysDao entrysDao = EntrysDao(this as AppDatabase);
  late final FieldListsDao fieldListsDao = FieldListsDao(this as AppDatabase);
  late final FieldsDao fieldsDao = FieldsDao(this as AppDatabase);
  late final NotesDao notesDao = NotesDao(this as AppDatabase);
  late final SessionsDao sessionsDao = SessionsDao(this as AppDatabase);
  late final SessionEntrysDao sessionEntrysDao =
      SessionEntrysDao(this as AppDatabase);
  late final TestSessionsDao testSessionsDao =
      TestSessionsDao(this as AppDatabase);
  late final WrongAnswersDao wrongAnswersDao =
      WrongAnswersDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        entryTexts,
        questions,
        fields,
        fieldLists,
        entrys,
        notes,
        sessions,
        sessionEntrys,
        testSessions,
        wrongAnswers
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
