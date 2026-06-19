// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppSetting(
    key: key ?? this.key,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEmailVerifiedMeta = const VerificationMeta(
    'isEmailVerified',
  );
  @override
  late final GeneratedColumn<bool> isEmailVerified = GeneratedColumn<bool>(
    'is_email_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_email_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  profileJson = GeneratedColumn<String>(
    'profile_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<Map<String, dynamic>?>(
    $LocalUsersTable.$converterprofileJson,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  statsJson = GeneratedColumn<String>(
    'stats_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<Map<String, dynamic>?>($LocalUsersTable.$converterstatsJson);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  subscriptionJson = GeneratedColumn<String>(
    'subscription_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<Map<String, dynamic>?>(
    $LocalUsersTable.$convertersubscriptionJson,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    username,
    email,
    isEmailVerified,
    profileJson,
    statsJson,
    subscriptionJson,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('is_email_verified')) {
      context.handle(
        _isEmailVerifiedMeta,
        isEmailVerified.isAcceptableOrUnknown(
          data['is_email_verified']!,
          _isEmailVerifiedMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      isEmailVerified:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_email_verified'],
          )!,
      profileJson: $LocalUsersTable.$converterprofileJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}profile_json'],
        ),
      ),
      statsJson: $LocalUsersTable.$converterstatsJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}stats_json'],
        ),
      ),
      subscriptionJson: $LocalUsersTable.$convertersubscriptionJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subscription_json'],
        ),
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $converterprofileJson =
      const NullableJsonMapConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converterstatsJson =
      const NullableJsonMapConverter();
  static TypeConverter<Map<String, dynamic>?, String?>
  $convertersubscriptionJson = const NullableJsonMapConverter();
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final int id;
  final String? serverId;
  final String username;
  final String? email;
  final bool isEmailVerified;
  final Map<String, dynamic>? profileJson;
  final Map<String, dynamic>? statsJson;
  final Map<String, dynamic>? subscriptionJson;
  final DateTime? lastSyncedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalUser({
    required this.id,
    this.serverId,
    required this.username,
    this.email,
    required this.isEmailVerified,
    this.profileJson,
    this.statsJson,
    this.subscriptionJson,
    this.lastSyncedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['is_email_verified'] = Variable<bool>(isEmailVerified);
    if (!nullToAbsent || profileJson != null) {
      map['profile_json'] = Variable<String>(
        $LocalUsersTable.$converterprofileJson.toSql(profileJson),
      );
    }
    if (!nullToAbsent || statsJson != null) {
      map['stats_json'] = Variable<String>(
        $LocalUsersTable.$converterstatsJson.toSql(statsJson),
      );
    }
    if (!nullToAbsent || subscriptionJson != null) {
      map['subscription_json'] = Variable<String>(
        $LocalUsersTable.$convertersubscriptionJson.toSql(subscriptionJson),
      );
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      username: Value(username),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      isEmailVerified: Value(isEmailVerified),
      profileJson:
          profileJson == null && nullToAbsent
              ? const Value.absent()
              : Value(profileJson),
      statsJson:
          statsJson == null && nullToAbsent
              ? const Value.absent()
              : Value(statsJson),
      subscriptionJson:
          subscriptionJson == null && nullToAbsent
              ? const Value.absent()
              : Value(subscriptionJson),
      lastSyncedAt:
          lastSyncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      isEmailVerified: serializer.fromJson<bool>(json['isEmailVerified']),
      profileJson: serializer.fromJson<Map<String, dynamic>?>(
        json['profileJson'],
      ),
      statsJson: serializer.fromJson<Map<String, dynamic>?>(json['statsJson']),
      subscriptionJson: serializer.fromJson<Map<String, dynamic>?>(
        json['subscriptionJson'],
      ),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String?>(email),
      'isEmailVerified': serializer.toJson<bool>(isEmailVerified),
      'profileJson': serializer.toJson<Map<String, dynamic>?>(profileJson),
      'statsJson': serializer.toJson<Map<String, dynamic>?>(statsJson),
      'subscriptionJson': serializer.toJson<Map<String, dynamic>?>(
        subscriptionJson,
      ),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalUser copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    String? username,
    Value<String?> email = const Value.absent(),
    bool? isEmailVerified,
    Value<Map<String, dynamic>?> profileJson = const Value.absent(),
    Value<Map<String, dynamic>?> statsJson = const Value.absent(),
    Value<Map<String, dynamic>?> subscriptionJson = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalUser(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    username: username ?? this.username,
    email: email.present ? email.value : this.email,
    isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    profileJson: profileJson.present ? profileJson.value : this.profileJson,
    statsJson: statsJson.present ? statsJson.value : this.statsJson,
    subscriptionJson:
        subscriptionJson.present
            ? subscriptionJson.value
            : this.subscriptionJson,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      isEmailVerified:
          data.isEmailVerified.present
              ? data.isEmailVerified.value
              : this.isEmailVerified,
      profileJson:
          data.profileJson.present ? data.profileJson.value : this.profileJson,
      statsJson: data.statsJson.present ? data.statsJson.value : this.statsJson,
      subscriptionJson:
          data.subscriptionJson.present
              ? data.subscriptionJson.value
              : this.subscriptionJson,
      lastSyncedAt:
          data.lastSyncedAt.present
              ? data.lastSyncedAt.value
              : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('isEmailVerified: $isEmailVerified, ')
          ..write('profileJson: $profileJson, ')
          ..write('statsJson: $statsJson, ')
          ..write('subscriptionJson: $subscriptionJson, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    username,
    email,
    isEmailVerified,
    profileJson,
    statsJson,
    subscriptionJson,
    lastSyncedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.username == this.username &&
          other.email == this.email &&
          other.isEmailVerified == this.isEmailVerified &&
          other.profileJson == this.profileJson &&
          other.statsJson == this.statsJson &&
          other.subscriptionJson == this.subscriptionJson &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<String> username;
  final Value<String?> email;
  final Value<bool> isEmailVerified;
  final Value<Map<String, dynamic>?> profileJson;
  final Value<Map<String, dynamic>?> statsJson;
  final Value<Map<String, dynamic>?> subscriptionJson;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.isEmailVerified = const Value.absent(),
    this.profileJson = const Value.absent(),
    this.statsJson = const Value.absent(),
    this.subscriptionJson = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required String username,
    this.email = const Value.absent(),
    this.isEmailVerified = const Value.absent(),
    this.profileJson = const Value.absent(),
    this.statsJson = const Value.absent(),
    this.subscriptionJson = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : username = Value(username);
  static Insertable<LocalUser> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? username,
    Expression<String>? email,
    Expression<bool>? isEmailVerified,
    Expression<String>? profileJson,
    Expression<String>? statsJson,
    Expression<String>? subscriptionJson,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (isEmailVerified != null) 'is_email_verified': isEmailVerified,
      if (profileJson != null) 'profile_json': profileJson,
      if (statsJson != null) 'stats_json': statsJson,
      if (subscriptionJson != null) 'subscription_json': subscriptionJson,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalUsersCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<String>? username,
    Value<String?>? email,
    Value<bool>? isEmailVerified,
    Value<Map<String, dynamic>?>? profileJson,
    Value<Map<String, dynamic>?>? statsJson,
    Value<Map<String, dynamic>?>? subscriptionJson,
    Value<DateTime?>? lastSyncedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      username: username ?? this.username,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      profileJson: profileJson ?? this.profileJson,
      statsJson: statsJson ?? this.statsJson,
      subscriptionJson: subscriptionJson ?? this.subscriptionJson,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isEmailVerified.present) {
      map['is_email_verified'] = Variable<bool>(isEmailVerified.value);
    }
    if (profileJson.present) {
      map['profile_json'] = Variable<String>(
        $LocalUsersTable.$converterprofileJson.toSql(profileJson.value),
      );
    }
    if (statsJson.present) {
      map['stats_json'] = Variable<String>(
        $LocalUsersTable.$converterstatsJson.toSql(statsJson.value),
      );
    }
    if (subscriptionJson.present) {
      map['subscription_json'] = Variable<String>(
        $LocalUsersTable.$convertersubscriptionJson.toSql(
          subscriptionJson.value,
        ),
      );
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('isEmailVerified: $isEmailVerified, ')
          ..write('profileJson: $profileJson, ')
          ..write('statsJson: $statsJson, ')
          ..write('subscriptionJson: $subscriptionJson, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WorkspacesTable extends Workspaces
    with TableInfo<$WorkspacesTable, Workspace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workspaceTypeMeta = const VerificationMeta(
    'workspaceType',
  );
  @override
  late final GeneratedColumn<String> workspaceType = GeneratedColumn<String>(
    'workspace_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceTypeNameMeta = const VerificationMeta(
    'workspaceTypeName',
  );
  @override
  late final GeneratedColumn<String> workspaceTypeName =
      GeneratedColumn<String>(
        'workspace_type_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _accessCodeMeta = const VerificationMeta(
    'accessCode',
  );
  @override
  late final GeneratedColumn<String> accessCode = GeneratedColumn<String>(
    'access_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPublicMeta = const VerificationMeta(
    'isPublic',
  );
  @override
  late final GeneratedColumn<bool> isPublic = GeneratedColumn<bool>(
    'is_public',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_public" IN (0, 1))',
    ),
  );
  static const VerificationMeta _requiresApprovalMeta = const VerificationMeta(
    'requiresApproval',
  );
  @override
  late final GeneratedColumn<bool> requiresApproval = GeneratedColumn<bool>(
    'requires_approval',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_approval" IN (0, 1))',
    ),
  );
  static const VerificationMeta _memberCountMeta = const VerificationMeta(
    'memberCount',
  );
  @override
  late final GeneratedColumn<int> memberCount = GeneratedColumn<int>(
    'member_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxMembersMeta = const VerificationMeta(
    'maxMembers',
  );
  @override
  late final GeneratedColumn<int> maxMembers = GeneratedColumn<int>(
    'max_members',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _channelCountMeta = const VerificationMeta(
    'channelCount',
  );
  @override
  late final GeneratedColumn<int> channelCount = GeneratedColumn<int>(
    'channel_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupCountMeta = const VerificationMeta(
    'groupCount',
  );
  @override
  late final GeneratedColumn<int> groupCount = GeneratedColumn<int>(
    'group_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentGuidelinesMeta = const VerificationMeta(
    'contentGuidelines',
  );
  @override
  late final GeneratedColumn<String> contentGuidelines =
      GeneratedColumn<String>(
        'content_guidelines',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<List<dynamic>?, String>
  rulesJson = GeneratedColumn<String>(
    'rules_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<dynamic>?>($WorkspacesTable.$converterrulesJson);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>(
    $WorkspacesTable.$convertermetadataJson,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverCreatedAtMeta = const VerificationMeta(
    'serverCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverCreatedAt =
      GeneratedColumn<DateTime>(
        'server_created_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serverUpdatedAtMeta = const VerificationMeta(
    'serverUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverUpdatedAt =
      GeneratedColumn<DateTime>(
        'server_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    name,
    description,
    workspaceType,
    workspaceTypeName,
    accessCode,
    isPublic,
    requiresApproval,
    memberCount,
    maxMembers,
    channelCount,
    groupCount,
    contentGuidelines,
    rulesJson,
    metadataJson,
    createdBy,
    serverCreatedAt,
    serverUpdatedAt,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspaces';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workspace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('workspace_type')) {
      context.handle(
        _workspaceTypeMeta,
        workspaceType.isAcceptableOrUnknown(
          data['workspace_type']!,
          _workspaceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceTypeMeta);
    }
    if (data.containsKey('workspace_type_name')) {
      context.handle(
        _workspaceTypeNameMeta,
        workspaceTypeName.isAcceptableOrUnknown(
          data['workspace_type_name']!,
          _workspaceTypeNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceTypeNameMeta);
    }
    if (data.containsKey('access_code')) {
      context.handle(
        _accessCodeMeta,
        accessCode.isAcceptableOrUnknown(data['access_code']!, _accessCodeMeta),
      );
    }
    if (data.containsKey('is_public')) {
      context.handle(
        _isPublicMeta,
        isPublic.isAcceptableOrUnknown(data['is_public']!, _isPublicMeta),
      );
    }
    if (data.containsKey('requires_approval')) {
      context.handle(
        _requiresApprovalMeta,
        requiresApproval.isAcceptableOrUnknown(
          data['requires_approval']!,
          _requiresApprovalMeta,
        ),
      );
    }
    if (data.containsKey('member_count')) {
      context.handle(
        _memberCountMeta,
        memberCount.isAcceptableOrUnknown(
          data['member_count']!,
          _memberCountMeta,
        ),
      );
    }
    if (data.containsKey('max_members')) {
      context.handle(
        _maxMembersMeta,
        maxMembers.isAcceptableOrUnknown(data['max_members']!, _maxMembersMeta),
      );
    }
    if (data.containsKey('channel_count')) {
      context.handle(
        _channelCountMeta,
        channelCount.isAcceptableOrUnknown(
          data['channel_count']!,
          _channelCountMeta,
        ),
      );
    }
    if (data.containsKey('group_count')) {
      context.handle(
        _groupCountMeta,
        groupCount.isAcceptableOrUnknown(data['group_count']!, _groupCountMeta),
      );
    }
    if (data.containsKey('content_guidelines')) {
      context.handle(
        _contentGuidelinesMeta,
        contentGuidelines.isAcceptableOrUnknown(
          data['content_guidelines']!,
          _contentGuidelinesMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('server_created_at')) {
      context.handle(
        _serverCreatedAtMeta,
        serverCreatedAt.isAcceptableOrUnknown(
          data['server_created_at']!,
          _serverCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at')) {
      context.handle(
        _serverUpdatedAtMeta,
        serverUpdatedAt.isAcceptableOrUnknown(
          data['server_updated_at']!,
          _serverUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workspace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workspace(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      workspaceType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}workspace_type'],
          )!,
      workspaceTypeName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}workspace_type_name'],
          )!,
      accessCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}access_code'],
      ),
      isPublic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_public'],
      ),
      requiresApproval: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_approval'],
      ),
      memberCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_count'],
      ),
      maxMembers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_members'],
      ),
      channelCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}channel_count'],
      ),
      groupCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_count'],
      ),
      contentGuidelines: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_guidelines'],
      ),
      rulesJson: $WorkspacesTable.$converterrulesJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rules_json'],
        ),
      ),
      metadataJson: $WorkspacesTable.$convertermetadataJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metadata_json'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      serverCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_created_at'],
      ),
      serverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_updated_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $WorkspacesTable createAlias(String alias) {
    return $WorkspacesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<dynamic>?, String?> $converterrulesJson =
      const NullableJsonListConverter();
  static TypeConverter<Map<String, dynamic>, String> $convertermetadataJson =
      const JsonMapConverter();
}

class Workspace extends DataClass implements Insertable<Workspace> {
  final int id;
  final String? serverId;
  final String name;
  final String? description;
  final String workspaceType;
  final String workspaceTypeName;
  final String? accessCode;
  final bool? isPublic;
  final bool? requiresApproval;
  final int? memberCount;
  final int? maxMembers;
  final int? channelCount;
  final int? groupCount;
  final String? contentGuidelines;
  final List<dynamic>? rulesJson;
  final Map<String, dynamic> metadataJson;
  final String? createdBy;
  final DateTime? serverCreatedAt;
  final DateTime? serverUpdatedAt;
  final DateTime? lastSyncedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Workspace({
    required this.id,
    this.serverId,
    required this.name,
    this.description,
    required this.workspaceType,
    required this.workspaceTypeName,
    this.accessCode,
    this.isPublic,
    this.requiresApproval,
    this.memberCount,
    this.maxMembers,
    this.channelCount,
    this.groupCount,
    this.contentGuidelines,
    this.rulesJson,
    required this.metadataJson,
    this.createdBy,
    this.serverCreatedAt,
    this.serverUpdatedAt,
    this.lastSyncedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['workspace_type'] = Variable<String>(workspaceType);
    map['workspace_type_name'] = Variable<String>(workspaceTypeName);
    if (!nullToAbsent || accessCode != null) {
      map['access_code'] = Variable<String>(accessCode);
    }
    if (!nullToAbsent || isPublic != null) {
      map['is_public'] = Variable<bool>(isPublic);
    }
    if (!nullToAbsent || requiresApproval != null) {
      map['requires_approval'] = Variable<bool>(requiresApproval);
    }
    if (!nullToAbsent || memberCount != null) {
      map['member_count'] = Variable<int>(memberCount);
    }
    if (!nullToAbsent || maxMembers != null) {
      map['max_members'] = Variable<int>(maxMembers);
    }
    if (!nullToAbsent || channelCount != null) {
      map['channel_count'] = Variable<int>(channelCount);
    }
    if (!nullToAbsent || groupCount != null) {
      map['group_count'] = Variable<int>(groupCount);
    }
    if (!nullToAbsent || contentGuidelines != null) {
      map['content_guidelines'] = Variable<String>(contentGuidelines);
    }
    if (!nullToAbsent || rulesJson != null) {
      map['rules_json'] = Variable<String>(
        $WorkspacesTable.$converterrulesJson.toSql(rulesJson),
      );
    }
    {
      map['metadata_json'] = Variable<String>(
        $WorkspacesTable.$convertermetadataJson.toSql(metadataJson),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || serverCreatedAt != null) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt);
    }
    if (!nullToAbsent || serverUpdatedAt != null) {
      map['server_updated_at'] = Variable<DateTime>(serverUpdatedAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkspacesCompanion toCompanion(bool nullToAbsent) {
    return WorkspacesCompanion(
      id: Value(id),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      workspaceType: Value(workspaceType),
      workspaceTypeName: Value(workspaceTypeName),
      accessCode:
          accessCode == null && nullToAbsent
              ? const Value.absent()
              : Value(accessCode),
      isPublic:
          isPublic == null && nullToAbsent
              ? const Value.absent()
              : Value(isPublic),
      requiresApproval:
          requiresApproval == null && nullToAbsent
              ? const Value.absent()
              : Value(requiresApproval),
      memberCount:
          memberCount == null && nullToAbsent
              ? const Value.absent()
              : Value(memberCount),
      maxMembers:
          maxMembers == null && nullToAbsent
              ? const Value.absent()
              : Value(maxMembers),
      channelCount:
          channelCount == null && nullToAbsent
              ? const Value.absent()
              : Value(channelCount),
      groupCount:
          groupCount == null && nullToAbsent
              ? const Value.absent()
              : Value(groupCount),
      contentGuidelines:
          contentGuidelines == null && nullToAbsent
              ? const Value.absent()
              : Value(contentGuidelines),
      rulesJson:
          rulesJson == null && nullToAbsent
              ? const Value.absent()
              : Value(rulesJson),
      metadataJson: Value(metadataJson),
      createdBy:
          createdBy == null && nullToAbsent
              ? const Value.absent()
              : Value(createdBy),
      serverCreatedAt:
          serverCreatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(serverCreatedAt),
      serverUpdatedAt:
          serverUpdatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(serverUpdatedAt),
      lastSyncedAt:
          lastSyncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Workspace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workspace(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      workspaceType: serializer.fromJson<String>(json['workspaceType']),
      workspaceTypeName: serializer.fromJson<String>(json['workspaceTypeName']),
      accessCode: serializer.fromJson<String?>(json['accessCode']),
      isPublic: serializer.fromJson<bool?>(json['isPublic']),
      requiresApproval: serializer.fromJson<bool?>(json['requiresApproval']),
      memberCount: serializer.fromJson<int?>(json['memberCount']),
      maxMembers: serializer.fromJson<int?>(json['maxMembers']),
      channelCount: serializer.fromJson<int?>(json['channelCount']),
      groupCount: serializer.fromJson<int?>(json['groupCount']),
      contentGuidelines: serializer.fromJson<String?>(
        json['contentGuidelines'],
      ),
      rulesJson: serializer.fromJson<List<dynamic>?>(json['rulesJson']),
      metadataJson: serializer.fromJson<Map<String, dynamic>>(
        json['metadataJson'],
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      serverCreatedAt: serializer.fromJson<DateTime?>(json['serverCreatedAt']),
      serverUpdatedAt: serializer.fromJson<DateTime?>(json['serverUpdatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'workspaceType': serializer.toJson<String>(workspaceType),
      'workspaceTypeName': serializer.toJson<String>(workspaceTypeName),
      'accessCode': serializer.toJson<String?>(accessCode),
      'isPublic': serializer.toJson<bool?>(isPublic),
      'requiresApproval': serializer.toJson<bool?>(requiresApproval),
      'memberCount': serializer.toJson<int?>(memberCount),
      'maxMembers': serializer.toJson<int?>(maxMembers),
      'channelCount': serializer.toJson<int?>(channelCount),
      'groupCount': serializer.toJson<int?>(groupCount),
      'contentGuidelines': serializer.toJson<String?>(contentGuidelines),
      'rulesJson': serializer.toJson<List<dynamic>?>(rulesJson),
      'metadataJson': serializer.toJson<Map<String, dynamic>>(metadataJson),
      'createdBy': serializer.toJson<String?>(createdBy),
      'serverCreatedAt': serializer.toJson<DateTime?>(serverCreatedAt),
      'serverUpdatedAt': serializer.toJson<DateTime?>(serverUpdatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Workspace copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    String? name,
    Value<String?> description = const Value.absent(),
    String? workspaceType,
    String? workspaceTypeName,
    Value<String?> accessCode = const Value.absent(),
    Value<bool?> isPublic = const Value.absent(),
    Value<bool?> requiresApproval = const Value.absent(),
    Value<int?> memberCount = const Value.absent(),
    Value<int?> maxMembers = const Value.absent(),
    Value<int?> channelCount = const Value.absent(),
    Value<int?> groupCount = const Value.absent(),
    Value<String?> contentGuidelines = const Value.absent(),
    Value<List<dynamic>?> rulesJson = const Value.absent(),
    Map<String, dynamic>? metadataJson,
    Value<String?> createdBy = const Value.absent(),
    Value<DateTime?> serverCreatedAt = const Value.absent(),
    Value<DateTime?> serverUpdatedAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Workspace(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    workspaceType: workspaceType ?? this.workspaceType,
    workspaceTypeName: workspaceTypeName ?? this.workspaceTypeName,
    accessCode: accessCode.present ? accessCode.value : this.accessCode,
    isPublic: isPublic.present ? isPublic.value : this.isPublic,
    requiresApproval:
        requiresApproval.present
            ? requiresApproval.value
            : this.requiresApproval,
    memberCount: memberCount.present ? memberCount.value : this.memberCount,
    maxMembers: maxMembers.present ? maxMembers.value : this.maxMembers,
    channelCount: channelCount.present ? channelCount.value : this.channelCount,
    groupCount: groupCount.present ? groupCount.value : this.groupCount,
    contentGuidelines:
        contentGuidelines.present
            ? contentGuidelines.value
            : this.contentGuidelines,
    rulesJson: rulesJson.present ? rulesJson.value : this.rulesJson,
    metadataJson: metadataJson ?? this.metadataJson,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    serverCreatedAt:
        serverCreatedAt.present ? serverCreatedAt.value : this.serverCreatedAt,
    serverUpdatedAt:
        serverUpdatedAt.present ? serverUpdatedAt.value : this.serverUpdatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Workspace copyWithCompanion(WorkspacesCompanion data) {
    return Workspace(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      workspaceType:
          data.workspaceType.present
              ? data.workspaceType.value
              : this.workspaceType,
      workspaceTypeName:
          data.workspaceTypeName.present
              ? data.workspaceTypeName.value
              : this.workspaceTypeName,
      accessCode:
          data.accessCode.present ? data.accessCode.value : this.accessCode,
      isPublic: data.isPublic.present ? data.isPublic.value : this.isPublic,
      requiresApproval:
          data.requiresApproval.present
              ? data.requiresApproval.value
              : this.requiresApproval,
      memberCount:
          data.memberCount.present ? data.memberCount.value : this.memberCount,
      maxMembers:
          data.maxMembers.present ? data.maxMembers.value : this.maxMembers,
      channelCount:
          data.channelCount.present
              ? data.channelCount.value
              : this.channelCount,
      groupCount:
          data.groupCount.present ? data.groupCount.value : this.groupCount,
      contentGuidelines:
          data.contentGuidelines.present
              ? data.contentGuidelines.value
              : this.contentGuidelines,
      rulesJson: data.rulesJson.present ? data.rulesJson.value : this.rulesJson,
      metadataJson:
          data.metadataJson.present
              ? data.metadataJson.value
              : this.metadataJson,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      serverCreatedAt:
          data.serverCreatedAt.present
              ? data.serverCreatedAt.value
              : this.serverCreatedAt,
      serverUpdatedAt:
          data.serverUpdatedAt.present
              ? data.serverUpdatedAt.value
              : this.serverUpdatedAt,
      lastSyncedAt:
          data.lastSyncedAt.present
              ? data.lastSyncedAt.value
              : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workspace(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('workspaceType: $workspaceType, ')
          ..write('workspaceTypeName: $workspaceTypeName, ')
          ..write('accessCode: $accessCode, ')
          ..write('isPublic: $isPublic, ')
          ..write('requiresApproval: $requiresApproval, ')
          ..write('memberCount: $memberCount, ')
          ..write('maxMembers: $maxMembers, ')
          ..write('channelCount: $channelCount, ')
          ..write('groupCount: $groupCount, ')
          ..write('contentGuidelines: $contentGuidelines, ')
          ..write('rulesJson: $rulesJson, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdBy: $createdBy, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    serverId,
    name,
    description,
    workspaceType,
    workspaceTypeName,
    accessCode,
    isPublic,
    requiresApproval,
    memberCount,
    maxMembers,
    channelCount,
    groupCount,
    contentGuidelines,
    rulesJson,
    metadataJson,
    createdBy,
    serverCreatedAt,
    serverUpdatedAt,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workspace &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.name == this.name &&
          other.description == this.description &&
          other.workspaceType == this.workspaceType &&
          other.workspaceTypeName == this.workspaceTypeName &&
          other.accessCode == this.accessCode &&
          other.isPublic == this.isPublic &&
          other.requiresApproval == this.requiresApproval &&
          other.memberCount == this.memberCount &&
          other.maxMembers == this.maxMembers &&
          other.channelCount == this.channelCount &&
          other.groupCount == this.groupCount &&
          other.contentGuidelines == this.contentGuidelines &&
          other.rulesJson == this.rulesJson &&
          other.metadataJson == this.metadataJson &&
          other.createdBy == this.createdBy &&
          other.serverCreatedAt == this.serverCreatedAt &&
          other.serverUpdatedAt == this.serverUpdatedAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkspacesCompanion extends UpdateCompanion<Workspace> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> workspaceType;
  final Value<String> workspaceTypeName;
  final Value<String?> accessCode;
  final Value<bool?> isPublic;
  final Value<bool?> requiresApproval;
  final Value<int?> memberCount;
  final Value<int?> maxMembers;
  final Value<int?> channelCount;
  final Value<int?> groupCount;
  final Value<String?> contentGuidelines;
  final Value<List<dynamic>?> rulesJson;
  final Value<Map<String, dynamic>> metadataJson;
  final Value<String?> createdBy;
  final Value<DateTime?> serverCreatedAt;
  final Value<DateTime?> serverUpdatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WorkspacesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.workspaceType = const Value.absent(),
    this.workspaceTypeName = const Value.absent(),
    this.accessCode = const Value.absent(),
    this.isPublic = const Value.absent(),
    this.requiresApproval = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.maxMembers = const Value.absent(),
    this.channelCount = const Value.absent(),
    this.groupCount = const Value.absent(),
    this.contentGuidelines = const Value.absent(),
    this.rulesJson = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.serverCreatedAt = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkspacesCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String workspaceType,
    required String workspaceTypeName,
    this.accessCode = const Value.absent(),
    this.isPublic = const Value.absent(),
    this.requiresApproval = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.maxMembers = const Value.absent(),
    this.channelCount = const Value.absent(),
    this.groupCount = const Value.absent(),
    this.contentGuidelines = const Value.absent(),
    this.rulesJson = const Value.absent(),
    required Map<String, dynamic> metadataJson,
    this.createdBy = const Value.absent(),
    this.serverCreatedAt = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       workspaceType = Value(workspaceType),
       workspaceTypeName = Value(workspaceTypeName),
       metadataJson = Value(metadataJson);
  static Insertable<Workspace> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? workspaceType,
    Expression<String>? workspaceTypeName,
    Expression<String>? accessCode,
    Expression<bool>? isPublic,
    Expression<bool>? requiresApproval,
    Expression<int>? memberCount,
    Expression<int>? maxMembers,
    Expression<int>? channelCount,
    Expression<int>? groupCount,
    Expression<String>? contentGuidelines,
    Expression<String>? rulesJson,
    Expression<String>? metadataJson,
    Expression<String>? createdBy,
    Expression<DateTime>? serverCreatedAt,
    Expression<DateTime>? serverUpdatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (workspaceType != null) 'workspace_type': workspaceType,
      if (workspaceTypeName != null) 'workspace_type_name': workspaceTypeName,
      if (accessCode != null) 'access_code': accessCode,
      if (isPublic != null) 'is_public': isPublic,
      if (requiresApproval != null) 'requires_approval': requiresApproval,
      if (memberCount != null) 'member_count': memberCount,
      if (maxMembers != null) 'max_members': maxMembers,
      if (channelCount != null) 'channel_count': channelCount,
      if (groupCount != null) 'group_count': groupCount,
      if (contentGuidelines != null) 'content_guidelines': contentGuidelines,
      if (rulesJson != null) 'rules_json': rulesJson,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (createdBy != null) 'created_by': createdBy,
      if (serverCreatedAt != null) 'server_created_at': serverCreatedAt,
      if (serverUpdatedAt != null) 'server_updated_at': serverUpdatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkspacesCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? workspaceType,
    Value<String>? workspaceTypeName,
    Value<String?>? accessCode,
    Value<bool?>? isPublic,
    Value<bool?>? requiresApproval,
    Value<int?>? memberCount,
    Value<int?>? maxMembers,
    Value<int?>? channelCount,
    Value<int?>? groupCount,
    Value<String?>? contentGuidelines,
    Value<List<dynamic>?>? rulesJson,
    Value<Map<String, dynamic>>? metadataJson,
    Value<String?>? createdBy,
    Value<DateTime?>? serverCreatedAt,
    Value<DateTime?>? serverUpdatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WorkspacesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      name: name ?? this.name,
      description: description ?? this.description,
      workspaceType: workspaceType ?? this.workspaceType,
      workspaceTypeName: workspaceTypeName ?? this.workspaceTypeName,
      accessCode: accessCode ?? this.accessCode,
      isPublic: isPublic ?? this.isPublic,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      memberCount: memberCount ?? this.memberCount,
      maxMembers: maxMembers ?? this.maxMembers,
      channelCount: channelCount ?? this.channelCount,
      groupCount: groupCount ?? this.groupCount,
      contentGuidelines: contentGuidelines ?? this.contentGuidelines,
      rulesJson: rulesJson ?? this.rulesJson,
      metadataJson: metadataJson ?? this.metadataJson,
      createdBy: createdBy ?? this.createdBy,
      serverCreatedAt: serverCreatedAt ?? this.serverCreatedAt,
      serverUpdatedAt: serverUpdatedAt ?? this.serverUpdatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (workspaceType.present) {
      map['workspace_type'] = Variable<String>(workspaceType.value);
    }
    if (workspaceTypeName.present) {
      map['workspace_type_name'] = Variable<String>(workspaceTypeName.value);
    }
    if (accessCode.present) {
      map['access_code'] = Variable<String>(accessCode.value);
    }
    if (isPublic.present) {
      map['is_public'] = Variable<bool>(isPublic.value);
    }
    if (requiresApproval.present) {
      map['requires_approval'] = Variable<bool>(requiresApproval.value);
    }
    if (memberCount.present) {
      map['member_count'] = Variable<int>(memberCount.value);
    }
    if (maxMembers.present) {
      map['max_members'] = Variable<int>(maxMembers.value);
    }
    if (channelCount.present) {
      map['channel_count'] = Variable<int>(channelCount.value);
    }
    if (groupCount.present) {
      map['group_count'] = Variable<int>(groupCount.value);
    }
    if (contentGuidelines.present) {
      map['content_guidelines'] = Variable<String>(contentGuidelines.value);
    }
    if (rulesJson.present) {
      map['rules_json'] = Variable<String>(
        $WorkspacesTable.$converterrulesJson.toSql(rulesJson.value),
      );
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(
        $WorkspacesTable.$convertermetadataJson.toSql(metadataJson.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (serverCreatedAt.present) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt.value);
    }
    if (serverUpdatedAt.present) {
      map['server_updated_at'] = Variable<DateTime>(serverUpdatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkspacesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('workspaceType: $workspaceType, ')
          ..write('workspaceTypeName: $workspaceTypeName, ')
          ..write('accessCode: $accessCode, ')
          ..write('isPublic: $isPublic, ')
          ..write('requiresApproval: $requiresApproval, ')
          ..write('memberCount: $memberCount, ')
          ..write('maxMembers: $maxMembers, ')
          ..write('channelCount: $channelCount, ')
          ..write('groupCount: $groupCount, ')
          ..write('contentGuidelines: $contentGuidelines, ')
          ..write('rulesJson: $rulesJson, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdBy: $createdBy, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChannelsTable extends Channels with TableInfo<$ChannelsTable, Channel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChannelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverCreatedAtMeta = const VerificationMeta(
    'serverCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverCreatedAt =
      GeneratedColumn<DateTime>(
        'server_created_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    workspaceId,
    groupId,
    name,
    isPrivate,
    createdBy,
    serverCreatedAt,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'channels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Channel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('server_created_at')) {
      context.handle(
        _serverCreatedAtMeta,
        serverCreatedAt.isAcceptableOrUnknown(
          data['server_created_at']!,
          _serverCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Channel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Channel(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      isPrivate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_private'],
          )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      serverCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_created_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $ChannelsTable createAlias(String alias) {
    return $ChannelsTable(attachedDatabase, alias);
  }
}

class Channel extends DataClass implements Insertable<Channel> {
  final int id;
  final String? serverId;
  final String? workspaceId;
  final String? groupId;
  final String name;
  final bool isPrivate;
  final String? createdBy;
  final DateTime? serverCreatedAt;
  final DateTime? lastSyncedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Channel({
    required this.id,
    this.serverId,
    this.workspaceId,
    this.groupId,
    required this.name,
    required this.isPrivate,
    this.createdBy,
    this.serverCreatedAt,
    this.lastSyncedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || workspaceId != null) {
      map['workspace_id'] = Variable<String>(workspaceId);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    map['name'] = Variable<String>(name);
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || serverCreatedAt != null) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChannelsCompanion toCompanion(bool nullToAbsent) {
    return ChannelsCompanion(
      id: Value(id),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      workspaceId:
          workspaceId == null && nullToAbsent
              ? const Value.absent()
              : Value(workspaceId),
      groupId:
          groupId == null && nullToAbsent
              ? const Value.absent()
              : Value(groupId),
      name: Value(name),
      isPrivate: Value(isPrivate),
      createdBy:
          createdBy == null && nullToAbsent
              ? const Value.absent()
              : Value(createdBy),
      serverCreatedAt:
          serverCreatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(serverCreatedAt),
      lastSyncedAt:
          lastSyncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Channel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Channel(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      workspaceId: serializer.fromJson<String?>(json['workspaceId']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      serverCreatedAt: serializer.fromJson<DateTime?>(json['serverCreatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'workspaceId': serializer.toJson<String?>(workspaceId),
      'groupId': serializer.toJson<String?>(groupId),
      'name': serializer.toJson<String>(name),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'createdBy': serializer.toJson<String?>(createdBy),
      'serverCreatedAt': serializer.toJson<DateTime?>(serverCreatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Channel copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    Value<String?> workspaceId = const Value.absent(),
    Value<String?> groupId = const Value.absent(),
    String? name,
    bool? isPrivate,
    Value<String?> createdBy = const Value.absent(),
    Value<DateTime?> serverCreatedAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Channel(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    workspaceId: workspaceId.present ? workspaceId.value : this.workspaceId,
    groupId: groupId.present ? groupId.value : this.groupId,
    name: name ?? this.name,
    isPrivate: isPrivate ?? this.isPrivate,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    serverCreatedAt:
        serverCreatedAt.present ? serverCreatedAt.value : this.serverCreatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Channel copyWithCompanion(ChannelsCompanion data) {
    return Channel(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      serverCreatedAt:
          data.serverCreatedAt.present
              ? data.serverCreatedAt.value
              : this.serverCreatedAt,
      lastSyncedAt:
          data.lastSyncedAt.present
              ? data.lastSyncedAt.value
              : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Channel(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('createdBy: $createdBy, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    workspaceId,
    groupId,
    name,
    isPrivate,
    createdBy,
    serverCreatedAt,
    lastSyncedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Channel &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.workspaceId == this.workspaceId &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.isPrivate == this.isPrivate &&
          other.createdBy == this.createdBy &&
          other.serverCreatedAt == this.serverCreatedAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChannelsCompanion extends UpdateCompanion<Channel> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<String?> workspaceId;
  final Value<String?> groupId;
  final Value<String> name;
  final Value<bool> isPrivate;
  final Value<String?> createdBy;
  final Value<DateTime?> serverCreatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChannelsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.serverCreatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChannelsCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.groupId = const Value.absent(),
    required String name,
    this.isPrivate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.serverCreatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Channel> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? workspaceId,
    Expression<String>? groupId,
    Expression<String>? name,
    Expression<bool>? isPrivate,
    Expression<String>? createdBy,
    Expression<DateTime>? serverCreatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (isPrivate != null) 'is_private': isPrivate,
      if (createdBy != null) 'created_by': createdBy,
      if (serverCreatedAt != null) 'server_created_at': serverCreatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChannelsCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<String?>? workspaceId,
    Value<String?>? groupId,
    Value<String>? name,
    Value<bool>? isPrivate,
    Value<String?>? createdBy,
    Value<DateTime?>? serverCreatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ChannelsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      workspaceId: workspaceId ?? this.workspaceId,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      isPrivate: isPrivate ?? this.isPrivate,
      createdBy: createdBy ?? this.createdBy,
      serverCreatedAt: serverCreatedAt ?? this.serverCreatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (serverCreatedAt.present) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('createdBy: $createdBy, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientMessageIdMeta = const VerificationMeta(
    'clientMessageId',
  );
  @override
  late final GeneratedColumn<String> clientMessageId = GeneratedColumn<String>(
    'client_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _channelIdMeta = const VerificationMeta(
    'channelId',
  );
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
    'channel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderUsernameMeta = const VerificationMeta(
    'senderUsername',
  );
  @override
  late final GeneratedColumn<String> senderUsername = GeneratedColumn<String>(
    'sender_username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageTypeMeta = const VerificationMeta(
    'messageType',
  );
  @override
  late final GeneratedColumn<String> messageType = GeneratedColumn<String>(
    'message_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>($MessagesTable.$convertermetadataJson);
  static const VerificationMeta _clientCreatedAtMeta = const VerificationMeta(
    'clientCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>(
        'client_created_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _serverCreatedAtMeta = const VerificationMeta(
    'serverCreatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverCreatedAt =
      GeneratedColumn<DateTime>(
        'server_created_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serverUpdatedAtMeta = const VerificationMeta(
    'serverUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverUpdatedAt =
      GeneratedColumn<DateTime>(
        'server_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serverSequenceMeta = const VerificationMeta(
    'serverSequence',
  );
  @override
  late final GeneratedColumn<int> serverSequence = GeneratedColumn<int>(
    'server_sequence',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEditedMeta = const VerificationMeta(
    'isEdited',
  );
  @override
  late final GeneratedColumn<bool> isEdited = GeneratedColumn<bool>(
    'is_edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _editedAtMeta = const VerificationMeta(
    'editedAt',
  );
  @override
  late final GeneratedColumn<DateTime> editedAt = GeneratedColumn<DateTime>(
    'edited_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MessageDeliveryStatus, String>
  deliveryStatus = GeneratedColumn<String>(
    'delivery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sending'),
  ).withConverter<MessageDeliveryStatus>(
    $MessagesTable.$converterdeliveryStatus,
  );
  static const VerificationMeta _lastSyncErrorMeta = const VerificationMeta(
    'lastSyncError',
  );
  @override
  late final GeneratedColumn<String> lastSyncError = GeneratedColumn<String>(
    'last_sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    clientMessageId,
    channelId,
    senderId,
    senderUsername,
    content,
    messageType,
    metadataJson,
    clientCreatedAt,
    serverCreatedAt,
    serverUpdatedAt,
    serverSequence,
    version,
    isEdited,
    editedAt,
    deletedAt,
    deliveryStatus,
    lastSyncError,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('client_message_id')) {
      context.handle(
        _clientMessageIdMeta,
        clientMessageId.isAcceptableOrUnknown(
          data['client_message_id']!,
          _clientMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('sender_username')) {
      context.handle(
        _senderUsernameMeta,
        senderUsername.isAcceptableOrUnknown(
          data['sender_username']!,
          _senderUsernameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senderUsernameMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('message_type')) {
      context.handle(
        _messageTypeMeta,
        messageType.isAcceptableOrUnknown(
          data['message_type']!,
          _messageTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_messageTypeMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
        _clientCreatedAtMeta,
        clientCreatedAt.isAcceptableOrUnknown(
          data['client_created_at']!,
          _clientCreatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('server_created_at')) {
      context.handle(
        _serverCreatedAtMeta,
        serverCreatedAt.isAcceptableOrUnknown(
          data['server_created_at']!,
          _serverCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at')) {
      context.handle(
        _serverUpdatedAtMeta,
        serverUpdatedAt.isAcceptableOrUnknown(
          data['server_updated_at']!,
          _serverUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('server_sequence')) {
      context.handle(
        _serverSequenceMeta,
        serverSequence.isAcceptableOrUnknown(
          data['server_sequence']!,
          _serverSequenceMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('is_edited')) {
      context.handle(
        _isEditedMeta,
        isEdited.isAcceptableOrUnknown(data['is_edited']!, _isEditedMeta),
      );
    }
    if (data.containsKey('edited_at')) {
      context.handle(
        _editedAtMeta,
        editedAt.isAcceptableOrUnknown(data['edited_at']!, _editedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('last_sync_error')) {
      context.handle(
        _lastSyncErrorMeta,
        lastSyncError.isAcceptableOrUnknown(
          data['last_sync_error']!,
          _lastSyncErrorMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      clientMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_message_id'],
      ),
      channelId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}channel_id'],
          )!,
      senderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sender_id'],
          )!,
      senderUsername:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sender_username'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      messageType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}message_type'],
          )!,
      metadataJson: $MessagesTable.$convertermetadataJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metadata_json'],
        )!,
      ),
      clientCreatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}client_created_at'],
          )!,
      serverCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_created_at'],
      ),
      serverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_updated_at'],
      ),
      serverSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_sequence'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      ),
      isEdited:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_edited'],
          )!,
      editedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}edited_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      deliveryStatus: $MessagesTable.$converterdeliveryStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}delivery_status'],
        )!,
      ),
      lastSyncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sync_error'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $convertermetadataJson =
      const JsonMapConverter();
  static TypeConverter<MessageDeliveryStatus, String> $converterdeliveryStatus =
      const MessageDeliveryStatusConverter();
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final String? serverId;
  final String? clientMessageId;
  final String channelId;
  final String senderId;
  final String senderUsername;
  final String content;
  final String messageType;
  final Map<String, dynamic> metadataJson;
  final DateTime clientCreatedAt;
  final DateTime? serverCreatedAt;
  final DateTime? serverUpdatedAt;
  final int? serverSequence;
  final int? version;
  final bool isEdited;
  final DateTime? editedAt;
  final DateTime? deletedAt;
  final MessageDeliveryStatus deliveryStatus;
  final String? lastSyncError;
  final DateTime? lastSyncedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Message({
    required this.id,
    this.serverId,
    this.clientMessageId,
    required this.channelId,
    required this.senderId,
    required this.senderUsername,
    required this.content,
    required this.messageType,
    required this.metadataJson,
    required this.clientCreatedAt,
    this.serverCreatedAt,
    this.serverUpdatedAt,
    this.serverSequence,
    this.version,
    required this.isEdited,
    this.editedAt,
    this.deletedAt,
    required this.deliveryStatus,
    this.lastSyncError,
    this.lastSyncedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || clientMessageId != null) {
      map['client_message_id'] = Variable<String>(clientMessageId);
    }
    map['channel_id'] = Variable<String>(channelId);
    map['sender_id'] = Variable<String>(senderId);
    map['sender_username'] = Variable<String>(senderUsername);
    map['content'] = Variable<String>(content);
    map['message_type'] = Variable<String>(messageType);
    {
      map['metadata_json'] = Variable<String>(
        $MessagesTable.$convertermetadataJson.toSql(metadataJson),
      );
    }
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    if (!nullToAbsent || serverCreatedAt != null) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt);
    }
    if (!nullToAbsent || serverUpdatedAt != null) {
      map['server_updated_at'] = Variable<DateTime>(serverUpdatedAt);
    }
    if (!nullToAbsent || serverSequence != null) {
      map['server_sequence'] = Variable<int>(serverSequence);
    }
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<int>(version);
    }
    map['is_edited'] = Variable<bool>(isEdited);
    if (!nullToAbsent || editedAt != null) {
      map['edited_at'] = Variable<DateTime>(editedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['delivery_status'] = Variable<String>(
        $MessagesTable.$converterdeliveryStatus.toSql(deliveryStatus),
      );
    }
    if (!nullToAbsent || lastSyncError != null) {
      map['last_sync_error'] = Variable<String>(lastSyncError);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      clientMessageId:
          clientMessageId == null && nullToAbsent
              ? const Value.absent()
              : Value(clientMessageId),
      channelId: Value(channelId),
      senderId: Value(senderId),
      senderUsername: Value(senderUsername),
      content: Value(content),
      messageType: Value(messageType),
      metadataJson: Value(metadataJson),
      clientCreatedAt: Value(clientCreatedAt),
      serverCreatedAt:
          serverCreatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(serverCreatedAt),
      serverUpdatedAt:
          serverUpdatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(serverUpdatedAt),
      serverSequence:
          serverSequence == null && nullToAbsent
              ? const Value.absent()
              : Value(serverSequence),
      version:
          version == null && nullToAbsent
              ? const Value.absent()
              : Value(version),
      isEdited: Value(isEdited),
      editedAt:
          editedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(editedAt),
      deletedAt:
          deletedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(deletedAt),
      deliveryStatus: Value(deliveryStatus),
      lastSyncError:
          lastSyncError == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncError),
      lastSyncedAt:
          lastSyncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      clientMessageId: serializer.fromJson<String?>(json['clientMessageId']),
      channelId: serializer.fromJson<String>(json['channelId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      senderUsername: serializer.fromJson<String>(json['senderUsername']),
      content: serializer.fromJson<String>(json['content']),
      messageType: serializer.fromJson<String>(json['messageType']),
      metadataJson: serializer.fromJson<Map<String, dynamic>>(
        json['metadataJson'],
      ),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      serverCreatedAt: serializer.fromJson<DateTime?>(json['serverCreatedAt']),
      serverUpdatedAt: serializer.fromJson<DateTime?>(json['serverUpdatedAt']),
      serverSequence: serializer.fromJson<int?>(json['serverSequence']),
      version: serializer.fromJson<int?>(json['version']),
      isEdited: serializer.fromJson<bool>(json['isEdited']),
      editedAt: serializer.fromJson<DateTime?>(json['editedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      deliveryStatus: serializer.fromJson<MessageDeliveryStatus>(
        json['deliveryStatus'],
      ),
      lastSyncError: serializer.fromJson<String?>(json['lastSyncError']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'clientMessageId': serializer.toJson<String?>(clientMessageId),
      'channelId': serializer.toJson<String>(channelId),
      'senderId': serializer.toJson<String>(senderId),
      'senderUsername': serializer.toJson<String>(senderUsername),
      'content': serializer.toJson<String>(content),
      'messageType': serializer.toJson<String>(messageType),
      'metadataJson': serializer.toJson<Map<String, dynamic>>(metadataJson),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'serverCreatedAt': serializer.toJson<DateTime?>(serverCreatedAt),
      'serverUpdatedAt': serializer.toJson<DateTime?>(serverUpdatedAt),
      'serverSequence': serializer.toJson<int?>(serverSequence),
      'version': serializer.toJson<int?>(version),
      'isEdited': serializer.toJson<bool>(isEdited),
      'editedAt': serializer.toJson<DateTime?>(editedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'deliveryStatus': serializer.toJson<MessageDeliveryStatus>(
        deliveryStatus,
      ),
      'lastSyncError': serializer.toJson<String?>(lastSyncError),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Message copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    Value<String?> clientMessageId = const Value.absent(),
    String? channelId,
    String? senderId,
    String? senderUsername,
    String? content,
    String? messageType,
    Map<String, dynamic>? metadataJson,
    DateTime? clientCreatedAt,
    Value<DateTime?> serverCreatedAt = const Value.absent(),
    Value<DateTime?> serverUpdatedAt = const Value.absent(),
    Value<int?> serverSequence = const Value.absent(),
    Value<int?> version = const Value.absent(),
    bool? isEdited,
    Value<DateTime?> editedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    MessageDeliveryStatus? deliveryStatus,
    Value<String?> lastSyncError = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Message(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    clientMessageId:
        clientMessageId.present ? clientMessageId.value : this.clientMessageId,
    channelId: channelId ?? this.channelId,
    senderId: senderId ?? this.senderId,
    senderUsername: senderUsername ?? this.senderUsername,
    content: content ?? this.content,
    messageType: messageType ?? this.messageType,
    metadataJson: metadataJson ?? this.metadataJson,
    clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
    serverCreatedAt:
        serverCreatedAt.present ? serverCreatedAt.value : this.serverCreatedAt,
    serverUpdatedAt:
        serverUpdatedAt.present ? serverUpdatedAt.value : this.serverUpdatedAt,
    serverSequence:
        serverSequence.present ? serverSequence.value : this.serverSequence,
    version: version.present ? version.value : this.version,
    isEdited: isEdited ?? this.isEdited,
    editedAt: editedAt.present ? editedAt.value : this.editedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    lastSyncError:
        lastSyncError.present ? lastSyncError.value : this.lastSyncError,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      clientMessageId:
          data.clientMessageId.present
              ? data.clientMessageId.value
              : this.clientMessageId,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      senderUsername:
          data.senderUsername.present
              ? data.senderUsername.value
              : this.senderUsername,
      content: data.content.present ? data.content.value : this.content,
      messageType:
          data.messageType.present ? data.messageType.value : this.messageType,
      metadataJson:
          data.metadataJson.present
              ? data.metadataJson.value
              : this.metadataJson,
      clientCreatedAt:
          data.clientCreatedAt.present
              ? data.clientCreatedAt.value
              : this.clientCreatedAt,
      serverCreatedAt:
          data.serverCreatedAt.present
              ? data.serverCreatedAt.value
              : this.serverCreatedAt,
      serverUpdatedAt:
          data.serverUpdatedAt.present
              ? data.serverUpdatedAt.value
              : this.serverUpdatedAt,
      serverSequence:
          data.serverSequence.present
              ? data.serverSequence.value
              : this.serverSequence,
      version: data.version.present ? data.version.value : this.version,
      isEdited: data.isEdited.present ? data.isEdited.value : this.isEdited,
      editedAt: data.editedAt.present ? data.editedAt.value : this.editedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      deliveryStatus:
          data.deliveryStatus.present
              ? data.deliveryStatus.value
              : this.deliveryStatus,
      lastSyncError:
          data.lastSyncError.present
              ? data.lastSyncError.value
              : this.lastSyncError,
      lastSyncedAt:
          data.lastSyncedAt.present
              ? data.lastSyncedAt.value
              : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('channelId: $channelId, ')
          ..write('senderId: $senderId, ')
          ..write('senderUsername: $senderUsername, ')
          ..write('content: $content, ')
          ..write('messageType: $messageType, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('serverSequence: $serverSequence, ')
          ..write('version: $version, ')
          ..write('isEdited: $isEdited, ')
          ..write('editedAt: $editedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    serverId,
    clientMessageId,
    channelId,
    senderId,
    senderUsername,
    content,
    messageType,
    metadataJson,
    clientCreatedAt,
    serverCreatedAt,
    serverUpdatedAt,
    serverSequence,
    version,
    isEdited,
    editedAt,
    deletedAt,
    deliveryStatus,
    lastSyncError,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.clientMessageId == this.clientMessageId &&
          other.channelId == this.channelId &&
          other.senderId == this.senderId &&
          other.senderUsername == this.senderUsername &&
          other.content == this.content &&
          other.messageType == this.messageType &&
          other.metadataJson == this.metadataJson &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.serverCreatedAt == this.serverCreatedAt &&
          other.serverUpdatedAt == this.serverUpdatedAt &&
          other.serverSequence == this.serverSequence &&
          other.version == this.version &&
          other.isEdited == this.isEdited &&
          other.editedAt == this.editedAt &&
          other.deletedAt == this.deletedAt &&
          other.deliveryStatus == this.deliveryStatus &&
          other.lastSyncError == this.lastSyncError &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<String?> clientMessageId;
  final Value<String> channelId;
  final Value<String> senderId;
  final Value<String> senderUsername;
  final Value<String> content;
  final Value<String> messageType;
  final Value<Map<String, dynamic>> metadataJson;
  final Value<DateTime> clientCreatedAt;
  final Value<DateTime?> serverCreatedAt;
  final Value<DateTime?> serverUpdatedAt;
  final Value<int?> serverSequence;
  final Value<int?> version;
  final Value<bool> isEdited;
  final Value<DateTime?> editedAt;
  final Value<DateTime?> deletedAt;
  final Value<MessageDeliveryStatus> deliveryStatus;
  final Value<String?> lastSyncError;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.clientMessageId = const Value.absent(),
    this.channelId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.senderUsername = const Value.absent(),
    this.content = const Value.absent(),
    this.messageType = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.serverCreatedAt = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.serverSequence = const Value.absent(),
    this.version = const Value.absent(),
    this.isEdited = const Value.absent(),
    this.editedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.clientMessageId = const Value.absent(),
    required String channelId,
    required String senderId,
    required String senderUsername,
    required String content,
    required String messageType,
    required Map<String, dynamic> metadataJson,
    required DateTime clientCreatedAt,
    this.serverCreatedAt = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.serverSequence = const Value.absent(),
    this.version = const Value.absent(),
    this.isEdited = const Value.absent(),
    this.editedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : channelId = Value(channelId),
       senderId = Value(senderId),
       senderUsername = Value(senderUsername),
       content = Value(content),
       messageType = Value(messageType),
       metadataJson = Value(metadataJson),
       clientCreatedAt = Value(clientCreatedAt);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? clientMessageId,
    Expression<String>? channelId,
    Expression<String>? senderId,
    Expression<String>? senderUsername,
    Expression<String>? content,
    Expression<String>? messageType,
    Expression<String>? metadataJson,
    Expression<DateTime>? clientCreatedAt,
    Expression<DateTime>? serverCreatedAt,
    Expression<DateTime>? serverUpdatedAt,
    Expression<int>? serverSequence,
    Expression<int>? version,
    Expression<bool>? isEdited,
    Expression<DateTime>? editedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? deliveryStatus,
    Expression<String>? lastSyncError,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (clientMessageId != null) 'client_message_id': clientMessageId,
      if (channelId != null) 'channel_id': channelId,
      if (senderId != null) 'sender_id': senderId,
      if (senderUsername != null) 'sender_username': senderUsername,
      if (content != null) 'content': content,
      if (messageType != null) 'message_type': messageType,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (serverCreatedAt != null) 'server_created_at': serverCreatedAt,
      if (serverUpdatedAt != null) 'server_updated_at': serverUpdatedAt,
      if (serverSequence != null) 'server_sequence': serverSequence,
      if (version != null) 'version': version,
      if (isEdited != null) 'is_edited': isEdited,
      if (editedAt != null) 'edited_at': editedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (deliveryStatus != null) 'delivery_status': deliveryStatus,
      if (lastSyncError != null) 'last_sync_error': lastSyncError,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<String?>? clientMessageId,
    Value<String>? channelId,
    Value<String>? senderId,
    Value<String>? senderUsername,
    Value<String>? content,
    Value<String>? messageType,
    Value<Map<String, dynamic>>? metadataJson,
    Value<DateTime>? clientCreatedAt,
    Value<DateTime?>? serverCreatedAt,
    Value<DateTime?>? serverUpdatedAt,
    Value<int?>? serverSequence,
    Value<int?>? version,
    Value<bool>? isEdited,
    Value<DateTime?>? editedAt,
    Value<DateTime?>? deletedAt,
    Value<MessageDeliveryStatus>? deliveryStatus,
    Value<String?>? lastSyncError,
    Value<DateTime?>? lastSyncedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      channelId: channelId ?? this.channelId,
      senderId: senderId ?? this.senderId,
      senderUsername: senderUsername ?? this.senderUsername,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      metadataJson: metadataJson ?? this.metadataJson,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      serverCreatedAt: serverCreatedAt ?? this.serverCreatedAt,
      serverUpdatedAt: serverUpdatedAt ?? this.serverUpdatedAt,
      serverSequence: serverSequence ?? this.serverSequence,
      version: version ?? this.version,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      lastSyncError: lastSyncError ?? this.lastSyncError,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (clientMessageId.present) {
      map['client_message_id'] = Variable<String>(clientMessageId.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (senderUsername.present) {
      map['sender_username'] = Variable<String>(senderUsername.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (messageType.present) {
      map['message_type'] = Variable<String>(messageType.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(
        $MessagesTable.$convertermetadataJson.toSql(metadataJson.value),
      );
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (serverCreatedAt.present) {
      map['server_created_at'] = Variable<DateTime>(serverCreatedAt.value);
    }
    if (serverUpdatedAt.present) {
      map['server_updated_at'] = Variable<DateTime>(serverUpdatedAt.value);
    }
    if (serverSequence.present) {
      map['server_sequence'] = Variable<int>(serverSequence.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (isEdited.present) {
      map['is_edited'] = Variable<bool>(isEdited.value);
    }
    if (editedAt.present) {
      map['edited_at'] = Variable<DateTime>(editedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (deliveryStatus.present) {
      map['delivery_status'] = Variable<String>(
        $MessagesTable.$converterdeliveryStatus.toSql(deliveryStatus.value),
      );
    }
    if (lastSyncError.present) {
      map['last_sync_error'] = Variable<String>(lastSyncError.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('channelId: $channelId, ')
          ..write('senderId: $senderId, ')
          ..write('senderUsername: $senderUsername, ')
          ..write('content: $content, ')
          ..write('messageType: $messageType, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('serverCreatedAt: $serverCreatedAt, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('serverSequence: $serverSequence, ')
          ..write('version: $version, ')
          ..write('isEdited: $isEdited, ')
          ..write('editedAt: $editedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MessageAttachmentsTable extends MessageAttachments
    with TableInfo<$MessageAttachmentsTable, MessageAttachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageLocalIdMeta = const VerificationMeta(
    'messageLocalId',
  );
  @override
  late final GeneratedColumn<int> messageLocalId = GeneratedColumn<int>(
    'message_local_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageServerIdMeta = const VerificationMeta(
    'messageServerId',
  );
  @override
  late final GeneratedColumn<String> messageServerId = GeneratedColumn<String>(
    'message_server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localFilePathMeta = const VerificationMeta(
    'localFilePath',
  );
  @override
  late final GeneratedColumn<String> localFilePath = GeneratedColumn<String>(
    'local_file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AttachmentTransferStatus, String>
  transferStatus = GeneratedColumn<String>(
    'transfer_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_only'),
  ).withConverter<AttachmentTransferStatus>(
    $MessageAttachmentsTable.$convertertransferStatus,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    messageLocalId,
    messageServerId,
    localFilePath,
    remoteUrl,
    mimeType,
    sizeBytes,
    checksum,
    transferStatus,
    attemptCount,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageAttachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('message_local_id')) {
      context.handle(
        _messageLocalIdMeta,
        messageLocalId.isAcceptableOrUnknown(
          data['message_local_id']!,
          _messageLocalIdMeta,
        ),
      );
    }
    if (data.containsKey('message_server_id')) {
      context.handle(
        _messageServerIdMeta,
        messageServerId.isAcceptableOrUnknown(
          data['message_server_id']!,
          _messageServerIdMeta,
        ),
      );
    }
    if (data.containsKey('local_file_path')) {
      context.handle(
        _localFilePathMeta,
        localFilePath.isAcceptableOrUnknown(
          data['local_file_path']!,
          _localFilePathMeta,
        ),
      );
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageAttachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageAttachment(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      messageLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}message_local_id'],
      ),
      messageServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_server_id'],
      ),
      localFilePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_file_path'],
      ),
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      ),
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      ),
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      ),
      transferStatus: $MessageAttachmentsTable.$convertertransferStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}transfer_status'],
        )!,
      ),
      attemptCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}attempt_count'],
          )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $MessageAttachmentsTable createAlias(String alias) {
    return $MessageAttachmentsTable(attachedDatabase, alias);
  }

  static TypeConverter<AttachmentTransferStatus, String>
  $convertertransferStatus = const AttachmentTransferStatusConverter();
}

class MessageAttachment extends DataClass
    implements Insertable<MessageAttachment> {
  final int id;
  final String? serverId;
  final int? messageLocalId;
  final String? messageServerId;
  final String? localFilePath;
  final String? remoteUrl;
  final String? mimeType;
  final int? sizeBytes;
  final String? checksum;
  final AttachmentTransferStatus transferStatus;
  final int attemptCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MessageAttachment({
    required this.id,
    this.serverId,
    this.messageLocalId,
    this.messageServerId,
    this.localFilePath,
    this.remoteUrl,
    this.mimeType,
    this.sizeBytes,
    this.checksum,
    required this.transferStatus,
    required this.attemptCount,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || messageLocalId != null) {
      map['message_local_id'] = Variable<int>(messageLocalId);
    }
    if (!nullToAbsent || messageServerId != null) {
      map['message_server_id'] = Variable<String>(messageServerId);
    }
    if (!nullToAbsent || localFilePath != null) {
      map['local_file_path'] = Variable<String>(localFilePath);
    }
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || sizeBytes != null) {
      map['size_bytes'] = Variable<int>(sizeBytes);
    }
    if (!nullToAbsent || checksum != null) {
      map['checksum'] = Variable<String>(checksum);
    }
    {
      map['transfer_status'] = Variable<String>(
        $MessageAttachmentsTable.$convertertransferStatus.toSql(transferStatus),
      );
    }
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessageAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return MessageAttachmentsCompanion(
      id: Value(id),
      serverId:
          serverId == null && nullToAbsent
              ? const Value.absent()
              : Value(serverId),
      messageLocalId:
          messageLocalId == null && nullToAbsent
              ? const Value.absent()
              : Value(messageLocalId),
      messageServerId:
          messageServerId == null && nullToAbsent
              ? const Value.absent()
              : Value(messageServerId),
      localFilePath:
          localFilePath == null && nullToAbsent
              ? const Value.absent()
              : Value(localFilePath),
      remoteUrl:
          remoteUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(remoteUrl),
      mimeType:
          mimeType == null && nullToAbsent
              ? const Value.absent()
              : Value(mimeType),
      sizeBytes:
          sizeBytes == null && nullToAbsent
              ? const Value.absent()
              : Value(sizeBytes),
      checksum:
          checksum == null && nullToAbsent
              ? const Value.absent()
              : Value(checksum),
      transferStatus: Value(transferStatus),
      attemptCount: Value(attemptCount),
      lastError:
          lastError == null && nullToAbsent
              ? const Value.absent()
              : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MessageAttachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageAttachment(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      messageLocalId: serializer.fromJson<int?>(json['messageLocalId']),
      messageServerId: serializer.fromJson<String?>(json['messageServerId']),
      localFilePath: serializer.fromJson<String?>(json['localFilePath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      sizeBytes: serializer.fromJson<int?>(json['sizeBytes']),
      checksum: serializer.fromJson<String?>(json['checksum']),
      transferStatus: serializer.fromJson<AttachmentTransferStatus>(
        json['transferStatus'],
      ),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'messageLocalId': serializer.toJson<int?>(messageLocalId),
      'messageServerId': serializer.toJson<String?>(messageServerId),
      'localFilePath': serializer.toJson<String?>(localFilePath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'mimeType': serializer.toJson<String?>(mimeType),
      'sizeBytes': serializer.toJson<int?>(sizeBytes),
      'checksum': serializer.toJson<String?>(checksum),
      'transferStatus': serializer.toJson<AttachmentTransferStatus>(
        transferStatus,
      ),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MessageAttachment copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    Value<int?> messageLocalId = const Value.absent(),
    Value<String?> messageServerId = const Value.absent(),
    Value<String?> localFilePath = const Value.absent(),
    Value<String?> remoteUrl = const Value.absent(),
    Value<String?> mimeType = const Value.absent(),
    Value<int?> sizeBytes = const Value.absent(),
    Value<String?> checksum = const Value.absent(),
    AttachmentTransferStatus? transferStatus,
    int? attemptCount,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MessageAttachment(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    messageLocalId:
        messageLocalId.present ? messageLocalId.value : this.messageLocalId,
    messageServerId:
        messageServerId.present ? messageServerId.value : this.messageServerId,
    localFilePath:
        localFilePath.present ? localFilePath.value : this.localFilePath,
    remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    sizeBytes: sizeBytes.present ? sizeBytes.value : this.sizeBytes,
    checksum: checksum.present ? checksum.value : this.checksum,
    transferStatus: transferStatus ?? this.transferStatus,
    attemptCount: attemptCount ?? this.attemptCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MessageAttachment copyWithCompanion(MessageAttachmentsCompanion data) {
    return MessageAttachment(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      messageLocalId:
          data.messageLocalId.present
              ? data.messageLocalId.value
              : this.messageLocalId,
      messageServerId:
          data.messageServerId.present
              ? data.messageServerId.value
              : this.messageServerId,
      localFilePath:
          data.localFilePath.present
              ? data.localFilePath.value
              : this.localFilePath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      transferStatus:
          data.transferStatus.present
              ? data.transferStatus.value
              : this.transferStatus,
      attemptCount:
          data.attemptCount.present
              ? data.attemptCount.value
              : this.attemptCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageAttachment(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('messageLocalId: $messageLocalId, ')
          ..write('messageServerId: $messageServerId, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('checksum: $checksum, ')
          ..write('transferStatus: $transferStatus, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    messageLocalId,
    messageServerId,
    localFilePath,
    remoteUrl,
    mimeType,
    sizeBytes,
    checksum,
    transferStatus,
    attemptCount,
    lastError,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageAttachment &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.messageLocalId == this.messageLocalId &&
          other.messageServerId == this.messageServerId &&
          other.localFilePath == this.localFilePath &&
          other.remoteUrl == this.remoteUrl &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.checksum == this.checksum &&
          other.transferStatus == this.transferStatus &&
          other.attemptCount == this.attemptCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MessageAttachmentsCompanion extends UpdateCompanion<MessageAttachment> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<int?> messageLocalId;
  final Value<String?> messageServerId;
  final Value<String?> localFilePath;
  final Value<String?> remoteUrl;
  final Value<String?> mimeType;
  final Value<int?> sizeBytes;
  final Value<String?> checksum;
  final Value<AttachmentTransferStatus> transferStatus;
  final Value<int> attemptCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MessageAttachmentsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.messageLocalId = const Value.absent(),
    this.messageServerId = const Value.absent(),
    this.localFilePath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.checksum = const Value.absent(),
    this.transferStatus = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MessageAttachmentsCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.messageLocalId = const Value.absent(),
    this.messageServerId = const Value.absent(),
    this.localFilePath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.checksum = const Value.absent(),
    this.transferStatus = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<MessageAttachment> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? messageLocalId,
    Expression<String>? messageServerId,
    Expression<String>? localFilePath,
    Expression<String>? remoteUrl,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? checksum,
    Expression<String>? transferStatus,
    Expression<int>? attemptCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (messageLocalId != null) 'message_local_id': messageLocalId,
      if (messageServerId != null) 'message_server_id': messageServerId,
      if (localFilePath != null) 'local_file_path': localFilePath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (checksum != null) 'checksum': checksum,
      if (transferStatus != null) 'transfer_status': transferStatus,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MessageAttachmentsCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<int?>? messageLocalId,
    Value<String?>? messageServerId,
    Value<String?>? localFilePath,
    Value<String?>? remoteUrl,
    Value<String?>? mimeType,
    Value<int?>? sizeBytes,
    Value<String?>? checksum,
    Value<AttachmentTransferStatus>? transferStatus,
    Value<int>? attemptCount,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MessageAttachmentsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      messageLocalId: messageLocalId ?? this.messageLocalId,
      messageServerId: messageServerId ?? this.messageServerId,
      localFilePath: localFilePath ?? this.localFilePath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      checksum: checksum ?? this.checksum,
      transferStatus: transferStatus ?? this.transferStatus,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (messageLocalId.present) {
      map['message_local_id'] = Variable<int>(messageLocalId.value);
    }
    if (messageServerId.present) {
      map['message_server_id'] = Variable<String>(messageServerId.value);
    }
    if (localFilePath.present) {
      map['local_file_path'] = Variable<String>(localFilePath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (transferStatus.present) {
      map['transfer_status'] = Variable<String>(
        $MessageAttachmentsTable.$convertertransferStatus.toSql(
          transferStatus.value,
        ),
      );
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('messageLocalId: $messageLocalId, ')
          ..write('messageServerId: $messageServerId, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('checksum: $checksum, ')
          ..write('transferStatus: $transferStatus, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientMutationIdMeta = const VerificationMeta(
    'clientMutationId',
  );
  @override
  late final GeneratedColumn<String> clientMutationId = GeneratedColumn<String>(
    'client_mutation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityLocalIdMeta = const VerificationMeta(
    'entityLocalId',
  );
  @override
  late final GeneratedColumn<String> entityLocalId = GeneratedColumn<String>(
    'entity_local_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityServerIdMeta = const VerificationMeta(
    'entityServerId',
  );
  @override
  late final GeneratedColumn<String> entityServerId = GeneratedColumn<String>(
    'entity_server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncMutationOperation, String>
  operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SyncMutationOperation>($SyncOutboxTable.$converteroperation);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>($SyncOutboxTable.$converterpayloadJson);
  static const VerificationMeta _scopeTypeMeta = const VerificationMeta(
    'scopeType',
  );
  @override
  late final GeneratedColumn<String> scopeType = GeneratedColumn<String>(
    'scope_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scopeIdMeta = const VerificationMeta(
    'scopeId',
  );
  @override
  late final GeneratedColumn<String> scopeId = GeneratedColumn<String>(
    'scope_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncMutationStatus, String>
  status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  ).withConverter<SyncMutationStatus>($SyncOutboxTable.$converterstatus);
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextRetryAt = GeneratedColumn<DateTime>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientMutationId,
    entityType,
    entityLocalId,
    entityServerId,
    operation,
    payloadJson,
    scopeType,
    scopeId,
    status,
    attemptCount,
    nextRetryAt,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_mutation_id')) {
      context.handle(
        _clientMutationIdMeta,
        clientMutationId.isAcceptableOrUnknown(
          data['client_mutation_id']!,
          _clientMutationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientMutationIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_local_id')) {
      context.handle(
        _entityLocalIdMeta,
        entityLocalId.isAcceptableOrUnknown(
          data['entity_local_id']!,
          _entityLocalIdMeta,
        ),
      );
    }
    if (data.containsKey('entity_server_id')) {
      context.handle(
        _entityServerIdMeta,
        entityServerId.isAcceptableOrUnknown(
          data['entity_server_id']!,
          _entityServerIdMeta,
        ),
      );
    }
    if (data.containsKey('scope_type')) {
      context.handle(
        _scopeTypeMeta,
        scopeType.isAcceptableOrUnknown(data['scope_type']!, _scopeTypeMeta),
      );
    }
    if (data.containsKey('scope_id')) {
      context.handle(
        _scopeIdMeta,
        scopeId.isAcceptableOrUnknown(data['scope_id']!, _scopeIdMeta),
      );
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      clientMutationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}client_mutation_id'],
          )!,
      entityType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}entity_type'],
          )!,
      entityLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_local_id'],
      ),
      entityServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_server_id'],
      ),
      operation: $SyncOutboxTable.$converteroperation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}operation'],
        )!,
      ),
      payloadJson: $SyncOutboxTable.$converterpayloadJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}payload_json'],
        )!,
      ),
      scopeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope_type'],
      ),
      scopeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope_id'],
      ),
      status: $SyncOutboxTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      attemptCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}attempt_count'],
          )!,
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_retry_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncMutationOperation, String> $converteroperation =
      const MutationOperationConverter();
  static TypeConverter<Map<String, dynamic>, String> $converterpayloadJson =
      const JsonMapConverter();
  static TypeConverter<SyncMutationStatus, String> $converterstatus =
      const MutationStatusConverter();
}

class SyncOutboxData extends DataClass implements Insertable<SyncOutboxData> {
  final int id;
  final String clientMutationId;
  final String entityType;
  final String? entityLocalId;
  final String? entityServerId;
  final SyncMutationOperation operation;
  final Map<String, dynamic> payloadJson;
  final String? scopeType;
  final String? scopeId;
  final SyncMutationStatus status;
  final int attemptCount;
  final DateTime? nextRetryAt;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncOutboxData({
    required this.id,
    required this.clientMutationId,
    required this.entityType,
    this.entityLocalId,
    this.entityServerId,
    required this.operation,
    required this.payloadJson,
    this.scopeType,
    this.scopeId,
    required this.status,
    required this.attemptCount,
    this.nextRetryAt,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_mutation_id'] = Variable<String>(clientMutationId);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityLocalId != null) {
      map['entity_local_id'] = Variable<String>(entityLocalId);
    }
    if (!nullToAbsent || entityServerId != null) {
      map['entity_server_id'] = Variable<String>(entityServerId);
    }
    {
      map['operation'] = Variable<String>(
        $SyncOutboxTable.$converteroperation.toSql(operation),
      );
    }
    {
      map['payload_json'] = Variable<String>(
        $SyncOutboxTable.$converterpayloadJson.toSql(payloadJson),
      );
    }
    if (!nullToAbsent || scopeType != null) {
      map['scope_type'] = Variable<String>(scopeType);
    }
    if (!nullToAbsent || scopeId != null) {
      map['scope_id'] = Variable<String>(scopeId);
    }
    {
      map['status'] = Variable<String>(
        $SyncOutboxTable.$converterstatus.toSql(status),
      );
    }
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      id: Value(id),
      clientMutationId: Value(clientMutationId),
      entityType: Value(entityType),
      entityLocalId:
          entityLocalId == null && nullToAbsent
              ? const Value.absent()
              : Value(entityLocalId),
      entityServerId:
          entityServerId == null && nullToAbsent
              ? const Value.absent()
              : Value(entityServerId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      scopeType:
          scopeType == null && nullToAbsent
              ? const Value.absent()
              : Value(scopeType),
      scopeId:
          scopeId == null && nullToAbsent
              ? const Value.absent()
              : Value(scopeId),
      status: Value(status),
      attemptCount: Value(attemptCount),
      nextRetryAt:
          nextRetryAt == null && nullToAbsent
              ? const Value.absent()
              : Value(nextRetryAt),
      lastError:
          lastError == null && nullToAbsent
              ? const Value.absent()
              : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncOutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxData(
      id: serializer.fromJson<int>(json['id']),
      clientMutationId: serializer.fromJson<String>(json['clientMutationId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityLocalId: serializer.fromJson<String?>(json['entityLocalId']),
      entityServerId: serializer.fromJson<String?>(json['entityServerId']),
      operation: serializer.fromJson<SyncMutationOperation>(json['operation']),
      payloadJson: serializer.fromJson<Map<String, dynamic>>(
        json['payloadJson'],
      ),
      scopeType: serializer.fromJson<String?>(json['scopeType']),
      scopeId: serializer.fromJson<String?>(json['scopeId']),
      status: serializer.fromJson<SyncMutationStatus>(json['status']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      nextRetryAt: serializer.fromJson<DateTime?>(json['nextRetryAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientMutationId': serializer.toJson<String>(clientMutationId),
      'entityType': serializer.toJson<String>(entityType),
      'entityLocalId': serializer.toJson<String?>(entityLocalId),
      'entityServerId': serializer.toJson<String?>(entityServerId),
      'operation': serializer.toJson<SyncMutationOperation>(operation),
      'payloadJson': serializer.toJson<Map<String, dynamic>>(payloadJson),
      'scopeType': serializer.toJson<String?>(scopeType),
      'scopeId': serializer.toJson<String?>(scopeId),
      'status': serializer.toJson<SyncMutationStatus>(status),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'nextRetryAt': serializer.toJson<DateTime?>(nextRetryAt),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncOutboxData copyWith({
    int? id,
    String? clientMutationId,
    String? entityType,
    Value<String?> entityLocalId = const Value.absent(),
    Value<String?> entityServerId = const Value.absent(),
    SyncMutationOperation? operation,
    Map<String, dynamic>? payloadJson,
    Value<String?> scopeType = const Value.absent(),
    Value<String?> scopeId = const Value.absent(),
    SyncMutationStatus? status,
    int? attemptCount,
    Value<DateTime?> nextRetryAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SyncOutboxData(
    id: id ?? this.id,
    clientMutationId: clientMutationId ?? this.clientMutationId,
    entityType: entityType ?? this.entityType,
    entityLocalId:
        entityLocalId.present ? entityLocalId.value : this.entityLocalId,
    entityServerId:
        entityServerId.present ? entityServerId.value : this.entityServerId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    scopeType: scopeType.present ? scopeType.value : this.scopeType,
    scopeId: scopeId.present ? scopeId.value : this.scopeId,
    status: status ?? this.status,
    attemptCount: attemptCount ?? this.attemptCount,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncOutboxData copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxData(
      id: data.id.present ? data.id.value : this.id,
      clientMutationId:
          data.clientMutationId.present
              ? data.clientMutationId.value
              : this.clientMutationId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityLocalId:
          data.entityLocalId.present
              ? data.entityLocalId.value
              : this.entityLocalId,
      entityServerId:
          data.entityServerId.present
              ? data.entityServerId.value
              : this.entityServerId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      scopeType: data.scopeType.present ? data.scopeType.value : this.scopeType,
      scopeId: data.scopeId.present ? data.scopeId.value : this.scopeId,
      status: data.status.present ? data.status.value : this.status,
      attemptCount:
          data.attemptCount.present
              ? data.attemptCount.value
              : this.attemptCount,
      nextRetryAt:
          data.nextRetryAt.present ? data.nextRetryAt.value : this.nextRetryAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxData(')
          ..write('id: $id, ')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityLocalId: $entityLocalId, ')
          ..write('entityServerId: $entityServerId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('scopeType: $scopeType, ')
          ..write('scopeId: $scopeId, ')
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientMutationId,
    entityType,
    entityLocalId,
    entityServerId,
    operation,
    payloadJson,
    scopeType,
    scopeId,
    status,
    attemptCount,
    nextRetryAt,
    lastError,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxData &&
          other.id == this.id &&
          other.clientMutationId == this.clientMutationId &&
          other.entityType == this.entityType &&
          other.entityLocalId == this.entityLocalId &&
          other.entityServerId == this.entityServerId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.scopeType == this.scopeType &&
          other.scopeId == this.scopeId &&
          other.status == this.status &&
          other.attemptCount == this.attemptCount &&
          other.nextRetryAt == this.nextRetryAt &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxData> {
  final Value<int> id;
  final Value<String> clientMutationId;
  final Value<String> entityType;
  final Value<String?> entityLocalId;
  final Value<String?> entityServerId;
  final Value<SyncMutationOperation> operation;
  final Value<Map<String, dynamic>> payloadJson;
  final Value<String?> scopeType;
  final Value<String?> scopeId;
  final Value<SyncMutationStatus> status;
  final Value<int> attemptCount;
  final Value<DateTime?> nextRetryAt;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SyncOutboxCompanion({
    this.id = const Value.absent(),
    this.clientMutationId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityLocalId = const Value.absent(),
    this.entityServerId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.scopeType = const Value.absent(),
    this.scopeId = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    this.id = const Value.absent(),
    required String clientMutationId,
    required String entityType,
    this.entityLocalId = const Value.absent(),
    this.entityServerId = const Value.absent(),
    required SyncMutationOperation operation,
    required Map<String, dynamic> payloadJson,
    this.scopeType = const Value.absent(),
    this.scopeId = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientMutationId = Value(clientMutationId),
       entityType = Value(entityType),
       operation = Value(operation),
       payloadJson = Value(payloadJson);
  static Insertable<SyncOutboxData> custom({
    Expression<int>? id,
    Expression<String>? clientMutationId,
    Expression<String>? entityType,
    Expression<String>? entityLocalId,
    Expression<String>? entityServerId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<String>? scopeType,
    Expression<String>? scopeId,
    Expression<String>? status,
    Expression<int>? attemptCount,
    Expression<DateTime>? nextRetryAt,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientMutationId != null) 'client_mutation_id': clientMutationId,
      if (entityType != null) 'entity_type': entityType,
      if (entityLocalId != null) 'entity_local_id': entityLocalId,
      if (entityServerId != null) 'entity_server_id': entityServerId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (scopeType != null) 'scope_type': scopeType,
      if (scopeId != null) 'scope_id': scopeId,
      if (status != null) 'status': status,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<int>? id,
    Value<String>? clientMutationId,
    Value<String>? entityType,
    Value<String?>? entityLocalId,
    Value<String?>? entityServerId,
    Value<SyncMutationOperation>? operation,
    Value<Map<String, dynamic>>? payloadJson,
    Value<String?>? scopeType,
    Value<String?>? scopeId,
    Value<SyncMutationStatus>? status,
    Value<int>? attemptCount,
    Value<DateTime?>? nextRetryAt,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SyncOutboxCompanion(
      id: id ?? this.id,
      clientMutationId: clientMutationId ?? this.clientMutationId,
      entityType: entityType ?? this.entityType,
      entityLocalId: entityLocalId ?? this.entityLocalId,
      entityServerId: entityServerId ?? this.entityServerId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      scopeType: scopeType ?? this.scopeType,
      scopeId: scopeId ?? this.scopeId,
      status: status ?? this.status,
      attemptCount: attemptCount ?? this.attemptCount,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientMutationId.present) {
      map['client_mutation_id'] = Variable<String>(clientMutationId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityLocalId.present) {
      map['entity_local_id'] = Variable<String>(entityLocalId.value);
    }
    if (entityServerId.present) {
      map['entity_server_id'] = Variable<String>(entityServerId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(
        $SyncOutboxTable.$converteroperation.toSql(operation.value),
      );
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(
        $SyncOutboxTable.$converterpayloadJson.toSql(payloadJson.value),
      );
    }
    if (scopeType.present) {
      map['scope_type'] = Variable<String>(scopeType.value);
    }
    if (scopeId.present) {
      map['scope_id'] = Variable<String>(scopeId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncOutboxTable.$converterstatus.toSql(status.value),
      );
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('id: $id, ')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityLocalId: $entityLocalId, ')
          ..write('entityServerId: $entityServerId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('scopeType: $scopeType, ')
          ..write('scopeId: $scopeId, ')
          ..write('status: $status, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTable extends SyncState
    with TableInfo<$SyncStateTable, SyncStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scopeTypeMeta = const VerificationMeta(
    'scopeType',
  );
  @override
  late final GeneratedColumn<String> scopeType = GeneratedColumn<String>(
    'scope_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeIdMeta = const VerificationMeta(
    'scopeId',
  );
  @override
  late final GeneratedColumn<String> scopeId = GeneratedColumn<String>(
    'scope_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastServerSequenceMeta =
      const VerificationMeta('lastServerSequence');
  @override
  late final GeneratedColumn<int> lastServerSequence = GeneratedColumn<int>(
    'last_server_sequence',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  cursorJson = GeneratedColumn<String>(
    'cursor_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<Map<String, dynamic>?>($SyncStateTable.$convertercursorJson);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scopeType,
    scopeId,
    lastServerSequence,
    lastSyncedAt,
    cursorJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scope_type')) {
      context.handle(
        _scopeTypeMeta,
        scopeType.isAcceptableOrUnknown(data['scope_type']!, _scopeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeTypeMeta);
    }
    if (data.containsKey('scope_id')) {
      context.handle(
        _scopeIdMeta,
        scopeId.isAcceptableOrUnknown(data['scope_id']!, _scopeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeIdMeta);
    }
    if (data.containsKey('last_server_sequence')) {
      context.handle(
        _lastServerSequenceMeta,
        lastServerSequence.isAcceptableOrUnknown(
          data['last_server_sequence']!,
          _lastServerSequenceMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      scopeType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}scope_type'],
          )!,
      scopeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}scope_id'],
          )!,
      lastServerSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_server_sequence'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      cursorJson: $SyncStateTable.$convertercursorJson.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cursor_json'],
        ),
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $SyncStateTable createAlias(String alias) {
    return $SyncStateTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>?, String?> $convertercursorJson =
      const NullableJsonMapConverter();
}

class SyncStateData extends DataClass implements Insertable<SyncStateData> {
  final int id;
  final String scopeType;
  final String scopeId;
  final int? lastServerSequence;
  final DateTime? lastSyncedAt;
  final Map<String, dynamic>? cursorJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncStateData({
    required this.id,
    required this.scopeType,
    required this.scopeId,
    this.lastServerSequence,
    this.lastSyncedAt,
    this.cursorJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scope_type'] = Variable<String>(scopeType);
    map['scope_id'] = Variable<String>(scopeId);
    if (!nullToAbsent || lastServerSequence != null) {
      map['last_server_sequence'] = Variable<int>(lastServerSequence);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || cursorJson != null) {
      map['cursor_json'] = Variable<String>(
        $SyncStateTable.$convertercursorJson.toSql(cursorJson),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncStateCompanion toCompanion(bool nullToAbsent) {
    return SyncStateCompanion(
      id: Value(id),
      scopeType: Value(scopeType),
      scopeId: Value(scopeId),
      lastServerSequence:
          lastServerSequence == null && nullToAbsent
              ? const Value.absent()
              : Value(lastServerSequence),
      lastSyncedAt:
          lastSyncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncedAt),
      cursorJson:
          cursorJson == null && nullToAbsent
              ? const Value.absent()
              : Value(cursorJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateData(
      id: serializer.fromJson<int>(json['id']),
      scopeType: serializer.fromJson<String>(json['scopeType']),
      scopeId: serializer.fromJson<String>(json['scopeId']),
      lastServerSequence: serializer.fromJson<int?>(json['lastServerSequence']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      cursorJson: serializer.fromJson<Map<String, dynamic>?>(
        json['cursorJson'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scopeType': serializer.toJson<String>(scopeType),
      'scopeId': serializer.toJson<String>(scopeId),
      'lastServerSequence': serializer.toJson<int?>(lastServerSequence),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'cursorJson': serializer.toJson<Map<String, dynamic>?>(cursorJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncStateData copyWith({
    int? id,
    String? scopeType,
    String? scopeId,
    Value<int?> lastServerSequence = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    Value<Map<String, dynamic>?> cursorJson = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SyncStateData(
    id: id ?? this.id,
    scopeType: scopeType ?? this.scopeType,
    scopeId: scopeId ?? this.scopeId,
    lastServerSequence:
        lastServerSequence.present
            ? lastServerSequence.value
            : this.lastServerSequence,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    cursorJson: cursorJson.present ? cursorJson.value : this.cursorJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncStateData copyWithCompanion(SyncStateCompanion data) {
    return SyncStateData(
      id: data.id.present ? data.id.value : this.id,
      scopeType: data.scopeType.present ? data.scopeType.value : this.scopeType,
      scopeId: data.scopeId.present ? data.scopeId.value : this.scopeId,
      lastServerSequence:
          data.lastServerSequence.present
              ? data.lastServerSequence.value
              : this.lastServerSequence,
      lastSyncedAt:
          data.lastSyncedAt.present
              ? data.lastSyncedAt.value
              : this.lastSyncedAt,
      cursorJson:
          data.cursorJson.present ? data.cursorJson.value : this.cursorJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateData(')
          ..write('id: $id, ')
          ..write('scopeType: $scopeType, ')
          ..write('scopeId: $scopeId, ')
          ..write('lastServerSequence: $lastServerSequence, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('cursorJson: $cursorJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scopeType,
    scopeId,
    lastServerSequence,
    lastSyncedAt,
    cursorJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateData &&
          other.id == this.id &&
          other.scopeType == this.scopeType &&
          other.scopeId == this.scopeId &&
          other.lastServerSequence == this.lastServerSequence &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.cursorJson == this.cursorJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncStateCompanion extends UpdateCompanion<SyncStateData> {
  final Value<int> id;
  final Value<String> scopeType;
  final Value<String> scopeId;
  final Value<int?> lastServerSequence;
  final Value<DateTime?> lastSyncedAt;
  final Value<Map<String, dynamic>?> cursorJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SyncStateCompanion({
    this.id = const Value.absent(),
    this.scopeType = const Value.absent(),
    this.scopeId = const Value.absent(),
    this.lastServerSequence = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.cursorJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncStateCompanion.insert({
    this.id = const Value.absent(),
    required String scopeType,
    required String scopeId,
    this.lastServerSequence = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.cursorJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : scopeType = Value(scopeType),
       scopeId = Value(scopeId);
  static Insertable<SyncStateData> custom({
    Expression<int>? id,
    Expression<String>? scopeType,
    Expression<String>? scopeId,
    Expression<int>? lastServerSequence,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? cursorJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scopeType != null) 'scope_type': scopeType,
      if (scopeId != null) 'scope_id': scopeId,
      if (lastServerSequence != null)
        'last_server_sequence': lastServerSequence,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (cursorJson != null) 'cursor_json': cursorJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncStateCompanion copyWith({
    Value<int>? id,
    Value<String>? scopeType,
    Value<String>? scopeId,
    Value<int?>? lastServerSequence,
    Value<DateTime?>? lastSyncedAt,
    Value<Map<String, dynamic>?>? cursorJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SyncStateCompanion(
      id: id ?? this.id,
      scopeType: scopeType ?? this.scopeType,
      scopeId: scopeId ?? this.scopeId,
      lastServerSequence: lastServerSequence ?? this.lastServerSequence,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      cursorJson: cursorJson ?? this.cursorJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scopeType.present) {
      map['scope_type'] = Variable<String>(scopeType.value);
    }
    if (scopeId.present) {
      map['scope_id'] = Variable<String>(scopeId.value);
    }
    if (lastServerSequence.present) {
      map['last_server_sequence'] = Variable<int>(lastServerSequence.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (cursorJson.present) {
      map['cursor_json'] = Variable<String>(
        $SyncStateTable.$convertercursorJson.toSql(cursorJson.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateCompanion(')
          ..write('id: $id, ')
          ..write('scopeType: $scopeType, ')
          ..write('scopeId: $scopeId, ')
          ..write('lastServerSequence: $lastServerSequence, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('cursorJson: $cursorJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncErrorsTable extends SyncErrors
    with TableInfo<$SyncErrorsTable, SyncError> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncErrorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientMutationIdMeta = const VerificationMeta(
    'clientMutationId',
  );
  @override
  late final GeneratedColumn<String> clientMutationId = GeneratedColumn<String>(
    'client_mutation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityLocalIdMeta = const VerificationMeta(
    'entityLocalId',
  );
  @override
  late final GeneratedColumn<String> entityLocalId = GeneratedColumn<String>(
    'entity_local_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityServerIdMeta = const VerificationMeta(
    'entityServerId',
  );
  @override
  late final GeneratedColumn<String> entityServerId = GeneratedColumn<String>(
    'entity_server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncMutationOperation, String>
  operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SyncMutationOperation>($SyncErrorsTable.$converteroperation);
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryableMeta = const VerificationMeta(
    'retryable',
  );
  @override
  late final GeneratedColumn<bool> retryable = GeneratedColumn<bool>(
    'retryable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("retryable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncMutationStatus, String>
  status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('failed'),
  ).withConverter<SyncMutationStatus>($SyncErrorsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientMutationId,
    entityType,
    entityLocalId,
    entityServerId,
    operation,
    errorCode,
    errorMessage,
    retryable,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_errors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncError> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_mutation_id')) {
      context.handle(
        _clientMutationIdMeta,
        clientMutationId.isAcceptableOrUnknown(
          data['client_mutation_id']!,
          _clientMutationIdMeta,
        ),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_local_id')) {
      context.handle(
        _entityLocalIdMeta,
        entityLocalId.isAcceptableOrUnknown(
          data['entity_local_id']!,
          _entityLocalIdMeta,
        ),
      );
    }
    if (data.containsKey('entity_server_id')) {
      context.handle(
        _entityServerIdMeta,
        entityServerId.isAcceptableOrUnknown(
          data['entity_server_id']!,
          _entityServerIdMeta,
        ),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_errorMessageMeta);
    }
    if (data.containsKey('retryable')) {
      context.handle(
        _retryableMeta,
        retryable.isAcceptableOrUnknown(data['retryable']!, _retryableMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncError map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncError(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      clientMutationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_mutation_id'],
      ),
      entityType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}entity_type'],
          )!,
      entityLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_local_id'],
      ),
      entityServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_server_id'],
      ),
      operation: $SyncErrorsTable.$converteroperation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}operation'],
        )!,
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      errorMessage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}error_message'],
          )!,
      retryable:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}retryable'],
          )!,
      status: $SyncErrorsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $SyncErrorsTable createAlias(String alias) {
    return $SyncErrorsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncMutationOperation, String> $converteroperation =
      const MutationOperationConverter();
  static TypeConverter<SyncMutationStatus, String> $converterstatus =
      const MutationStatusConverter();
}

class SyncError extends DataClass implements Insertable<SyncError> {
  final int id;
  final String? clientMutationId;
  final String entityType;
  final String? entityLocalId;
  final String? entityServerId;
  final SyncMutationOperation operation;
  final String? errorCode;
  final String errorMessage;
  final bool retryable;
  final SyncMutationStatus status;
  final DateTime createdAt;
  const SyncError({
    required this.id,
    this.clientMutationId,
    required this.entityType,
    this.entityLocalId,
    this.entityServerId,
    required this.operation,
    this.errorCode,
    required this.errorMessage,
    required this.retryable,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clientMutationId != null) {
      map['client_mutation_id'] = Variable<String>(clientMutationId);
    }
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityLocalId != null) {
      map['entity_local_id'] = Variable<String>(entityLocalId);
    }
    if (!nullToAbsent || entityServerId != null) {
      map['entity_server_id'] = Variable<String>(entityServerId);
    }
    {
      map['operation'] = Variable<String>(
        $SyncErrorsTable.$converteroperation.toSql(operation),
      );
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['error_message'] = Variable<String>(errorMessage);
    map['retryable'] = Variable<bool>(retryable);
    {
      map['status'] = Variable<String>(
        $SyncErrorsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncErrorsCompanion toCompanion(bool nullToAbsent) {
    return SyncErrorsCompanion(
      id: Value(id),
      clientMutationId:
          clientMutationId == null && nullToAbsent
              ? const Value.absent()
              : Value(clientMutationId),
      entityType: Value(entityType),
      entityLocalId:
          entityLocalId == null && nullToAbsent
              ? const Value.absent()
              : Value(entityLocalId),
      entityServerId:
          entityServerId == null && nullToAbsent
              ? const Value.absent()
              : Value(entityServerId),
      operation: Value(operation),
      errorCode:
          errorCode == null && nullToAbsent
              ? const Value.absent()
              : Value(errorCode),
      errorMessage: Value(errorMessage),
      retryable: Value(retryable),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory SyncError.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncError(
      id: serializer.fromJson<int>(json['id']),
      clientMutationId: serializer.fromJson<String?>(json['clientMutationId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityLocalId: serializer.fromJson<String?>(json['entityLocalId']),
      entityServerId: serializer.fromJson<String?>(json['entityServerId']),
      operation: serializer.fromJson<SyncMutationOperation>(json['operation']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      errorMessage: serializer.fromJson<String>(json['errorMessage']),
      retryable: serializer.fromJson<bool>(json['retryable']),
      status: serializer.fromJson<SyncMutationStatus>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientMutationId': serializer.toJson<String?>(clientMutationId),
      'entityType': serializer.toJson<String>(entityType),
      'entityLocalId': serializer.toJson<String?>(entityLocalId),
      'entityServerId': serializer.toJson<String?>(entityServerId),
      'operation': serializer.toJson<SyncMutationOperation>(operation),
      'errorCode': serializer.toJson<String?>(errorCode),
      'errorMessage': serializer.toJson<String>(errorMessage),
      'retryable': serializer.toJson<bool>(retryable),
      'status': serializer.toJson<SyncMutationStatus>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncError copyWith({
    int? id,
    Value<String?> clientMutationId = const Value.absent(),
    String? entityType,
    Value<String?> entityLocalId = const Value.absent(),
    Value<String?> entityServerId = const Value.absent(),
    SyncMutationOperation? operation,
    Value<String?> errorCode = const Value.absent(),
    String? errorMessage,
    bool? retryable,
    SyncMutationStatus? status,
    DateTime? createdAt,
  }) => SyncError(
    id: id ?? this.id,
    clientMutationId:
        clientMutationId.present
            ? clientMutationId.value
            : this.clientMutationId,
    entityType: entityType ?? this.entityType,
    entityLocalId:
        entityLocalId.present ? entityLocalId.value : this.entityLocalId,
    entityServerId:
        entityServerId.present ? entityServerId.value : this.entityServerId,
    operation: operation ?? this.operation,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    errorMessage: errorMessage ?? this.errorMessage,
    retryable: retryable ?? this.retryable,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncError copyWithCompanion(SyncErrorsCompanion data) {
    return SyncError(
      id: data.id.present ? data.id.value : this.id,
      clientMutationId:
          data.clientMutationId.present
              ? data.clientMutationId.value
              : this.clientMutationId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityLocalId:
          data.entityLocalId.present
              ? data.entityLocalId.value
              : this.entityLocalId,
      entityServerId:
          data.entityServerId.present
              ? data.entityServerId.value
              : this.entityServerId,
      operation: data.operation.present ? data.operation.value : this.operation,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      errorMessage:
          data.errorMessage.present
              ? data.errorMessage.value
              : this.errorMessage,
      retryable: data.retryable.present ? data.retryable.value : this.retryable,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncError(')
          ..write('id: $id, ')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityLocalId: $entityLocalId, ')
          ..write('entityServerId: $entityServerId, ')
          ..write('operation: $operation, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('retryable: $retryable, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientMutationId,
    entityType,
    entityLocalId,
    entityServerId,
    operation,
    errorCode,
    errorMessage,
    retryable,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncError &&
          other.id == this.id &&
          other.clientMutationId == this.clientMutationId &&
          other.entityType == this.entityType &&
          other.entityLocalId == this.entityLocalId &&
          other.entityServerId == this.entityServerId &&
          other.operation == this.operation &&
          other.errorCode == this.errorCode &&
          other.errorMessage == this.errorMessage &&
          other.retryable == this.retryable &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class SyncErrorsCompanion extends UpdateCompanion<SyncError> {
  final Value<int> id;
  final Value<String?> clientMutationId;
  final Value<String> entityType;
  final Value<String?> entityLocalId;
  final Value<String?> entityServerId;
  final Value<SyncMutationOperation> operation;
  final Value<String?> errorCode;
  final Value<String> errorMessage;
  final Value<bool> retryable;
  final Value<SyncMutationStatus> status;
  final Value<DateTime> createdAt;
  const SyncErrorsCompanion({
    this.id = const Value.absent(),
    this.clientMutationId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityLocalId = const Value.absent(),
    this.entityServerId = const Value.absent(),
    this.operation = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.retryable = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncErrorsCompanion.insert({
    this.id = const Value.absent(),
    this.clientMutationId = const Value.absent(),
    required String entityType,
    this.entityLocalId = const Value.absent(),
    this.entityServerId = const Value.absent(),
    required SyncMutationOperation operation,
    this.errorCode = const Value.absent(),
    required String errorMessage,
    this.retryable = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entityType = Value(entityType),
       operation = Value(operation),
       errorMessage = Value(errorMessage);
  static Insertable<SyncError> custom({
    Expression<int>? id,
    Expression<String>? clientMutationId,
    Expression<String>? entityType,
    Expression<String>? entityLocalId,
    Expression<String>? entityServerId,
    Expression<String>? operation,
    Expression<String>? errorCode,
    Expression<String>? errorMessage,
    Expression<bool>? retryable,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientMutationId != null) 'client_mutation_id': clientMutationId,
      if (entityType != null) 'entity_type': entityType,
      if (entityLocalId != null) 'entity_local_id': entityLocalId,
      if (entityServerId != null) 'entity_server_id': entityServerId,
      if (operation != null) 'operation': operation,
      if (errorCode != null) 'error_code': errorCode,
      if (errorMessage != null) 'error_message': errorMessage,
      if (retryable != null) 'retryable': retryable,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncErrorsCompanion copyWith({
    Value<int>? id,
    Value<String?>? clientMutationId,
    Value<String>? entityType,
    Value<String?>? entityLocalId,
    Value<String?>? entityServerId,
    Value<SyncMutationOperation>? operation,
    Value<String?>? errorCode,
    Value<String>? errorMessage,
    Value<bool>? retryable,
    Value<SyncMutationStatus>? status,
    Value<DateTime>? createdAt,
  }) {
    return SyncErrorsCompanion(
      id: id ?? this.id,
      clientMutationId: clientMutationId ?? this.clientMutationId,
      entityType: entityType ?? this.entityType,
      entityLocalId: entityLocalId ?? this.entityLocalId,
      entityServerId: entityServerId ?? this.entityServerId,
      operation: operation ?? this.operation,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
      retryable: retryable ?? this.retryable,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientMutationId.present) {
      map['client_mutation_id'] = Variable<String>(clientMutationId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityLocalId.present) {
      map['entity_local_id'] = Variable<String>(entityLocalId.value);
    }
    if (entityServerId.present) {
      map['entity_server_id'] = Variable<String>(entityServerId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(
        $SyncErrorsTable.$converteroperation.toSql(operation.value),
      );
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (retryable.present) {
      map['retryable'] = Variable<bool>(retryable.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncErrorsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncErrorsCompanion(')
          ..write('id: $id, ')
          ..write('clientMutationId: $clientMutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityLocalId: $entityLocalId, ')
          ..write('entityServerId: $entityServerId, ')
          ..write('operation: $operation, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('retryable: $retryable, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $WorkspacesTable workspaces = $WorkspacesTable(this);
  late final $ChannelsTable channels = $ChannelsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $MessageAttachmentsTable messageAttachments =
      $MessageAttachmentsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $SyncStateTable syncState = $SyncStateTable(this);
  late final $SyncErrorsTable syncErrors = $SyncErrorsTable(this);
  late final Index localUsersServerIdUnique = Index(
    'local_users_server_id_unique',
    'CREATE UNIQUE INDEX local_users_server_id_unique ON local_users (server_id)',
  );
  late final Index workspacesServerIdUnique = Index(
    'workspaces_server_id_unique',
    'CREATE UNIQUE INDEX workspaces_server_id_unique ON workspaces (server_id)',
  );
  late final Index channelsServerIdUnique = Index(
    'channels_server_id_unique',
    'CREATE UNIQUE INDEX channels_server_id_unique ON channels (server_id)',
  );
  late final Index messagesServerIdUnique = Index(
    'messages_server_id_unique',
    'CREATE UNIQUE INDEX messages_server_id_unique ON messages (server_id)',
  );
  late final Index messagesClientMessageIdUnique = Index(
    'messages_client_message_id_unique',
    'CREATE UNIQUE INDEX messages_client_message_id_unique ON messages (client_message_id)',
  );
  late final Index messagesChannelSequence = Index(
    'messages_channel_sequence',
    'CREATE INDEX messages_channel_sequence ON messages (channel_id, server_sequence)',
  );
  late final Index messageAttachmentsServerIdUnique = Index(
    'message_attachments_server_id_unique',
    'CREATE UNIQUE INDEX message_attachments_server_id_unique ON message_attachments (server_id)',
  );
  late final Index syncOutboxClientMutationIdUnique = Index(
    'sync_outbox_client_mutation_id_unique',
    'CREATE UNIQUE INDEX sync_outbox_client_mutation_id_unique ON sync_outbox (client_mutation_id)',
  );
  late final Index syncOutboxScopeStatus = Index(
    'sync_outbox_scope_status',
    'CREATE INDEX sync_outbox_scope_status ON sync_outbox (scope_id, status)',
  );
  late final Index syncStateScopeUnique = Index(
    'sync_state_scope_unique',
    'CREATE UNIQUE INDEX sync_state_scope_unique ON sync_state (scope_type, scope_id)',
  );
  late final ChatMessagesDao chatMessagesDao = ChatMessagesDao(
    this as AppDatabase,
  );
  late final InstallationIdentityDao installationIdentityDao =
      InstallationIdentityDao(this as AppDatabase);
  late final SyncOutboxDao syncOutboxDao = SyncOutboxDao(this as AppDatabase);
  late final SyncStateDao syncStateDao = SyncStateDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSettings,
    localUsers,
    workspaces,
    channels,
    messages,
    messageAttachments,
    syncOutbox,
    syncState,
    syncErrors,
    localUsersServerIdUnique,
    workspacesServerIdUnique,
    channelsServerIdUnique,
    messagesServerIdUnique,
    messagesClientMessageIdUnique,
    messagesChannelSequence,
    messageAttachmentsServerIdUnique,
    syncOutboxClientMutationIdUnique,
    syncOutboxScopeStatus,
    syncStateScopeUnique,
  ];
}

typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$LocalUsersTableCreateCompanionBuilder =
    LocalUsersCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      required String username,
      Value<String?> email,
      Value<bool> isEmailVerified,
      Value<Map<String, dynamic>?> profileJson,
      Value<Map<String, dynamic>?> statsJson,
      Value<Map<String, dynamic>?> subscriptionJson,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$LocalUsersTableUpdateCompanionBuilder =
    LocalUsersCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<String> username,
      Value<String?> email,
      Value<bool> isEmailVerified,
      Value<Map<String, dynamic>?> profileJson,
      Value<Map<String, dynamic>?> statsJson,
      Value<Map<String, dynamic>?> subscriptionJson,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEmailVerified => $composableBuilder(
    column: $table.isEmailVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get profileJson => $composableBuilder(
    column: $table.profileJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get statsJson => $composableBuilder(
    column: $table.statsJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get subscriptionJson => $composableBuilder(
    column: $table.subscriptionJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEmailVerified => $composableBuilder(
    column: $table.isEmailVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileJson => $composableBuilder(
    column: $table.profileJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statsJson => $composableBuilder(
    column: $table.statsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionJson => $composableBuilder(
    column: $table.subscriptionJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get isEmailVerified => $composableBuilder(
    column: $table.isEmailVerified,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  get profileJson => $composableBuilder(
    column: $table.profileJson,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  get statsJson =>
      $composableBuilder(column: $table.statsJson, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  get subscriptionJson => $composableBuilder(
    column: $table.subscriptionJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUsersTable,
          LocalUser,
          $$LocalUsersTableFilterComposer,
          $$LocalUsersTableOrderingComposer,
          $$LocalUsersTableAnnotationComposer,
          $$LocalUsersTableCreateCompanionBuilder,
          $$LocalUsersTableUpdateCompanionBuilder,
          (
            LocalUser,
            BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>,
          ),
          LocalUser,
          PrefetchHooks Function()
        > {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<bool> isEmailVerified = const Value.absent(),
                Value<Map<String, dynamic>?> profileJson = const Value.absent(),
                Value<Map<String, dynamic>?> statsJson = const Value.absent(),
                Value<Map<String, dynamic>?> subscriptionJson =
                    const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocalUsersCompanion(
                id: id,
                serverId: serverId,
                username: username,
                email: email,
                isEmailVerified: isEmailVerified,
                profileJson: profileJson,
                statsJson: statsJson,
                subscriptionJson: subscriptionJson,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                required String username,
                Value<String?> email = const Value.absent(),
                Value<bool> isEmailVerified = const Value.absent(),
                Value<Map<String, dynamic>?> profileJson = const Value.absent(),
                Value<Map<String, dynamic>?> statsJson = const Value.absent(),
                Value<Map<String, dynamic>?> subscriptionJson =
                    const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocalUsersCompanion.insert(
                id: id,
                serverId: serverId,
                username: username,
                email: email,
                isEmailVerified: isEmailVerified,
                profileJson: profileJson,
                statsJson: statsJson,
                subscriptionJson: subscriptionJson,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUsersTable,
      LocalUser,
      $$LocalUsersTableFilterComposer,
      $$LocalUsersTableOrderingComposer,
      $$LocalUsersTableAnnotationComposer,
      $$LocalUsersTableCreateCompanionBuilder,
      $$LocalUsersTableUpdateCompanionBuilder,
      (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
      LocalUser,
      PrefetchHooks Function()
    >;
typedef $$WorkspacesTableCreateCompanionBuilder =
    WorkspacesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      required String name,
      Value<String?> description,
      required String workspaceType,
      required String workspaceTypeName,
      Value<String?> accessCode,
      Value<bool?> isPublic,
      Value<bool?> requiresApproval,
      Value<int?> memberCount,
      Value<int?> maxMembers,
      Value<int?> channelCount,
      Value<int?> groupCount,
      Value<String?> contentGuidelines,
      Value<List<dynamic>?> rulesJson,
      required Map<String, dynamic> metadataJson,
      Value<String?> createdBy,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> serverUpdatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WorkspacesTableUpdateCompanionBuilder =
    WorkspacesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<String> name,
      Value<String?> description,
      Value<String> workspaceType,
      Value<String> workspaceTypeName,
      Value<String?> accessCode,
      Value<bool?> isPublic,
      Value<bool?> requiresApproval,
      Value<int?> memberCount,
      Value<int?> maxMembers,
      Value<int?> channelCount,
      Value<int?> groupCount,
      Value<String?> contentGuidelines,
      Value<List<dynamic>?> rulesJson,
      Value<Map<String, dynamic>> metadataJson,
      Value<String?> createdBy,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> serverUpdatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$WorkspacesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workspaceType => $composableBuilder(
    column: $table.workspaceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workspaceTypeName => $composableBuilder(
    column: $table.workspaceTypeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessCode => $composableBuilder(
    column: $table.accessCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresApproval => $composableBuilder(
    column: $table.requiresApproval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxMembers => $composableBuilder(
    column: $table.maxMembers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get channelCount => $composableBuilder(
    column: $table.channelCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get groupCount => $composableBuilder(
    column: $table.groupCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentGuidelines => $composableBuilder(
    column: $table.contentGuidelines,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<dynamic>?, List<dynamic>, String>
  get rulesJson => $composableBuilder(
    column: $table.rulesJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkspacesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workspaceType => $composableBuilder(
    column: $table.workspaceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workspaceTypeName => $composableBuilder(
    column: $table.workspaceTypeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessCode => $composableBuilder(
    column: $table.accessCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresApproval => $composableBuilder(
    column: $table.requiresApproval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxMembers => $composableBuilder(
    column: $table.maxMembers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get channelCount => $composableBuilder(
    column: $table.channelCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get groupCount => $composableBuilder(
    column: $table.groupCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentGuidelines => $composableBuilder(
    column: $table.contentGuidelines,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rulesJson => $composableBuilder(
    column: $table.rulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkspacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workspaceType => $composableBuilder(
    column: $table.workspaceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workspaceTypeName => $composableBuilder(
    column: $table.workspaceTypeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accessCode => $composableBuilder(
    column: $table.accessCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPublic =>
      $composableBuilder(column: $table.isPublic, builder: (column) => column);

  GeneratedColumn<bool> get requiresApproval => $composableBuilder(
    column: $table.requiresApproval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxMembers => $composableBuilder(
    column: $table.maxMembers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get channelCount => $composableBuilder(
    column: $table.channelCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get groupCount => $composableBuilder(
    column: $table.groupCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentGuidelines => $composableBuilder(
    column: $table.contentGuidelines,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<dynamic>?, String> get rulesJson =>
      $composableBuilder(column: $table.rulesJson, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorkspacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkspacesTable,
          Workspace,
          $$WorkspacesTableFilterComposer,
          $$WorkspacesTableOrderingComposer,
          $$WorkspacesTableAnnotationComposer,
          $$WorkspacesTableCreateCompanionBuilder,
          $$WorkspacesTableUpdateCompanionBuilder,
          (
            Workspace,
            BaseReferences<_$AppDatabase, $WorkspacesTable, Workspace>,
          ),
          Workspace,
          PrefetchHooks Function()
        > {
  $$WorkspacesTableTableManager(_$AppDatabase db, $WorkspacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorkspacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorkspacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WorkspacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> workspaceType = const Value.absent(),
                Value<String> workspaceTypeName = const Value.absent(),
                Value<String?> accessCode = const Value.absent(),
                Value<bool?> isPublic = const Value.absent(),
                Value<bool?> requiresApproval = const Value.absent(),
                Value<int?> memberCount = const Value.absent(),
                Value<int?> maxMembers = const Value.absent(),
                Value<int?> channelCount = const Value.absent(),
                Value<int?> groupCount = const Value.absent(),
                Value<String?> contentGuidelines = const Value.absent(),
                Value<List<dynamic>?> rulesJson = const Value.absent(),
                Value<Map<String, dynamic>> metadataJson = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> serverUpdatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WorkspacesCompanion(
                id: id,
                serverId: serverId,
                name: name,
                description: description,
                workspaceType: workspaceType,
                workspaceTypeName: workspaceTypeName,
                accessCode: accessCode,
                isPublic: isPublic,
                requiresApproval: requiresApproval,
                memberCount: memberCount,
                maxMembers: maxMembers,
                channelCount: channelCount,
                groupCount: groupCount,
                contentGuidelines: contentGuidelines,
                rulesJson: rulesJson,
                metadataJson: metadataJson,
                createdBy: createdBy,
                serverCreatedAt: serverCreatedAt,
                serverUpdatedAt: serverUpdatedAt,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String workspaceType,
                required String workspaceTypeName,
                Value<String?> accessCode = const Value.absent(),
                Value<bool?> isPublic = const Value.absent(),
                Value<bool?> requiresApproval = const Value.absent(),
                Value<int?> memberCount = const Value.absent(),
                Value<int?> maxMembers = const Value.absent(),
                Value<int?> channelCount = const Value.absent(),
                Value<int?> groupCount = const Value.absent(),
                Value<String?> contentGuidelines = const Value.absent(),
                Value<List<dynamic>?> rulesJson = const Value.absent(),
                required Map<String, dynamic> metadataJson,
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> serverUpdatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WorkspacesCompanion.insert(
                id: id,
                serverId: serverId,
                name: name,
                description: description,
                workspaceType: workspaceType,
                workspaceTypeName: workspaceTypeName,
                accessCode: accessCode,
                isPublic: isPublic,
                requiresApproval: requiresApproval,
                memberCount: memberCount,
                maxMembers: maxMembers,
                channelCount: channelCount,
                groupCount: groupCount,
                contentGuidelines: contentGuidelines,
                rulesJson: rulesJson,
                metadataJson: metadataJson,
                createdBy: createdBy,
                serverCreatedAt: serverCreatedAt,
                serverUpdatedAt: serverUpdatedAt,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkspacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkspacesTable,
      Workspace,
      $$WorkspacesTableFilterComposer,
      $$WorkspacesTableOrderingComposer,
      $$WorkspacesTableAnnotationComposer,
      $$WorkspacesTableCreateCompanionBuilder,
      $$WorkspacesTableUpdateCompanionBuilder,
      (Workspace, BaseReferences<_$AppDatabase, $WorkspacesTable, Workspace>),
      Workspace,
      PrefetchHooks Function()
    >;
typedef $$ChannelsTableCreateCompanionBuilder =
    ChannelsCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<String?> workspaceId,
      Value<String?> groupId,
      required String name,
      Value<bool> isPrivate,
      Value<String?> createdBy,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ChannelsTableUpdateCompanionBuilder =
    ChannelsCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<String?> workspaceId,
      Value<String?> groupId,
      Value<String> name,
      Value<bool> isPrivate,
      Value<String?> createdBy,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ChannelsTableFilterComposer
    extends Composer<_$AppDatabase, $ChannelsTable> {
  $$ChannelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChannelsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChannelsTable> {
  $$ChannelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChannelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChannelsTable> {
  $$ChannelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
    column: $table.workspaceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChannelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChannelsTable,
          Channel,
          $$ChannelsTableFilterComposer,
          $$ChannelsTableOrderingComposer,
          $$ChannelsTableAnnotationComposer,
          $$ChannelsTableCreateCompanionBuilder,
          $$ChannelsTableUpdateCompanionBuilder,
          (Channel, BaseReferences<_$AppDatabase, $ChannelsTable, Channel>),
          Channel,
          PrefetchHooks Function()
        > {
  $$ChannelsTableTableManager(_$AppDatabase db, $ChannelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ChannelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ChannelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ChannelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> workspaceId = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ChannelsCompanion(
                id: id,
                serverId: serverId,
                workspaceId: workspaceId,
                groupId: groupId,
                name: name,
                isPrivate: isPrivate,
                createdBy: createdBy,
                serverCreatedAt: serverCreatedAt,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> workspaceId = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                required String name,
                Value<bool> isPrivate = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ChannelsCompanion.insert(
                id: id,
                serverId: serverId,
                workspaceId: workspaceId,
                groupId: groupId,
                name: name,
                isPrivate: isPrivate,
                createdBy: createdBy,
                serverCreatedAt: serverCreatedAt,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChannelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChannelsTable,
      Channel,
      $$ChannelsTableFilterComposer,
      $$ChannelsTableOrderingComposer,
      $$ChannelsTableAnnotationComposer,
      $$ChannelsTableCreateCompanionBuilder,
      $$ChannelsTableUpdateCompanionBuilder,
      (Channel, BaseReferences<_$AppDatabase, $ChannelsTable, Channel>),
      Channel,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<String?> clientMessageId,
      required String channelId,
      required String senderId,
      required String senderUsername,
      required String content,
      required String messageType,
      required Map<String, dynamic> metadataJson,
      required DateTime clientCreatedAt,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> serverUpdatedAt,
      Value<int?> serverSequence,
      Value<int?> version,
      Value<bool> isEdited,
      Value<DateTime?> editedAt,
      Value<DateTime?> deletedAt,
      Value<MessageDeliveryStatus> deliveryStatus,
      Value<String?> lastSyncError,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<String?> clientMessageId,
      Value<String> channelId,
      Value<String> senderId,
      Value<String> senderUsername,
      Value<String> content,
      Value<String> messageType,
      Value<Map<String, dynamic>> metadataJson,
      Value<DateTime> clientCreatedAt,
      Value<DateTime?> serverCreatedAt,
      Value<DateTime?> serverUpdatedAt,
      Value<int?> serverSequence,
      Value<int?> version,
      Value<bool> isEdited,
      Value<DateTime?> editedAt,
      Value<DateTime?> deletedAt,
      Value<MessageDeliveryStatus> deliveryStatus,
      Value<String?> lastSyncError,
      Value<DateTime?> lastSyncedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channelId => $composableBuilder(
    column: $table.channelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderUsername => $composableBuilder(
    column: $table.senderUsername,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverSequence => $composableBuilder(
    column: $table.serverSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEdited => $composableBuilder(
    column: $table.isEdited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get editedAt => $composableBuilder(
    column: $table.editedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MessageDeliveryStatus,
    MessageDeliveryStatus,
    String
  >
  get deliveryStatus => $composableBuilder(
    column: $table.deliveryStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channelId => $composableBuilder(
    column: $table.channelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderUsername => $composableBuilder(
    column: $table.senderUsername,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverSequence => $composableBuilder(
    column: $table.serverSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEdited => $composableBuilder(
    column: $table.isEdited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get editedAt => $composableBuilder(
    column: $table.editedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deliveryStatus => $composableBuilder(
    column: $table.deliveryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get channelId =>
      $composableBuilder(column: $table.channelId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get senderUsername => $composableBuilder(
    column: $table.senderUsername,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
    column: $table.clientCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get serverCreatedAt => $composableBuilder(
    column: $table.serverCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverSequence => $composableBuilder(
    column: $table.serverSequence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get isEdited =>
      $composableBuilder(column: $table.isEdited, builder: (column) => column);

  GeneratedColumn<DateTime> get editedAt =>
      $composableBuilder(column: $table.editedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MessageDeliveryStatus, String>
  get deliveryStatus => $composableBuilder(
    column: $table.deliveryStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> clientMessageId = const Value.absent(),
                Value<String> channelId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> senderUsername = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> messageType = const Value.absent(),
                Value<Map<String, dynamic>> metadataJson = const Value.absent(),
                Value<DateTime> clientCreatedAt = const Value.absent(),
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> serverUpdatedAt = const Value.absent(),
                Value<int?> serverSequence = const Value.absent(),
                Value<int?> version = const Value.absent(),
                Value<bool> isEdited = const Value.absent(),
                Value<DateTime?> editedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<MessageDeliveryStatus> deliveryStatus =
                    const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                serverId: serverId,
                clientMessageId: clientMessageId,
                channelId: channelId,
                senderId: senderId,
                senderUsername: senderUsername,
                content: content,
                messageType: messageType,
                metadataJson: metadataJson,
                clientCreatedAt: clientCreatedAt,
                serverCreatedAt: serverCreatedAt,
                serverUpdatedAt: serverUpdatedAt,
                serverSequence: serverSequence,
                version: version,
                isEdited: isEdited,
                editedAt: editedAt,
                deletedAt: deletedAt,
                deliveryStatus: deliveryStatus,
                lastSyncError: lastSyncError,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> clientMessageId = const Value.absent(),
                required String channelId,
                required String senderId,
                required String senderUsername,
                required String content,
                required String messageType,
                required Map<String, dynamic> metadataJson,
                required DateTime clientCreatedAt,
                Value<DateTime?> serverCreatedAt = const Value.absent(),
                Value<DateTime?> serverUpdatedAt = const Value.absent(),
                Value<int?> serverSequence = const Value.absent(),
                Value<int?> version = const Value.absent(),
                Value<bool> isEdited = const Value.absent(),
                Value<DateTime?> editedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<MessageDeliveryStatus> deliveryStatus =
                    const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                serverId: serverId,
                clientMessageId: clientMessageId,
                channelId: channelId,
                senderId: senderId,
                senderUsername: senderUsername,
                content: content,
                messageType: messageType,
                metadataJson: metadataJson,
                clientCreatedAt: clientCreatedAt,
                serverCreatedAt: serverCreatedAt,
                serverUpdatedAt: serverUpdatedAt,
                serverSequence: serverSequence,
                version: version,
                isEdited: isEdited,
                editedAt: editedAt,
                deletedAt: deletedAt,
                deliveryStatus: deliveryStatus,
                lastSyncError: lastSyncError,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$MessageAttachmentsTableCreateCompanionBuilder =
    MessageAttachmentsCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<int?> messageLocalId,
      Value<String?> messageServerId,
      Value<String?> localFilePath,
      Value<String?> remoteUrl,
      Value<String?> mimeType,
      Value<int?> sizeBytes,
      Value<String?> checksum,
      Value<AttachmentTransferStatus> transferStatus,
      Value<int> attemptCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$MessageAttachmentsTableUpdateCompanionBuilder =
    MessageAttachmentsCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<int?> messageLocalId,
      Value<String?> messageServerId,
      Value<String?> localFilePath,
      Value<String?> remoteUrl,
      Value<String?> mimeType,
      Value<int?> sizeBytes,
      Value<String?> checksum,
      Value<AttachmentTransferStatus> transferStatus,
      Value<int> attemptCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MessageAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $MessageAttachmentsTable> {
  $$MessageAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get messageLocalId => $composableBuilder(
    column: $table.messageLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageServerId => $composableBuilder(
    column: $table.messageServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localFilePath => $composableBuilder(
    column: $table.localFilePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    AttachmentTransferStatus,
    AttachmentTransferStatus,
    String
  >
  get transferStatus => $composableBuilder(
    column: $table.transferStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageAttachmentsTable> {
  $$MessageAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get messageLocalId => $composableBuilder(
    column: $table.messageLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageServerId => $composableBuilder(
    column: $table.messageServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localFilePath => $composableBuilder(
    column: $table.localFilePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferStatus => $composableBuilder(
    column: $table.transferStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageAttachmentsTable> {
  $$MessageAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<int> get messageLocalId => $composableBuilder(
    column: $table.messageLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get messageServerId => $composableBuilder(
    column: $table.messageServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localFilePath => $composableBuilder(
    column: $table.localFilePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AttachmentTransferStatus, String>
  get transferStatus => $composableBuilder(
    column: $table.transferStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessageAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessageAttachmentsTable,
          MessageAttachment,
          $$MessageAttachmentsTableFilterComposer,
          $$MessageAttachmentsTableOrderingComposer,
          $$MessageAttachmentsTableAnnotationComposer,
          $$MessageAttachmentsTableCreateCompanionBuilder,
          $$MessageAttachmentsTableUpdateCompanionBuilder,
          (
            MessageAttachment,
            BaseReferences<
              _$AppDatabase,
              $MessageAttachmentsTable,
              MessageAttachment
            >,
          ),
          MessageAttachment,
          PrefetchHooks Function()
        > {
  $$MessageAttachmentsTableTableManager(
    _$AppDatabase db,
    $MessageAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MessageAttachmentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$MessageAttachmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$MessageAttachmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<int?> messageLocalId = const Value.absent(),
                Value<String?> messageServerId = const Value.absent(),
                Value<String?> localFilePath = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int?> sizeBytes = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<AttachmentTransferStatus> transferStatus =
                    const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MessageAttachmentsCompanion(
                id: id,
                serverId: serverId,
                messageLocalId: messageLocalId,
                messageServerId: messageServerId,
                localFilePath: localFilePath,
                remoteUrl: remoteUrl,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                checksum: checksum,
                transferStatus: transferStatus,
                attemptCount: attemptCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<int?> messageLocalId = const Value.absent(),
                Value<String?> messageServerId = const Value.absent(),
                Value<String?> localFilePath = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int?> sizeBytes = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<AttachmentTransferStatus> transferStatus =
                    const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MessageAttachmentsCompanion.insert(
                id: id,
                serverId: serverId,
                messageLocalId: messageLocalId,
                messageServerId: messageServerId,
                localFilePath: localFilePath,
                remoteUrl: remoteUrl,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                checksum: checksum,
                transferStatus: transferStatus,
                attemptCount: attemptCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessageAttachmentsTable,
      MessageAttachment,
      $$MessageAttachmentsTableFilterComposer,
      $$MessageAttachmentsTableOrderingComposer,
      $$MessageAttachmentsTableAnnotationComposer,
      $$MessageAttachmentsTableCreateCompanionBuilder,
      $$MessageAttachmentsTableUpdateCompanionBuilder,
      (
        MessageAttachment,
        BaseReferences<
          _$AppDatabase,
          $MessageAttachmentsTable,
          MessageAttachment
        >,
      ),
      MessageAttachment,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<int> id,
      required String clientMutationId,
      required String entityType,
      Value<String?> entityLocalId,
      Value<String?> entityServerId,
      required SyncMutationOperation operation,
      required Map<String, dynamic> payloadJson,
      Value<String?> scopeType,
      Value<String?> scopeId,
      Value<SyncMutationStatus> status,
      Value<int> attemptCount,
      Value<DateTime?> nextRetryAt,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<int> id,
      Value<String> clientMutationId,
      Value<String> entityType,
      Value<String?> entityLocalId,
      Value<String?> entityServerId,
      Value<SyncMutationOperation> operation,
      Value<Map<String, dynamic>> payloadJson,
      Value<String?> scopeType,
      Value<String?> scopeId,
      Value<SyncMutationStatus> status,
      Value<int> attemptCount,
      Value<DateTime?> nextRetryAt,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityLocalId => $composableBuilder(
    column: $table.entityLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityServerId => $composableBuilder(
    column: $table.entityServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    SyncMutationOperation,
    SyncMutationOperation,
    String
  >
  get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get scopeType => $composableBuilder(
    column: $table.scopeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scopeId => $composableBuilder(
    column: $table.scopeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncMutationStatus, SyncMutationStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityLocalId => $composableBuilder(
    column: $table.entityLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityServerId => $composableBuilder(
    column: $table.entityServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scopeType => $composableBuilder(
    column: $table.scopeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scopeId => $composableBuilder(
    column: $table.scopeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityLocalId => $composableBuilder(
    column: $table.entityLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityServerId => $composableBuilder(
    column: $table.entityServerId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncMutationOperation, String>
  get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scopeType =>
      $composableBuilder(column: $table.scopeType, builder: (column) => column);

  GeneratedColumn<String> get scopeId =>
      $composableBuilder(column: $table.scopeId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncMutationStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOutboxData,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOutboxData,
            BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxData>,
          ),
          SyncOutboxData,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientMutationId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String?> entityLocalId = const Value.absent(),
                Value<String?> entityServerId = const Value.absent(),
                Value<SyncMutationOperation> operation = const Value.absent(),
                Value<Map<String, dynamic>> payloadJson = const Value.absent(),
                Value<String?> scopeType = const Value.absent(),
                Value<String?> scopeId = const Value.absent(),
                Value<SyncMutationStatus> status = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncOutboxCompanion(
                id: id,
                clientMutationId: clientMutationId,
                entityType: entityType,
                entityLocalId: entityLocalId,
                entityServerId: entityServerId,
                operation: operation,
                payloadJson: payloadJson,
                scopeType: scopeType,
                scopeId: scopeId,
                status: status,
                attemptCount: attemptCount,
                nextRetryAt: nextRetryAt,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientMutationId,
                required String entityType,
                Value<String?> entityLocalId = const Value.absent(),
                Value<String?> entityServerId = const Value.absent(),
                required SyncMutationOperation operation,
                required Map<String, dynamic> payloadJson,
                Value<String?> scopeType = const Value.absent(),
                Value<String?> scopeId = const Value.absent(),
                Value<SyncMutationStatus> status = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                id: id,
                clientMutationId: clientMutationId,
                entityType: entityType,
                entityLocalId: entityLocalId,
                entityServerId: entityServerId,
                operation: operation,
                payloadJson: payloadJson,
                scopeType: scopeType,
                scopeId: scopeId,
                status: status,
                attemptCount: attemptCount,
                nextRetryAt: nextRetryAt,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOutboxData,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (
        SyncOutboxData,
        BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxData>,
      ),
      SyncOutboxData,
      PrefetchHooks Function()
    >;
typedef $$SyncStateTableCreateCompanionBuilder =
    SyncStateCompanion Function({
      Value<int> id,
      required String scopeType,
      required String scopeId,
      Value<int?> lastServerSequence,
      Value<DateTime?> lastSyncedAt,
      Value<Map<String, dynamic>?> cursorJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SyncStateTableUpdateCompanionBuilder =
    SyncStateCompanion Function({
      Value<int> id,
      Value<String> scopeType,
      Value<String> scopeId,
      Value<int?> lastServerSequence,
      Value<DateTime?> lastSyncedAt,
      Value<Map<String, dynamic>?> cursorJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SyncStateTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scopeType => $composableBuilder(
    column: $table.scopeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scopeId => $composableBuilder(
    column: $table.scopeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastServerSequence => $composableBuilder(
    column: $table.lastServerSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get cursorJson => $composableBuilder(
    column: $table.cursorJson,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStateTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scopeType => $composableBuilder(
    column: $table.scopeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scopeId => $composableBuilder(
    column: $table.scopeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastServerSequence => $composableBuilder(
    column: $table.lastServerSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cursorJson => $composableBuilder(
    column: $table.cursorJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scopeType =>
      $composableBuilder(column: $table.scopeType, builder: (column) => column);

  GeneratedColumn<String> get scopeId =>
      $composableBuilder(column: $table.scopeId, builder: (column) => column);

  GeneratedColumn<int> get lastServerSequence => $composableBuilder(
    column: $table.lastServerSequence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  get cursorJson => $composableBuilder(
    column: $table.cursorJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStateTable,
          SyncStateData,
          $$SyncStateTableFilterComposer,
          $$SyncStateTableOrderingComposer,
          $$SyncStateTableAnnotationComposer,
          $$SyncStateTableCreateCompanionBuilder,
          $$SyncStateTableUpdateCompanionBuilder,
          (
            SyncStateData,
            BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateData>,
          ),
          SyncStateData,
          PrefetchHooks Function()
        > {
  $$SyncStateTableTableManager(_$AppDatabase db, $SyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> scopeType = const Value.absent(),
                Value<String> scopeId = const Value.absent(),
                Value<int?> lastServerSequence = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<Map<String, dynamic>?> cursorJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncStateCompanion(
                id: id,
                scopeType: scopeType,
                scopeId: scopeId,
                lastServerSequence: lastServerSequence,
                lastSyncedAt: lastSyncedAt,
                cursorJson: cursorJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String scopeType,
                required String scopeId,
                Value<int?> lastServerSequence = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<Map<String, dynamic>?> cursorJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncStateCompanion.insert(
                id: id,
                scopeType: scopeType,
                scopeId: scopeId,
                lastServerSequence: lastServerSequence,
                lastSyncedAt: lastSyncedAt,
                cursorJson: cursorJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStateTable,
      SyncStateData,
      $$SyncStateTableFilterComposer,
      $$SyncStateTableOrderingComposer,
      $$SyncStateTableAnnotationComposer,
      $$SyncStateTableCreateCompanionBuilder,
      $$SyncStateTableUpdateCompanionBuilder,
      (
        SyncStateData,
        BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateData>,
      ),
      SyncStateData,
      PrefetchHooks Function()
    >;
typedef $$SyncErrorsTableCreateCompanionBuilder =
    SyncErrorsCompanion Function({
      Value<int> id,
      Value<String?> clientMutationId,
      required String entityType,
      Value<String?> entityLocalId,
      Value<String?> entityServerId,
      required SyncMutationOperation operation,
      Value<String?> errorCode,
      required String errorMessage,
      Value<bool> retryable,
      Value<SyncMutationStatus> status,
      Value<DateTime> createdAt,
    });
typedef $$SyncErrorsTableUpdateCompanionBuilder =
    SyncErrorsCompanion Function({
      Value<int> id,
      Value<String?> clientMutationId,
      Value<String> entityType,
      Value<String?> entityLocalId,
      Value<String?> entityServerId,
      Value<SyncMutationOperation> operation,
      Value<String?> errorCode,
      Value<String> errorMessage,
      Value<bool> retryable,
      Value<SyncMutationStatus> status,
      Value<DateTime> createdAt,
    });

class $$SyncErrorsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncErrorsTable> {
  $$SyncErrorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityLocalId => $composableBuilder(
    column: $table.entityLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityServerId => $composableBuilder(
    column: $table.entityServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    SyncMutationOperation,
    SyncMutationOperation,
    String
  >
  get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get retryable => $composableBuilder(
    column: $table.retryable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncMutationStatus, SyncMutationStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncErrorsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncErrorsTable> {
  $$SyncErrorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityLocalId => $composableBuilder(
    column: $table.entityLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityServerId => $composableBuilder(
    column: $table.entityServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get retryable => $composableBuilder(
    column: $table.retryable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncErrorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncErrorsTable> {
  $$SyncErrorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientMutationId => $composableBuilder(
    column: $table.clientMutationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityLocalId => $composableBuilder(
    column: $table.entityLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityServerId => $composableBuilder(
    column: $table.entityServerId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncMutationOperation, String>
  get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get retryable =>
      $composableBuilder(column: $table.retryable, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncMutationStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncErrorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncErrorsTable,
          SyncError,
          $$SyncErrorsTableFilterComposer,
          $$SyncErrorsTableOrderingComposer,
          $$SyncErrorsTableAnnotationComposer,
          $$SyncErrorsTableCreateCompanionBuilder,
          $$SyncErrorsTableUpdateCompanionBuilder,
          (
            SyncError,
            BaseReferences<_$AppDatabase, $SyncErrorsTable, SyncError>,
          ),
          SyncError,
          PrefetchHooks Function()
        > {
  $$SyncErrorsTableTableManager(_$AppDatabase db, $SyncErrorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncErrorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncErrorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SyncErrorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> clientMutationId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String?> entityLocalId = const Value.absent(),
                Value<String?> entityServerId = const Value.absent(),
                Value<SyncMutationOperation> operation = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String> errorMessage = const Value.absent(),
                Value<bool> retryable = const Value.absent(),
                Value<SyncMutationStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncErrorsCompanion(
                id: id,
                clientMutationId: clientMutationId,
                entityType: entityType,
                entityLocalId: entityLocalId,
                entityServerId: entityServerId,
                operation: operation,
                errorCode: errorCode,
                errorMessage: errorMessage,
                retryable: retryable,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> clientMutationId = const Value.absent(),
                required String entityType,
                Value<String?> entityLocalId = const Value.absent(),
                Value<String?> entityServerId = const Value.absent(),
                required SyncMutationOperation operation,
                Value<String?> errorCode = const Value.absent(),
                required String errorMessage,
                Value<bool> retryable = const Value.absent(),
                Value<SyncMutationStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncErrorsCompanion.insert(
                id: id,
                clientMutationId: clientMutationId,
                entityType: entityType,
                entityLocalId: entityLocalId,
                entityServerId: entityServerId,
                operation: operation,
                errorCode: errorCode,
                errorMessage: errorMessage,
                retryable: retryable,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncErrorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncErrorsTable,
      SyncError,
      $$SyncErrorsTableFilterComposer,
      $$SyncErrorsTableOrderingComposer,
      $$SyncErrorsTableAnnotationComposer,
      $$SyncErrorsTableCreateCompanionBuilder,
      $$SyncErrorsTableUpdateCompanionBuilder,
      (SyncError, BaseReferences<_$AppDatabase, $SyncErrorsTable, SyncError>),
      SyncError,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$WorkspacesTableTableManager get workspaces =>
      $$WorkspacesTableTableManager(_db, _db.workspaces);
  $$ChannelsTableTableManager get channels =>
      $$ChannelsTableTableManager(_db, _db.channels);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$MessageAttachmentsTableTableManager get messageAttachments =>
      $$MessageAttachmentsTableTableManager(_db, _db.messageAttachments);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
  $$SyncErrorsTableTableManager get syncErrors =>
      $$SyncErrorsTableTableManager(_db, _db.syncErrors);
}

mixin _$ChatMessagesDaoMixin on DatabaseAccessor<AppDatabase> {
  $MessagesTable get messages => attachedDatabase.messages;
}
mixin _$InstallationIdentityDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
}
mixin _$SyncOutboxDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncOutboxTable get syncOutbox => attachedDatabase.syncOutbox;
}
mixin _$SyncStateDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncStateTable get syncState => attachedDatabase.syncState;
}
