# Silogan POS — Technical Stack

> **Precedence:** `Silogan-POS-Definition.md` is authoritative. This document
> describes the stack; conflicting feature or schema suggestions here are
> superseded by that specification.

## 1. Project Goal

Silogan POS is a **local-first Android Point of Sale application** designed to run on an Android tablet with a thermal printer.

The first version does **not require a cloud backend, API, internet connection, or online database**.

The priority is:

1. Fast cashier operation
2. Fully offline operation
3. Simple architecture
4. Reliable local data storage
5. Easy thermal receipt printing
6. Easy future expansion if cloud sync is needed later

---

# 2. Core Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| Mobile App | **Flutter** | Android POS application |
| Language | **Dart** | Application development |
| Local Database | **SQLite** | Persistent local POS database |
| Database ORM/Toolkit | **Drift** | Type-safe SQLite database layer |
| State Management | **Riverpod** | Application state and dependency management |
| Thermal Printing | **ESC/POS** | Receipt printing |
| Platform | **Android** | POS tablet |
| Source Control | **Git + GitHub** | Version control |

### Primary stack

> **Flutter + Dart + Drift + SQLite + Riverpod + ESC/POS**

---

# 3. Architecture

The application should be **local-first**.

```text
┌──────────────────────────────────┐
│          ANDROID TABLET          │
│                                  │
│  ┌────────────────────────────┐  │
│  │       Flutter UI           │  │
│  └──────────────┬─────────────┘  │
│                 │                │
│  ┌──────────────▼─────────────┐  │
│  │      Application Logic     │  │
│  │      + Riverpod            │  │
│  └──────────────┬─────────────┘  │
│                 │                │
│  ┌──────────────▼─────────────┐  │
│  │          Drift             │  │
│  │   Type-safe DB Access      │  │
│  └──────────────┬─────────────┘  │
│                 │                │
│  ┌──────────────▼─────────────┐  │
│  │          SQLite            │  │
│  │      Local Database        │  │
│  └────────────────────────────┘  │
│                                  │
│                 │                │
│                 ▼                │
│          Thermal Printer         │
│             ESC/POS              │
└──────────────────────────────────┘
```

---

# 4. Offline-First Requirement

The POS must **not depend on the internet** for normal operations.

The following must work without internet:

- View products
- Search products
- Create orders
- Modify quantities
- Calculate totals
- Apply configured discounts
- Accept payments
- Complete sales
- Deduct inventory
- Print receipts
- View today's sales
- Basic reports

There should be **no API call required to complete a sale**.

### Example

```text
Cashier selects product
        ↓
Add to cart
        ↓
Calculate total
        ↓
Confirm payment
        ↓
SQLite transaction
        ↓
Inventory updated
        ↓
Receipt printed
        ↓
Sale completed
```

The application should never block a sale because the internet is unavailable.

---

# 5. Database

## SQLite

SQLite is the actual local database stored on the Android device.

It should contain all data required for the POS to operate.

Recommended core tables:

```text
products
inventory_items
inventory_movements

sales
sale_items
discounts
discount_products
expenses

settings
```

Additional tables can be added when a feature requires them.

---

# 6. Drift

Drift is the primary database abstraction layer.

Use Drift instead of scattering raw SQL throughout the application.

```text
Flutter
   ↓
Repositories / Services
   ↓
Drift
   ↓
SQLite
```

Benefits:

- Type-safe queries
- Compile-time query checking
- Generated Dart classes
- Reactive queries
- Easier migrations
- Cleaner database code
- Better maintainability

Database access should be centralized.

UI widgets should **not directly manipulate SQLite**.

---

# 7. Database Rules

## Every important record should have

```text
id
createdAt
updatedAt
```

For example:

```text
Product
----------------
id
name
sellingPriceCentavos
inventoryItemId
isActive
createdAt
updatedAt
```

Use stable IDs rather than relying only on database row order.

## Monetary values

Do not use floating-point values for money.

Use integer minor units for every persisted monetary value.

Example:

```text
₱125.50
```

stored as:

```text
12550
```

where the value represents centavos.

This avoids floating-point rounding problems.

---

# 8. Database Transactions

Sales must be atomic.

Completing a sale should happen inside a database transaction.

Conceptually:

```text
BEGIN TRANSACTION

Create sale
Create sale items
Create payment
Deduct inventory
Create inventory movements

COMMIT
```

If something fails:

```text
ROLLBACK
```

The system must never create a completed sale while failing to update its corresponding inventory records.

---

# 9. Inventory

Inventory should be based on **stock movements**, not only a manually edited quantity.

Example:

```text
Initial Stock
    ↓
+ Purchase
    ↓
- Sale
    ↓
+ Stock Adjustment
    ↓
- Waste
```

Recommended inventory movement types:

```text
purchase
sale
return
adjustment
waste
```

The current inventory quantity can be maintained for fast access, while movements provide traceability.

---

# 10. POS Sale Flow

