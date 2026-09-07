import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_provider.dart';
import '../data/catalog_repository.dart';
import '../domain/catalog_item.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.watch(appDatabaseProvider));
});

final activeCatalogProvider = StreamProvider<List<CatalogItem>>((ref) {
  return ref.watch(catalogRepositoryProvider).watchCatalog();
});

final productInclusionsProvider = FutureProvider.family(
  (ref, String productId) =>
      ref.watch(catalogRepositoryProvider).getProductInclusions(productId),
);
