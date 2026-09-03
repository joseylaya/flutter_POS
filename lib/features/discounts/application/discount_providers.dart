import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_provider.dart';
import '../data/discount_repository.dart';
import '../domain/active_discount.dart';

final discountRepositoryProvider = Provider<DiscountRepository>((ref) {
  return DiscountRepository(ref.watch(appDatabaseProvider));
});

final activeDiscountProvider = StreamProvider<ActiveDiscount?>((ref) {
  return ref.watch(discountRepositoryProvider).watchActive();
});
