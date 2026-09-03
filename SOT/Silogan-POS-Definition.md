# Silogan POS — Complete Project Definition & Technical Specification

> **Source-of-truth status:** This is the authoritative MVP specification. If the
> other documents in this directory conflict with it, this document takes
> precedence.

## Confirmed Implementation Decisions — 2026-09-02

- The application/project name is **JmPOS**. The business name shown in the UI
  and printed on receipts is configurable in `settings`.
- The MVP has one owner/cashier and opens without login, roles, permissions, or
  cashier sessions.
- All monetary values are stored as integer centavos in SQLite and represented
  as Dart `int` values. For example, PHP 125.50 is stored as `12550`.
- Percentage discounts are calculated for the complete sale-item line, then
  rounded once to the nearest centavo using half-up rounding.
- Cash checkout requires cash received greater than or equal to the total and
  calculates change automatically. GCash remains recording-only.
- Transaction numbers use one permanent, increasing sequence, never reset
  daily, and display beginning with `000001`.
- Printing targets generic Bluetooth ESC/POS printers. Both 58 mm and 80 mm
  widths are configurable; final verification will use the actual hardware.
- Manual local backup export and restore are part of the MVP.
- The domain schema remains limited to the nine tables in section 77. Sequence
  state and backup preferences belong in the single `settings` record.

## 1. Project Overview

**Silogan POS** is a simple, offline-first Point-of-Sale system designed specifically for a small silogan/food business.

The system is built around one principle:

> **Simple on the surface. Automatic underneath.**

The owner should only need to select products, set quantities, accept payment, and print the receipt.

The system automatically handles:

- Sales recording
- Inventory deduction
- Product cost calculation
- Profit calculation
- Profit margin calculation
- Discounts
- Payment recording
- Receipt generation
- Low-stock monitoring
- Basic sales reports
- Basic expenses
- Offline operation

---

# 2. MVP Goal

The MVP must allow the owner/cashier to operate the entire POS without an internet connection.

Core workflow:

```text
Open POS
  ↓
Select Product
  ↓
Set Quantity
  ↓
Review Cart
  ↓
PAY
  ↓
Cash / GCash
  ↓
Complete Sale
  ↓
Print Receipt
```

The cashier must NOT manually:

- Calculate discounts
- Calculate product cost
- Calculate profit
- Calculate profit margin
- Deduct inventory
- Calculate daily sales totals

All of these are handled automatically.

---

# 3. User Scope

The MVP supports exactly **one user**.

The user is both:

- Owner
- Cashier

No roles or permissions are required.

### Not included

- Multiple users
- Staff accounts
- Manager accounts
- Role permissions
- Approval workflows
- Employee tracking

---

# 4. Device Scope

The MVP is designed for:

- One Android tablet/device
- One POS installation
- One local database
- One Bluetooth thermal printer

No multi-device synchronization is required.

---

# 5. Offline Architecture

The MVP is **100% offline**.

The local SQLite database is the source of truth.

The following must work without internet:

- Product browsing
- Cart
- Checkout
- Sales
- Inventory
- Discounts
- Cost calculations
- Profit calculations
- Expenses
- Reports
- Receipt generation
- Printer operation

There must be no dependency on an API or cloud backend for normal POS operation.

### Future consideration

Cloud synchronization may be added later, but it is explicitly outside the MVP.

---

# 6. Product Definition

A product is the item sold through the POS.

Example:

```text
PRODUCT

Sisig Meal
Selling Price: ₱120
Linked Inventory: Sisig Meal
```

Each POS product must link to exactly **one inventory item**.

Relationship:

```text
PRODUCT
  ├── Selling Price
  └── Linked Inventory
        ├── Stock
        ├── Unit
        ├── Cost
        └── Low Stock Threshold
```

---

# 7. Inventory Definition

Inventory is intentionally simple.

Inventory represents the actual sellable product or serving.

Example:

```text
INVENTORY

Sisig Meal
Stock: 10 servings
Cost: ₱65
Unit: serving

Coke
Stock: 20 bottles
Cost: ₱20
Unit: bottle
```

The system does **not** track ingredients.

It does not need inventory records for:

```text
Eggs
Rice
Oil
Garlic
Pork
Soy Sauce
```

Inventory only tracks what can actually be sold through the POS.

---

# 8. Inventory Fields

Each inventory item contains:

- ID
- Name
- Stock Quantity
- Unit
- Cost Per Unit
- Low Stock Threshold
- Active/Inactive Status
- Created At
- Updated At

Example:

```text
Name: Sisig Meal
Stock: 10
Unit: serving
Cost: ₱65
Low Stock Threshold: 5
Status: Active
```

