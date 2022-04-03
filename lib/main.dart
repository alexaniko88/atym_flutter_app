import 'package:atym_flutter_app/core/simple_bloc_delegate.dart';
import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/l10n/locales.dart';
import 'package:atym_flutter_app/provider_setup.dart';
import 'package:atym_flutter_app/ui/pages/counter_page.dart';
import 'package:atym_flutter_app/ui/pages/heroes_page.dart';
import 'package:atym_flutter_app/ui/widgets/language_switcher_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.locale = Locales.english;
  BlocOverrides.runZoned(
    () {
      runApp(
        MultiProvider(
          providers: providers
            ..add(
              BlocProvider(
                create: (context) => ConnectivityWrapperCubit(),
              ),
            ),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Get.locale,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).pageChooser),
              actions: [LanguageSwitcherIcon()],
            ),
            body: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context).goToCounterPage),
                    onPressed: () => Navigator.push(
                      context,
                      CounterPage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context).goToHeroesPage),
                    onPressed: () => Navigator.push(
                      context,
                      HeroesPage.route(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
