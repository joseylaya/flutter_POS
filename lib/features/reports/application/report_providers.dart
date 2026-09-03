import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/app_database.dart';
import '../../../database/database_provider.dart';
import '../data/reports_repository.dart';

final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  return ReportsRepository(ref.watch(appDatabaseProvider));
});

final salesHistoryProvider = StreamProvider<List<Sale>>((ref) {
  return ref.watch(reportsRepositoryProvider).watchSales();
});

enum ReportPeriod { today, week, month }

(DateTime, DateTime) reportRange(ReportPeriod period, DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  final from = switch (period) {
    ReportPeriod.today => today,
    ReportPeriod.week => today.subtract(Duration(days: today.weekday - 1)),
    ReportPeriod.month => DateTime(now.year, now.month),
  };
  final until = switch (period) {
    ReportPeriod.today => today.add(const Duration(days: 1)),
    ReportPeriod.week => from.add(const Duration(days: 7)),
    ReportPeriod.month => DateTime(now.year, now.month + 1),
  };
  return (from, until);
}

final reportSummaryProvider =
    StreamProvider.family<ReportSummary, ReportPeriod>((ref, period) {
      final (from, until) = reportRange(period, DateTime.now());
      return ref.watch(reportsRepositoryProvider).watchSummary(from, until);
    });

final productPerformanceProvider =
    StreamProvider.family<List<ProductPerformance>, ReportPeriod>((
      ref,
      period,
    ) {
      final (from, until) = reportRange(period, DateTime.now());
      return ref
          .watch(reportsRepositoryProvider)
          .watchProductPerformance(from, until);
    });