### Data types

```text
stock_quantity       INTEGER
cost_per_unit        INTEGER  // centavos
low_stock_threshold  INTEGER
```

Inventory quantities are whole numbers only.

---

# 9. Product → Inventory Relationship

The MVP intentionally uses:

```text
1 Product → 1 Inventory Item
```

The reverse is also one-to-one.

This prevents the system from becoming an ingredient-management or manufacturing system.

---

# 10. Inventory Quantity Rules

Inventory quantities must use whole numbers only.

Valid:

```text
10
9
5
1
0
-1
```

Invalid:

```text
0.5
1.25
2.75
```

---

# 11. Automatic Inventory Deduction

When a sale is completed, the system automatically deducts the quantity sold.

Example:

```text
Before:
Sisig Meal = 10

Customer buys:
2 Sisig Meal

After:
Sisig Meal = 8
```

The cashier does not manually modify inventory after a sale.

---

# 12. Negative Inventory

Negative inventory is explicitly allowed.

If:

```text
Stock = 0
```

and the owner sells:

```text
Quantity = 1
```

the resulting inventory becomes:

```text
Stock = -1
```

The sale must NOT be blocked.

Negative inventory must be clearly visible in the inventory UI.

Do not create a database constraint that prevents negative stock.

---

# 13. Manual Inventory Adjustments

The owner can manually modify inventory through:

- Add Stock
- Remove Stock

No reason is required for MVP.

Example:

```text
Current Stock: 5

Add Stock: 10

New Stock: 15
```

or:

```text
Current Stock: 5

Remove Stock: 2

New Stock: 3
```

Manual adjustments are separate from sales.

---

# 14. Inventory Movements

Although the UI is simple, the system should maintain an inventory movement history.

Table:

```text
inventory_movements
```

Purpose:

- Provide traceability
- Record sales deductions
- Record manual stock additions
- Record manual stock removals
- Help diagnose inventory discrepancies

Movement types:

```text
SALE
ADD
REMOVE
```

Example:

```text
inventory_item_id: inv_001
movement_type: SALE
quantity: -2
quantity_before: 10
quantity_after: 8
reference_type: SALE
reference_id: sale_001
```

---

# 15. Inventory Movement Rules

For a sale:

```text
quantity = -quantity_sold
```

For Add Stock:

```text
quantity = +quantity_added
```

For Remove Stock:

```text
quantity = -quantity_removed
```

Every movement should record:

- Quantity before
- Movement quantity
- Quantity after
- Reference type
- Reference ID
- Timestamp

---

# 16. Product Cost

Each inventory item has a manually entered cost.

Example:

```text
Sisig Meal

Selling Price: ₱120
Cost: ₱65
Stock: 10
```

The MVP does not calculate cost from ingredients.

Not included:

- Recipe
- BOM
- Ingredient costing
- Supplier costing
- Purchase-order costing
- Manufacturing costing

---

# 17. Sales Calculation

For every completed sale, the system records:

- Product
- Quantity
- Base selling price
- Actual selling price
- Product cost
- Total sales
- Total cost
- Profit
- Profit margin

### Formulas

```text
Sales = Actual Selling Price × Quantity

Cost = Cost Per Unit × Quantity

Profit = Sales - Cost

Profit Margin = Profit ÷ Sales × 100
```

Example:

```text
Selling Price = ₱120
Cost = ₱65
Quantity = 5

Sales = ₱600
Cost = ₱325
Profit = ₱275
Profit Margin = 45.83%
```

---

# 18. Discount System

The MVP supports exactly **one active percentage discount at a time**.

Discount states:

```text
ON
OFF
```

When enabling a discount, the owner chooses:

```text
All Products
```

or:

```text
Selected Products Only
```

Then specifies the percentage.

Example:

```text
Discount: 10%
Scope: Selected Products

Selected:
- Sisig Meal
- Longsilog
```

---

# 19. Discount Persistence

The active discount remains active until the owner:

- Disables it
- Changes it

The discount is not limited to the current cart.

If a selected product is added to a new cart while the discount is active, the discount automatically applies.

---

# 20. Discount Price Rules

The original product price must **never** be overwritten.

Example:

```text
Base Price: ₱120
Discount: 10%
Effective Price: ₱108
```

Formula:

```text
Effective Price =
    Base Price × (1 - Discount Percentage / 100)
```

When the discount is disabled:

```text
Base Price: ₱120
Effective Price: ₱120
```

The base price remains ₱120.

---

# 21. Manual Discount Override

Manual discounted prices are NOT allowed.

Example:

```text
Base Price = ₱120
Discount = 10%
```

The system must calculate:

```text
₱108
```

The owner cannot manually change the effective price to ₱105.

The configured discount rule must be strictly enforced.

---

# 22. Discount and Profit

Profit must use the **actual discounted selling price**.

Example:

```text
Base Price: ₱120
Cost: ₱65
Discount: 10%

Effective Price: ₱108

Profit:
₱108 - ₱65 = ₱43
```

Therefore:

```text
Profit = Actual Sale Price - Product Cost
```

not:

```text
Base Price - Product Cost
```

---

# 23. Discount Display

The POS should clearly indicate when a discount is active.

Examples:

```text
10% OFF
```

or:

```text
Discount Active — 10% OFF
```

A discounted product may display:

```text
₱120
₱108
10% OFF
```

The effective selling price must be obvious.

---

# 24. Cart and Checkout

The cart must show:

- Product
- Quantity
- Unit price
- Discount
- Line total
- Subtotal
- Total discount
- Final total

Example:

```text
Sisig Meal × 2
₱108 each
₱216

Coke × 1
₱30

----------------

Subtotal      ₱270
Discount      -₱24
----------------
TOTAL         ₱246
```

The subtotal is calculated using base prices before discount.

---

# 25. Completed Sales

When the owner completes payment, the transaction becomes a completed sale.

Completed sales are historical records and must not be freely editable.

Historical sale data must remain accurate even when products, prices, costs, or discounts change later.

---

# 26. Refunds

Refund functionality is **not included in the MVP**.

Not included:

- Full refunds
- Partial refunds
- Returns
- Exchanges
- Refund approval workflows

If inventory requires correction, the owner can use Add Stock or Remove Stock.

---

# 27. Payment Methods

The MVP supports exactly:

```text
CASH
GCASH
```

GCash is simply recorded as the payment method.

No online GCash verification or payment gateway is required.

Not included:

- Maya
- Bank transfer
- Cards
- Credit/utang
- Split payments
- Payment gateway integration

---

# 28. Cash Payment

For Cash, the system may support:

```text
Total: ₱246

Cash Received:
₱500

Change:
₱254
```

The sale can only be completed when sufficient cash is received.

---

# 29. GCash Payment

For GCash:

```text
Total: ₱246

Payment:
GCash

[ COMPLETE SALE ]
```

No online verification is required.

The payment method is stored with the completed sale.

---

# 30. Receipt Printing

The POS must support Bluetooth thermal receipt printing.

Receipt should contain at minimum:

- Business name
- Date/time
- Transaction number
- Items
- Quantity
- Price
- Discount
- Total
- Payment method

Example:

```text
BUSINESS NAME

Date / Time
Transaction Number

-------------------------
Item          Qty   Price
-------------------------
Sisig Meal     2    ₱216
Coke           1     ₱30
-------------------------

Subtotal            ₱270
Discount            -₱24
TOTAL               ₱246

Payment: GCash
```

The exact layout may be adjusted according to printer paper width.

---

# 31. Printer Transaction Rule

The printer must NOT control whether a sale succeeds.

Correct:

```text
Complete Sale
    ↓
Commit Database
    ↓
Print Receipt
```

If the Bluetooth printer is disconnected:

- Sale remains completed
- Inventory remains deducted
- Financial data remains stored
- Receipt printing can be retried

Never require successful printing before committing the sale.

---

# 32. Dashboard

The dashboard must remain simple and relevant.

Example:

```text
TODAY

Sales          ₱12,450
Cost            ₱6,200
Profit          ₱6,250
Orders                87

LOW STOCK

Sisig Meal             2
Coke                   4
```

Do not overload the dashboard with unnecessary analytics.

---

# 33. Sales Reports

Minimum reports:

- Total sales
- Total product cost
- Total profit
- Profit margin
- Number of orders
- Quantity sold
- Product sales
- Product profitability

The owner should be able to answer:

```text
What sold?
How many sold?
How much did I sell?
How much did it cost?
How much profit did I make?
```

---

# 34. Expenses

Basic operating expenses can be recorded separately.

Examples:

- Rent
- Electricity
- Water
- Supplies
- Other business expenses

Fields:

```text
name
category
amount
expense_date
notes
```

Product costs and operating expenses must remain separate.

---

# 35. Financial Definitions

### Sales

Money generated from completed product sales after item-level discounts.

### Product Cost

The cost of products sold.

### Gross Profit

```text
Sales - Product Cost
```

### Operating Expenses

Expenses such as:

```text
Rent
Electricity
Water
Supplies
```

### Net Profit

