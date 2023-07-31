import 'package:flutter/foundation.dart';

import 'app_database.dart';

@immutable
class FullyRandomTest {
  final UncompletedFullyRandomTest uncompletedFullyRandomTest;
  final Set<String> entries;
  FullyRandomTest(this.uncompletedFullyRandomTest, this.entries);
}
