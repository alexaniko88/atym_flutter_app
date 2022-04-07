import 'package:atym_flutter_app/core/simple_bloc_delegate.dart';
import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/cubits/counter_cubit.dart';
import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/l10n/locales.dart';
import 'package:atym_flutter_app/provider_setup.dart';
import 'package:atym_flutter_app/ui/pages/main_navigator_page.dart';
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
          providers: providers,
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ConnectivityWrapperCubit()..setConnectivityListener(),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => HeroesCubit(context.read()),
        ),
      ],
      child: GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Get.locale,
        home: MainNavigatorPage(),
      ),
    );
  }
}