```text
Gross Profit - Operating Expenses
```

Example:

```text
Sales              ₱10,000
Product Cost        ₱5,000
---------------------------
Gross Profit         ₱5,000

Expenses             ₱1,000
---------------------------
Net Profit           ₱4,000
```

---

# 36. Database Architecture

The MVP uses **SQLite** as the local database.

Core tables:

```text
settings
products
inventory_items
inventory_movements
discounts
discount_products
sales
sale_items
expenses
```

No unnecessary tables should be introduced.

---

# 37. `settings`

Stores basic POS/business configuration.

```text
settings
--------------------------------
id
business_name
receipt_footer
currency
printer_name
printer_paper_width_mm
next_transaction_number
created_at
updated_at
```

The MVP only requires one settings record.

Example:

```text
business_name: "Jose's Silogan"
receipt_footer: "Thank you!"
currency: "PHP"
printer_name: "Thermal Printer"
```

---

# 38. `products`

Stores products displayed in the POS.

```text
products
--------------------------------
id
name
selling_price
inventory_item_id
is_active
created_at
updated_at
```

Rules:

- `selling_price` is always the base price.
- Discount does not modify `selling_price`.
- Historical sales do not depend on the current product price.

---

# 39. `inventory_items`

Stores sellable inventory.

```text
inventory_items
--------------------------------
id
name
stock_quantity
unit
cost_per_unit
low_stock_threshold
is_active
created_at
updated_at
```

Recommended types:

```text
id                    TEXT/UUID
name                  TEXT
stock_quantity        INTEGER
unit                  TEXT
cost_per_unit         INTEGER  // centavos
low_stock_threshold   INTEGER
is_active             BOOLEAN
created_at            DATETIME
updated_at            DATETIME
```

---

# 40. `inventory_movements`

```text
inventory_movements
--------------------------------
id
inventory_item_id
movement_type
quantity
quantity_before
quantity_after
reference_type
reference_id
created_at
```

Movement types:

```text
SALE
ADD
REMOVE
```

Recommended behavior:

```text
SALE:
quantity = negative

ADD:
quantity = positive

REMOVE:
quantity = negative
```

---

# 41. `discounts`

```text
discounts
--------------------------------
id
name
percentage
scope
is_active
created_at
updated_at
```

Allowed scope values:

```text
ALL
SELECTED
```

Example:

```text
name: "10% OFF"
percentage: 10.00
scope: SELECTED
is_active: true
```

---

# 42. `discount_products`

Used when discount scope is `SELECTED`.

```text
discount_products
--------------------------------
id
discount_id
product_id
created_at
```

Relationship:

```text
discounts
    ↓
discount_products
    ↓
products
```

---

# 43. Active Discount Rule

Only one discount may be active.

When activating a new discount:

```text
Existing Active Discount
        ↓
Deactivate
        ↓
New Discount
        ↓
Activate
```

This operation must happen inside a database transaction.

The application should prevent multiple active discounts.

---

# 44. `sales`

Stores the sale header.

```text
sales
--------------------------------
id
transaction_number
subtotal
discount_amount
total_amount
total_cost
profit
profit_margin
payment_method
cash_received
change_amount
status
completed_at
created_at
updated_at
```

Allowed payment methods:

```text
CASH
GCASH
```

`cash_received` and `change_amount` are integer-centavo snapshots for Cash
sales. They are null for GCash sales.

MVP status:

```text
COMPLETED
```

---

# 45. `sale_items`

Stores each product sold and its historical snapshot.

```text
sale_items
--------------------------------
id
sale_id
product_id
product_name
quantity
base_unit_price
discount_percentage
discount_unit_amount
actual_unit_price
line_subtotal
line_discount
line_total
cost_per_unit
line_cost
line_profit
created_at
```

---

# 46. Historical Sale Snapshot

`product_name`, prices, discount, and cost are stored directly in `sale_items`.

This is intentional.

Example:

```text
Today:
Sisig Meal
Price: ₱120
Cost: ₱65
```

Sale records:

```text
product_name = Sisig Meal
base_unit_price = 120.00
cost_per_unit = 65.00
```

Later:

```text
Product price = ₱130
Cost = ₱70
Product name = Sisig Special
```

The historical sale must still show:

```text
Sisig Meal
₱120
Cost ₱65
```

Historical transaction records must not change.

---

# 47. Sale Item Calculation

Example:

```text
Base Price: ₱120
Discount: 10%
Quantity: 2
Cost: ₱65
```

Stored values:

