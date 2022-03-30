import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class WidgetTestsHelper {
  static bool runGoldenTests = true;

  static Future testWidget(
    WidgetTester tester,
    Widget widget, {
    Widget Function(Widget widget)? optionalWrapper,
    bool useScaffold = true,
    bool wrapWithMockNetworkImage = false,
    Function()? doAfterPumpInAsyncMode,
  }) async {
    wrapWithMockNetworkImage
        ? await mockNetworkImagesFor(() async => await await _doPumpWidget(
              tester,
              widget,
              optionalWrapper,
              useScaffold,
            ))
        : await await _doPumpWidget(
            tester,
            widget,
            optionalWrapper,
            useScaffold,
          );
  }

  static Future _doPumpWidget(
    WidgetTester tester,
    Widget widget,
    Widget Function(Widget widget)? optionalWrapper,
    bool useScaffold,
  ) async {
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

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final ByteData data = await load(key);
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
