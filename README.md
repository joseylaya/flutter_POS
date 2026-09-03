# JmPOS

JmPOS is an offline-first Android point-of-sale application for a small food
business. Flutter provides the UI, Drift manages the local SQLite database, and
Riverpod provides application state and dependency management.

The authoritative MVP specification is
[`SOT/Silogan-POS-Definition.md`](SOT/Silogan-POS-Definition.md).

## Development

```sh
flutter pub get
flutter pub run build_runner build
flutter analyze
flutter test
```

Generated Drift files are committed so a checkout can be analyzed and tested
without first running code generation. Regenerate them whenever a table changes.

## Current status

- Android Flutter project initialized
- Nine-table Drift schema implemented
- Foreign keys, domain checks, and indexes enabled
- Riverpod database provider implemented
- Database constraint tests passing
- Product/inventory repository implemented
- Atomic product creation and synchronized product/inventory updates
- Traceable stock additions and removals, including negative stock
- Reactive active-catalog provider implemented
- Responsive tablet/mobile navigation shell implemented
- Product create, edit, and deactivate interface implemented
- Inventory status and add/remove stock interface implemented
- Integer-safe Philippine peso parsing and formatting implemented
- POS product grid and cart quantity controls implemented
- All-products and selected-products discount configuration implemented
- Cash and GCash payment flows implemented
- Atomic checkout, sale snapshots, inventory deduction, and numbering implemented
- Debug Android APK build verified
- Today/week/month financial reports and product performance implemented
- Sales history and receipt reprint implemented
- Operating expense recording and net-profit reporting implemented
- Configurable business details, receipt footer, printer, and paper width implemented
- Bluetooth ESC/POS receipt generation for 58 mm and 80 mm printers implemented
- Validated local backup export and safety-copy restore implemented

The software MVP is feature-complete. Final Bluetooth output verification requires
the target Android tablet and physical thermal printer.
