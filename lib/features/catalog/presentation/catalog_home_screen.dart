import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../expenses/presentation/expenses_screen.dart';
import '../../pos/presentation/pos_screen.dart';
import '../../reports/presentation/reports_screen.dart';
import '../../settings/application/settings_providers.dart';
import '../../settings/presentation/settings_screen.dart';
import 'inventory_screen.dart';
import 'products_screen.dart';

class CatalogHomeScreen extends ConsumerStatefulWidget {
  const CatalogHomeScreen({super.key});
  @override
  ConsumerState<CatalogHomeScreen> createState() => _CatalogHomeScreenState();
}

class _CatalogHomeScreenState extends ConsumerState<CatalogHomeScreen> {
  int selected = 0;
  bool menuCollapsed = false;
  static const pages = [
    PosScreen(),
    ProductsScreen(),
    InventoryScreen(),
    ReportsScreen(),
    ExpensesScreen(),
    SettingsScreen(),
  ];
  static const labels = [
    'POS',
    'Products',
    'Inventory',
    'Reports',
    'Expenses',
    'Settings',
  ];
  static const icons = [
    Icons.point_of_sale_rounded,
    Icons.restaurant_menu,
    Icons.inventory_2_outlined,
    Icons.insights_outlined,
    Icons.receipt_long_outlined,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, size) {
      if (size.maxWidth >= 800) {
        return Scaffold(
          body: Row(
            children: [
              _Sidebar(
                selected: selected,
                extended: !menuCollapsed,
                onSelected: (value) => setState(() => selected = value),
                onToggle: () => setState(() => menuCollapsed = !menuCollapsed),
              ),
              VerticalDivider(width: 1, color: Theme.of(context).dividerColor),
              Expanded(child: pages[selected]),
            ],
          ),
        );
      }
      return Scaffold(
        body: pages[selected],
        bottomNavigationBar: NavigationBar(
          height: 70,
          selectedIndex: selected.clamp(0, 4),
          onDestinationSelected: (value) => value == 4
              ? _showMore(context)
              : setState(() => selected = value),
          destinations: [
            for (var i = 0; i < 4; i++)
              NavigationDestination(icon: Icon(icons[i]), label: labels[i]),
            const NavigationDestination(
              icon: Icon(Icons.more_horiz_rounded),
              label: 'More',
            ),
          ],
        ),
      );
    },
  );

  Future<void> _showMore(BuildContext context) async {
    final value = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(icons[4]),
              title: Text(labels[4]),
              onTap: () => Navigator.pop(context, 4),
            ),
            ListTile(
              leading: Icon(icons[5]),
              title: Text(labels[5]),
              onTap: () => Navigator.pop(context, 5),
            ),
          ],
        ),
      ),
    );
    if (value != null) setState(() => selected = value);
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({
    required this.selected,
    required this.extended,
    required this.onSelected,
    required this.onToggle,
  });
  final int selected;
  final bool extended;
  final ValueChanged<int> onSelected;
  final VoidCallback onToggle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).valueOrNull;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: extended ? 240 : 76,
      color: dark ? const Color(0xFF18191E) : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                extended ? 18 : 12,
                18,
                extended ? 18 : 12,
                12,
              ),
              child: Row(
                mainAxisAlignment: extended
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Color(0xFF181000),
                    ),
                  ),
                  if (extended) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'JmPOS',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            settings?.businessName ?? 'Local POS',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (extended)
              Container(
                margin: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: .1),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: .28),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.storage_outlined,
                      size: 18,
                      color: Color(0xFF10B981),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Saved locally',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: extended ? 12 : 8,
                  vertical: 4,
                ),
                children: [
                  for (
                    var i = 0;
                    i < _CatalogHomeScreenState.labels.length;
                    i++
                  )
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Tooltip(
                        message: extended
                            ? ''
                            : _CatalogHomeScreenState.labels[i],
                        child: Material(
                          color: selected == i
                              ? const Color(0xFFF59E0B)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(13),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(13),
                            onTap: () => onSelected(i),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: extended
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                children: [
                                  if (extended) const SizedBox(width: 14),
                                  Icon(
                                    _CatalogHomeScreenState.icons[i],
                                    color: selected == i
                                        ? const Color(0xFF181000)
                                        : null,
                                  ),
                                  if (extended) ...[
                                    const SizedBox(width: 13),
                                    Expanded(
                                      child: Text(
                                        _CatalogHomeScreenState.labels[i],
                                        style: TextStyle(
                                          color: selected == i
                                              ? const Color(0xFF181000)
                                              : null,
                                          fontWeight: selected == i
                                              ? FontWeight.w900
                                              : FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: extended
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (extended)
                    IconButton(
                      tooltip: dark ? 'Use light mode' : 'Use dark mode',
                      onPressed: () => ref
                          .read(settingsRepositoryProvider)
                          .updateThemeMode(dark ? 'LIGHT' : 'DARK'),
                      icon: Icon(
                        dark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                      ),
                    ),
                  IconButton.filledTonal(
                    tooltip: extended ? 'Collapse menu' : 'Expand menu',
                    onPressed: onToggle,
                    icon: const Icon(Icons.menu_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