```text
base_unit_price       = 120.00
discount_percentage   = 10.00
discount_unit_amount  = 12.00
actual_unit_price     = 108.00

line_subtotal         = 240.00
line_discount         = 24.00
line_total            = 216.00

cost_per_unit         = 65.00
line_cost             = 130.00
line_profit           = 86.00
```

---

# 48. Sale Header Calculation

For the complete sale:

```text
subtotal       = 270.00
discount       = 24.00
total          = 246.00
cost           = 150.00
profit         = 96.00
margin         = 39.02%
```

Formula:

```text
profit = total_amount - total_cost

profit_margin =
    profit / total_amount × 100
```

If total amount is zero, profit margin must not divide by zero.

---

# 49. `expenses`

```text
expenses
--------------------------------
id
name
category
amount
expense_date
notes
created_at
updated_at
```

Example:

```text
name: Electricity
category: Utilities
amount: 2500.00
expense_date: 2026-09-02
```

---

# 50. Money Precision

Money must use integer minor units (centavos) in SQLite and Dart.

Use:

```text
INTEGER
```

for:

```text
selling_price
cost_per_unit
subtotal
discount_amount
total_amount
total_cost
profit
amount
```

For example, PHP 125.50 is stored as `12550`. Do not use SQLite `REAL`, Dart
`double`, or decimal-looking SQLite declarations for persisted money. Percentage
calculations use integer/rational arithmetic and the confirmed line-level
half-up rounding rule.

---

# 51. IDs

All entities should use application-generated IDs.

Recommended:

```text
TEXT UUID
```

or another consistent application-generated identifier.

Do not mix multiple ID-generation strategies.

Every table should have:

```text
id
```

as its primary key.

---

# 52. Timestamps

Tables containing mutable or historical records should use:

```text
created_at
updated_at
```

Transaction completion should additionally use:

```text
completed_at
```

Expenses should use:

```text
expense_date
```

Reports should use the appropriate business date/time fields rather than relying only on the current timestamp.

---

# 53. Product Deactivation

Products with historical sales must not be physically deleted.

Instead:

```text
is_active = false
```

An inactive product:

- Does not appear in the POS
- Cannot be newly sold
- Remains available in historical sales
- Remains available in reports

The same principle applies to inventory items.

---

# 54. Foreign Keys

Foreign keys must be enforced.

Relationships:

```text
products.inventory_item_id
    → inventory_items.id

discount_products.discount_id
    → discounts.id

discount_products.product_id
    → products.id

sale_items.sale_id
    → sales.id

sale_items.product_id
    → products.id

inventory_movements.inventory_item_id
    → inventory_items.id
```

Do not use cascading deletes that can destroy historical transaction data.

---

# 55. Unique Constraints

Recommended:

```text
products.id
inventory_items.id
discounts.id
sales.id
expenses.id
```

must be unique.

Also:

```text
sales.transaction_number
```

must be unique.

For selected discount products:

```text
UNIQUE(discount_id, product_id)
```

This prevents the same product from being attached to the same discount multiple times.

---

# 56. Recommended Indexes

```text
products:
    is_active
    inventory_item_id

inventory_items:
    is_active
    stock_quantity

inventory_movements:
    inventory_item_id
    created_at
    reference_id

discounts:
    is_active

discount_products:
    discount_id
    product_id

sales:
    transaction_number
    status
    completed_at
    payment_method

sale_items:
    sale_id
    product_id

expenses:
    expense_date
    category
```

---

# 57. Dashboard Data

Do not create a separate dashboard table containing duplicated totals.

Calculate dashboard values from completed sales.

Examples:

```text
Today's Sales
SUM(sales.total_amount)
```

```text
Today's Cost
SUM(sales.total_cost)
```

```text
Today's Profit
SUM(sales.profit)
```

```text
Today's Orders
COUNT(sales.id)
```

This prevents duplicate sources of truth.

---

# 58. Low Stock

A product is considered low stock when:

```text
stock_quantity <= low_stock_threshold
```

Example:

```text
Stock = 2
Threshold = 5
```

Status:

```text
LOW STOCK
```

If:

```text
Stock = -2
```

show:

```text
NEGATIVE STOCK
```

or an equivalent strong warning.

The product remains sellable.

---

# 59. Core Database Relationship

```text
PRODUCT
   │
   └── INVENTORY ITEM
          │
          └── INVENTORY MOVEMENTS


PRODUCT
   │
   └── SALE ITEM
          │
          └── SALE


DISCOUNT
   │
   └── DISCOUNT PRODUCTS
          │
          └── PRODUCT
```

---

# 60. Complete Sale Transaction

Every checkout must execute as one database transaction.

Conceptually:

