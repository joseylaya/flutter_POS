import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

abstract class EntityTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Settings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get businessName =>
      text().withDefault(const Constant('BRADZ SILOGAN'))();
  TextColumn get receiptTagline =>
      text().withDefault(const Constant('Savoring every bite'))();
  TextColumn get businessHours => text().withDefault(
    const Constant(
      'Mon-Tue 10:00 AM - 10:00 PM\n'
      'Wed - CLOSED\n'
      'Thu-Sun 10:00 AM - 10:00 PM',
    ),
  )();
  TextColumn get businessAddress =>
      text().withDefault(const Constant('BNCA Basak Lapu-Lapu City'))();
  TextColumn get receiptFooter =>
      text().withDefault(const Constant('Thank you!'))();
  TextColumn get currency => text().withDefault(const Constant('PHP'))();
  TextColumn get printerName => text().nullable()();
  TextColumn get printerAddress => text().nullable()();
  IntColumn get printerPaperWidthMm => integer()
      .withDefault(const Constant(58))
      .check(
        const CustomExpression<bool>('printer_paper_width_mm IN (58, 80)'),
      )();
  IntColumn get nextTransactionNumber => integer()
      .withDefault(const Constant(1))
      .check(const CustomExpression<bool>('next_transaction_number > 0'))();
  TextColumn get themeMode => text()
      .withDefault(const Constant('SYSTEM'))
      .check(
        const CustomExpression<bool>(
          "theme_mode IN ('SYSTEM', 'LIGHT', 'DARK')",
        ),
      )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const ['CHECK (id = 1)'];
}

