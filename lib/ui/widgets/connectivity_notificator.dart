import 'dart:async';

import 'package:atym_flutter_app/ui/builders/connectivity_wrapper_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _Constants {
  static const Duration animationDuration = Duration(
    milliseconds: 200,
  );
  static const Duration delayedBackOnline = Duration(
    seconds: 3,
  );
  static const Curve curve = Curves.fastOutSlowIn;
  static const double containerHeight = 32;
}

class ConnectivityNotificator extends StatefulWidget {
  ConnectivityNotificator({
    Key? key,
  }) : super(key: key);

  @override
  State<ConnectivityNotificator> createState() =>
      _ConnectivityNotificatorState();
}

class _ConnectivityNotificatorState extends State<ConnectivityNotificator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _height;
  Timer? _reverseAnimationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: _Constants.animationDuration,
      vsync: this,
    );

    double safeBottom = WidgetsBinding.instance?.window.padding.bottom ?? 0;

    _height = Tween<double>(
      begin: 0,
      end: safeBottom <= _Constants.containerHeight
          ? _Constants.containerHeight
          : safeBottom - _Constants.containerHeight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: _Constants.curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _reverseAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapperBuilder(
      listener: (context, isOnline) async =>
          await _doOnConnectivityChange(isOnline),
      builder: (context, isOnline) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => AnimatedContainer(
            duration: _Constants.animationDuration,
            curve: _Constants.curve,
            width: double.maxFinite,
            height: _height.value,
            color: isOnline ? Colors.green : Colors.black,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  isOnline
                      ? AppLocalizations.of(context).youAreBackOnline
                      : AppLocalizations.of(context).youAreOffline,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future _doOnConnectivityChange(bool isOnline) async {
    if (!isOnline) {
      if (_reverseAnimationTimer != null) {
        _reverseAnimationTimer!.cancel();
      }
      try {
        await _controller.forward(from: 0).orCancel;
      } on TickerCanceled {}
    } else {
      _reverseAnimationTimer = Timer(
        _Constants.delayedBackOnline,
        () async => await _cancelTimer(),
      );
    }
  }

  Future _cancelTimer() async {
    try {
      await _controller.reverse(from: 1).orCancel;
    } on TickerCanceled {}
  }
}
