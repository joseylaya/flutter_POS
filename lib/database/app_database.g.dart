// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _businessNameMeta = const VerificationMeta(
    'businessName',
  );
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
    'business_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BRADZ SILOGAN'),
  );
  static const VerificationMeta _receiptTaglineMeta = const VerificationMeta(
    'receiptTagline',
  );
  @override
  late final GeneratedColumn<String> receiptTagline = GeneratedColumn<String>(
    'receipt_tagline',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Savoring every bite'),
  );
  static const VerificationMeta _businessHoursMeta = const VerificationMeta(
    'businessHours',
  );
  @override
  late final GeneratedColumn<String> businessHours = GeneratedColumn<String>(
    'business_hours',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(
      'Mon-Tue 10:00 AM - 10:00 PM\n'
      'Wed - CLOSED\n'
      'Thu-Sun 10:00 AM - 10:00 PM',
    ),
  );
  static const VerificationMeta _businessAddressMeta = const VerificationMeta(
    'businessAddress',
  );
  @override
  late final GeneratedColumn<String> businessAddress = GeneratedColumn<String>(
    'business_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BNCA Basak Lapu-Lapu City'),
  );
  static const VerificationMeta _receiptFooterMeta = const VerificationMeta(
    'receiptFooter',
  );
  @override
  late final GeneratedColumn<String> receiptFooter = GeneratedColumn<String>(
    'receipt_footer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Thank you!'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PHP'),
  );
  static const VerificationMeta _printerNameMeta = const VerificationMeta(
    'printerName',
  );
  @override
  late final GeneratedColumn<String> printerName = GeneratedColumn<String>(
    'printer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _printerAddressMeta = const VerificationMeta(
    'printerAddress',
  );
  @override
  late final GeneratedColumn<String> printerAddress = GeneratedColumn<String>(
    'printer_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _printerPaperWidthMmMeta =
      const VerificationMeta('printerPaperWidthMm');
  @override
  late final GeneratedColumn<int> printerPaperWidthMm = GeneratedColumn<int>(
    'printer_paper_width_mm',
    aliasedName,
    false,
    check: () =>
        const CustomExpression<bool>('printer_paper_width_mm IN (58, 80)'),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(58),
  );
  static const VerificationMeta _nextTransactionNumberMeta =
      const VerificationMeta('nextTransactionNumber');
  @override
  late final GeneratedColumn<int> nextTransactionNumber = GeneratedColumn<int>(
    'next_transaction_number',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('next_transaction_number > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "theme_mode IN ('SYSTEM', 'LIGHT', 'DARK')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYSTEM'),
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
    businessName,
    receiptTagline,
    businessHours,
    businessAddress,
    receiptFooter,
    currency,
    printerName,
    printerAddress,
    printerPaperWidthMm,
    nextTransactionNumber,
    themeMode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('business_name')) {
      context.handle(
        _businessNameMeta,
        businessName.isAcceptableOrUnknown(
          data['business_name']!,
          _businessNameMeta,
        ),
      );
    }
    if (data.containsKey('receipt_tagline')) {
      context.handle(
        _receiptTaglineMeta,
        receiptTagline.isAcceptableOrUnknown(
          data['receipt_tagline']!,
          _receiptTaglineMeta,
        ),
      );
    }
    if (data.containsKey('business_hours')) {
      context.handle(
        _businessHoursMeta,
        businessHours.isAcceptableOrUnknown(
          data['business_hours']!,
          _businessHoursMeta,
        ),
      );
    }
    if (data.containsKey('business_address')) {
      context.handle(
        _businessAddressMeta,
        businessAddress.isAcceptableOrUnknown(
          data['business_address']!,
          _businessAddressMeta,
        ),
      );
    }
    if (data.containsKey('receipt_footer')) {
      context.handle(
        _receiptFooterMeta,
        receiptFooter.isAcceptableOrUnknown(
          data['receipt_footer']!,
          _receiptFooterMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('printer_name')) {
      context.handle(
        _printerNameMeta,
        printerName.isAcceptableOrUnknown(
          data['printer_name']!,
          _printerNameMeta,
        ),
      );
    }
    if (data.containsKey('printer_address')) {
      context.handle(
        _printerAddressMeta,
        printerAddress.isAcceptableOrUnknown(
          data['printer_address']!,
          _printerAddressMeta,
        ),
      );
    }
    if (data.containsKey('printer_paper_width_mm')) {
      context.handle(
        _printerPaperWidthMmMeta,
        printerPaperWidthMm.isAcceptableOrUnknown(
          data['printer_paper_width_mm']!,
          _printerPaperWidthMmMeta,
        ),
      );
    }
    if (data.containsKey('next_transaction_number')) {
      context.handle(
        _nextTransactionNumberMeta,
        nextTransactionNumber.isAcceptableOrUnknown(
          data['next_transaction_number']!,
          _nextTransactionNumberMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
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
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      businessName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_name'],
      )!,
      receiptTagline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_tagline'],
      )!,
      businessHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_hours'],
      )!,
      businessAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_address'],
      )!,
      receiptFooter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_footer'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      printerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_name'],
      ),
      printerAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_address'],
      ),
      printerPaperWidthMm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}printer_paper_width_mm'],
      )!,
      nextTransactionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_transaction_number'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String businessName;
  final String receiptTagline;
  final String businessHours;
  final String businessAddress;
  final String receiptFooter;
  final String currency;
  final String? printerName;
  final String? printerAddress;
  final int printerPaperWidthMm;
  final int nextTransactionNumber;
  final String themeMode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Setting({
    required this.id,
    required this.businessName,
    required this.receiptTagline,
    required this.businessHours,
    required this.businessAddress,
    required this.receiptFooter,
    required this.currency,
    this.printerName,
    this.printerAddress,
    required this.printerPaperWidthMm,
    required this.nextTransactionNumber,
    required this.themeMode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['business_name'] = Variable<String>(businessName);
    map['receipt_tagline'] = Variable<String>(receiptTagline);
    map['business_hours'] = Variable<String>(businessHours);
    map['business_address'] = Variable<String>(businessAddress);
    map['receipt_footer'] = Variable<String>(receiptFooter);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || printerName != null) {
      map['printer_name'] = Variable<String>(printerName);
    }
    if (!nullToAbsent || printerAddress != null) {
      map['printer_address'] = Variable<String>(printerAddress);
    }
    map['printer_paper_width_mm'] = Variable<int>(printerPaperWidthMm);
    map['next_transaction_number'] = Variable<int>(nextTransactionNumber);
    map['theme_mode'] = Variable<String>(themeMode);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      businessName: Value(businessName),
      receiptTagline: Value(receiptTagline),
      businessHours: Value(businessHours),
      businessAddress: Value(businessAddress),
      receiptFooter: Value(receiptFooter),
      currency: Value(currency),
      printerName: printerName == null && nullToAbsent
          ? const Value.absent()
          : Value(printerName),
      printerAddress: printerAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(printerAddress),
      printerPaperWidthMm: Value(printerPaperWidthMm),
      nextTransactionNumber: Value(nextTransactionNumber),
      themeMode: Value(themeMode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      businessName: serializer.fromJson<String>(json['businessName']),
      receiptTagline: serializer.fromJson<String>(json['receiptTagline']),
      businessHours: serializer.fromJson<String>(json['businessHours']),
      businessAddress: serializer.fromJson<String>(json['businessAddress']),
      receiptFooter: serializer.fromJson<String>(json['receiptFooter']),
      currency: serializer.fromJson<String>(json['currency']),
      printerName: serializer.fromJson<String?>(json['printerName']),
      printerAddress: serializer.fromJson<String?>(json['printerAddress']),
      printerPaperWidthMm: serializer.fromJson<int>(
        json['printerPaperWidthMm'],
      ),
      nextTransactionNumber: serializer.fromJson<int>(
        json['nextTransactionNumber'],
      ),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'businessName': serializer.toJson<String>(businessName),
      'receiptTagline': serializer.toJson<String>(receiptTagline),
      'businessHours': serializer.toJson<String>(businessHours),
      'businessAddress': serializer.toJson<String>(businessAddress),
      'receiptFooter': serializer.toJson<String>(receiptFooter),
      'currency': serializer.toJson<String>(currency),
      'printerName': serializer.toJson<String?>(printerName),
      'printerAddress': serializer.toJson<String?>(printerAddress),
      'printerPaperWidthMm': serializer.toJson<int>(printerPaperWidthMm),
      'nextTransactionNumber': serializer.toJson<int>(nextTransactionNumber),
      'themeMode': serializer.toJson<String>(themeMode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith({
    int? id,
    String? businessName,
    String? receiptTagline,
    String? businessHours,
    String? businessAddress,
    String? receiptFooter,
    String? currency,
    Value<String?> printerName = const Value.absent(),
    Value<String?> printerAddress = const Value.absent(),
    int? printerPaperWidthMm,
    int? nextTransactionNumber,
    String? themeMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Setting(
    id: id ?? this.id,
    businessName: businessName ?? this.businessName,
    receiptTagline: receiptTagline ?? this.receiptTagline,
    businessHours: businessHours ?? this.businessHours,
    businessAddress: businessAddress ?? this.businessAddress,
    receiptFooter: receiptFooter ?? this.receiptFooter,
    currency: currency ?? this.currency,
    printerName: printerName.present ? printerName.value : this.printerName,
    printerAddress: printerAddress.present
        ? printerAddress.value
        : this.printerAddress,
    printerPaperWidthMm: printerPaperWidthMm ?? this.printerPaperWidthMm,
    nextTransactionNumber: nextTransactionNumber ?? this.nextTransactionNumber,
    themeMode: themeMode ?? this.themeMode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
      receiptTagline: data.receiptTagline.present
          ? data.receiptTagline.value
          : this.receiptTagline,
      businessHours: data.businessHours.present
          ? data.businessHours.value
          : this.businessHours,
      businessAddress: data.businessAddress.present
          ? data.businessAddress.value
          : this.businessAddress,
      receiptFooter: data.receiptFooter.present
          ? data.receiptFooter.value
          : this.receiptFooter,
      currency: data.currency.present ? data.currency.value : this.currency,
      printerName: data.printerName.present
          ? data.printerName.value
          : this.printerName,
      printerAddress: data.printerAddress.present
          ? data.printerAddress.value
          : this.printerAddress,
      printerPaperWidthMm: data.printerPaperWidthMm.present
          ? data.printerPaperWidthMm.value
          : this.printerPaperWidthMm,
      nextTransactionNumber: data.nextTransactionNumber.present
          ? data.nextTransactionNumber.value
          : this.nextTransactionNumber,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('receiptTagline: $receiptTagline, ')
          ..write('businessHours: $businessHours, ')
          ..write('businessAddress: $businessAddress, ')
          ..write('receiptFooter: $receiptFooter, ')
          ..write('currency: $currency, ')
          ..write('printerName: $printerName, ')
          ..write('printerAddress: $printerAddress, ')
          ..write('printerPaperWidthMm: $printerPaperWidthMm, ')
          ..write('nextTransactionNumber: $nextTransactionNumber, ')
          ..write('themeMode: $themeMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    businessName,
    receiptTagline,
    businessHours,
    businessAddress,
    receiptFooter,
    currency,
    printerName,
    printerAddress,
    printerPaperWidthMm,
    nextTransactionNumber,
    themeMode,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.businessName == this.businessName &&
          other.receiptTagline == this.receiptTagline &&
          other.businessHours == this.businessHours &&
          other.businessAddress == this.businessAddress &&
          other.receiptFooter == this.receiptFooter &&
          other.currency == this.currency &&
          other.printerName == this.printerName &&
          other.printerAddress == this.printerAddress &&
          other.printerPaperWidthMm == this.printerPaperWidthMm &&
          other.nextTransactionNumber == this.nextTransactionNumber &&
          other.themeMode == this.themeMode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<String> businessName;
  final Value<String> receiptTagline;
  final Value<String> businessHours;
  final Value<String> businessAddress;
  final Value<String> receiptFooter;
  final Value<String> currency;
  final Value<String?> printerName;
  final Value<String?> printerAddress;
  final Value<int> printerPaperWidthMm;
  final Value<int> nextTransactionNumber;
  final Value<String> themeMode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.receiptTagline = const Value.absent(),
    this.businessHours = const Value.absent(),
    this.businessAddress = const Value.absent(),
    this.receiptFooter = const Value.absent(),
    this.currency = const Value.absent(),
    this.printerName = const Value.absent(),
    this.printerAddress = const Value.absent(),
    this.printerPaperWidthMm = const Value.absent(),
    this.nextTransactionNumber = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.receiptTagline = const Value.absent(),
    this.businessHours = const Value.absent(),
    this.businessAddress = const Value.absent(),
    this.receiptFooter = const Value.absent(),
    this.currency = const Value.absent(),
    this.printerName = const Value.absent(),
    this.printerAddress = const Value.absent(),
    this.printerPaperWidthMm = const Value.absent(),
    this.nextTransactionNumber = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<String>? businessName,
    Expression<String>? receiptTagline,
    Expression<String>? businessHours,
    Expression<String>? businessAddress,
    Expression<String>? receiptFooter,
    Expression<String>? currency,
    Expression<String>? printerName,
    Expression<String>? printerAddress,
    Expression<int>? printerPaperWidthMm,
    Expression<int>? nextTransactionNumber,
    Expression<String>? themeMode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessName != null) 'business_name': businessName,
      if (receiptTagline != null) 'receipt_tagline': receiptTagline,
      if (businessHours != null) 'business_hours': businessHours,
      if (businessAddress != null) 'business_address': businessAddress,
      if (receiptFooter != null) 'receipt_footer': receiptFooter,
      if (currency != null) 'currency': currency,
      if (printerName != null) 'printer_name': printerName,
      if (printerAddress != null) 'printer_address': printerAddress,
      if (printerPaperWidthMm != null)
        'printer_paper_width_mm': printerPaperWidthMm,
      if (nextTransactionNumber != null)
        'next_transaction_number': nextTransactionNumber,
      if (themeMode != null) 'theme_mode': themeMode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? businessName,
    Value<String>? receiptTagline,
    Value<String>? businessHours,
    Value<String>? businessAddress,
    Value<String>? receiptFooter,
    Value<String>? currency,
    Value<String?>? printerName,
    Value<String?>? printerAddress,
    Value<int>? printerPaperWidthMm,
    Value<int>? nextTransactionNumber,
    Value<String>? themeMode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      receiptTagline: receiptTagline ?? this.receiptTagline,
      businessHours: businessHours ?? this.businessHours,
      businessAddress: businessAddress ?? this.businessAddress,
      receiptFooter: receiptFooter ?? this.receiptFooter,
      currency: currency ?? this.currency,
      printerName: printerName ?? this.printerName,
      printerAddress: printerAddress ?? this.printerAddress,
      printerPaperWidthMm: printerPaperWidthMm ?? this.printerPaperWidthMm,
      nextTransactionNumber:
          nextTransactionNumber ?? this.nextTransactionNumber,
      themeMode: themeMode ?? this.themeMode,
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
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (receiptTagline.present) {
      map['receipt_tagline'] = Variable<String>(receiptTagline.value);
    }
    if (businessHours.present) {
      map['business_hours'] = Variable<String>(businessHours.value);
    }
    if (businessAddress.present) {
      map['business_address'] = Variable<String>(businessAddress.value);
    }
    if (receiptFooter.present) {
      map['receipt_footer'] = Variable<String>(receiptFooter.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (printerName.present) {
      map['printer_name'] = Variable<String>(printerName.value);
    }
    if (printerAddress.present) {
      map['printer_address'] = Variable<String>(printerAddress.value);
    }
    if (printerPaperWidthMm.present) {
      map['printer_paper_width_mm'] = Variable<int>(printerPaperWidthMm.value);
    }
    if (nextTransactionNumber.present) {
      map['next_transaction_number'] = Variable<int>(
        nextTransactionNumber.value,
      );
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
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
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('receiptTagline: $receiptTagline, ')
          ..write('businessHours: $businessHours, ')
          ..write('businessAddress: $businessAddress, ')
          ..write('receiptFooter: $receiptFooter, ')
          ..write('currency: $currency, ')
          ..write('printerName: $printerName, ')
          ..write('printerAddress: $printerAddress, ')
          ..write('printerPaperWidthMm: $printerPaperWidthMm, ')
          ..write('nextTransactionNumber: $nextTransactionNumber, ')
          ..write('themeMode: $themeMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<int> stockQuantity = GeneratedColumn<int>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPerUnitMeta = const VerificationMeta(
    'costPerUnit',
  );
  @override
  late final GeneratedColumn<int> costPerUnit = GeneratedColumn<int>(
    'cost_per_unit',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('cost_per_unit >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lowStockThresholdMeta = const VerificationMeta(
    'lowStockThreshold',
  );
  @override
  late final GeneratedColumn<int> lowStockThreshold = GeneratedColumn<int>(
    'low_stock_threshold',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('low_stock_threshold >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    stockQuantity,
    unit,
    costPerUnit,
    lowStockThreshold,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('cost_per_unit')) {
      context.handle(
        _costPerUnitMeta,
        costPerUnit.isAcceptableOrUnknown(
          data['cost_per_unit']!,
          _costPerUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costPerUnitMeta);
    }
    if (data.containsKey('low_stock_threshold')) {
      context.handle(
        _lowStockThresholdMeta,
        lowStockThreshold.isAcceptableOrUnknown(
          data['low_stock_threshold']!,
          _lowStockThresholdMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      costPerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_per_unit'],
      )!,
      lowStockThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_stock_threshold'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final int stockQuantity;
  final String unit;
  final int costPerUnit;
  final int lowStockThreshold;
  final bool isActive;
  const InventoryItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.stockQuantity,
    required this.unit,
    required this.costPerUnit,
    required this.lowStockThreshold,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['stock_quantity'] = Variable<int>(stockQuantity);
    map['unit'] = Variable<String>(unit);
    map['cost_per_unit'] = Variable<int>(costPerUnit);
    map['low_stock_threshold'] = Variable<int>(lowStockThreshold);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      stockQuantity: Value(stockQuantity),
      unit: Value(unit),
      costPerUnit: Value(costPerUnit),
      lowStockThreshold: Value(lowStockThreshold),
      isActive: Value(isActive),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      stockQuantity: serializer.fromJson<int>(json['stockQuantity']),
      unit: serializer.fromJson<String>(json['unit']),
      costPerUnit: serializer.fromJson<int>(json['costPerUnit']),
      lowStockThreshold: serializer.fromJson<int>(json['lowStockThreshold']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'stockQuantity': serializer.toJson<int>(stockQuantity),
      'unit': serializer.toJson<String>(unit),
      'costPerUnit': serializer.toJson<int>(costPerUnit),
      'lowStockThreshold': serializer.toJson<int>(lowStockThreshold),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  InventoryItem copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    int? stockQuantity,
    String? unit,
    int? costPerUnit,
    int? lowStockThreshold,
    bool? isActive,
  }) => InventoryItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    stockQuantity: stockQuantity ?? this.stockQuantity,
    unit: unit ?? this.unit,
    costPerUnit: costPerUnit ?? this.costPerUnit,
    lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
    isActive: isActive ?? this.isActive,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      costPerUnit: data.costPerUnit.present
          ? data.costPerUnit.value
          : this.costPerUnit,
      lowStockThreshold: data.lowStockThreshold.present
          ? data.lowStockThreshold.value
          : this.lowStockThreshold,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('unit: $unit, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    stockQuantity,
    unit,
    costPerUnit,
    lowStockThreshold,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.stockQuantity == this.stockQuantity &&
          other.unit == this.unit &&
          other.costPerUnit == this.costPerUnit &&
          other.lowStockThreshold == this.lowStockThreshold &&
          other.isActive == this.isActive);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<int> stockQuantity;
  final Value<String> unit;
  final Value<int> costPerUnit;
  final Value<int> lowStockThreshold;
  final Value<bool> isActive;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.costPerUnit = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    this.stockQuantity = const Value.absent(),
    required String unit,
    required int costPerUnit,
    this.lowStockThreshold = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       unit = Value(unit),
       costPerUnit = Value(costPerUnit);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<int>? stockQuantity,
    Expression<String>? unit,
    Expression<int>? costPerUnit,
    Expression<int>? lowStockThreshold,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (unit != null) 'unit': unit,
      if (costPerUnit != null) 'cost_per_unit': costPerUnit,
      if (lowStockThreshold != null) 'low_stock_threshold': lowStockThreshold,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<int>? stockQuantity,
    Value<String>? unit,
    Value<int>? costPerUnit,
    Value<int>? lowStockThreshold,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      unit: unit ?? this.unit,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<int>(stockQuantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (costPerUnit.present) {
      map['cost_per_unit'] = Variable<int>(costPerUnit.value);
    }
    if (lowStockThreshold.present) {
      map['low_stock_threshold'] = Variable<int>(lowStockThreshold.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('unit: $unit, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Other'),
  );
  static const VerificationMeta _imageDataMeta = const VerificationMeta(
    'imageData',
  );
  @override
  late final GeneratedColumn<Uint8List> imageData = GeneratedColumn<Uint8List>(
    'image_data',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<int> sellingPrice = GeneratedColumn<int>(
    'selling_price',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('selling_price >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inventoryItemIdMeta = const VerificationMeta(
    'inventoryItemId',
  );
  @override
  late final GeneratedColumn<String> inventoryItemId = GeneratedColumn<String>(
    'inventory_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES inventory_items (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    category,
    imageData,
    sellingPrice,
    inventoryItemId,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('image_data')) {
      context.handle(
        _imageDataMeta,
        imageData.isAcceptableOrUnknown(data['image_data']!, _imageDataMeta),
      );
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('inventory_item_id')) {
      context.handle(
        _inventoryItemIdMeta,
        inventoryItemId.isAcceptableOrUnknown(
          data['inventory_item_id']!,
          _inventoryItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inventoryItemIdMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      ),
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}selling_price'],
      )!,
      inventoryItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inventory_item_id'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String category;
  final Uint8List? imageData;
  final int sellingPrice;
  final String inventoryItemId;
  final bool isActive;
  const Product({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.category,
    this.imageData,
    required this.sellingPrice,
    required this.inventoryItemId,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || imageData != null) {
      map['image_data'] = Variable<Uint8List>(imageData);
    }
    map['selling_price'] = Variable<int>(sellingPrice);
    map['inventory_item_id'] = Variable<String>(inventoryItemId);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      category: Value(category),
      imageData: imageData == null && nullToAbsent
          ? const Value.absent()
          : Value(imageData),
      sellingPrice: Value(sellingPrice),
      inventoryItemId: Value(inventoryItemId),
      isActive: Value(isActive),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      imageData: serializer.fromJson<Uint8List?>(json['imageData']),
      sellingPrice: serializer.fromJson<int>(json['sellingPrice']),
      inventoryItemId: serializer.fromJson<String>(json['inventoryItemId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'imageData': serializer.toJson<Uint8List?>(imageData),
      'sellingPrice': serializer.toJson<int>(sellingPrice),
      'inventoryItemId': serializer.toJson<String>(inventoryItemId),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Product copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? category,
    Value<Uint8List?> imageData = const Value.absent(),
    int? sellingPrice,
    String? inventoryItemId,
    bool? isActive,
  }) => Product(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    category: category ?? this.category,
    imageData: imageData.present ? imageData.value : this.imageData,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    inventoryItemId: inventoryItemId ?? this.inventoryItemId,
    isActive: isActive ?? this.isActive,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      imageData: data.imageData.present ? data.imageData.value : this.imageData,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      inventoryItemId: data.inventoryItemId.present
          ? data.inventoryItemId.value
          : this.inventoryItemId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('imageData: $imageData, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('inventoryItemId: $inventoryItemId, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    category,
    $driftBlobEquality.hash(imageData),
    sellingPrice,
    inventoryItemId,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.category == this.category &&
          $driftBlobEquality.equals(other.imageData, this.imageData) &&
          other.sellingPrice == this.sellingPrice &&
          other.inventoryItemId == this.inventoryItemId &&
          other.isActive == this.isActive);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String> category;
  final Value<Uint8List?> imageData;
  final Value<int> sellingPrice;
  final Value<String> inventoryItemId;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.imageData = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.inventoryItemId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.imageData = const Value.absent(),
    required int sellingPrice,
    required String inventoryItemId,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       sellingPrice = Value(sellingPrice),
       inventoryItemId = Value(inventoryItemId);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? category,
    Expression<Uint8List>? imageData,
    Expression<int>? sellingPrice,
    Expression<String>? inventoryItemId,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (imageData != null) 'image_data': imageData,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (inventoryItemId != null) 'inventory_item_id': inventoryItemId,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String>? category,
    Value<Uint8List?>? imageData,
    Value<int>? sellingPrice,
    Value<String>? inventoryItemId,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      category: category ?? this.category,
      imageData: imageData ?? this.imageData,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      inventoryItemId: inventoryItemId ?? this.inventoryItemId,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<int>(sellingPrice.value);
    }
    if (inventoryItemId.present) {
      map['inventory_item_id'] = Variable<String>(inventoryItemId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('imageData: $imageData, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('inventoryItemId: $inventoryItemId, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductInclusionsTable extends ProductInclusions
    with TableInfo<$ProductInclusionsTable, ProductInclusion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductInclusionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _inventoryItemIdMeta = const VerificationMeta(
    'inventoryItemId',
  );
  @override
  late final GeneratedColumn<String> inventoryItemId = GeneratedColumn<String>(
    'inventory_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES inventory_items (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('quantity > 0'),
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    inventoryItemId,
    quantity,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_inclusions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductInclusion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('inventory_item_id')) {
      context.handle(
        _inventoryItemIdMeta,
        inventoryItemId.isAcceptableOrUnknown(
          data['inventory_item_id']!,
          _inventoryItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inventoryItemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {productId, inventoryItemId},
  ];
  @override
  ProductInclusion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductInclusion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      inventoryItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inventory_item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductInclusionsTable createAlias(String alias) {
    return $ProductInclusionsTable(attachedDatabase, alias);
  }
}

class ProductInclusion extends DataClass
    implements Insertable<ProductInclusion> {
  final String id;
  final String productId;
  final String inventoryItemId;
  final int quantity;
  final DateTime createdAt;
  const ProductInclusion({
    required this.id,
    required this.productId,
    required this.inventoryItemId,
    required this.quantity,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['inventory_item_id'] = Variable<String>(inventoryItemId);
    map['quantity'] = Variable<int>(quantity);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductInclusionsCompanion toCompanion(bool nullToAbsent) {
    return ProductInclusionsCompanion(
      id: Value(id),
      productId: Value(productId),
      inventoryItemId: Value(inventoryItemId),
      quantity: Value(quantity),
      createdAt: Value(createdAt),
    );
  }

  factory ProductInclusion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductInclusion(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      inventoryItemId: serializer.fromJson<String>(json['inventoryItemId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'inventoryItemId': serializer.toJson<String>(inventoryItemId),
      'quantity': serializer.toJson<int>(quantity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductInclusion copyWith({
    String? id,
    String? productId,
    String? inventoryItemId,
    int? quantity,
    DateTime? createdAt,
  }) => ProductInclusion(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    inventoryItemId: inventoryItemId ?? this.inventoryItemId,
    quantity: quantity ?? this.quantity,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductInclusion copyWithCompanion(ProductInclusionsCompanion data) {
    return ProductInclusion(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      inventoryItemId: data.inventoryItemId.present
          ? data.inventoryItemId.value
          : this.inventoryItemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductInclusion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('inventoryItemId: $inventoryItemId, ')
          ..write('quantity: $quantity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, inventoryItemId, quantity, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductInclusion &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.inventoryItemId == this.inventoryItemId &&
          other.quantity == this.quantity &&
          other.createdAt == this.createdAt);
}

class ProductInclusionsCompanion extends UpdateCompanion<ProductInclusion> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> inventoryItemId;
  final Value<int> quantity;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductInclusionsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.inventoryItemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductInclusionsCompanion.insert({
    required String id,
    required String productId,
    required String inventoryItemId,
    required int quantity,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       productId = Value(productId),
       inventoryItemId = Value(inventoryItemId),
       quantity = Value(quantity);
  static Insertable<ProductInclusion> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? inventoryItemId,
    Expression<int>? quantity,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (inventoryItemId != null) 'inventory_item_id': inventoryItemId,
      if (quantity != null) 'quantity': quantity,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductInclusionsCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String>? inventoryItemId,
    Value<int>? quantity,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductInclusionsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      inventoryItemId: inventoryItemId ?? this.inventoryItemId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (inventoryItemId.present) {
      map['inventory_item_id'] = Variable<String>(inventoryItemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductInclusionsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('inventoryItemId: $inventoryItemId, ')
          ..write('quantity: $quantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryMovementsTable extends InventoryMovements
    with TableInfo<$InventoryMovementsTable, InventoryMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inventoryItemIdMeta = const VerificationMeta(
    'inventoryItemId',
  );
  @override
  late final GeneratedColumn<String> inventoryItemId = GeneratedColumn<String>(
    'inventory_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES inventory_items (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _movementTypeMeta = const VerificationMeta(
    'movementType',
  );
  @override
  late final GeneratedColumn<String> movementType = GeneratedColumn<String>(
    'movement_type',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "movement_type IN ('SALE', 'ADD', 'REMOVE')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('quantity != 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityBeforeMeta = const VerificationMeta(
    'quantityBefore',
  );
  @override
  late final GeneratedColumn<int> quantityBefore = GeneratedColumn<int>(
    'quantity_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityAfterMeta = const VerificationMeta(
    'quantityAfter',
  );
  @override
  late final GeneratedColumn<int> quantityAfter = GeneratedColumn<int>(
    'quantity_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inventoryItemId,
    movementType,
    quantity,
    quantityBefore,
    quantityAfter,
    referenceType,
    referenceId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('inventory_item_id')) {
      context.handle(
        _inventoryItemIdMeta,
        inventoryItemId.isAcceptableOrUnknown(
          data['inventory_item_id']!,
          _inventoryItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inventoryItemIdMeta);
    }
    if (data.containsKey('movement_type')) {
      context.handle(
        _movementTypeMeta,
        movementType.isAcceptableOrUnknown(
          data['movement_type']!,
          _movementTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_movementTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('quantity_before')) {
      context.handle(
        _quantityBeforeMeta,
        quantityBefore.isAcceptableOrUnknown(
          data['quantity_before']!,
          _quantityBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityBeforeMeta);
    }
    if (data.containsKey('quantity_after')) {
      context.handle(
        _quantityAfterMeta,
        quantityAfter.isAcceptableOrUnknown(
          data['quantity_after']!,
          _quantityAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityAfterMeta);
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
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
  InventoryMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      inventoryItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inventory_item_id'],
      )!,
      movementType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}movement_type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      quantityBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_before'],
      )!,
      quantityAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_after'],
      )!,
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InventoryMovementsTable createAlias(String alias) {
    return $InventoryMovementsTable(attachedDatabase, alias);
  }
}

class InventoryMovement extends DataClass
    implements Insertable<InventoryMovement> {
  final String id;
  final String inventoryItemId;
  final String movementType;
  final int quantity;
  final int quantityBefore;
  final int quantityAfter;
  final String? referenceType;
  final String? referenceId;
  final DateTime createdAt;
  const InventoryMovement({
    required this.id,
    required this.inventoryItemId,
    required this.movementType,
    required this.quantity,
    required this.quantityBefore,
    required this.quantityAfter,
    this.referenceType,
    this.referenceId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['inventory_item_id'] = Variable<String>(inventoryItemId);
    map['movement_type'] = Variable<String>(movementType);
    map['quantity'] = Variable<int>(quantity);
    map['quantity_before'] = Variable<int>(quantityBefore);
    map['quantity_after'] = Variable<int>(quantityAfter);
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InventoryMovementsCompanion toCompanion(bool nullToAbsent) {
    return InventoryMovementsCompanion(
      id: Value(id),
      inventoryItemId: Value(inventoryItemId),
      movementType: Value(movementType),
      quantity: Value(quantity),
      quantityBefore: Value(quantityBefore),
      quantityAfter: Value(quantityAfter),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      createdAt: Value(createdAt),
    );
  }

  factory InventoryMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryMovement(
      id: serializer.fromJson<String>(json['id']),
      inventoryItemId: serializer.fromJson<String>(json['inventoryItemId']),
      movementType: serializer.fromJson<String>(json['movementType']),
      quantity: serializer.fromJson<int>(json['quantity']),
      quantityBefore: serializer.fromJson<int>(json['quantityBefore']),
      quantityAfter: serializer.fromJson<int>(json['quantityAfter']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'inventoryItemId': serializer.toJson<String>(inventoryItemId),
      'movementType': serializer.toJson<String>(movementType),
      'quantity': serializer.toJson<int>(quantity),
      'quantityBefore': serializer.toJson<int>(quantityBefore),
      'quantityAfter': serializer.toJson<int>(quantityAfter),
      'referenceType': serializer.toJson<String?>(referenceType),
      'referenceId': serializer.toJson<String?>(referenceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InventoryMovement copyWith({
    String? id,
    String? inventoryItemId,
    String? movementType,
    int? quantity,
    int? quantityBefore,
    int? quantityAfter,
    Value<String?> referenceType = const Value.absent(),
    Value<String?> referenceId = const Value.absent(),
    DateTime? createdAt,
  }) => InventoryMovement(
    id: id ?? this.id,
    inventoryItemId: inventoryItemId ?? this.inventoryItemId,
    movementType: movementType ?? this.movementType,
    quantity: quantity ?? this.quantity,
    quantityBefore: quantityBefore ?? this.quantityBefore,
    quantityAfter: quantityAfter ?? this.quantityAfter,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    createdAt: createdAt ?? this.createdAt,
  );
  InventoryMovement copyWithCompanion(InventoryMovementsCompanion data) {
    return InventoryMovement(
      id: data.id.present ? data.id.value : this.id,
      inventoryItemId: data.inventoryItemId.present
          ? data.inventoryItemId.value
          : this.inventoryItemId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      quantityBefore: data.quantityBefore.present
          ? data.quantityBefore.value
          : this.quantityBefore,
      quantityAfter: data.quantityAfter.present
          ? data.quantityAfter.value
          : this.quantityAfter,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryMovement(')
          ..write('id: $id, ')
          ..write('inventoryItemId: $inventoryItemId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('quantityBefore: $quantityBefore, ')
          ..write('quantityAfter: $quantityAfter, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    inventoryItemId,
    movementType,
    quantity,
    quantityBefore,
    quantityAfter,
    referenceType,
    referenceId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryMovement &&
          other.id == this.id &&
          other.inventoryItemId == this.inventoryItemId &&
          other.movementType == this.movementType &&
          other.quantity == this.quantity &&
          other.quantityBefore == this.quantityBefore &&
          other.quantityAfter == this.quantityAfter &&
          other.referenceType == this.referenceType &&
          other.referenceId == this.referenceId &&
          other.createdAt == this.createdAt);
}

class InventoryMovementsCompanion extends UpdateCompanion<InventoryMovement> {
  final Value<String> id;
  final Value<String> inventoryItemId;
  final Value<String> movementType;
  final Value<int> quantity;
  final Value<int> quantityBefore;
  final Value<int> quantityAfter;
  final Value<String?> referenceType;
  final Value<String?> referenceId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InventoryMovementsCompanion({
    this.id = const Value.absent(),
    this.inventoryItemId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityBefore = const Value.absent(),
    this.quantityAfter = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryMovementsCompanion.insert({
    required String id,
    required String inventoryItemId,
    required String movementType,
    required int quantity,
    required int quantityBefore,
    required int quantityAfter,
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       inventoryItemId = Value(inventoryItemId),
       movementType = Value(movementType),
       quantity = Value(quantity),
       quantityBefore = Value(quantityBefore),
       quantityAfter = Value(quantityAfter);
  static Insertable<InventoryMovement> custom({
    Expression<String>? id,
    Expression<String>? inventoryItemId,
    Expression<String>? movementType,
    Expression<int>? quantity,
    Expression<int>? quantityBefore,
    Expression<int>? quantityAfter,
    Expression<String>? referenceType,
    Expression<String>? referenceId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inventoryItemId != null) 'inventory_item_id': inventoryItemId,
      if (movementType != null) 'movement_type': movementType,
      if (quantity != null) 'quantity': quantity,
      if (quantityBefore != null) 'quantity_before': quantityBefore,
      if (quantityAfter != null) 'quantity_after': quantityAfter,
      if (referenceType != null) 'reference_type': referenceType,
      if (referenceId != null) 'reference_id': referenceId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryMovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? inventoryItemId,
    Value<String>? movementType,
    Value<int>? quantity,
    Value<int>? quantityBefore,
    Value<int>? quantityAfter,
    Value<String?>? referenceType,
    Value<String?>? referenceId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InventoryMovementsCompanion(
      id: id ?? this.id,
      inventoryItemId: inventoryItemId ?? this.inventoryItemId,
      movementType: movementType ?? this.movementType,
      quantity: quantity ?? this.quantity,
      quantityBefore: quantityBefore ?? this.quantityBefore,
      quantityAfter: quantityAfter ?? this.quantityAfter,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (inventoryItemId.present) {
      map['inventory_item_id'] = Variable<String>(inventoryItemId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(movementType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (quantityBefore.present) {
      map['quantity_before'] = Variable<int>(quantityBefore.value);
    }
    if (quantityAfter.present) {
      map['quantity_after'] = Variable<int>(quantityAfter.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryMovementsCompanion(')
          ..write('id: $id, ')
          ..write('inventoryItemId: $inventoryItemId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('quantityBefore: $quantityBefore, ')
          ..write('quantityAfter: $quantityAfter, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiscountsTable extends Discounts
    with TableInfo<$DiscountsTable, Discount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentageBasisPointsMeta =
      const VerificationMeta('percentageBasisPoints');
  @override
  late final GeneratedColumn<int> percentageBasisPoints = GeneratedColumn<int>(
    'percentage_basis_points',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      'percentage_basis_points BETWEEN 1 AND 10000',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>("scope IN ('ALL', 'SELECTED')"),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    percentageBasisPoints,
    scope,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Discount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('percentage_basis_points')) {
      context.handle(
        _percentageBasisPointsMeta,
        percentageBasisPoints.isAcceptableOrUnknown(
          data['percentage_basis_points']!,
          _percentageBasisPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_percentageBasisPointsMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Discount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Discount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      percentageBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}percentage_basis_points'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $DiscountsTable createAlias(String alias) {
    return $DiscountsTable(attachedDatabase, alias);
  }
}

class Discount extends DataClass implements Insertable<Discount> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final int percentageBasisPoints;
  final String scope;
  final bool isActive;
  const Discount({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.percentageBasisPoints,
    required this.scope,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['percentage_basis_points'] = Variable<int>(percentageBasisPoints);
    map['scope'] = Variable<String>(scope);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  DiscountsCompanion toCompanion(bool nullToAbsent) {
    return DiscountsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      percentageBasisPoints: Value(percentageBasisPoints),
      scope: Value(scope),
      isActive: Value(isActive),
    );
  }

  factory Discount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Discount(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      percentageBasisPoints: serializer.fromJson<int>(
        json['percentageBasisPoints'],
      ),
      scope: serializer.fromJson<String>(json['scope']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'percentageBasisPoints': serializer.toJson<int>(percentageBasisPoints),
      'scope': serializer.toJson<String>(scope),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Discount copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    int? percentageBasisPoints,
    String? scope,
    bool? isActive,
  }) => Discount(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    percentageBasisPoints: percentageBasisPoints ?? this.percentageBasisPoints,
    scope: scope ?? this.scope,
    isActive: isActive ?? this.isActive,
  );
  Discount copyWithCompanion(DiscountsCompanion data) {
    return Discount(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      percentageBasisPoints: data.percentageBasisPoints.present
          ? data.percentageBasisPoints.value
          : this.percentageBasisPoints,
      scope: data.scope.present ? data.scope.value : this.scope,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Discount(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('percentageBasisPoints: $percentageBasisPoints, ')
          ..write('scope: $scope, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    percentageBasisPoints,
    scope,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Discount &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.percentageBasisPoints == this.percentageBasisPoints &&
          other.scope == this.scope &&
          other.isActive == this.isActive);
}

class DiscountsCompanion extends UpdateCompanion<Discount> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<int> percentageBasisPoints;
  final Value<String> scope;
  final Value<bool> isActive;
  final Value<int> rowid;
  const DiscountsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.percentageBasisPoints = const Value.absent(),
    this.scope = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiscountsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required int percentageBasisPoints,
    required String scope,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       percentageBasisPoints = Value(percentageBasisPoints),
       scope = Value(scope);
  static Insertable<Discount> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<int>? percentageBasisPoints,
    Expression<String>? scope,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (percentageBasisPoints != null)
        'percentage_basis_points': percentageBasisPoints,
      if (scope != null) 'scope': scope,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiscountsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<int>? percentageBasisPoints,
    Value<String>? scope,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return DiscountsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      percentageBasisPoints:
          percentageBasisPoints ?? this.percentageBasisPoints,
      scope: scope ?? this.scope,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (percentageBasisPoints.present) {
      map['percentage_basis_points'] = Variable<int>(
        percentageBasisPoints.value,
      );
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('percentageBasisPoints: $percentageBasisPoints, ')
          ..write('scope: $scope, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiscountProductsTable extends DiscountProducts
    with TableInfo<$DiscountProductsTable, DiscountProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountIdMeta = const VerificationMeta(
    'discountId',
  );
  @override
  late final GeneratedColumn<String> discountId = GeneratedColumn<String>(
    'discount_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES discounts (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
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
  @override
  List<GeneratedColumn> get $columns => [id, discountId, productId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discount_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiscountProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('discount_id')) {
      context.handle(
        _discountIdMeta,
        discountId.isAcceptableOrUnknown(data['discount_id']!, _discountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_discountIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {discountId, productId},
  ];
  @override
  DiscountProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscountProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      discountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discount_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DiscountProductsTable createAlias(String alias) {
    return $DiscountProductsTable(attachedDatabase, alias);
  }
}

class DiscountProduct extends DataClass implements Insertable<DiscountProduct> {
  final String id;
  final String discountId;
  final String productId;
  final DateTime createdAt;
  const DiscountProduct({
    required this.id,
    required this.discountId,
    required this.productId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['discount_id'] = Variable<String>(discountId);
    map['product_id'] = Variable<String>(productId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DiscountProductsCompanion toCompanion(bool nullToAbsent) {
    return DiscountProductsCompanion(
      id: Value(id),
      discountId: Value(discountId),
      productId: Value(productId),
      createdAt: Value(createdAt),
    );
  }

  factory DiscountProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiscountProduct(
      id: serializer.fromJson<String>(json['id']),
      discountId: serializer.fromJson<String>(json['discountId']),
      productId: serializer.fromJson<String>(json['productId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'discountId': serializer.toJson<String>(discountId),
      'productId': serializer.toJson<String>(productId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DiscountProduct copyWith({
    String? id,
    String? discountId,
    String? productId,
    DateTime? createdAt,
  }) => DiscountProduct(
    id: id ?? this.id,
    discountId: discountId ?? this.discountId,
    productId: productId ?? this.productId,
    createdAt: createdAt ?? this.createdAt,
  );
  DiscountProduct copyWithCompanion(DiscountProductsCompanion data) {
    return DiscountProduct(
      id: data.id.present ? data.id.value : this.id,
      discountId: data.discountId.present
          ? data.discountId.value
          : this.discountId,
      productId: data.productId.present ? data.productId.value : this.productId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiscountProduct(')
          ..write('id: $id, ')
          ..write('discountId: $discountId, ')
          ..write('productId: $productId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, discountId, productId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscountProduct &&
          other.id == this.id &&
          other.discountId == this.discountId &&
          other.productId == this.productId &&
          other.createdAt == this.createdAt);
}

class DiscountProductsCompanion extends UpdateCompanion<DiscountProduct> {
  final Value<String> id;
  final Value<String> discountId;
  final Value<String> productId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DiscountProductsCompanion({
    this.id = const Value.absent(),
    this.discountId = const Value.absent(),
    this.productId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiscountProductsCompanion.insert({
    required String id,
    required String discountId,
    required String productId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       discountId = Value(discountId),
       productId = Value(productId);
  static Insertable<DiscountProduct> custom({
    Expression<String>? id,
    Expression<String>? discountId,
    Expression<String>? productId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (discountId != null) 'discount_id': discountId,
      if (productId != null) 'product_id': productId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiscountProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? discountId,
    Value<String>? productId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DiscountProductsCompanion(
      id: id ?? this.id,
      discountId: discountId ?? this.discountId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (discountId.present) {
      map['discount_id'] = Variable<String>(discountId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountProductsCompanion(')
          ..write('id: $id, ')
          ..write('discountId: $discountId, ')
          ..write('productId: $productId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _transactionNumberMeta = const VerificationMeta(
    'transactionNumber',
  );
  @override
  late final GeneratedColumn<int> transactionNumber = GeneratedColumn<int>(
    'transaction_number',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('transaction_number > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('subtotal >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<int> discountAmount = GeneratedColumn<int>(
    'discount_amount',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('discount_amount >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
    'total_amount',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('total_amount >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<int> totalCost = GeneratedColumn<int>(
    'total_cost',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('total_cost >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profitMeta = const VerificationMeta('profit');
  @override
  late final GeneratedColumn<int> profit = GeneratedColumn<int>(
    'profit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profitMarginBasisPointsMeta =
      const VerificationMeta('profitMarginBasisPoints');
  @override
  late final GeneratedColumn<int> profitMarginBasisPoints =
      GeneratedColumn<int>(
        'profit_margin_basis_points',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    check: () =>
        const CustomExpression<bool>("payment_method IN ('CASH', 'GCASH')"),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentReferenceMeta = const VerificationMeta(
    'paymentReference',
  );
  @override
  late final GeneratedColumn<String> paymentReference = GeneratedColumn<String>(
    'payment_reference',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 80),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderTypeMeta = const VerificationMeta(
    'orderType',
  );
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
    'order_type',
    aliasedName,
    false,
    check: () =>
        const CustomExpression<bool>("order_type IN ('DINE_IN', 'TAKE_OUT')"),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('DINE_IN'),
  );
  static const VerificationMeta _fulfillmentTypeMeta = const VerificationMeta(
    'fulfillmentType',
  );
  @override
  late final GeneratedColumn<String> fulfillmentType = GeneratedColumn<String>(
    'fulfillment_type',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      "fulfillment_type IS NULL OR fulfillment_type IN ('DELIVERY', 'PICKUP')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cashReceivedMeta = const VerificationMeta(
    'cashReceived',
  );
  @override
  late final GeneratedColumn<int> cashReceived = GeneratedColumn<int>(
    'cash_received',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changeAmountMeta = const VerificationMeta(
    'changeAmount',
  );
  @override
  late final GeneratedColumn<int> changeAmount = GeneratedColumn<int>(
    'change_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>("status = 'COMPLETED'"),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('COMPLETED'),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    transactionNumber,
    subtotal,
    discountAmount,
    totalAmount,
    totalCost,
    profit,
    profitMarginBasisPoints,
    paymentMethod,
    paymentReference,
    orderType,
    fulfillmentType,
    cashReceived,
    changeAmount,
    status,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('transaction_number')) {
      context.handle(
        _transactionNumberMeta,
        transactionNumber.isAcceptableOrUnknown(
          data['transaction_number']!,
          _transactionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionNumberMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountAmountMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('profit')) {
      context.handle(
        _profitMeta,
        profit.isAcceptableOrUnknown(data['profit']!, _profitMeta),
      );
    } else if (isInserting) {
      context.missing(_profitMeta);
    }
    if (data.containsKey('profit_margin_basis_points')) {
      context.handle(
        _profitMarginBasisPointsMeta,
        profitMarginBasisPoints.isAcceptableOrUnknown(
          data['profit_margin_basis_points']!,
          _profitMarginBasisPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_profitMarginBasisPointsMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('payment_reference')) {
      context.handle(
        _paymentReferenceMeta,
        paymentReference.isAcceptableOrUnknown(
          data['payment_reference']!,
          _paymentReferenceMeta,
        ),
      );
    }
    if (data.containsKey('order_type')) {
      context.handle(
        _orderTypeMeta,
        orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta),
      );
    }
    if (data.containsKey('fulfillment_type')) {
      context.handle(
        _fulfillmentTypeMeta,
        fulfillmentType.isAcceptableOrUnknown(
          data['fulfillment_type']!,
          _fulfillmentTypeMeta,
        ),
      );
    }
    if (data.containsKey('cash_received')) {
      context.handle(
        _cashReceivedMeta,
        cashReceived.isAcceptableOrUnknown(
          data['cash_received']!,
          _cashReceivedMeta,
        ),
      );
    }
    if (data.containsKey('change_amount')) {
      context.handle(
        _changeAmountMeta,
        changeAmount.isAcceptableOrUnknown(
          data['change_amount']!,
          _changeAmountMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      transactionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_number'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_amount'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost'],
      )!,
      profit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profit'],
      )!,
      profitMarginBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profit_margin_basis_points'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      paymentReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_reference'],
      ),
      orderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_type'],
      )!,
      fulfillmentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fulfillment_type'],
      ),
      cashReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cash_received'],
      ),
      changeAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}change_amount'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int transactionNumber;
  final int subtotal;
  final int discountAmount;
  final int totalAmount;
  final int totalCost;
  final int profit;
  final int profitMarginBasisPoints;
  final String paymentMethod;
  final String? paymentReference;
  final String orderType;
  final String? fulfillmentType;
  final int? cashReceived;
  final int? changeAmount;
  final String status;
  final DateTime completedAt;
  const Sale({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionNumber,
    required this.subtotal,
    required this.discountAmount,
    required this.totalAmount,
    required this.totalCost,
    required this.profit,
    required this.profitMarginBasisPoints,
    required this.paymentMethod,
    this.paymentReference,
    required this.orderType,
    this.fulfillmentType,
    this.cashReceived,
    this.changeAmount,
    required this.status,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['transaction_number'] = Variable<int>(transactionNumber);
    map['subtotal'] = Variable<int>(subtotal);
    map['discount_amount'] = Variable<int>(discountAmount);
    map['total_amount'] = Variable<int>(totalAmount);
    map['total_cost'] = Variable<int>(totalCost);
    map['profit'] = Variable<int>(profit);
    map['profit_margin_basis_points'] = Variable<int>(profitMarginBasisPoints);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || paymentReference != null) {
      map['payment_reference'] = Variable<String>(paymentReference);
    }
    map['order_type'] = Variable<String>(orderType);
    if (!nullToAbsent || fulfillmentType != null) {
      map['fulfillment_type'] = Variable<String>(fulfillmentType);
    }
    if (!nullToAbsent || cashReceived != null) {
      map['cash_received'] = Variable<int>(cashReceived);
    }
    if (!nullToAbsent || changeAmount != null) {
      map['change_amount'] = Variable<int>(changeAmount);
    }
    map['status'] = Variable<String>(status);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      transactionNumber: Value(transactionNumber),
      subtotal: Value(subtotal),
      discountAmount: Value(discountAmount),
      totalAmount: Value(totalAmount),
      totalCost: Value(totalCost),
      profit: Value(profit),
      profitMarginBasisPoints: Value(profitMarginBasisPoints),
      paymentMethod: Value(paymentMethod),
      paymentReference: paymentReference == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentReference),
      orderType: Value(orderType),
      fulfillmentType: fulfillmentType == null && nullToAbsent
          ? const Value.absent()
          : Value(fulfillmentType),
      cashReceived: cashReceived == null && nullToAbsent
          ? const Value.absent()
          : Value(cashReceived),
      changeAmount: changeAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(changeAmount),
      status: Value(status),
      completedAt: Value(completedAt),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      transactionNumber: serializer.fromJson<int>(json['transactionNumber']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      discountAmount: serializer.fromJson<int>(json['discountAmount']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      totalCost: serializer.fromJson<int>(json['totalCost']),
      profit: serializer.fromJson<int>(json['profit']),
      profitMarginBasisPoints: serializer.fromJson<int>(
        json['profitMarginBasisPoints'],
      ),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paymentReference: serializer.fromJson<String?>(json['paymentReference']),
      orderType: serializer.fromJson<String>(json['orderType']),
      fulfillmentType: serializer.fromJson<String?>(json['fulfillmentType']),
      cashReceived: serializer.fromJson<int?>(json['cashReceived']),
      changeAmount: serializer.fromJson<int?>(json['changeAmount']),
      status: serializer.fromJson<String>(json['status']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'transactionNumber': serializer.toJson<int>(transactionNumber),
      'subtotal': serializer.toJson<int>(subtotal),
      'discountAmount': serializer.toJson<int>(discountAmount),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'totalCost': serializer.toJson<int>(totalCost),
      'profit': serializer.toJson<int>(profit),
      'profitMarginBasisPoints': serializer.toJson<int>(
        profitMarginBasisPoints,
      ),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paymentReference': serializer.toJson<String?>(paymentReference),
      'orderType': serializer.toJson<String>(orderType),
      'fulfillmentType': serializer.toJson<String?>(fulfillmentType),
      'cashReceived': serializer.toJson<int?>(cashReceived),
      'changeAmount': serializer.toJson<int?>(changeAmount),
      'status': serializer.toJson<String>(status),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  Sale copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? transactionNumber,
    int? subtotal,
    int? discountAmount,
    int? totalAmount,
    int? totalCost,
    int? profit,
    int? profitMarginBasisPoints,
    String? paymentMethod,
    Value<String?> paymentReference = const Value.absent(),
    String? orderType,
    Value<String?> fulfillmentType = const Value.absent(),
    Value<int?> cashReceived = const Value.absent(),
    Value<int?> changeAmount = const Value.absent(),
    String? status,
    DateTime? completedAt,
  }) => Sale(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    transactionNumber: transactionNumber ?? this.transactionNumber,
    subtotal: subtotal ?? this.subtotal,
    discountAmount: discountAmount ?? this.discountAmount,
    totalAmount: totalAmount ?? this.totalAmount,
    totalCost: totalCost ?? this.totalCost,
    profit: profit ?? this.profit,
    profitMarginBasisPoints:
        profitMarginBasisPoints ?? this.profitMarginBasisPoints,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    paymentReference: paymentReference.present
        ? paymentReference.value
        : this.paymentReference,
    orderType: orderType ?? this.orderType,
    fulfillmentType: fulfillmentType.present
        ? fulfillmentType.value
        : this.fulfillmentType,
    cashReceived: cashReceived.present ? cashReceived.value : this.cashReceived,
    changeAmount: changeAmount.present ? changeAmount.value : this.changeAmount,
    status: status ?? this.status,
    completedAt: completedAt ?? this.completedAt,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      transactionNumber: data.transactionNumber.present
          ? data.transactionNumber.value
          : this.transactionNumber,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      profit: data.profit.present ? data.profit.value : this.profit,
      profitMarginBasisPoints: data.profitMarginBasisPoints.present
          ? data.profitMarginBasisPoints.value
          : this.profitMarginBasisPoints,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentReference: data.paymentReference.present
          ? data.paymentReference.value
          : this.paymentReference,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      fulfillmentType: data.fulfillmentType.present
          ? data.fulfillmentType.value
          : this.fulfillmentType,
      cashReceived: data.cashReceived.present
          ? data.cashReceived.value
          : this.cashReceived,
      changeAmount: data.changeAmount.present
          ? data.changeAmount.value
          : this.changeAmount,
      status: data.status.present ? data.status.value : this.status,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('transactionNumber: $transactionNumber, ')
          ..write('subtotal: $subtotal, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('totalCost: $totalCost, ')
          ..write('profit: $profit, ')
          ..write('profitMarginBasisPoints: $profitMarginBasisPoints, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentReference: $paymentReference, ')
          ..write('orderType: $orderType, ')
          ..write('fulfillmentType: $fulfillmentType, ')
          ..write('cashReceived: $cashReceived, ')
          ..write('changeAmount: $changeAmount, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    transactionNumber,
    subtotal,
    discountAmount,
    totalAmount,
    totalCost,
    profit,
    profitMarginBasisPoints,
    paymentMethod,
    paymentReference,
    orderType,
    fulfillmentType,
    cashReceived,
    changeAmount,
    status,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.transactionNumber == this.transactionNumber &&
          other.subtotal == this.subtotal &&
          other.discountAmount == this.discountAmount &&
          other.totalAmount == this.totalAmount &&
          other.totalCost == this.totalCost &&
          other.profit == this.profit &&
          other.profitMarginBasisPoints == this.profitMarginBasisPoints &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentReference == this.paymentReference &&
          other.orderType == this.orderType &&
          other.fulfillmentType == this.fulfillmentType &&
          other.cashReceived == this.cashReceived &&
          other.changeAmount == this.changeAmount &&
          other.status == this.status &&
          other.completedAt == this.completedAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> transactionNumber;
  final Value<int> subtotal;
  final Value<int> discountAmount;
  final Value<int> totalAmount;
  final Value<int> totalCost;
  final Value<int> profit;
  final Value<int> profitMarginBasisPoints;
  final Value<String> paymentMethod;
  final Value<String?> paymentReference;
  final Value<String> orderType;
  final Value<String?> fulfillmentType;
  final Value<int?> cashReceived;
  final Value<int?> changeAmount;
  final Value<String> status;
  final Value<DateTime> completedAt;
  final Value<int> rowid;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.transactionNumber = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.profit = const Value.absent(),
    this.profitMarginBasisPoints = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentReference = const Value.absent(),
    this.orderType = const Value.absent(),
    this.fulfillmentType = const Value.absent(),
    this.cashReceived = const Value.absent(),
    this.changeAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int transactionNumber,
    required int subtotal,
    required int discountAmount,
    required int totalAmount,
    required int totalCost,
    required int profit,
    required int profitMarginBasisPoints,
    required String paymentMethod,
    this.paymentReference = const Value.absent(),
    this.orderType = const Value.absent(),
    this.fulfillmentType = const Value.absent(),
    this.cashReceived = const Value.absent(),
    this.changeAmount = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime completedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       transactionNumber = Value(transactionNumber),
       subtotal = Value(subtotal),
       discountAmount = Value(discountAmount),
       totalAmount = Value(totalAmount),
       totalCost = Value(totalCost),
       profit = Value(profit),
       profitMarginBasisPoints = Value(profitMarginBasisPoints),
       paymentMethod = Value(paymentMethod),
       completedAt = Value(completedAt);
  static Insertable<Sale> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? transactionNumber,
    Expression<int>? subtotal,
    Expression<int>? discountAmount,
    Expression<int>? totalAmount,
    Expression<int>? totalCost,
    Expression<int>? profit,
    Expression<int>? profitMarginBasisPoints,
    Expression<String>? paymentMethod,
    Expression<String>? paymentReference,
    Expression<String>? orderType,
    Expression<String>? fulfillmentType,
    Expression<int>? cashReceived,
    Expression<int>? changeAmount,
    Expression<String>? status,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (transactionNumber != null) 'transaction_number': transactionNumber,
      if (subtotal != null) 'subtotal': subtotal,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (totalCost != null) 'total_cost': totalCost,
      if (profit != null) 'profit': profit,
      if (profitMarginBasisPoints != null)
        'profit_margin_basis_points': profitMarginBasisPoints,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentReference != null) 'payment_reference': paymentReference,
      if (orderType != null) 'order_type': orderType,
      if (fulfillmentType != null) 'fulfillment_type': fulfillmentType,
      if (cashReceived != null) 'cash_received': cashReceived,
      if (changeAmount != null) 'change_amount': changeAmount,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? transactionNumber,
    Value<int>? subtotal,
    Value<int>? discountAmount,
    Value<int>? totalAmount,
    Value<int>? totalCost,
    Value<int>? profit,
    Value<int>? profitMarginBasisPoints,
    Value<String>? paymentMethod,
    Value<String?>? paymentReference,
    Value<String>? orderType,
    Value<String?>? fulfillmentType,
    Value<int?>? cashReceived,
    Value<int?>? changeAmount,
    Value<String>? status,
    Value<DateTime>? completedAt,
    Value<int>? rowid,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      totalCost: totalCost ?? this.totalCost,
      profit: profit ?? this.profit,
      profitMarginBasisPoints:
          profitMarginBasisPoints ?? this.profitMarginBasisPoints,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentReference: paymentReference ?? this.paymentReference,
      orderType: orderType ?? this.orderType,
      fulfillmentType: fulfillmentType ?? this.fulfillmentType,
      cashReceived: cashReceived ?? this.cashReceived,
      changeAmount: changeAmount ?? this.changeAmount,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (transactionNumber.present) {
      map['transaction_number'] = Variable<int>(transactionNumber.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<int>(discountAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<int>(totalCost.value);
    }
    if (profit.present) {
      map['profit'] = Variable<int>(profit.value);
    }
    if (profitMarginBasisPoints.present) {
      map['profit_margin_basis_points'] = Variable<int>(
        profitMarginBasisPoints.value,
      );
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paymentReference.present) {
      map['payment_reference'] = Variable<String>(paymentReference.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (fulfillmentType.present) {
      map['fulfillment_type'] = Variable<String>(fulfillmentType.value);
    }
    if (cashReceived.present) {
      map['cash_received'] = Variable<int>(cashReceived.value);
    }
    if (changeAmount.present) {
      map['change_amount'] = Variable<int>(changeAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('transactionNumber: $transactionNumber, ')
          ..write('subtotal: $subtotal, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('totalCost: $totalCost, ')
          ..write('profit: $profit, ')
          ..write('profitMarginBasisPoints: $profitMarginBasisPoints, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentReference: $paymentReference, ')
          ..write('orderType: $orderType, ')
          ..write('fulfillmentType: $fulfillmentType, ')
          ..write('cashReceived: $cashReceived, ')
          ..write('changeAmount: $changeAmount, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('quantity > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUnitPriceMeta = const VerificationMeta(
    'baseUnitPrice',
  );
  @override
  late final GeneratedColumn<int> baseUnitPrice = GeneratedColumn<int>(
    'base_unit_price',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('base_unit_price >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountBasisPointsMeta =
      const VerificationMeta('discountBasisPoints');
  @override
  late final GeneratedColumn<int> discountBasisPoints = GeneratedColumn<int>(
    'discount_basis_points',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      'discount_basis_points BETWEEN 0 AND 10000',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualUnitPriceMeta = const VerificationMeta(
    'actualUnitPrice',
  );
  @override
  late final GeneratedColumn<int> actualUnitPrice = GeneratedColumn<int>(
    'actual_unit_price',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('actual_unit_price >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineSubtotalMeta = const VerificationMeta(
    'lineSubtotal',
  );
  @override
  late final GeneratedColumn<int> lineSubtotal = GeneratedColumn<int>(
    'line_subtotal',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('line_subtotal >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineDiscountMeta = const VerificationMeta(
    'lineDiscount',
  );
  @override
  late final GeneratedColumn<int> lineDiscount = GeneratedColumn<int>(
    'line_discount',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('line_discount >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTotalMeta = const VerificationMeta(
    'lineTotal',
  );
  @override
  late final GeneratedColumn<int> lineTotal = GeneratedColumn<int>(
    'line_total',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('line_total >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPerUnitMeta = const VerificationMeta(
    'costPerUnit',
  );
  @override
  late final GeneratedColumn<int> costPerUnit = GeneratedColumn<int>(
    'cost_per_unit',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('cost_per_unit >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineCostMeta = const VerificationMeta(
    'lineCost',
  );
  @override
  late final GeneratedColumn<int> lineCost = GeneratedColumn<int>(
    'line_cost',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('line_cost >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineProfitMeta = const VerificationMeta(
    'lineProfit',
  );
  @override
  late final GeneratedColumn<int> lineProfit = GeneratedColumn<int>(
    'line_profit',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    productId,
    productName,
    quantity,
    baseUnitPrice,
    discountBasisPoints,
    actualUnitPrice,
    lineSubtotal,
    lineDiscount,
    lineTotal,
    costPerUnit,
    lineCost,
    lineProfit,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('base_unit_price')) {
      context.handle(
        _baseUnitPriceMeta,
        baseUnitPrice.isAcceptableOrUnknown(
          data['base_unit_price']!,
          _baseUnitPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseUnitPriceMeta);
    }
    if (data.containsKey('discount_basis_points')) {
      context.handle(
        _discountBasisPointsMeta,
        discountBasisPoints.isAcceptableOrUnknown(
          data['discount_basis_points']!,
          _discountBasisPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountBasisPointsMeta);
    }
    if (data.containsKey('actual_unit_price')) {
      context.handle(
        _actualUnitPriceMeta,
        actualUnitPrice.isAcceptableOrUnknown(
          data['actual_unit_price']!,
          _actualUnitPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualUnitPriceMeta);
    }
    if (data.containsKey('line_subtotal')) {
      context.handle(
        _lineSubtotalMeta,
        lineSubtotal.isAcceptableOrUnknown(
          data['line_subtotal']!,
          _lineSubtotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineSubtotalMeta);
    }
    if (data.containsKey('line_discount')) {
      context.handle(
        _lineDiscountMeta,
        lineDiscount.isAcceptableOrUnknown(
          data['line_discount']!,
          _lineDiscountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineDiscountMeta);
    }
    if (data.containsKey('line_total')) {
      context.handle(
        _lineTotalMeta,
        lineTotal.isAcceptableOrUnknown(data['line_total']!, _lineTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMeta);
    }
    if (data.containsKey('cost_per_unit')) {
      context.handle(
        _costPerUnitMeta,
        costPerUnit.isAcceptableOrUnknown(
          data['cost_per_unit']!,
          _costPerUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costPerUnitMeta);
    }
    if (data.containsKey('line_cost')) {
      context.handle(
        _lineCostMeta,
        lineCost.isAcceptableOrUnknown(data['line_cost']!, _lineCostMeta),
      );
    } else if (isInserting) {
      context.missing(_lineCostMeta);
    }
    if (data.containsKey('line_profit')) {
      context.handle(
        _lineProfitMeta,
        lineProfit.isAcceptableOrUnknown(data['line_profit']!, _lineProfitMeta),
      );
    } else if (isInserting) {
      context.missing(_lineProfitMeta);
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
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      baseUnitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_unit_price'],
      )!,
      discountBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_basis_points'],
      )!,
      actualUnitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_unit_price'],
      )!,
      lineSubtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_subtotal'],
      )!,
      lineDiscount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_discount'],
      )!,
      lineTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total'],
      )!,
      costPerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_per_unit'],
      )!,
      lineCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_cost'],
      )!,
      lineProfit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_profit'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final String id;
  final String saleId;
  final String productId;
  final String productName;
  final int quantity;
  final int baseUnitPrice;
  final int discountBasisPoints;
  final int actualUnitPrice;
  final int lineSubtotal;
  final int lineDiscount;
  final int lineTotal;
  final int costPerUnit;
  final int lineCost;
  final int lineProfit;
  final DateTime createdAt;
  const SaleItem({
    required this.id,
    required this.saleId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.baseUnitPrice,
    required this.discountBasisPoints,
    required this.actualUnitPrice,
    required this.lineSubtotal,
    required this.lineDiscount,
    required this.lineTotal,
    required this.costPerUnit,
    required this.lineCost,
    required this.lineProfit,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['product_id'] = Variable<String>(productId);
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['base_unit_price'] = Variable<int>(baseUnitPrice);
    map['discount_basis_points'] = Variable<int>(discountBasisPoints);
    map['actual_unit_price'] = Variable<int>(actualUnitPrice);
    map['line_subtotal'] = Variable<int>(lineSubtotal);
    map['line_discount'] = Variable<int>(lineDiscount);
    map['line_total'] = Variable<int>(lineTotal);
    map['cost_per_unit'] = Variable<int>(costPerUnit);
    map['line_cost'] = Variable<int>(lineCost);
    map['line_profit'] = Variable<int>(lineProfit);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productId: Value(productId),
      productName: Value(productName),
      quantity: Value(quantity),
      baseUnitPrice: Value(baseUnitPrice),
      discountBasisPoints: Value(discountBasisPoints),
      actualUnitPrice: Value(actualUnitPrice),
      lineSubtotal: Value(lineSubtotal),
      lineDiscount: Value(lineDiscount),
      lineTotal: Value(lineTotal),
      costPerUnit: Value(costPerUnit),
      lineCost: Value(lineCost),
      lineProfit: Value(lineProfit),
      createdAt: Value(createdAt),
    );
  }

  factory SaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      productId: serializer.fromJson<String>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      baseUnitPrice: serializer.fromJson<int>(json['baseUnitPrice']),
      discountBasisPoints: serializer.fromJson<int>(
        json['discountBasisPoints'],
      ),
      actualUnitPrice: serializer.fromJson<int>(json['actualUnitPrice']),
      lineSubtotal: serializer.fromJson<int>(json['lineSubtotal']),
      lineDiscount: serializer.fromJson<int>(json['lineDiscount']),
      lineTotal: serializer.fromJson<int>(json['lineTotal']),
      costPerUnit: serializer.fromJson<int>(json['costPerUnit']),
      lineCost: serializer.fromJson<int>(json['lineCost']),
      lineProfit: serializer.fromJson<int>(json['lineProfit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'productId': serializer.toJson<String>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'baseUnitPrice': serializer.toJson<int>(baseUnitPrice),
      'discountBasisPoints': serializer.toJson<int>(discountBasisPoints),
      'actualUnitPrice': serializer.toJson<int>(actualUnitPrice),
      'lineSubtotal': serializer.toJson<int>(lineSubtotal),
      'lineDiscount': serializer.toJson<int>(lineDiscount),
      'lineTotal': serializer.toJson<int>(lineTotal),
      'costPerUnit': serializer.toJson<int>(costPerUnit),
      'lineCost': serializer.toJson<int>(lineCost),
      'lineProfit': serializer.toJson<int>(lineProfit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SaleItem copyWith({
    String? id,
    String? saleId,
    String? productId,
    String? productName,
    int? quantity,
    int? baseUnitPrice,
    int? discountBasisPoints,
    int? actualUnitPrice,
    int? lineSubtotal,
    int? lineDiscount,
    int? lineTotal,
    int? costPerUnit,
    int? lineCost,
    int? lineProfit,
    DateTime? createdAt,
  }) => SaleItem(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    quantity: quantity ?? this.quantity,
    baseUnitPrice: baseUnitPrice ?? this.baseUnitPrice,
    discountBasisPoints: discountBasisPoints ?? this.discountBasisPoints,
    actualUnitPrice: actualUnitPrice ?? this.actualUnitPrice,
    lineSubtotal: lineSubtotal ?? this.lineSubtotal,
    lineDiscount: lineDiscount ?? this.lineDiscount,
    lineTotal: lineTotal ?? this.lineTotal,
    costPerUnit: costPerUnit ?? this.costPerUnit,
    lineCost: lineCost ?? this.lineCost,
    lineProfit: lineProfit ?? this.lineProfit,
    createdAt: createdAt ?? this.createdAt,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      baseUnitPrice: data.baseUnitPrice.present
          ? data.baseUnitPrice.value
          : this.baseUnitPrice,
      discountBasisPoints: data.discountBasisPoints.present
          ? data.discountBasisPoints.value
          : this.discountBasisPoints,
      actualUnitPrice: data.actualUnitPrice.present
          ? data.actualUnitPrice.value
          : this.actualUnitPrice,
      lineSubtotal: data.lineSubtotal.present
          ? data.lineSubtotal.value
          : this.lineSubtotal,
      lineDiscount: data.lineDiscount.present
          ? data.lineDiscount.value
          : this.lineDiscount,
      lineTotal: data.lineTotal.present ? data.lineTotal.value : this.lineTotal,
      costPerUnit: data.costPerUnit.present
          ? data.costPerUnit.value
          : this.costPerUnit,
      lineCost: data.lineCost.present ? data.lineCost.value : this.lineCost,
      lineProfit: data.lineProfit.present
          ? data.lineProfit.value
          : this.lineProfit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('baseUnitPrice: $baseUnitPrice, ')
          ..write('discountBasisPoints: $discountBasisPoints, ')
          ..write('actualUnitPrice: $actualUnitPrice, ')
          ..write('lineSubtotal: $lineSubtotal, ')
          ..write('lineDiscount: $lineDiscount, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('lineCost: $lineCost, ')
          ..write('lineProfit: $lineProfit, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    productId,
    productName,
    quantity,
    baseUnitPrice,
    discountBasisPoints,
    actualUnitPrice,
    lineSubtotal,
    lineDiscount,
    lineTotal,
    costPerUnit,
    lineCost,
    lineProfit,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.baseUnitPrice == this.baseUnitPrice &&
          other.discountBasisPoints == this.discountBasisPoints &&
          other.actualUnitPrice == this.actualUnitPrice &&
          other.lineSubtotal == this.lineSubtotal &&
          other.lineDiscount == this.lineDiscount &&
          other.lineTotal == this.lineTotal &&
          other.costPerUnit == this.costPerUnit &&
          other.lineCost == this.lineCost &&
          other.lineProfit == this.lineProfit &&
          other.createdAt == this.createdAt);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> productId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<int> baseUnitPrice;
  final Value<int> discountBasisPoints;
  final Value<int> actualUnitPrice;
  final Value<int> lineSubtotal;
  final Value<int> lineDiscount;
  final Value<int> lineTotal;
  final Value<int> costPerUnit;
  final Value<int> lineCost;
  final Value<int> lineProfit;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.baseUnitPrice = const Value.absent(),
    this.discountBasisPoints = const Value.absent(),
    this.actualUnitPrice = const Value.absent(),
    this.lineSubtotal = const Value.absent(),
    this.lineDiscount = const Value.absent(),
    this.lineTotal = const Value.absent(),
    this.costPerUnit = const Value.absent(),
    this.lineCost = const Value.absent(),
    this.lineProfit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    required String id,
    required String saleId,
    required String productId,
    required String productName,
    required int quantity,
    required int baseUnitPrice,
    required int discountBasisPoints,
    required int actualUnitPrice,
    required int lineSubtotal,
    required int lineDiscount,
    required int lineTotal,
    required int costPerUnit,
    required int lineCost,
    required int lineProfit,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       saleId = Value(saleId),
       productId = Value(productId),
       productName = Value(productName),
       quantity = Value(quantity),
       baseUnitPrice = Value(baseUnitPrice),
       discountBasisPoints = Value(discountBasisPoints),
       actualUnitPrice = Value(actualUnitPrice),
       lineSubtotal = Value(lineSubtotal),
       lineDiscount = Value(lineDiscount),
       lineTotal = Value(lineTotal),
       costPerUnit = Value(costPerUnit),
       lineCost = Value(lineCost),
       lineProfit = Value(lineProfit);
  static Insertable<SaleItem> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<int>? baseUnitPrice,
    Expression<int>? discountBasisPoints,
    Expression<int>? actualUnitPrice,
    Expression<int>? lineSubtotal,
    Expression<int>? lineDiscount,
    Expression<int>? lineTotal,
    Expression<int>? costPerUnit,
    Expression<int>? lineCost,
    Expression<int>? lineProfit,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (baseUnitPrice != null) 'base_unit_price': baseUnitPrice,
      if (discountBasisPoints != null)
        'discount_basis_points': discountBasisPoints,
      if (actualUnitPrice != null) 'actual_unit_price': actualUnitPrice,
      if (lineSubtotal != null) 'line_subtotal': lineSubtotal,
      if (lineDiscount != null) 'line_discount': lineDiscount,
      if (lineTotal != null) 'line_total': lineTotal,
      if (costPerUnit != null) 'cost_per_unit': costPerUnit,
      if (lineCost != null) 'line_cost': lineCost,
      if (lineProfit != null) 'line_profit': lineProfit,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? saleId,
    Value<String>? productId,
    Value<String>? productName,
    Value<int>? quantity,
    Value<int>? baseUnitPrice,
    Value<int>? discountBasisPoints,
    Value<int>? actualUnitPrice,
    Value<int>? lineSubtotal,
    Value<int>? lineDiscount,
    Value<int>? lineTotal,
    Value<int>? costPerUnit,
    Value<int>? lineCost,
    Value<int>? lineProfit,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      baseUnitPrice: baseUnitPrice ?? this.baseUnitPrice,
      discountBasisPoints: discountBasisPoints ?? this.discountBasisPoints,
      actualUnitPrice: actualUnitPrice ?? this.actualUnitPrice,
      lineSubtotal: lineSubtotal ?? this.lineSubtotal,
      lineDiscount: lineDiscount ?? this.lineDiscount,
      lineTotal: lineTotal ?? this.lineTotal,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      lineCost: lineCost ?? this.lineCost,
      lineProfit: lineProfit ?? this.lineProfit,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (baseUnitPrice.present) {
      map['base_unit_price'] = Variable<int>(baseUnitPrice.value);
    }
    if (discountBasisPoints.present) {
      map['discount_basis_points'] = Variable<int>(discountBasisPoints.value);
    }
    if (actualUnitPrice.present) {
      map['actual_unit_price'] = Variable<int>(actualUnitPrice.value);
    }
    if (lineSubtotal.present) {
      map['line_subtotal'] = Variable<int>(lineSubtotal.value);
    }
    if (lineDiscount.present) {
      map['line_discount'] = Variable<int>(lineDiscount.value);
    }
    if (lineTotal.present) {
      map['line_total'] = Variable<int>(lineTotal.value);
    }
    if (costPerUnit.present) {
      map['cost_per_unit'] = Variable<int>(costPerUnit.value);
    }
    if (lineCost.present) {
      map['line_cost'] = Variable<int>(lineCost.value);
    }
    if (lineProfit.present) {
      map['line_profit'] = Variable<int>(lineProfit.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('baseUnitPrice: $baseUnitPrice, ')
          ..write('discountBasisPoints: $discountBasisPoints, ')
          ..write('actualUnitPrice: $actualUnitPrice, ')
          ..write('lineSubtotal: $lineSubtotal, ')
          ..write('lineDiscount: $lineDiscount, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('lineCost: $lineCost, ')
          ..write('lineProfit: $lineProfit, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleReversalsTable extends SaleReversals
    with TableInfo<$SaleReversalsTable, SaleReversal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleReversalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES sales (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _reversalTypeMeta = const VerificationMeta(
    'reversalType',
  );
  @override
  late final GeneratedColumn<String> reversalType = GeneratedColumn<String>(
    'reversal_type',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "reversal_type IN ('CANCELLATION', 'REFUND')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 250,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reversedAtMeta = const VerificationMeta(
    'reversedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reversedAt = GeneratedColumn<DateTime>(
    'reversed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    reversalType,
    reason,
    reversedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_reversals';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleReversal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('reversal_type')) {
      context.handle(
        _reversalTypeMeta,
        reversalType.isAcceptableOrUnknown(
          data['reversal_type']!,
          _reversalTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reversalTypeMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('reversed_at')) {
      context.handle(
        _reversedAtMeta,
        reversedAt.isAcceptableOrUnknown(data['reversed_at']!, _reversedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reversedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleReversal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleReversal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      reversalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reversal_type'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      reversedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reversed_at'],
      )!,
    );
  }

  @override
  $SaleReversalsTable createAlias(String alias) {
    return $SaleReversalsTable(attachedDatabase, alias);
  }
}

class SaleReversal extends DataClass implements Insertable<SaleReversal> {
  final String id;
  final String saleId;
  final String reversalType;
  final String reason;
  final DateTime reversedAt;
  const SaleReversal({
    required this.id,
    required this.saleId,
    required this.reversalType,
    required this.reason,
    required this.reversedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['reversal_type'] = Variable<String>(reversalType);
    map['reason'] = Variable<String>(reason);
    map['reversed_at'] = Variable<DateTime>(reversedAt);
    return map;
  }

  SaleReversalsCompanion toCompanion(bool nullToAbsent) {
    return SaleReversalsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      reversalType: Value(reversalType),
      reason: Value(reason),
      reversedAt: Value(reversedAt),
    );
  }

  factory SaleReversal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleReversal(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      reversalType: serializer.fromJson<String>(json['reversalType']),
      reason: serializer.fromJson<String>(json['reason']),
      reversedAt: serializer.fromJson<DateTime>(json['reversedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'reversalType': serializer.toJson<String>(reversalType),
      'reason': serializer.toJson<String>(reason),
      'reversedAt': serializer.toJson<DateTime>(reversedAt),
    };
  }

  SaleReversal copyWith({
    String? id,
    String? saleId,
    String? reversalType,
    String? reason,
    DateTime? reversedAt,
  }) => SaleReversal(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    reversalType: reversalType ?? this.reversalType,
    reason: reason ?? this.reason,
    reversedAt: reversedAt ?? this.reversedAt,
  );
  SaleReversal copyWithCompanion(SaleReversalsCompanion data) {
    return SaleReversal(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      reversalType: data.reversalType.present
          ? data.reversalType.value
          : this.reversalType,
      reason: data.reason.present ? data.reason.value : this.reason,
      reversedAt: data.reversedAt.present
          ? data.reversedAt.value
          : this.reversedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleReversal(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('reversalType: $reversalType, ')
          ..write('reason: $reason, ')
          ..write('reversedAt: $reversedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, saleId, reversalType, reason, reversedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleReversal &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.reversalType == this.reversalType &&
          other.reason == this.reason &&
          other.reversedAt == this.reversedAt);
}

class SaleReversalsCompanion extends UpdateCompanion<SaleReversal> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> reversalType;
  final Value<String> reason;
  final Value<DateTime> reversedAt;
  final Value<int> rowid;
  const SaleReversalsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.reversalType = const Value.absent(),
    this.reason = const Value.absent(),
    this.reversedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleReversalsCompanion.insert({
    required String id,
    required String saleId,
    required String reversalType,
    required String reason,
    required DateTime reversedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       saleId = Value(saleId),
       reversalType = Value(reversalType),
       reason = Value(reason),
       reversedAt = Value(reversedAt);
  static Insertable<SaleReversal> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? reversalType,
    Expression<String>? reason,
    Expression<DateTime>? reversedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (reversalType != null) 'reversal_type': reversalType,
      if (reason != null) 'reason': reason,
      if (reversedAt != null) 'reversed_at': reversedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleReversalsCompanion copyWith({
    Value<String>? id,
    Value<String>? saleId,
    Value<String>? reversalType,
    Value<String>? reason,
    Value<DateTime>? reversedAt,
    Value<int>? rowid,
  }) {
    return SaleReversalsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      reversalType: reversalType ?? this.reversalType,
      reason: reason ?? this.reason,
      reversedAt: reversedAt ?? this.reversedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (reversalType.present) {
      map['reversal_type'] = Variable<String>(reversalType.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (reversedAt.present) {
      map['reversed_at'] = Variable<DateTime>(reversedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleReversalsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('reversalType: $reversalType, ')
          ..write('reason: $reason, ')
          ..write('reversedAt: $reversedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('amount > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    name,
    category,
    amount,
    expenseDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expense_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String category;
  final int amount;
  final DateTime expenseDate;
  final String? notes;
  const Expense({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.category,
    required this.amount,
    required this.expenseDate,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<int>(amount);
    map['expense_date'] = Variable<DateTime>(expenseDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
      category: Value(category),
      amount: Value(amount),
      expenseDate: Value(expenseDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<int>(json['amount']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<int>(amount),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Expense copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? category,
    int? amount,
    DateTime? expenseDate,
    Value<String?> notes = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    expenseDate: expenseDate ?? this.expenseDate,
    notes: notes.present ? notes.value : this.notes,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    name,
    category,
    amount,
    expenseDate,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.expenseDate == this.expenseDate &&
          other.notes == this.notes);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<String> category;
  final Value<int> amount;
  final Value<DateTime> expenseDate;
  final Value<String?> notes;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String name,
    required String category,
    required int amount,
    required DateTime expenseDate,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       amount = Value(amount),
       expenseDate = Value(expenseDate);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? amount,
    Expression<DateTime>? expenseDate,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<String>? category,
    Value<int>? amount,
    Value<DateTime>? expenseDate,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      expenseDate: expenseDate ?? this.expenseDate,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductInclusionsTable productInclusions =
      $ProductInclusionsTable(this);
  late final $InventoryMovementsTable inventoryMovements =
      $InventoryMovementsTable(this);
  late final $DiscountsTable discounts = $DiscountsTable(this);
  late final $DiscountProductsTable discountProducts = $DiscountProductsTable(
    this,
  );
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $SaleReversalsTable saleReversals = $SaleReversalsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settings,
    inventoryItems,
    products,
    productInclusions,
    inventoryMovements,
    discounts,
    discountProducts,
    sales,
    saleItems,
    saleReversals,
    expenses,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'inventory_items',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_inclusions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('product_inclusions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'inventory_items',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('product_inclusions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'inventory_items',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('inventory_movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'discounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('discount_products', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'discounts',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('discount_products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('discount_products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sale_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sale_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sale_reversals', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String> businessName,
      Value<String> receiptTagline,
      Value<String> businessHours,
      Value<String> businessAddress,
      Value<String> receiptFooter,
      Value<String> currency,
      Value<String?> printerName,
      Value<String?> printerAddress,
      Value<int> printerPaperWidthMm,
      Value<int> nextTransactionNumber,
      Value<String> themeMode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String> businessName,
      Value<String> receiptTagline,
      Value<String> businessHours,
      Value<String> businessAddress,
      Value<String> receiptFooter,
      Value<String> currency,
      Value<String?> printerName,
      Value<String?> printerAddress,
      Value<int> printerPaperWidthMm,
      Value<int> nextTransactionNumber,
      Value<String> themeMode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
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

  ColumnFilters<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptTagline => $composableBuilder(
    column: $table.receiptTagline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessHours => $composableBuilder(
    column: $table.businessHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessAddress => $composableBuilder(
    column: $table.businessAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptFooter => $composableBuilder(
    column: $table.receiptFooter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerAddress => $composableBuilder(
    column: $table.printerAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get printerPaperWidthMm => $composableBuilder(
    column: $table.printerPaperWidthMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextTransactionNumber => $composableBuilder(
    column: $table.nextTransactionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
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

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
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

  ColumnOrderings<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptTagline => $composableBuilder(
    column: $table.receiptTagline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessHours => $composableBuilder(
    column: $table.businessHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessAddress => $composableBuilder(
    column: $table.businessAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptFooter => $composableBuilder(
    column: $table.receiptFooter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerAddress => $composableBuilder(
    column: $table.printerAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get printerPaperWidthMm => $composableBuilder(
    column: $table.printerPaperWidthMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextTransactionNumber => $composableBuilder(
    column: $table.nextTransactionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
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

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptTagline => $composableBuilder(
    column: $table.receiptTagline,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessHours => $composableBuilder(
    column: $table.businessHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessAddress => $composableBuilder(
    column: $table.businessAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptFooter => $composableBuilder(
    column: $table.receiptFooter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get printerAddress => $composableBuilder(
    column: $table.printerAddress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get printerPaperWidthMm => $composableBuilder(
    column: $table.printerPaperWidthMm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextTransactionNumber => $composableBuilder(
    column: $table.nextTransactionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> receiptTagline = const Value.absent(),
                Value<String> businessHours = const Value.absent(),
                Value<String> businessAddress = const Value.absent(),
                Value<String> receiptFooter = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> printerName = const Value.absent(),
                Value<String?> printerAddress = const Value.absent(),
                Value<int> printerPaperWidthMm = const Value.absent(),
                Value<int> nextTransactionNumber = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                businessName: businessName,
                receiptTagline: receiptTagline,
                businessHours: businessHours,
                businessAddress: businessAddress,
                receiptFooter: receiptFooter,
                currency: currency,
                printerName: printerName,
                printerAddress: printerAddress,
                printerPaperWidthMm: printerPaperWidthMm,
                nextTransactionNumber: nextTransactionNumber,
                themeMode: themeMode,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> receiptTagline = const Value.absent(),
                Value<String> businessHours = const Value.absent(),
                Value<String> businessAddress = const Value.absent(),
                Value<String> receiptFooter = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> printerName = const Value.absent(),
                Value<String?> printerAddress = const Value.absent(),
                Value<int> printerPaperWidthMm = const Value.absent(),
                Value<int> nextTransactionNumber = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                businessName: businessName,
                receiptTagline: receiptTagline,
                businessHours: businessHours,
                businessAddress: businessAddress,
                receiptFooter: receiptFooter,
                currency: currency,
                printerName: printerName,
                printerAddress: printerAddress,
                printerPaperWidthMm: printerPaperWidthMm,
                nextTransactionNumber: nextTransactionNumber,
                themeMode: themeMode,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, Setting>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, Setting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      Value<int> stockQuantity,
      required String unit,
      required int costPerUnit,
      Value<int> lowStockThreshold,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<int> stockQuantity,
      Value<String> unit,
      Value<int> costPerUnit,
      Value<int> lowStockThreshold,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$InventoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem> {
  $$InventoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'inventory_items__id__products__inventory_item_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager($_db, $_db.products).filter(
      (f) => f.inventoryItemId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductInclusionsTable, List<ProductInclusion>>
  _productInclusionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productInclusions,
        aliasName: 'inventory_items__id__product_inclusions__inventory_item_id',
      );

  $$ProductInclusionsTableProcessedTableManager get productInclusionsRefs {
    final manager =
        $$ProductInclusionsTableTableManager(
          $_db,
          $_db.productInclusions,
        ).filter(
          (f) => f.inventoryItemId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _productInclusionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InventoryMovementsTable, List<InventoryMovement>>
  _inventoryMovementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryMovements,
        aliasName:
            'inventory_items__id__inventory_movements__inventory_item_id',
      );

  $$InventoryMovementsTableProcessedTableManager get inventoryMovementsRefs {
    final manager =
        $$InventoryMovementsTableTableManager(
          $_db,
          $_db.inventoryMovements,
        ).filter(
          (f) => f.inventoryItemId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _inventoryMovementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.inventoryItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productInclusionsRefs(
    Expression<bool> Function($$ProductInclusionsTableFilterComposer f) f,
  ) {
    final $$ProductInclusionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productInclusions,
      getReferencedColumn: (t) => t.inventoryItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductInclusionsTableFilterComposer(
            $db: $db,
            $table: $db.productInclusions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryMovementsRefs(
    Expression<bool> Function($$InventoryMovementsTableFilterComposer f) f,
  ) {
    final $$InventoryMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryMovements,
      getReferencedColumn: (t) => t.inventoryItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryMovementsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.inventoryItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productInclusionsRefs<T extends Object>(
    Expression<T> Function($$ProductInclusionsTableAnnotationComposer a) f,
  ) {
    final $$ProductInclusionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productInclusions,
          getReferencedColumn: (t) => t.inventoryItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductInclusionsTableAnnotationComposer(
                $db: $db,
                $table: $db.productInclusions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> inventoryMovementsRefs<T extends Object>(
    Expression<T> Function($$InventoryMovementsTableAnnotationComposer a) f,
  ) {
    final $$InventoryMovementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryMovements,
          getReferencedColumn: (t) => t.inventoryItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryMovementsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryMovements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (InventoryItem, $$InventoryItemsTableReferences),
          InventoryItem,
          PrefetchHooks Function({
            bool productsRefs,
            bool productInclusionsRefs,
            bool inventoryMovementsRefs,
          })
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> costPerUnit = const Value.absent(),
                Value<int> lowStockThreshold = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                stockQuantity: stockQuantity,
                unit: unit,
                costPerUnit: costPerUnit,
                lowStockThreshold: lowStockThreshold,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                Value<int> stockQuantity = const Value.absent(),
                required String unit,
                required int costPerUnit,
                Value<int> lowStockThreshold = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                stockQuantity: stockQuantity,
                unit: unit,
                costPerUnit: costPerUnit,
                lowStockThreshold: lowStockThreshold,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InventoryItemsTable, InventoryItem>(table),
                  $$InventoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productsRefs = false,
                productInclusionsRefs = false,
                inventoryMovementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (productsRefs) db.products,
                    if (productInclusionsRefs) db.productInclusions,
                    if (inventoryMovementsRefs) db.inventoryMovements,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (productsRefs)
                        await $_getPrefetchedData<
                          InventoryItem,
                          $InventoryItemsTable,
                          Product
                        >(
                          currentTable: table,
                          referencedTable: $$InventoryItemsTableReferences
                              ._productsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InventoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).productsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.inventoryItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productInclusionsRefs)
                        await $_getPrefetchedData<
                          InventoryItem,
                          $InventoryItemsTable,
                          ProductInclusion
                        >(
                          currentTable: table,
                          referencedTable: $$InventoryItemsTableReferences
                              ._productInclusionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InventoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).productInclusionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.inventoryItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inventoryMovementsRefs)
                        await $_getPrefetchedData<
                          InventoryItem,
                          $InventoryItemsTable,
                          InventoryMovement
                        >(
                          currentTable: table,
                          referencedTable: $$InventoryItemsTableReferences
                              ._inventoryMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InventoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.inventoryItemId == item.id,
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

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (InventoryItem, $$InventoryItemsTableReferences),
      InventoryItem,
      PrefetchHooks Function({
        bool productsRefs,
        bool productInclusionsRefs,
        bool inventoryMovementsRefs,
      })
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      Value<String> category,
      Value<Uint8List?> imageData,
      required int sellingPrice,
      required String inventoryItemId,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String> category,
      Value<Uint8List?> imageData,
      Value<int> sellingPrice,
      Value<String> inventoryItemId,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InventoryItemsTable _inventoryItemIdTable(_$AppDatabase db) => db
      .inventoryItems
      .createAlias('products__inventory_item_id__inventory_items__id');

  $$InventoryItemsTableProcessedTableManager get inventoryItemId {
    final $_column = $_itemColumn<String>('inventory_item_id')!;

    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_inventoryItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProductInclusionsTable, List<ProductInclusion>>
  _productInclusionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productInclusions,
        aliasName: 'products__id__product_inclusions__product_id',
      );

  $$ProductInclusionsTableProcessedTableManager get productInclusionsRefs {
    final manager = $$ProductInclusionsTableTableManager(
      $_db,
      $_db.productInclusions,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productInclusionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DiscountProductsTable, List<DiscountProduct>>
  _discountProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.discountProducts,
    aliasName: 'products__id__discount_products__product_id',
  );

  $$DiscountProductsTableProcessedTableManager get discountProductsRefs {
    final manager = $$DiscountProductsTableTableManager(
      $_db,
      $_db.discountProducts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _discountProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: 'products__id__sale_items__product_id',
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$InventoryItemsTableFilterComposer get inventoryItemId {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> productInclusionsRefs(
    Expression<bool> Function($$ProductInclusionsTableFilterComposer f) f,
  ) {
    final $$ProductInclusionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productInclusions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductInclusionsTableFilterComposer(
            $db: $db,
            $table: $db.productInclusions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> discountProductsRefs(
    Expression<bool> Function($$DiscountProductsTableFilterComposer f) f,
  ) {
    final $$DiscountProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.discountProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountProductsTableFilterComposer(
            $db: $db,
            $table: $db.discountProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$InventoryItemsTableOrderingComposer get inventoryItemId {
    final $$InventoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<Uint8List> get imageData =>
      $composableBuilder(column: $table.imageData, builder: (column) => column);

  GeneratedColumn<int> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$InventoryItemsTableAnnotationComposer get inventoryItemId {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> productInclusionsRefs<T extends Object>(
    Expression<T> Function($$ProductInclusionsTableAnnotationComposer a) f,
  ) {
    final $$ProductInclusionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productInclusions,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductInclusionsTableAnnotationComposer(
                $db: $db,
                $table: $db.productInclusions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> discountProductsRefs<T extends Object>(
    Expression<T> Function($$DiscountProductsTableAnnotationComposer a) f,
  ) {
    final $$DiscountProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.discountProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.discountProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool inventoryItemId,
            bool productInclusionsRefs,
            bool discountProductsRefs,
            bool saleItemsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<Uint8List?> imageData = const Value.absent(),
                Value<int> sellingPrice = const Value.absent(),
                Value<String> inventoryItemId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                category: category,
                imageData: imageData,
                sellingPrice: sellingPrice,
                inventoryItemId: inventoryItemId,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                Value<String> category = const Value.absent(),
                Value<Uint8List?> imageData = const Value.absent(),
                required int sellingPrice,
                required String inventoryItemId,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                category: category,
                imageData: imageData,
                sellingPrice: sellingPrice,
                inventoryItemId: inventoryItemId,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, Product>(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                inventoryItemId = false,
                productInclusionsRefs = false,
                discountProductsRefs = false,
                saleItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (productInclusionsRefs) db.productInclusions,
                    if (discountProductsRefs) db.discountProducts,
                    if (saleItemsRefs) db.saleItems,
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
                        if (inventoryItemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.inventoryItemId,
                                    referencedTable: $$ProductsTableReferences
                                        ._inventoryItemIdTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._inventoryItemIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (productInclusionsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          ProductInclusion
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._productInclusionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).productInclusionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (discountProductsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          DiscountProduct
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._discountProductsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).discountProductsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          SaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).saleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
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

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool inventoryItemId,
        bool productInclusionsRefs,
        bool discountProductsRefs,
        bool saleItemsRefs,
      })
    >;
typedef $$ProductInclusionsTableCreateCompanionBuilder =
    ProductInclusionsCompanion Function({
      required String id,
      required String productId,
      required String inventoryItemId,
      required int quantity,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ProductInclusionsTableUpdateCompanionBuilder =
    ProductInclusionsCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String> inventoryItemId,
      Value<int> quantity,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ProductInclusionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductInclusionsTable,
          ProductInclusion
        > {
  $$ProductInclusionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('product_inclusions__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InventoryItemsTable _inventoryItemIdTable(_$AppDatabase db) =>
      db.inventoryItems.createAlias(
        'product_inclusions__inventory_item_id__inventory_items__id',
      );

  $$InventoryItemsTableProcessedTableManager get inventoryItemId {
    final $_column = $_itemColumn<String>('inventory_item_id')!;

    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_inventoryItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductInclusionsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductInclusionsTable> {
  $$ProductInclusionsTableFilterComposer({
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

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InventoryItemsTableFilterComposer get inventoryItemId {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductInclusionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductInclusionsTable> {
  $$ProductInclusionsTableOrderingComposer({
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

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InventoryItemsTableOrderingComposer get inventoryItemId {
    final $$InventoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductInclusionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductInclusionsTable> {
  $$ProductInclusionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InventoryItemsTableAnnotationComposer get inventoryItemId {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductInclusionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductInclusionsTable,
          ProductInclusion,
          $$ProductInclusionsTableFilterComposer,
          $$ProductInclusionsTableOrderingComposer,
          $$ProductInclusionsTableAnnotationComposer,
          $$ProductInclusionsTableCreateCompanionBuilder,
          $$ProductInclusionsTableUpdateCompanionBuilder,
          (ProductInclusion, $$ProductInclusionsTableReferences),
          ProductInclusion,
          PrefetchHooks Function({bool productId, bool inventoryItemId})
        > {
  $$ProductInclusionsTableTableManager(
    _$AppDatabase db,
    $ProductInclusionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductInclusionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductInclusionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductInclusionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> inventoryItemId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductInclusionsCompanion(
                id: id,
                productId: productId,
                inventoryItemId: inventoryItemId,
                quantity: quantity,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String productId,
                required String inventoryItemId,
                required int quantity,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductInclusionsCompanion.insert(
                id: id,
                productId: productId,
                inventoryItemId: inventoryItemId,
                quantity: quantity,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductInclusionsTable, ProductInclusion>(table),
                  $$ProductInclusionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({productId = false, inventoryItemId = false}) {
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
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$ProductInclusionsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$ProductInclusionsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (inventoryItemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.inventoryItemId,
                                    referencedTable:
                                        $$ProductInclusionsTableReferences
                                            ._inventoryItemIdTable(db),
                                    referencedColumn:
                                        $$ProductInclusionsTableReferences
                                            ._inventoryItemIdTable(db)
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

typedef $$ProductInclusionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductInclusionsTable,
      ProductInclusion,
      $$ProductInclusionsTableFilterComposer,
      $$ProductInclusionsTableOrderingComposer,
      $$ProductInclusionsTableAnnotationComposer,
      $$ProductInclusionsTableCreateCompanionBuilder,
      $$ProductInclusionsTableUpdateCompanionBuilder,
      (ProductInclusion, $$ProductInclusionsTableReferences),
      ProductInclusion,
      PrefetchHooks Function({bool productId, bool inventoryItemId})
    >;
typedef $$InventoryMovementsTableCreateCompanionBuilder =
    InventoryMovementsCompanion Function({
      required String id,
      required String inventoryItemId,
      required String movementType,
      required int quantity,
      required int quantityBefore,
      required int quantityAfter,
      Value<String?> referenceType,
      Value<String?> referenceId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$InventoryMovementsTableUpdateCompanionBuilder =
    InventoryMovementsCompanion Function({
      Value<String> id,
      Value<String> inventoryItemId,
      Value<String> movementType,
      Value<int> quantity,
      Value<int> quantityBefore,
      Value<int> quantityAfter,
      Value<String?> referenceType,
      Value<String?> referenceId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InventoryMovementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InventoryMovementsTable,
          InventoryMovement
        > {
  $$InventoryMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InventoryItemsTable _inventoryItemIdTable(_$AppDatabase db) =>
      db.inventoryItems.createAlias(
        'inventory_movements__inventory_item_id__inventory_items__id',
      );

  $$InventoryItemsTableProcessedTableManager get inventoryItemId {
    final $_column = $_itemColumn<String>('inventory_item_id')!;

    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_inventoryItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryMovementsTable> {
  $$InventoryMovementsTableFilterComposer({
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

  ColumnFilters<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityBefore => $composableBuilder(
    column: $table.quantityBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityAfter => $composableBuilder(
    column: $table.quantityAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InventoryItemsTableFilterComposer get inventoryItemId {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryMovementsTable> {
  $$InventoryMovementsTableOrderingComposer({
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

  ColumnOrderings<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityBefore => $composableBuilder(
    column: $table.quantityBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityAfter => $composableBuilder(
    column: $table.quantityAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InventoryItemsTableOrderingComposer get inventoryItemId {
    final $$InventoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryMovementsTable> {
  $$InventoryMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get quantityBefore => $composableBuilder(
    column: $table.quantityBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantityAfter => $composableBuilder(
    column: $table.quantityAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InventoryItemsTableAnnotationComposer get inventoryItemId {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryItemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryMovementsTable,
          InventoryMovement,
          $$InventoryMovementsTableFilterComposer,
          $$InventoryMovementsTableOrderingComposer,
          $$InventoryMovementsTableAnnotationComposer,
          $$InventoryMovementsTableCreateCompanionBuilder,
          $$InventoryMovementsTableUpdateCompanionBuilder,
          (InventoryMovement, $$InventoryMovementsTableReferences),
          InventoryMovement,
          PrefetchHooks Function({bool inventoryItemId})
        > {
  $$InventoryMovementsTableTableManager(
    _$AppDatabase db,
    $InventoryMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryMovementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> inventoryItemId = const Value.absent(),
                Value<String> movementType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> quantityBefore = const Value.absent(),
                Value<int> quantityAfter = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryMovementsCompanion(
                id: id,
                inventoryItemId: inventoryItemId,
                movementType: movementType,
                quantity: quantity,
                quantityBefore: quantityBefore,
                quantityAfter: quantityAfter,
                referenceType: referenceType,
                referenceId: referenceId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String inventoryItemId,
                required String movementType,
                required int quantity,
                required int quantityBefore,
                required int quantityAfter,
                Value<String?> referenceType = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryMovementsCompanion.insert(
                id: id,
                inventoryItemId: inventoryItemId,
                movementType: movementType,
                quantity: quantity,
                quantityBefore: quantityBefore,
                quantityAfter: quantityAfter,
                referenceType: referenceType,
                referenceId: referenceId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InventoryMovementsTable, InventoryMovement>(
                    table,
                  ),
                  $$InventoryMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({inventoryItemId = false}) {
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
                    if (inventoryItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.inventoryItemId,
                                referencedTable:
                                    $$InventoryMovementsTableReferences
                                        ._inventoryItemIdTable(db),
                                referencedColumn:
                                    $$InventoryMovementsTableReferences
                                        ._inventoryItemIdTable(db)
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

typedef $$InventoryMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryMovementsTable,
      InventoryMovement,
      $$InventoryMovementsTableFilterComposer,
      $$InventoryMovementsTableOrderingComposer,
      $$InventoryMovementsTableAnnotationComposer,
      $$InventoryMovementsTableCreateCompanionBuilder,
      $$InventoryMovementsTableUpdateCompanionBuilder,
      (InventoryMovement, $$InventoryMovementsTableReferences),
      InventoryMovement,
      PrefetchHooks Function({bool inventoryItemId})
    >;
typedef $$DiscountsTableCreateCompanionBuilder =
    DiscountsCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      required int percentageBasisPoints,
      required String scope,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$DiscountsTableUpdateCompanionBuilder =
    DiscountsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<int> percentageBasisPoints,
      Value<String> scope,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$DiscountsTableReferences
    extends BaseReferences<_$AppDatabase, $DiscountsTable, Discount> {
  $$DiscountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DiscountProductsTable, List<DiscountProduct>>
  _discountProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.discountProducts,
    aliasName: 'discounts__id__discount_products__discount_id',
  );

  $$DiscountProductsTableProcessedTableManager get discountProductsRefs {
    final manager = $$DiscountProductsTableTableManager(
      $_db,
      $_db.discountProducts,
    ).filter((f) => f.discountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _discountProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DiscountsTableFilterComposer
    extends Composer<_$AppDatabase, $DiscountsTable> {
  $$DiscountsTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get percentageBasisPoints => $composableBuilder(
    column: $table.percentageBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> discountProductsRefs(
    Expression<bool> Function($$DiscountProductsTableFilterComposer f) f,
  ) {
    final $$DiscountProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.discountProducts,
      getReferencedColumn: (t) => t.discountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountProductsTableFilterComposer(
            $db: $db,
            $table: $db.discountProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DiscountsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscountsTable> {
  $$DiscountsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get percentageBasisPoints => $composableBuilder(
    column: $table.percentageBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiscountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscountsTable> {
  $$DiscountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get percentageBasisPoints => $composableBuilder(
    column: $table.percentageBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> discountProductsRefs<T extends Object>(
    Expression<T> Function($$DiscountProductsTableAnnotationComposer a) f,
  ) {
    final $$DiscountProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.discountProducts,
      getReferencedColumn: (t) => t.discountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.discountProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DiscountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiscountsTable,
          Discount,
          $$DiscountsTableFilterComposer,
          $$DiscountsTableOrderingComposer,
          $$DiscountsTableAnnotationComposer,
          $$DiscountsTableCreateCompanionBuilder,
          $$DiscountsTableUpdateCompanionBuilder,
          (Discount, $$DiscountsTableReferences),
          Discount,
          PrefetchHooks Function({bool discountProductsRefs})
        > {
  $$DiscountsTableTableManager(_$AppDatabase db, $DiscountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> percentageBasisPoints = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiscountsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                percentageBasisPoints: percentageBasisPoints,
                scope: scope,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                required int percentageBasisPoints,
                required String scope,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiscountsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                percentageBasisPoints: percentageBasisPoints,
                scope: scope,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DiscountsTable, Discount>(table),
                  $$DiscountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({discountProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (discountProductsRefs) db.discountProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (discountProductsRefs)
                    await $_getPrefetchedData<
                      Discount,
                      $DiscountsTable,
                      DiscountProduct
                    >(
                      currentTable: table,
                      referencedTable: $$DiscountsTableReferences
                          ._discountProductsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DiscountsTableReferences(
                            db,
                            table,
                            p0,
                          ).discountProductsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.discountId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DiscountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiscountsTable,
      Discount,
      $$DiscountsTableFilterComposer,
      $$DiscountsTableOrderingComposer,
      $$DiscountsTableAnnotationComposer,
      $$DiscountsTableCreateCompanionBuilder,
      $$DiscountsTableUpdateCompanionBuilder,
      (Discount, $$DiscountsTableReferences),
      Discount,
      PrefetchHooks Function({bool discountProductsRefs})
    >;
typedef $$DiscountProductsTableCreateCompanionBuilder =
    DiscountProductsCompanion Function({
      required String id,
      required String discountId,
      required String productId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$DiscountProductsTableUpdateCompanionBuilder =
    DiscountProductsCompanion Function({
      Value<String> id,
      Value<String> discountId,
      Value<String> productId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$DiscountProductsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DiscountProductsTable, DiscountProduct> {
  $$DiscountProductsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DiscountsTable _discountIdTable(_$AppDatabase db) =>
      db.discounts.createAlias('discount_products__discount_id__discounts__id');

  $$DiscountsTableProcessedTableManager get discountId {
    final $_column = $_itemColumn<String>('discount_id')!;

    final manager = $$DiscountsTableTableManager(
      $_db,
      $_db.discounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_discountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('discount_products__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DiscountProductsTableFilterComposer
    extends Composer<_$AppDatabase, $DiscountProductsTable> {
  $$DiscountProductsTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DiscountsTableFilterComposer get discountId {
    final $$DiscountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.discountId,
      referencedTable: $db.discounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountsTableFilterComposer(
            $db: $db,
            $table: $db.discounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiscountProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscountProductsTable> {
  $$DiscountProductsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DiscountsTableOrderingComposer get discountId {
    final $$DiscountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.discountId,
      referencedTable: $db.discounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountsTableOrderingComposer(
            $db: $db,
            $table: $db.discounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiscountProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscountProductsTable> {
  $$DiscountProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DiscountsTableAnnotationComposer get discountId {
    final $$DiscountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.discountId,
      referencedTable: $db.discounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiscountsTableAnnotationComposer(
            $db: $db,
            $table: $db.discounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiscountProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiscountProductsTable,
          DiscountProduct,
          $$DiscountProductsTableFilterComposer,
          $$DiscountProductsTableOrderingComposer,
          $$DiscountProductsTableAnnotationComposer,
          $$DiscountProductsTableCreateCompanionBuilder,
          $$DiscountProductsTableUpdateCompanionBuilder,
          (DiscountProduct, $$DiscountProductsTableReferences),
          DiscountProduct,
          PrefetchHooks Function({bool discountId, bool productId})
        > {
  $$DiscountProductsTableTableManager(
    _$AppDatabase db,
    $DiscountProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscountProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscountProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscountProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> discountId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiscountProductsCompanion(
                id: id,
                discountId: discountId,
                productId: productId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String discountId,
                required String productId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiscountProductsCompanion.insert(
                id: id,
                discountId: discountId,
                productId: productId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DiscountProductsTable, DiscountProduct>(table),
                  $$DiscountProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({discountId = false, productId = false}) {
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
                    if (discountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.discountId,
                                referencedTable:
                                    $$DiscountProductsTableReferences
                                        ._discountIdTable(db),
                                referencedColumn:
                                    $$DiscountProductsTableReferences
                                        ._discountIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$DiscountProductsTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$DiscountProductsTableReferences
                                        ._productIdTable(db)
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

typedef $$DiscountProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiscountProductsTable,
      DiscountProduct,
      $$DiscountProductsTableFilterComposer,
      $$DiscountProductsTableOrderingComposer,
      $$DiscountProductsTableAnnotationComposer,
      $$DiscountProductsTableCreateCompanionBuilder,
      $$DiscountProductsTableUpdateCompanionBuilder,
      (DiscountProduct, $$DiscountProductsTableReferences),
      DiscountProduct,
      PrefetchHooks Function({bool discountId, bool productId})
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required int transactionNumber,
      required int subtotal,
      required int discountAmount,
      required int totalAmount,
      required int totalCost,
      required int profit,
      required int profitMarginBasisPoints,
      required String paymentMethod,
      Value<String?> paymentReference,
      Value<String> orderType,
      Value<String?> fulfillmentType,
      Value<int?> cashReceived,
      Value<int?> changeAmount,
      Value<String> status,
      required DateTime completedAt,
      Value<int> rowid,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> transactionNumber,
      Value<int> subtotal,
      Value<int> discountAmount,
      Value<int> totalAmount,
      Value<int> totalCost,
      Value<int> profit,
      Value<int> profitMarginBasisPoints,
      Value<String> paymentMethod,
      Value<String?> paymentReference,
      Value<String> orderType,
      Value<String?> fulfillmentType,
      Value<int?> cashReceived,
      Value<int?> changeAmount,
      Value<String> status,
      Value<DateTime> completedAt,
      Value<int> rowid,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: 'sales__id__sale_items__sale_id',
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleReversalsTable, List<SaleReversal>>
  _saleReversalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleReversals,
    aliasName: 'sales__id__sale_reversals__sale_id',
  );

  $$SaleReversalsTableProcessedTableManager get saleReversalsRefs {
    final manager = $$SaleReversalsTableTableManager(
      $_db,
      $_db.saleReversals,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleReversalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionNumber => $composableBuilder(
    column: $table.transactionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get profitMarginBasisPoints => $composableBuilder(
    column: $table.profitMarginBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fulfillmentType => $composableBuilder(
    column: $table.fulfillmentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashReceived => $composableBuilder(
    column: $table.cashReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get changeAmount => $composableBuilder(
    column: $table.changeAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleReversalsRefs(
    Expression<bool> Function($$SaleReversalsTableFilterComposer f) f,
  ) {
    final $$SaleReversalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleReversals,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleReversalsTableFilterComposer(
            $db: $db,
            $table: $db.saleReversals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionNumber => $composableBuilder(
    column: $table.transactionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get profitMarginBasisPoints => $composableBuilder(
    column: $table.profitMarginBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fulfillmentType => $composableBuilder(
    column: $table.fulfillmentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashReceived => $composableBuilder(
    column: $table.cashReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get changeAmount => $composableBuilder(
    column: $table.changeAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get transactionNumber => $composableBuilder(
    column: $table.transactionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<int> get profit =>
      $composableBuilder(column: $table.profit, builder: (column) => column);

  GeneratedColumn<int> get profitMarginBasisPoints => $composableBuilder(
    column: $table.profitMarginBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<String> get fulfillmentType => $composableBuilder(
    column: $table.fulfillmentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cashReceived => $composableBuilder(
    column: $table.cashReceived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get changeAmount => $composableBuilder(
    column: $table.changeAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleReversalsRefs<T extends Object>(
    Expression<T> Function($$SaleReversalsTableAnnotationComposer a) f,
  ) {
    final $$SaleReversalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleReversals,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleReversalsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleReversals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool saleItemsRefs, bool saleReversalsRefs})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> transactionNumber = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> discountAmount = const Value.absent(),
                Value<int> totalAmount = const Value.absent(),
                Value<int> totalCost = const Value.absent(),
                Value<int> profit = const Value.absent(),
                Value<int> profitMarginBasisPoints = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> paymentReference = const Value.absent(),
                Value<String> orderType = const Value.absent(),
                Value<String?> fulfillmentType = const Value.absent(),
                Value<int?> cashReceived = const Value.absent(),
                Value<int?> changeAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                transactionNumber: transactionNumber,
                subtotal: subtotal,
                discountAmount: discountAmount,
                totalAmount: totalAmount,
                totalCost: totalCost,
                profit: profit,
                profitMarginBasisPoints: profitMarginBasisPoints,
                paymentMethod: paymentMethod,
                paymentReference: paymentReference,
                orderType: orderType,
                fulfillmentType: fulfillmentType,
                cashReceived: cashReceived,
                changeAmount: changeAmount,
                status: status,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required int transactionNumber,
                required int subtotal,
                required int discountAmount,
                required int totalAmount,
                required int totalCost,
                required int profit,
                required int profitMarginBasisPoints,
                required String paymentMethod,
                Value<String?> paymentReference = const Value.absent(),
                Value<String> orderType = const Value.absent(),
                Value<String?> fulfillmentType = const Value.absent(),
                Value<int?> cashReceived = const Value.absent(),
                Value<int?> changeAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime completedAt,
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                transactionNumber: transactionNumber,
                subtotal: subtotal,
                discountAmount: discountAmount,
                totalAmount: totalAmount,
                totalCost: totalCost,
                profit: profit,
                profitMarginBasisPoints: profitMarginBasisPoints,
                paymentMethod: paymentMethod,
                paymentReference: paymentReference,
                orderType: orderType,
                fulfillmentType: fulfillmentType,
                cashReceived: cashReceived,
                changeAmount: changeAmount,
                status: status,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SalesTable, Sale>(table),
                  $$SalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({saleItemsRefs = false, saleReversalsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (saleItemsRefs) db.saleItems,
                    if (saleReversalsRefs) db.saleReversals,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (saleItemsRefs)
                        await $_getPrefetchedData<Sale, $SalesTable, SaleItem>(
                          currentTable: table,
                          referencedTable: $$SalesTableReferences
                              ._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SalesTableReferences(
                                db,
                                table,
                                p0,
                              ).saleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleReversalsRefs)
                        await $_getPrefetchedData<
                          Sale,
                          $SalesTable,
                          SaleReversal
                        >(
                          currentTable: table,
                          referencedTable: $$SalesTableReferences
                              ._saleReversalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SalesTableReferences(
                                db,
                                table,
                                p0,
                              ).saleReversalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
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

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool saleItemsRefs, bool saleReversalsRefs})
    >;
typedef $$SaleItemsTableCreateCompanionBuilder =
    SaleItemsCompanion Function({
      required String id,
      required String saleId,
      required String productId,
      required String productName,
      required int quantity,
      required int baseUnitPrice,
      required int discountBasisPoints,
      required int actualUnitPrice,
      required int lineSubtotal,
      required int lineDiscount,
      required int lineTotal,
      required int costPerUnit,
      required int lineCost,
      required int lineProfit,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<String> id,
      Value<String> saleId,
      Value<String> productId,
      Value<String> productName,
      Value<int> quantity,
      Value<int> baseUnitPrice,
      Value<int> discountBasisPoints,
      Value<int> actualUnitPrice,
      Value<int> lineSubtotal,
      Value<int> lineDiscount,
      Value<int> lineTotal,
      Value<int> costPerUnit,
      Value<int> lineCost,
      Value<int> lineProfit,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem> {
  $$SaleItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) =>
      db.sales.createAlias('sale_items__sale_id__sales__id');

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('sale_items__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
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

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseUnitPrice => $composableBuilder(
    column: $table.baseUnitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountBasisPoints => $composableBuilder(
    column: $table.discountBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualUnitPrice => $composableBuilder(
    column: $table.actualUnitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineSubtotal => $composableBuilder(
    column: $table.lineSubtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineDiscount => $composableBuilder(
    column: $table.lineDiscount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineCost => $composableBuilder(
    column: $table.lineCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineProfit => $composableBuilder(
    column: $table.lineProfit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
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

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseUnitPrice => $composableBuilder(
    column: $table.baseUnitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountBasisPoints => $composableBuilder(
    column: $table.discountBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualUnitPrice => $composableBuilder(
    column: $table.actualUnitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineSubtotal => $composableBuilder(
    column: $table.lineSubtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineDiscount => $composableBuilder(
    column: $table.lineDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineCost => $composableBuilder(
    column: $table.lineCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineProfit => $composableBuilder(
    column: $table.lineProfit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get baseUnitPrice => $composableBuilder(
    column: $table.baseUnitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountBasisPoints => $composableBuilder(
    column: $table.discountBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualUnitPrice => $composableBuilder(
    column: $table.actualUnitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineSubtotal => $composableBuilder(
    column: $table.lineSubtotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineDiscount => $composableBuilder(
    column: $table.lineDiscount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineTotal =>
      $composableBuilder(column: $table.lineTotal, builder: (column) => column);

  GeneratedColumn<int> get costPerUnit => $composableBuilder(
    column: $table.costPerUnit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineCost =>
      $composableBuilder(column: $table.lineCost, builder: (column) => column);

  GeneratedColumn<int> get lineProfit => $composableBuilder(
    column: $table.lineProfit,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, $$SaleItemsTableReferences),
          SaleItem,
          PrefetchHooks Function({bool saleId, bool productId})
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> baseUnitPrice = const Value.absent(),
                Value<int> discountBasisPoints = const Value.absent(),
                Value<int> actualUnitPrice = const Value.absent(),
                Value<int> lineSubtotal = const Value.absent(),
                Value<int> lineDiscount = const Value.absent(),
                Value<int> lineTotal = const Value.absent(),
                Value<int> costPerUnit = const Value.absent(),
                Value<int> lineCost = const Value.absent(),
                Value<int> lineProfit = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                saleId: saleId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                baseUnitPrice: baseUnitPrice,
                discountBasisPoints: discountBasisPoints,
                actualUnitPrice: actualUnitPrice,
                lineSubtotal: lineSubtotal,
                lineDiscount: lineDiscount,
                lineTotal: lineTotal,
                costPerUnit: costPerUnit,
                lineCost: lineCost,
                lineProfit: lineProfit,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String saleId,
                required String productId,
                required String productName,
                required int quantity,
                required int baseUnitPrice,
                required int discountBasisPoints,
                required int actualUnitPrice,
                required int lineSubtotal,
                required int lineDiscount,
                required int lineTotal,
                required int costPerUnit,
                required int lineCost,
                required int lineProfit,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                saleId: saleId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                baseUnitPrice: baseUnitPrice,
                discountBasisPoints: discountBasisPoints,
                actualUnitPrice: actualUnitPrice,
                lineSubtotal: lineSubtotal,
                lineDiscount: lineDiscount,
                lineTotal: lineTotal,
                costPerUnit: costPerUnit,
                lineCost: lineCost,
                lineProfit: lineProfit,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SaleItemsTable, SaleItem>(table),
                  $$SaleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false, productId = false}) {
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
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$SaleItemsTableReferences
                                    ._saleIdTable(db),
                                referencedColumn: $$SaleItemsTableReferences
                                    ._saleIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$SaleItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$SaleItemsTableReferences
                                    ._productIdTable(db)
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

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, $$SaleItemsTableReferences),
      SaleItem,
      PrefetchHooks Function({bool saleId, bool productId})
    >;
typedef $$SaleReversalsTableCreateCompanionBuilder =
    SaleReversalsCompanion Function({
      required String id,
      required String saleId,
      required String reversalType,
      required String reason,
      required DateTime reversedAt,
      Value<int> rowid,
    });
typedef $$SaleReversalsTableUpdateCompanionBuilder =
    SaleReversalsCompanion Function({
      Value<String> id,
      Value<String> saleId,
      Value<String> reversalType,
      Value<String> reason,
      Value<DateTime> reversedAt,
      Value<int> rowid,
    });

final class $$SaleReversalsTableReferences
    extends BaseReferences<_$AppDatabase, $SaleReversalsTable, SaleReversal> {
  $$SaleReversalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SalesTable _saleIdTable(_$AppDatabase db) =>
      db.sales.createAlias('sale_reversals__sale_id__sales__id');

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleReversalsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleReversalsTable> {
  $$SaleReversalsTableFilterComposer({
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

  ColumnFilters<String> get reversalType => $composableBuilder(
    column: $table.reversalType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reversedAt => $composableBuilder(
    column: $table.reversedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleReversalsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleReversalsTable> {
  $$SaleReversalsTableOrderingComposer({
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

  ColumnOrderings<String> get reversalType => $composableBuilder(
    column: $table.reversalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reversedAt => $composableBuilder(
    column: $table.reversedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleReversalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleReversalsTable> {
  $$SaleReversalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reversalType => $composableBuilder(
    column: $table.reversalType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get reversedAt => $composableBuilder(
    column: $table.reversedAt,
    builder: (column) => column,
  );

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleReversalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleReversalsTable,
          SaleReversal,
          $$SaleReversalsTableFilterComposer,
          $$SaleReversalsTableOrderingComposer,
          $$SaleReversalsTableAnnotationComposer,
          $$SaleReversalsTableCreateCompanionBuilder,
          $$SaleReversalsTableUpdateCompanionBuilder,
          (SaleReversal, $$SaleReversalsTableReferences),
          SaleReversal,
          PrefetchHooks Function({bool saleId})
        > {
  $$SaleReversalsTableTableManager(_$AppDatabase db, $SaleReversalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleReversalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleReversalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleReversalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<String> reversalType = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<DateTime> reversedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleReversalsCompanion(
                id: id,
                saleId: saleId,
                reversalType: reversalType,
                reason: reason,
                reversedAt: reversedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String saleId,
                required String reversalType,
                required String reason,
                required DateTime reversedAt,
                Value<int> rowid = const Value.absent(),
              }) => SaleReversalsCompanion.insert(
                id: id,
                saleId: saleId,
                reversalType: reversalType,
                reason: reason,
                reversedAt: reversedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SaleReversalsTable, SaleReversal>(table),
                  $$SaleReversalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
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
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$SaleReversalsTableReferences
                                    ._saleIdTable(db),
                                referencedColumn: $$SaleReversalsTableReferences
                                    ._saleIdTable(db)
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

typedef $$SaleReversalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleReversalsTable,
      SaleReversal,
      $$SaleReversalsTableFilterComposer,
      $$SaleReversalsTableOrderingComposer,
      $$SaleReversalsTableAnnotationComposer,
      $$SaleReversalsTableCreateCompanionBuilder,
      $$SaleReversalsTableUpdateCompanionBuilder,
      (SaleReversal, $$SaleReversalsTableReferences),
      SaleReversal,
      PrefetchHooks Function({bool saleId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String name,
      required String category,
      required int amount,
      required DateTime expenseDate,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<String> category,
      Value<int> amount,
      Value<DateTime> expenseDate,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                category: category,
                amount: amount,
                expenseDate: expenseDate,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String name,
                required String category,
                required int amount,
                required DateTime expenseDate,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                category: category,
                amount: amount,
                expenseDate: expenseDate,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpensesTable, Expense>(table),
                  BaseReferences<_$AppDatabase, $ExpensesTable, Expense>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductInclusionsTableTableManager get productInclusions =>
      $$ProductInclusionsTableTableManager(_db, _db.productInclusions);
  $$InventoryMovementsTableTableManager get inventoryMovements =>
      $$InventoryMovementsTableTableManager(_db, _db.inventoryMovements);
  $$DiscountsTableTableManager get discounts =>
      $$DiscountsTableTableManager(_db, _db.discounts);
  $$DiscountProductsTableTableManager get discountProducts =>
      $$DiscountProductsTableTableManager(_db, _db.discountProducts);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$SaleReversalsTableTableManager get saleReversals =>
      $$SaleReversalsTableTableManager(_db, _db.saleReversals);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
}