class InventoryItems extends EntityTable {
  TextColumn get name => text().withLength(min: 1, max: 120)();
  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();
  TextColumn get unit => text().withLength(min: 1, max: 30)();
  IntColumn get costPerUnit =>
      integer().check(const CustomExpression<bool>('cost_per_unit >= 0'))();
  IntColumn get lowStockThreshold => integer()
      .withDefault(const Constant(0))
      .check(const CustomExpression<bool>('low_stock_threshold >= 0'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class Products extends EntityTable {
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get category => text().withDefault(const Constant('Other'))();
  BlobColumn get imageData => blob().nullable()();
  IntColumn get sellingPrice =>
      integer().check(const CustomExpression<bool>('selling_price >= 0'))();
  TextColumn get inventoryItemId => text().unique().references(
    InventoryItems,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class ProductInclusions extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(
    Products,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get inventoryItemId => text().references(
    InventoryItems,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  IntColumn get quantity =>
      integer().check(const CustomExpression<bool>('quantity > 0'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {productId, inventoryItemId},
  ];
}

class InventoryMovements extends Table {
  TextColumn get id => text()();
  TextColumn get inventoryItemId => text().references(
    InventoryItems,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get movementType => text().check(
    const CustomExpression<bool>("movement_type IN ('SALE', 'ADD', 'REMOVE')"),
  )();
  IntColumn get quantity =>
      integer().check(const CustomExpression<bool>('quantity != 0'))();
  IntColumn get quantityBefore => integer()();
  IntColumn get quantityAfter => integer()();
  TextColumn get referenceType => text().nullable()();
  TextColumn get referenceId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const [
    "CHECK ((movement_type = 'ADD' AND quantity > 0) OR "
        "(movement_type IN ('SALE', 'REMOVE') AND quantity < 0))",
    'CHECK (quantity_after = quantity_before + quantity)',
  ];
}

class Discounts extends EntityTable {
  TextColumn get name => text().withLength(min: 1, max: 120)();
  IntColumn get percentageBasisPoints => integer().check(
    const CustomExpression<bool>('percentage_basis_points BETWEEN 1 AND 10000'),
  )();
  TextColumn get scope => text().check(
    const CustomExpression<bool>("scope IN ('ALL', 'SELECTED')"),
  )();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
}

class DiscountProducts extends Table {
  TextColumn get id => text()();
  TextColumn get discountId => text().references(
    Discounts,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get productId => text().references(
    Products,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {discountId, productId},
  ];
}

class Sales extends EntityTable {
  IntColumn get transactionNumber => integer().unique().check(
    const CustomExpression<bool>('transaction_number > 0'),
  )();
  IntColumn get subtotal =>
      integer().check(const CustomExpression<bool>('subtotal >= 0'))();
  IntColumn get discountAmount =>
      integer().check(const CustomExpression<bool>('discount_amount >= 0'))();
  IntColumn get totalAmount =>
      integer().check(const CustomExpression<bool>('total_amount >= 0'))();
  IntColumn get totalCost =>
      integer().check(const CustomExpression<bool>('total_cost >= 0'))();
  IntColumn get profit => integer()();
  IntColumn get profitMarginBasisPoints => integer()();
  TextColumn get paymentMethod => text().check(
    const CustomExpression<bool>("payment_method IN ('CASH', 'GCASH')"),
  )();
  TextColumn get paymentReference => text().withLength(max: 80).nullable()();
  TextColumn get orderType => text()
      .withDefault(const Constant('DINE_IN'))
      .check(
        const CustomExpression<bool>("order_type IN ('DINE_IN', 'TAKE_OUT')"),
      )();
  TextColumn get fulfillmentType => text().nullable().check(
    const CustomExpression<bool>(
      "fulfillment_type IS NULL OR fulfillment_type IN ('DELIVERY', 'PICKUP')",
    ),
  )();
  IntColumn get cashReceived => integer().nullable()();
  IntColumn get changeAmount => integer().nullable()();
  TextColumn get status => text()
      .withDefault(const Constant('COMPLETED'))
      .check(const CustomExpression<bool>("status = 'COMPLETED'"))();
  DateTimeColumn get completedAt => dateTime()();

  @override
  List<String> get customConstraints => const [
    'CHECK (discount_amount <= subtotal)',
    'CHECK (total_amount = subtotal - discount_amount)',
    'CHECK (profit = total_amount - total_cost)',
    "CHECK ((payment_method = 'CASH' AND cash_received IS NOT NULL AND "
        'change_amount IS NOT NULL AND cash_received >= total_amount AND '
        "change_amount = cash_received - total_amount) OR (payment_method = 'GCASH' "
        'AND cash_received IS NULL AND change_amount IS NULL))',
    "CHECK ((order_type = 'DINE_IN' AND fulfillment_type IS NULL) OR "
        "(order_type = 'TAKE_OUT' AND fulfillment_type IS NOT NULL))",
  ];
}

class SaleItems extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text().references(
    Sales,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get productId => text().references(
    Products,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get productName => text().withLength(min: 1, max: 120)();
  IntColumn get quantity =>
      integer().check(const CustomExpression<bool>('quantity > 0'))();
  IntColumn get baseUnitPrice =>
      integer().check(const CustomExpression<bool>('base_unit_price >= 0'))();
  IntColumn get discountBasisPoints => integer().check(
    const CustomExpression<bool>('discount_basis_points BETWEEN 0 AND 10000'),
  )();
  IntColumn get actualUnitPrice =>
      integer().check(const CustomExpression<bool>('actual_unit_price >= 0'))();
  IntColumn get lineSubtotal =>
      integer().check(const CustomExpression<bool>('line_subtotal >= 0'))();
  IntColumn get lineDiscount =>
      integer().check(const CustomExpression<bool>('line_discount >= 0'))();
  IntColumn get lineTotal =>
      integer().check(const CustomExpression<bool>('line_total >= 0'))();
  IntColumn get costPerUnit =>
      integer().check(const CustomExpression<bool>('cost_per_unit >= 0'))();
  IntColumn get lineCost =>
      integer().check(const CustomExpression<bool>('line_cost >= 0'))();
  IntColumn get lineProfit => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => const [
    'CHECK (line_subtotal = base_unit_price * quantity)',
    'CHECK (line_discount <= line_subtotal)',
    'CHECK (line_total = line_subtotal - line_discount)',
    'CHECK (line_cost = cost_per_unit * quantity)',
    'CHECK (line_profit = line_total - line_cost)',
  ];
}

class SaleReversals extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text().unique().references(
    Sales,
    #id,
    onDelete: KeyAction.restrict,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get reversalType => text().check(
    const CustomExpression<bool>("reversal_type IN ('CANCELLATION', 'REFUND')"),
  )();
  TextColumn get reason => text().withLength(min: 3, max: 250)();
  DateTimeColumn get reversedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Expenses extends EntityTable {
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get category => text().withLength(min: 1, max: 80)();
  IntColumn get amount =>
      integer().check(const CustomExpression<bool>('amount > 0'))();
  DateTimeColumn get expenseDate => dateTime()();
  TextColumn get notes => text().nullable()();
}

@DriftDatabase(
  tables: [
    Settings,
    Products,
    InventoryItems,
    ProductInclusions,
    InventoryMovements,
    Discounts,
    DiscountProducts,
    Sales,
    SaleItems,
    SaleReversals,
    Expenses,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _createIndexes();
      await into(settings).insert(const SettingsCompanion());
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        if (!await _hasColumn('settings', 'printer_address')) {
          await migrator.addColumn(settings, settings.printerAddress);
        }
      }
      if (from < 3) {
        if (!await _hasColumn('settings', 'theme_mode')) {
          await migrator.addColumn(settings, settings.themeMode);
        }
      }
      if (from < 4) {
        if (!await _hasColumn('products', 'image_data')) {
          await migrator.addColumn(products, products.imageData);
        }
      }
      if (from < 5) {
        if (!await _hasColumn('sales', 'payment_reference')) {
          await migrator.addColumn(sales, sales.paymentReference);
        }
      }
      if (from < 6) {
        if (!await _hasColumn('products', 'category')) {
          await migrator.addColumn(products, products.category);
        }
        await customStatement(
          "UPDATE products SET category = 'Silog Meals' "
          "WHERE name IN ('Tapsilog', 'Tocilog', 'Bangsilog', 'Longsilog', "
          "'Cornsilog', 'Hotsilog', 'Porksilog')",
        );
        await customStatement(
          "UPDATE products SET category = 'Sides & Add-ons' "
          "WHERE name IN ('Extra Rice', 'Fried Egg')",
        );
        await customStatement(
          "UPDATE products SET category = 'Drinks' WHERE name = 'Hot Coffee'",
        );
      }
      if (from < 7) {
        await migrator.createTable(productInclusions);
        await customStatement(
          'CREATE INDEX product_inclusions_product_idx '
          'ON product_inclusions (product_id)',
        );
        await customStatement(
          'CREATE INDEX product_inclusions_inventory_idx '
          'ON product_inclusions (inventory_item_id)',
        );
      }
      if (from < 8) {
        if (!await _hasColumn('sales', 'order_type')) {
          await migrator.addColumn(sales, sales.orderType);
        }
        if (!await _hasColumn('sales', 'fulfillment_type')) {
          await migrator.addColumn(sales, sales.fulfillmentType);
        }
      }
      if (from < 9) {
        await migrator.createTable(saleReversals);
        await customStatement(
          'CREATE INDEX sale_reversals_date_idx ON sale_reversals (reversed_at)',
        );
      }
      if (from < 10) {
        if (!await _hasColumn('settings', 'receipt_tagline')) {
          await migrator.addColumn(settings, settings.receiptTagline);
        }
        if (!await _hasColumn('settings', 'business_hours')) {
          await migrator.addColumn(settings, settings.businessHours);
        }
        if (!await _hasColumn('settings', 'business_address')) {
          await migrator.addColumn(settings, settings.businessAddress);
        }
        await customStatement(
          "UPDATE settings SET business_name = 'BRADZ SILOGAN' "
          "WHERE business_name = 'JmPOS'",
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<bool> _hasColumn(String table, String column) async {
    final rows = await customSelect("PRAGMA table_info('$table')").get();
    return rows.any((row) => row.read<String>('name') == column);
  }

  Future<void> _createIndexes() async {
    const statements = [
      'CREATE INDEX products_active_idx ON products (is_active)',
      'CREATE INDEX product_inclusions_product_idx ON product_inclusions (product_id)',
      'CREATE INDEX product_inclusions_inventory_idx ON product_inclusions (inventory_item_id)',
      'CREATE INDEX inventory_active_stock_idx ON inventory_items (is_active, stock_quantity)',
      'CREATE INDEX inventory_movements_item_created_idx ON inventory_movements (inventory_item_id, created_at)',
      'CREATE INDEX inventory_movements_reference_idx ON inventory_movements (reference_id)',
      'CREATE UNIQUE INDEX discounts_one_active_idx ON discounts (is_active) WHERE is_active = 1',
      'CREATE INDEX discount_products_product_idx ON discount_products (product_id)',
      'CREATE INDEX sales_completed_idx ON sales (completed_at)',
      'CREATE INDEX sales_payment_idx ON sales (payment_method)',
      'CREATE INDEX sale_items_sale_idx ON sale_items (sale_id)',
      'CREATE INDEX sale_items_product_idx ON sale_items (product_id)',
      'CREATE INDEX sale_reversals_date_idx ON sale_reversals (reversed_at)',
      'CREATE INDEX expenses_date_category_idx ON expenses (expense_date, category)',
    ];
    for (final statement in statements) {
      await customStatement(statement);
    }
  }
}

QueryExecutor _openConnection() => driftDatabase(
  name: 'jm_pos',
  web: DriftWebOptions(
    sqlite3Wasm: Uri.parse('sqlite3.wasm'),
    driftWorker: Uri.parse('drift_worker.js'),
  ),
);
