# Silogan POS — Project Definition

## 1. Project Overview

**Silogan POS** is a simple, offline-first Point-of-Sale system designed specifically for a small silogan/food business.

The system is designed around one principle:

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

The core workflow is:

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

All of these must be handled automatically by the system.

---

# 3. User Scope

The MVP supports exactly **one user**.

The user is both:

- Owner
- Cashier

There are no roles or permissions in the MVP.

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

- One Android tablet
- One POS installation
- One local database
- One Bluetooth thermal printer

The system does not require a server or cloud backend for normal operation.

---

# 5. Offline Architecture

The POS must work **100% offline**.

The local database is the source of truth.

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
- Printer connection

There must be no dependency on an API or cloud server for normal POS operation.

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

Each POS product must have exactly **one linked inventory item**.

Relationship:

```text
PRODUCT
   │
   ├── Selling Price
   │
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

For example, the system does not need:

```text
Eggs
Rice
Oil
Garlic
Pork
Soy Sauce
```

The inventory system only tracks what can actually be sold through the POS.

---

# 8. Inventory Fields

Each inventory item should contain:

- Name
- Stock Quantity
- Unit
- Cost Per Unit
- Low Stock Threshold
- Active/Inactive Status

Example:

```text
Name: Sisig Meal
Stock: 10
Unit: serving
Cost: ₱65
Low Stock Threshold: 5
Status: Active
```

---

# 9. Inventory Quantity Rules

Inventory quantities must use **whole numbers only**.

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

This is because the POS is tracking sellable units such as:

- servings
- bottles
- pieces
- cups

---

# 10. Automatic Inventory Deduction

When a sale is completed, the system automatically deducts the quantity sold.

Example:

```text
Before Sale

Sisig Meal = 10
```

Customer buys:

```text
2 Sisig Meal
```

After sale:

```text
Sisig Meal = 8
```

The cashier does not manually modify inventory.

---

# 11. Negative Inventory

Negative inventory is allowed.

If:

```text
Stock = 0
```

and the owner sells:

```text
Quantity = 1
```

the resulting inventory is:

```text
Stock = -1
```

The sale must NOT be blocked.

Negative inventory should be clearly visible in the inventory screen.

Example:

```text
Sisig Meal
Stock: -2
```

This indicates that recorded sales have exceeded the currently recorded stock.

---

# 12. Manual Inventory Adjustments

The owner can manually modify inventory through:

- Add Stock
- Remove Stock

No reason is required in the MVP.

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

Inventory adjustments are separate from sales.

---

# 13. Product Cost

Each inventory item has a manually entered cost.

Example:

```text
Sisig Meal

Selling Price: ₱120
Cost: ₱65
Stock: 10
```

The MVP does not calculate cost from ingredients.

There is no:

- Recipe
- BOM
- Ingredient costing
- Supplier costing
- Purchase-order costing

---

# 14. Sales Calculation

For every sale, the system records:

- Product
- Quantity
- Actual selling price
- Product cost
- Total sales
- Total cost
- Profit

### Formula

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
```

Calculation:

```text
Sales = ₱120 × 5
      = ₱600

Cost = ₱65 × 5
     = ₱325

Profit = ₱600 - ₱325
       = ₱275

Profit Margin = ₱275 ÷ ₱600 × 100
              = 45.83%
```

---

# 15. Discount System

The MVP supports exactly **one active percentage discount at a time**.

The discount can be:

- ON
- OFF

When enabling a discount, the owner chooses:

```text
All Products
```

or:

```text
Selected Products Only
```

The owner then specifies the percentage.

Example:

```text
Discount: 10%
Scope: Selected Products
Products:
- Sisig Meal
- Longsilog
```

---

# 16. Discount Persistence

Once enabled, the discount remains active until the owner:

- Disables it
- Changes it

The discount is not limited to the current cart.

If a selected product is added to a new cart while the discount is active, the discount automatically applies.

---

# 17. Discount Price Rules

The original product price must **never be overwritten**.

Example:

```text
Base Price: ₱120
Discount: 10%
Effective Price: ₱108
```

The system calculates:

```text
Effective Price = Base Price - Discount
```

or:

```text
Effective Price = Base Price × (1 - Discount Percentage)
```

When the discount is disabled:

```text
Base Price: ₱120
Effective Price: ₱120
```

The original price remains unchanged.

---

# 18. Manual Discount Override

Manual discounted prices are NOT allowed.

For example, if:

```text
Base Price = ₱120
Discount = 10%
```

the system must always calculate:

```text
₱108
```

The owner cannot manually change this to:

```text
₱105
```

The discount rule must remain consistent.

---

# 19. Discount and Profit

Profit must use the **actual discounted selling price**.

Example:

```text
Base Price: ₱120
Cost: ₱65
Discount: 10%
```

