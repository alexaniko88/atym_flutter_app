import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:atym_flutter_app/l10n/locales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSwitcherIcon extends StatelessWidget {
  const LanguageSwitcherIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: () => _showLanguageSwitcher(context),
      icon: Icon(Icons.g_translate),
    );
  }

  Future<void> _showLanguageSwitcher(BuildContext context) {
    late final Locale localeToDisplay;
    late final String textToDisplay;
    if (Get.locale?.languageCode == Locales.english.languageCode) {
      localeToDisplay = Locales.spanish;
      textToDisplay = AppLocalizations.of(context).changeLanguageToSpanish;
    } else {
      localeToDisplay = Locales.english;
      textToDisplay = AppLocalizations.of(context).changeLanguageToEnglish;
    }

    return showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(textToDisplay),
          onPressed: () async => _updateLocale(localeToDisplay),
        ),
      ],
    );
  }

  Future<void> _updateLocale(Locale locale) async {
    await Get.updateLocale(locale);
    Get.back();
  }
}
