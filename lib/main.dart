import 'package:flutter/material.dart';
import 'package:storage_test/test_run.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TestRun.run();

  runApp(Container());
}