Effective selling price:

```text
₱108
```

Profit:

```text
₱108 - ₱65
= ₱43
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

# 20. Discount Display

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

The UI should make the effective selling price obvious.

---

# 21. Cart and Checkout

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

Subtotal      ₱240
Discount      -₱24
----------------
TOTAL         ₱216
```

---

# 22. Completed Sales

When the owner presses PAY and successfully completes payment, the transaction becomes a completed sale.

Completed sales must not be freely editable.

The system should preserve the original transaction data for reporting and traceability.

---

# 23. Refunds

Refund functionality is **not included in the MVP**.

The business is primarily selling prepared food, so full refund, partial refund, return, and exchange workflows are intentionally excluded.

If inventory needs correction, the owner can use:

```text
Add Stock
Remove Stock
```

---

# 24. Payment Methods

The MVP supports exactly two payment methods:

```text
Cash
GCash
```

GCash is simply recorded as the payment method.

The MVP does not require online GCash verification or payment gateway integration.

---

# 25. Payment Rules

Each completed sale must store its payment method.

Example:

```text
Transaction #000123

Total: ₱246

Payment:
GCash
```

No split payments are supported.

Not included:

- Maya
- Bank transfer
- Credit/utang
- Card
- Split payment
- Multiple payment combinations

---

# 26. Receipt Printing

The POS must support Bluetooth thermal receipt printing.

A completed sale should be printable immediately after checkout.

The receipt should contain at minimum:

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

Subtotal            ₱240
Discount            -₱24
TOTAL               ₱216

Payment: GCash
```

The exact receipt layout may be adjusted based on the selected thermal printer width.

---

# 27. Dashboard

The dashboard must remain simple.

It should prioritize information that the owner actually needs.

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

The dashboard should not be overloaded with unnecessary charts.

---

# 28. Sales Reports

The system should provide basic sales reporting.

Minimum reporting requirements:

- Total sales
- Total product cost
- Total profit
- Profit margin
- Number of orders
- Quantity sold
- Product sales
- Product profitability

The owner should be able to understand:

```text
What sold?
How many sold?
How much did I make?
How much did it cost?
How much profit did I make?
```

---

# 29. Expenses

Basic operating expenses may be recorded separately from product costs.

Examples:

- Rent
- Electricity
- Water
- Supplies
- Other business expenses

Product cost and operating expenses must remain separate.

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

The MVP does not attempt to become a full accounting system.

---

# 30. Core Data Relationship

The primary relationship is:

```text
PRODUCT
   │
   ├── Selling Price
   │
   └── INVENTORY
          │
          ├── Stock
          ├── Unit
          ├── Cost
          └── Low Stock Threshold
```

When a sale happens:

```text
PRODUCT
   ↓
SALE
   ↓
INVENTORY DEDUCTION
   ↓
PRODUCT COST
   ↓
PROFIT
```

---

# 31. End-to-End Example

Initial inventory:

```text
Sisig Meal
Stock: 10 servings
Cost: ₱65
Selling Price: ₱120

Coke
Stock: 20 bottles
Cost: ₱20
Selling Price: ₱30
```

Owner activates:

```text
10% OFF
Selected Products
```

Selected:

```text
Sisig Meal
```

Customer buys:

```text
2 Sisig Meal
1 Coke
```

The POS calculates:

```text
Sisig Meal
2 × ₱108 = ₱216

Coke
1 × ₱30 = ₱30

TOTAL = ₱246
```

Inventory becomes:

```text
Sisig Meal
10 → 8

Coke
20 → 19
```

Product cost:

```text
Sisig Meal
2 × ₱65 = ₱130

Coke
1 × ₱20 = ₱20

