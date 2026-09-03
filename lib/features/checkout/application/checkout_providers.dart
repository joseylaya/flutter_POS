import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_provider.dart';
import 'checkout_service.dart';

final checkoutServiceProvider = Provider<CheckoutService>((ref) {
  return CheckoutService(ref.watch(appDatabaseProvider));
});