```text
BEGIN TRANSACTION

1. Validate cart

2. Validate payment method

3. Load products

4. Load linked inventory

5. Load active discount

6. Determine effective prices

7. Calculate:
   - subtotal
   - discount
   - total
   - cost
   - profit
   - margin

8. Create sales record

9. Create sale_items

10. Deduct inventory

11. Create inventory_movements

12. Commit

If anything fails:
ROLLBACK
```

This prevents inconsistent states such as:

```text
Sale recorded
BUT inventory not deducted
```

or:

```text
Inventory deducted
BUT sale not recorded
```

---

# 61. Checkout Service

Sale processing should be centralized in a dedicated checkout/business service.

Do not scatter business logic across UI screens.

Architecture:

```text
POS UI
   ↓
Checkout Service
   ↓
Database Transaction
   ├── Sales
   ├── Sale Items
   ├── Inventory Deduction
   └── Inventory Movements
```

The UI collects user input.

The service performs the business logic.

---

# 62. Checkout Service Responsibilities

Conceptually:

```text
completeSale(cart, paymentMethod)
```

Responsibilities:

1. Verify cart is not empty.
2. Validate payment method.
3. Load products.
4. Load inventory.
5. Load active discount.
6. Determine applicable discount.
7. Calculate effective prices.
8. Calculate subtotal.
9. Calculate discount.
10. Calculate total.
11. Calculate product cost.
12. Calculate profit.
13. Calculate margin.
14. Create sale.
15. Create sale items.
16. Deduct inventory.
17. Create inventory movements.
18. Commit transaction.
19. Return completed sale.

Receipt printing happens after successful completion.

---

# 63. Checkout Example

Initial:

```text
Sisig Meal
Stock: 10
Cost: ₱65
Selling Price: ₱120

Coke
Stock: 20
Cost: ₱20
Selling Price: ₱30
```

Active discount:

```text
10% OFF
Selected Products
Sisig Meal
```

Customer buys:

```text
2 Sisig Meal
1 Coke
```

Base subtotal:

```text
Sisig Meal:
2 × ₱120 = ₱240

Coke:
1 × ₱30 = ₱30

Subtotal = ₱270
```

Discount:

```text
₱240 × 10% = ₱24
```

Final:

```text
Subtotal = ₱270
Discount = ₱24
Total = ₱246
```

Cost:

```text
Sisig:
2 × ₱65 = ₱130

Coke:
1 × ₱20 = ₱20

Total Cost = ₱150
```

Profit:

```text
₱246 - ₱150 = ₱96
```

Margin:

```text
₱96 ÷ ₱246 × 100 = 39.02%
```

Inventory:

```text
Sisig: 10 → 8
Coke: 20 → 19
```

---

# 64. UI Screens

Keep the MVP small.

Recommended screens:

```text
1. POS
2. Products
3. Inventory
4. Sales
5. Expenses
6. Reports
7. Settings
```

No login screen, user table, roles, permissions, or cashier-session workflow is
included in the MVP.

---

# 65. POS Screen

The POS is the primary screen.

Conceptually:

```text
┌──────────────────────────────┐
│          SILOGAN POS         │
├──────────────────────────────┤
│ Search products...           │
├──────────────────────────────┤
│                              │
│ [ SISIG ]  [ LONGSILOG ]     │
│                              │
│ [ COKE ]   [ HOTDOG ]        │
│                              │
├──────────────────────────────┤
│ CART                         │
│                              │
│ Sisig Meal       2    ₱216   │
│ Coke             1     ₱30   │
│                              │
│ Subtotal            ₱270    │
│ Discount             ₱24    │
│ TOTAL               ₱246    │
│                              │
│          [ PAY ]             │
└──────────────────────────────┘
```

---

# 66. Payment Screen

Keep it simple.

```text
TOTAL

₱246.00

[ CASH ]

[ GCASH ]
```

Cash:

```text
TOTAL: ₱246

Cash Received:
[ ₱500 ]

Change:
₱254

[ COMPLETE SALE ]
```

GCash:

```text
TOTAL: ₱246

[ COMPLETE SALE ]
```

---

# 67. Product Management

Product creation should be simple.

```text
Product Name
[ Sisig Meal ]

Selling Price
[ ₱120 ]

Inventory
[ Sisig Meal ▼ ]

[ SAVE ]
```

Because the relationship is one-to-one, do not expose unnecessary inventory complexity.

---

# 68. Inventory Management

Example:

```text
Sisig Meal

Stock
10 servings

Cost
₱65.00 / serving

Low Stock
5

[ ADD STOCK ]
[ REMOVE STOCK ]
```

Negative stock should be clearly visible.

