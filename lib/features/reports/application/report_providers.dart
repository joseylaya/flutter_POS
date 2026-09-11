import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_provider.dart';
import '../data/reports_repository.dart';

final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  return ReportsRepository(ref.watch(appDatabaseProvider));
});

final salesHistoryPageProvider = StreamProvider.autoDispose
    .family<
      SaleHistoryPage,
      ({int page, int pageSize, DateTime from, DateTime until})
    >((ref, request) {
      return ref
          .watch(reportsRepositoryProvider)
          .watchSalesPage(
            page: request.page,
            pageSize: request.pageSize,
            from: request.from,
            until: request.until,
          );
    });

typedef ReportRange = ({DateTime from, DateTime until});

final reportSummaryProvider = StreamProvider.autoDispose
    .family<ReportSummary, ReportRange>((ref, range) {
      return ref
          .watch(reportsRepositoryProvider)
          .watchSummary(range.from, range.until);
    });

final productPerformanceProvider = StreamProvider.autoDispose
    .family<List<ProductPerformance>, ReportRange>((ref, range) {
      return ref
          .watch(reportsRepositoryProvider)
          .watchProductPerformance(range.from, range.until);
    });
