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
    bool wrapWithAsyncRunner = false,
    bool wrapWithMockNetworkImage = false,
    Function()? doAfterPumpInAsyncMode,
  }) async {
    wrapWithMockNetworkImage
        ? await mockNetworkImagesFor(() async => await _wrapWithAsyncRunner(
              wrapWithAsyncRunner,
              tester,
              widget,
              optionalWrapper,
              useScaffold,
              doAfterPumpInAsyncMode,
            ))
        : await _wrapWithAsyncRunner(
            wrapWithAsyncRunner,
            tester,
            widget,
            optionalWrapper,
            useScaffold,
            doAfterPumpInAsyncMode,
          );
  }

  static Future _wrapWithAsyncRunner(
    bool wrapWithAsyncRunner,
    WidgetTester tester,
    Widget widget,
    Widget Function(Widget widget)? optionalWrapper,
    bool useScaffold,
    Function()? doAfterPumpInAsyncMode,
  ) async {
    return wrapWithAsyncRunner
        ? await tester.runAsync(
            () async {
              await _doPumpWidget(
                tester,
                widget,
                optionalWrapper,
                useScaffold,
              );
              if (doAfterPumpInAsyncMode != null) {
                await doAfterPumpInAsyncMode();
              }
            },
          )
        : await _doPumpWidget(
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

  static Future precacheAssetImages(
    WidgetTester tester, {
    Finder? finder,
    Duration pumpDuration = const Duration(milliseconds: 100),
    bool withPumAndSettle = true,
  }) async {
    if (finder == null) {
      finder = find.byType(Image);
    }
    final size = finder.evaluate().length;
    if (size > 0) {
      for (int i = 0; i < size; i++) {
        Element element = tester.element(finder.at(i));
        Image image = element.widget as Image;
        await precacheImage(image.image, element);
      }
      if (withPumAndSettle) {
        await tester.pumpAndSettle(pumpDuration);
      }
    }
  }

  static Future<dynamic> testSystemBackButtonTap(WidgetTester tester) async {
    final dynamic widgetsAppState = tester.state(
      find.byType(WidgetsApp),
    );
    expect(await widgetsAppState.didPopRoute(), isTrue);
    return widgetsAppState;
  }
}

///Use this when asset is not being rendered, instead of doAfterPumpInAsyncMode
class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final ByteData data = await load(key);
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
