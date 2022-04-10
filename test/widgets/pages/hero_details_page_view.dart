import 'package:atym_flutter_app/ui/pages/hero_details_page.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widget_tests_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Locale locale;

  setUpAll(() {
    locale = Locale('en');
  });

  group('HeroesView tests', () {
    testWidgets(
      'pump HeroDetailsPage with green shadows',
      (WidgetTester tester) async {
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: HeroDetailsPage(
              heroViewModel: HeroViewModel(
                imageURL: 'URL',
                name: 'name',
                fullName: 'fullName',
                publisher: 'publisher',
                strength: 100,
                speed: 100,
                power: 100,
                intelligence: 100,
                durability: 100,
                combat: 100,
              ),
            ),
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden('hero_details_page_view_1');
      },
    );

    testWidgets(
      'pump HeroDetailsPage with blue shadows',
          (WidgetTester tester) async {
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: HeroDetailsPage(
              heroViewModel: HeroViewModel(
                imageURL: 'URL',
                name: 'name',
                fullName: 'fullName',
                publisher: 'publisher',
                strength: 70,
                speed: 70,
                power: 70,
                intelligence: 70,
                durability: 70,
                combat: 70,
              ),
            ),
          ),
          useScaffold: true,
        );
        await tester.runAsync(() async {
          await tester.pump(Duration(seconds: 1));
          await tester.pump(Duration(seconds: 1));
        });
        await WidgetTestsHelper.expectGolden('hero_details_page_view_2');
      },
    );

    testWidgets(
      'pump HeroDetailsPage with yellow shadows',
          (WidgetTester tester) async {
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: HeroDetailsPage(
              heroViewModel: HeroViewModel(
                imageURL: 'URL',
                name: 'name',
                fullName: 'fullName',
                publisher: 'publisher',
                strength: 50,
                speed: 50,
                power: 50,
                intelligence: 50,
                durability: 50,
                combat: 50,
              ),
            ),
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden('hero_details_page_view_3');
      },
    );

    testWidgets(
      'pump HeroDetailsPage with orange shadows',
          (WidgetTester tester) async {
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: HeroDetailsPage(
              heroViewModel: HeroViewModel(
                imageURL: 'URL',
                name: 'name',
                fullName: 'fullName',
                publisher: 'publisher',
                strength: 30,
                speed: 30,
                power: 30,
                intelligence: 30,
                durability: 30,
                combat: 30,
              ),
            ),
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden('hero_details_page_view_4');
      },
    );

    testWidgets(
      'pump HeroDetailsPage with red shadows',
          (WidgetTester tester) async {
        await WidgetTestsHelper.testWidget(
          tester,
          Localizations(
            delegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            child: HeroDetailsPage(
              heroViewModel: HeroViewModel(
                imageURL: 'URL',
                name: 'name',
                fullName: 'fullName',
                publisher: 'publisher',
                strength: 10,
                speed: 10,
                power: 10,
                intelligence: 10,
                durability: 10,
                combat: 10,
              ),
            ),
          ),
          useScaffold: true,
        );
        await WidgetTestsHelper.expectGolden('hero_details_page_view_5');
      },
    );
  });
}