---

# 69. Inventory Adjustment UI

Add:

```text
Current Stock: 10

Quantity:
[ 5 ]

[ ADD STOCK ]
```

Result:

```text
10 → 15
```

Remove:

```text
Current Stock: 10

Quantity:
[ 3 ]

[ REMOVE STOCK ]
```

Result:

```text
10 → 7
```

No reason field is required.

---

# 70. Reports Structure

Avoid a huge analytics module.

Use three simple areas:

### Sales

```text
Today
This Week
This Month
```

### Products

```text
Best Selling
Highest Revenue
Highest Profit
```

### Expenses

```text
Total Expenses
By Category
```

---

# 71. Recommended Implementation Order

## Phase 1 — Database

Build:

```text
settings
products
inventory_items
inventory_movements
discounts
discount_products
sales
sale_items
expenses
```

Then implement:

```text
Products
Inventory
```

---

## Phase 2 — POS

Implement:

```text
Product Selection
Cart
Quantity
Pricing
Discount Calculation
```

---

## Phase 3 — Checkout

Implement:

```text
Payment
Sale Creation
Sale Items
Inventory Deduction
Inventory Movements
```

All inside one database transaction.

---

## Phase 4 — Financial Calculations

Implement:

```text
Product Cost
Gross Profit
Profit Margin
```

---

## Phase 5 — Receipt

Implement:

```text
Bluetooth Printer
Receipt Formatting
Print After Successful Sale
```

---

## Phase 6 — Dashboard & Reports

Implement:

```text
Dashboard
Sales Reports
Product Reports
Low Stock
Expenses
```

---

# 72. Critical Implementation Rules

### Rule 1 — Product price is immutable during discount

Never update product price just because a discount is active.

### Rule 2 — Inventory has one source of truth

Stock exists in `inventory_items.stock_quantity`.

Do not duplicate stock in `products`.

### Rule 3 — Historical sales are immutable

Never recalculate old sale records using current product settings.

### Rule 4 — Checkout is atomic

Sale creation and inventory deduction must happen in the same database transaction.

### Rule 5 — Printing is not part of checkout transaction

The sale succeeds even when the printer fails.

### Rule 6 — Negative stock is valid

Never block a sale because stock is zero or negative.

### Rule 7 — Discount is calculated, never manually overridden

The configured percentage is authoritative.

### Rule 8 — Product cost and expenses are separate

Product cost contributes to gross profit.

Operating expenses are deducted afterward to calculate net profit.

---

# 73. Explicit MVP Non-Goals

## Inventory

- Ingredient inventory
- Recipe management
- BOM
- Manufacturing
- Supplier management
- Purchase orders
- Receiving workflows
- Batch management
- Expiration tracking

## Users

- Multiple users
- Staff accounts
- Roles
- Permissions
- Manager approvals

## Sales

- Refunds
- Exchanges
- Customer accounts
- Loyalty
- Credit/utang
- Split payments

## Payments

- Maya
- Bank transfer
- Cards
- Payment gateways
- Online payment verification

## Infrastructure

- Cloud synchronization
- Multi-device synchronization
- Multi-branch support
- Cloud dependency

## Business

- Ecommerce
- Online ordering
- Delivery management
- AI assistant
- Advanced forecasting

## Accounting

- Full accounting
- General ledger
- Accounts payable
- Accounts receivable
- Tax accounting
- Complex financial workflows

---

# 74. Acceptance Criteria

## POS

- [ ] Owner can open POS offline.
- [ ] Owner can select products.
- [ ] Owner can change quantities.
- [ ] Owner can review cart.
- [ ] Owner can see discounts.
- [ ] Owner can see final total.
- [ ] Owner can select Cash.
- [ ] Owner can select GCash.
- [ ] Owner can complete sale offline.
- [ ] Completed sales are stored locally.

## Inventory

- [ ] Product is linked to inventory.
- [ ] Sale automatically deducts inventory.
- [ ] Deduction matches quantity sold.
- [ ] Inventory can become negative.
- [ ] Negative inventory does not block sales.
- [ ] Owner can add stock.
- [ ] Owner can remove stock.
- [ ] Inventory quantities are whole numbers.
- [ ] Inventory movements are recorded.

## Cost and Profit

- [ ] Owner can define cost per inventory item.
- [ ] Product cost is calculated automatically.
- [ ] Profit is calculated automatically.
- [ ] Profit margin is calculated automatically.
- [ ] Discounted sales use actual selling price.
- [ ] Multiple quantities calculate correctly.

## Discounts

