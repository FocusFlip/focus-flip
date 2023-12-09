import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ChartSeries {
  final String? year;
  final int? developers;
  final charts.Color? barColor;

  ChartSeries(
      {@required this.year,
      @required this.developers,
      @required this.barColor});
}
