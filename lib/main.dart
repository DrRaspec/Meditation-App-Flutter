import 'package:flutter/material.dart';
import 'package:flutter_adaptive_kit/flutter_adaptive_kit.dart';
import 'package:meditation_app/app.dart';
import 'package:meditation_app/core/di/app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppDependencies();
  final router = buildAppRouter();

  runApp(
    AdaptiveScope(
      designSize: const DesignSize(
        phone: Size(375, 812),
        tablet: Size(768, 1024),
        desktop: Size(1440, 900),
      ),
      child: MyApp(router: router),
    ),
  );
}