- [ ] Owner can enable discount.
- [ ] Owner can disable discount.
- [ ] Only one discount can be active.
- [ ] Discount can target all products.
- [ ] Discount can target selected products.
- [ ] Percentage can be configured.
- [ ] Selected products automatically receive discount.
- [ ] Newly added selected products receive active discount.
- [ ] Base price remains unchanged.
- [ ] Effective price is calculated automatically.
- [ ] Manual discount override is impossible.
- [ ] Discount status is clearly visible.

## Payments

- [ ] Cash works offline.
- [ ] GCash works offline.
- [ ] Payment method is stored.
- [ ] Split payment is not required.

## Receipt

- [ ] Receipt can be printed.
- [ ] Bluetooth thermal printer is supported.
- [ ] Receipt contains business name.
- [ ] Receipt contains date/time.
- [ ] Receipt contains transaction number.
- [ ] Receipt contains products.
- [ ] Receipt contains quantities.
- [ ] Receipt contains prices.
- [ ] Receipt contains discounts.
- [ ] Receipt contains total.
- [ ] Receipt contains payment method.
- [ ] Sale remains successful if printer is unavailable.

## Dashboard and Reports

- [ ] Today's sales are displayed.
- [ ] Today's product cost is displayed.
- [ ] Today's profit is displayed.
- [ ] Today's profit margin is available.
- [ ] Today's order count is displayed.
- [ ] Low-stock products are visible.
- [ ] Product sales are available.
- [ ] Product profit is available.
- [ ] Reports match completed sales.

## Offline

- [ ] POS works without internet.
- [ ] Sales work without internet.
- [ ] Inventory works without internet.
- [ ] Discounts work without internet.
- [ ] Cost/profit calculations work without internet.
- [ ] Reports work without internet.
- [ ] No cloud service is required.

## Backup and Restore

- [ ] Owner can export a local backup without internet.
- [ ] Owner can restore a valid JmPOS backup without internet.
- [ ] Invalid or incompatible files are rejected before the active database is changed.
- [ ] Restore preserves the previous usable database if replacement fails.

---

# 75. Definition of Done

The MVP is complete when the owner can perform this entire workflow without internet:

```text
Create Product
      ↓
Set Price
      ↓
Link Inventory
      ↓
Set Stock
      ↓
Set Cost
      ↓
Open POS
      ↓
Select Product
      ↓
Add Quantity
      ↓
Active Discount Applied Automatically
      ↓
Review Total
      ↓
Select Cash / GCash
      ↓
Complete Sale
      ↓
Inventory Automatically Deducted
      ↓
Cost Automatically Calculated
      ↓
Profit Automatically Calculated
      ↓
Sale Stored Locally
      ↓
Receipt Printed
      ↓
Dashboard Updated
```

The owner should be able to complete a normal transaction without manually performing calculations.

---

# 76. Product Philosophy

The POS should not try to become a large ERP system.

The product is designed around the actual daily workflow of a small silogan.

Guiding principle:

> **Make the cashier's job extremely simple while making the system's calculations extremely reliable.**

The owner should think:

```text
"What does the customer want?"
```

The system should handle:

```text
"How much?"
"How much did it cost?"
"How much stock was used?"
"How much profit was made?"
"How much discount was applied?"
"What should appear on the receipt?"
```

The interface should remain simple even when the underlying calculations are automatic and precise.

---

# 77. Final MVP Table List

The MVP database is intentionally limited to these nine tables:

```text
1. settings
2. products
3. inventory_items
4. inventory_movements
5. discounts
6. discount_products
7. sales
8. sale_items
9. expenses
```

Do not add additional domain tables unless a confirmed requirement requires them.

The architecture is intentionally small while still providing:

- Reliable sales history
- Inventory traceability
- Automatic costing
- Automatic profit calculation
- Controlled discounts
- Offline operation
- Basic financial reporting
- Bluetooth receipt printing

---

# 78. Final Architecture

```text
                 ┌─────────────┐
                 │    POS UI   │
                 └──────┬──────┘
                        ↓
               ┌─────────────────┐
               │ Checkout Service│
               └────────┬────────┘
                        ↓
               ┌─────────────────┐
               │  SQLite Local DB│
               └────────┬────────┘
                        │
        ┌───────────────┼────────────────┐
        ↓               ↓                ↓
    PRODUCTS        INVENTORY          SALES
        │               │                │
        ↓               ↓                ↓
   DISCOUNTS       MOVEMENTS        SALE ITEMS
                                         │
                                         ↓
                                     REPORTS

SALE COMPLETED
      ↓
THERMAL PRINTER
```

This architecture is the baseline technical specification for the Silogan POS MVP.
