import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ssm_app.dart';

void main() {
  initializeBlocs();
  // runApp(MobXApp());
  runApp(ProviderScope(child: MyApp()));
}
