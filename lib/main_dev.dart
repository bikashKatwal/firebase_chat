import 'package:flutter/material.dart';
import 'resources/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
      child: MyApp(),
      appTitle: "Flutter Flavors Dev",
      buildFlavor: "Development");
  return runApp(configuredApp);
}
