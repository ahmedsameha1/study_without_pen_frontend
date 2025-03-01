import 'package:flutter/foundation.dart';

import 'app_database.dart';

@immutable
class FullyRandomTest {
  final Session session;
  final TestSession testSession;
  final Set<String> entries;
  FullyRandomTest(this.session, this.testSession, this.entries);
}
