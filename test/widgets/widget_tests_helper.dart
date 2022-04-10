import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetTestsHelper {
  static bool runGoldenTests = true;

  static Future testWidget(
    WidgetTester tester,
    Widget widget, {
    Widget Function(Widget widget)? optionalWrapper,
    bool useScaffold = true,
  }) async {
    await tester.pumpWidget(
      optionalWrapper != null
          ? optionalWrapper(
              MaterialApp(
                home: useScaffold
                    ? Scaffold(
                        body: widget,
                      )
                    : widget,
                debugShowCheckedModeBanner: false,
              ),
            )
          : MaterialApp(
              home: useScaffold
                  ? Scaffold(
                      body: widget,
                    )
                  : widget,
              debugShowCheckedModeBanner: false,
            ),
    );
  }

  static Future expectGolden(
    String name, {
    Type type = MaterialApp,
  }) async {
    if (runGoldenTests) {
      await expectLater(
        find.byType(type),
        matchesGoldenFile('../golden/$name.png'),
      );
    }
  }
}