TOTAL COST = ₱150
```

Profit:

```text
₱246 - ₱150
= ₱96
```

The completed sale stores:

```text
Sales: ₱246
Cost: ₱150
Profit: ₱96
Payment: Cash or GCash
```

---

# 32. Business Rules

The following rules are mandatory for the MVP:

1. The system supports one user.
2. The owner is the cashier.
3. One product links to one inventory item.
4. Inventory represents sellable products/servings.
5. Ingredient-level inventory is not supported.
6. Inventory quantities are whole numbers.
7. Selling automatically deducts inventory.
8. Inventory is allowed to become negative.
9. Negative inventory does not block sales.
10. Cost is manually entered per inventory item.
11. Product cost is calculated automatically.
12. Profit is calculated automatically.
13. Profit margin is calculated automatically.
14. Profit uses the actual selling price.
15. Only one percentage discount can be active at a time.
16. Discount can apply to all products or selected products.
17. Discount remains active until disabled or changed.
18. Base product prices are never overwritten.
19. Effective discounted prices are calculated automatically.
20. Manual discounted-price overrides are not allowed.
21. Completed sales are not freely editable.
22. Refunds are not supported in the MVP.
23. Payment methods are Cash and GCash only.
24. GCash is stored as a payment method only.
25. Inventory can be manually added or removed.
26. Inventory adjustments do not require a reason.
27. Product costs and operating expenses are separate.
28. The POS must work offline.
29. The local database is the source of truth.
30. The MVP supports one device.
31. Bluetooth thermal printing is supported.
32. Reports must use stored transaction data.
33. The cashier should not manually calculate sales, cost, profit, or discounts.

---

# 33. Acceptance Criteria

## POS

- [ ] Owner can open the POS offline.
- [ ] Owner can select products.
- [ ] Owner can change quantities.
- [ ] Owner can review the cart.
- [ ] Owner can see discounts applied.
- [ ] Owner can see the final total.
- [ ] Owner can select Cash.
- [ ] Owner can select GCash.
- [ ] Owner can complete a sale offline.
- [ ] Completed sales are stored locally.

## Inventory

- [ ] Products are linked to inventory.
- [ ] Selling automatically deducts inventory.
- [ ] Deduction follows the quantity sold.
- [ ] Inventory can become negative.
- [ ] Negative inventory does not block sales.
- [ ] Owner can add stock.
- [ ] Owner can remove stock.
- [ ] Inventory quantities are whole numbers.

## Cost and Profit

- [ ] Owner can define cost per inventory item.
- [ ] System calculates product cost automatically.
- [ ] System calculates profit automatically.
- [ ] System calculates profit margin automatically.
- [ ] Discounted sales use the actual discounted selling price.
- [ ] Profit calculation remains correct for multiple quantities.

## Discounts

- [ ] Owner can enable a discount.
- [ ] Owner can disable a discount.
- [ ] Only one discount can be active.
- [ ] Discount can target all products.
- [ ] Discount can target selected products.
- [ ] Owner can specify the percentage.
- [ ] Selected products automatically receive the discount.
- [ ] Newly added selected products receive the active discount.
- [ ] Base product prices remain unchanged.
- [ ] Effective prices are calculated automatically.
- [ ] Manual discount overrides are not possible.
- [ ] Discount status is clearly visible.

## Payments

- [ ] Cash payment works offline.
- [ ] GCash payment works offline.
- [ ] Payment method is stored with the sale.
- [ ] Split payments are not required.

## Receipt

- [ ] Sale receipt can be printed.
- [ ] Bluetooth thermal printer is supported.
- [ ] Receipt contains business name.
- [ ] Receipt contains date/time.
- [ ] Receipt contains transaction number.
- [ ] Receipt contains products.
- [ ] Receipt contains quantities.
- [ ] Receipt contains prices.
- [ ] Receipt contains discount.
- [ ] Receipt contains total.
- [ ] Receipt contains payment method.

## Dashboard and Reports

- [ ] Today's sales are displayed.
- [ ] Today's product cost is displayed.
- [ ] Today's profit is displayed.
- [ ] Today's profit margin is calculated.
- [ ] Today's order count is displayed.
- [ ] Low-stock products are visible.
- [ ] Product sales can be viewed.
- [ ] Product profit can be viewed.
- [ ] Report totals match completed sales.

## Offline

- [ ] POS works without internet.
- [ ] Sales work without internet.
- [ ] Inventory works without internet.
- [ ] Discounts work without internet.
- [ ] Cost/profit calculations work without internet.
- [ ] Reports work without internet.
- [ ] No cloud service is required for normal operation.

---

# 34. Explicit MVP Non-Goals

The following must NOT be added to the MVP unless the project scope is intentionally changed.

### Inventory

- Ingredient inventory
- Recipe management
- BOM
- Manufacturing
- Supplier management
- Purchase orders
- Receiving workflows
- Batch management
- Expiration tracking

### Users

- Multiple users
- Staff accounts
- Roles
- Permissions
- Manager approvals

### Sales

- Refunds
- Exchanges
- Customer accounts
- Loyalty
- Credit/utang
- Split payments

### Payments

- Maya
- Bank transfer
- Cards
- Payment gateways
- Online payment verification

### Infrastructure

- Cloud synchronization
- Multi-device synchronization
- Multi-branch support
- Online backend requirement

### Business

- Ecommerce
- Online ordering
- Delivery management
- AI assistant
- Advanced forecasting

### Accounting

- Full accounting
- General ledger
- Accounts payable
- Accounts receivable
- Tax accounting
- Complex financial workflows

---

# 35. Definition of Done

The MVP is considered complete when the owner can perform this entire workflow without internet:

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
Apply Active Discount Automatically
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

The owner should be able to complete a normal transaction without manually performing any calculations.

---

# 36. Product Philosophy

The POS should not try to become a large ERP system.

The product should focus on the actual daily workflow of a small silogan.

The guiding principle is:

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