```text
Product Selection
       ↓
Cart
       ↓
Quantity
       ↓
Discount
       ↓
Order Total
       ↓
Payment
       ↓
Validate Payment
       ↓
Database Transaction
       ↓
Update Inventory
       ↓
Print Receipt
       ↓
Sale Complete
```

The sale should be considered successfully recorded only after the local database transaction succeeds.

---

# 11. Thermal Printer

The POS will use an ESC/POS-compatible thermal printer.

Possible connections:

- Bluetooth
- USB
- Network printer, if needed later

For the initial Android version, prioritize:

> **Bluetooth ESC/POS thermal printing**

The printer service should be isolated from the rest of the application.

```text
POS
 ↓
PrinterService
 ↓
ESC/POS
 ↓
Thermal Printer
```

A printer failure should not corrupt the sale.

Example:

```text
Sale saved successfully
        ↓
Printer attempts receipt
        ↓
Printing fails
        ↓
Show "Receipt failed to print"
        ↓
Allow "Print Again"
```

The sale should remain safely stored in SQLite.

---

# 12. State Management

Use **Riverpod** for application state.

Recommended separation:

```text
UI
 ↓
Provider
 ↓
Controller / Service
 ↓
Repository
 ↓
Drift
 ↓
SQLite
```

Avoid putting business logic directly inside Flutter widgets.

---

# 13. Suggested Project Structure

```text
lib/
│
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── utils/
│   └── services/
│
├── database/
│   ├── app_database.dart
│   ├── tables/
│   ├── daos/
│   └── migrations/
│
├── features/
│   │
│   ├── auth/
│   ├── dashboard/
│   ├── products/
│   ├── inventory/
│   ├── pos/
│   ├── sales/
│   ├── payments/
│   ├── cashier/
│   ├── discounts/
│   ├── expenses/
│   └── reports/
│
├── printing/
│   ├── printer_service.dart
│   └── receipt_builder.dart
│
└── main.dart
```

The exact structure can evolve as the application grows.

---

# 14. UI Principles

The POS is intended for a cashier, not a technical user.

The interface should prioritize:

- Large touch targets
- Large product buttons
- Minimal typing
- Fast product search
- Clear cart
- Clear total
- Large payment buttons
- Minimal navigation
- Clear success/error states
- Fast access to common products

Avoid unnecessary animations and complex interactions that slow down order entry.

---

# 15. Performance Requirements

The POS should feel instant for normal operations.

Important operations should happen locally:

```text
Product search       → SQLite
Cart calculation     → Local memory
Sale creation        → SQLite
Inventory update     → SQLite
Receipt generation   → Local
```

Do not make network requests during the normal checkout process.

---

# 16. Security

Because the database is local:

- Keep sensitive application configuration out of source code.
- Validate all database inputs.
- Avoid exposing the SQLite database through the UI.

Authentication, users, roles, permissions, and cashier sessions are outside the
single-owner MVP.

---

# 17. Backup Strategy

Because there is no cloud backend in the first version, **local backup is important**.

The application should eventually support:

```text
SQLite Database
      ↓
Export Backup
      ↓
Backup File
```

Possible future backup destinations:

- Android storage
- Google Drive
- USB
- Manual file transfer
- Cloud storage

The MVP includes manual local database backup export and restore. Restore must
validate the backup before replacing the active database and must never silently
overwrite the only usable copy.

---

# 18. Future Cloud Expansion

Cloud functionality is intentionally excluded from the first version.

However, the architecture should leave room for it.

Current:

```text
Flutter
   ↓
Drift
   ↓
SQLite
```

Future:

```text
Flutter
   ↓
Drift
   ↓
SQLite
   ↓
Sync Engine
   ↓
API
   ↓
Cloud Database
```

Do not build the API, cloud database, authentication server, or synchronization system until the business actually needs them.

---

# 19. Deployment

The POS should be distributed as an Android APK.

```text
Flutter Build
      ↓
silogan-pos.apk
      ↓
Install on Android Tablet
      ↓
Configure Printer
      ↓
Configure Store
      ↓
Ready to Use
```

No web server is required to run the POS.

No hosting is required.

No domain is required.

No internet connection is required for normal POS operation.

---

# 20. Development Cost

The software stack is free/open-source:

```text
Flutter             → Free
Dart                → Free
Drift               → Free
SQLite               → Free
Riverpod             → Free
Git                   → Free
GitHub                → Free
Android SDK           → Free
```

The main physical costs are:

```text
Android tablet
Thermal printer
Optional barcode scanner
```

---

# 21. MVP Technology Decision

For the first Silogan POS version, use:

> **Flutter + Dart + Drift + SQLite + Riverpod + ESC/POS**

Do **not** introduce:

- Laravel
- Node.js
- REST API
- Cloud database
- Supabase
- Firebase
- AWS
- VPS
- WebSocket
- Cloud synchronization

unless a future requirement actually needs them.

The goal of Version 1 is:

> **A fast, reliable, completely offline Android POS that stores its data locally and prints receipts directly to a thermal printer.**

This keeps the system inexpensive, fast, easy to deploy, and easy to maintain.
