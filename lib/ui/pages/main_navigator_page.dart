import 'package:atym_flutter_app/cubits/heroes_cubit.dart';
import 'package:atym_flutter_app/ui/widgets/connectivity_notification_view.dart';
import 'package:atym_flutter_app/ui/widgets/counter_view.dart';
import 'package:atym_flutter_app/ui/widgets/heroes_view.dart';
import 'package:atym_flutter_app/ui/widgets/language_switcher_icon_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainNavigatorPage extends StatefulWidget {
  const MainNavigatorPage({Key? key}) : super(key: key);

  @override
  State<MainNavigatorPage> createState() => _MainNavigatorPageState();
}

class _MainNavigatorPageState extends State<MainNavigatorPage> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = const [
      CounterView(),
      HeroesView(),
    ];
    super.initState();
  }

  void _onItemTapped({
    required BuildContext context,
    required int index,
  }) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        context.read<HeroesCubit>().getHeroes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).viewChooser),
        actions: [LanguageSwitcherIconView()],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomSheet: ConnectivityNotificationView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: AppLocalizations.of(context).counterView,
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: AppLocalizations.of(context).heroesView,
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellowAccent,
        onTap: (index) => _onItemTapped(
          context: context,
          index: index,
        ),
      ),
    );
  }
}
