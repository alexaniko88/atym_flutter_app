# atym_flutter_app

A new Flutter project.

###In trouble?
flutter clean
flutter pub cache repair

##Useful commands

###Tests
flutter test --update-goldens test/widgets/pages/counter_page_test.dart (any path goes instead)
flutter drive --driver=test_driver/integration_driver.dart --target=integration_test/path (any path goes instead)

###Git
git checkout stable

###Code metrics
flutter pub run dart_code_metrics:metrics lib --reporter=html
flutter pub run dart_code_metrics:metrics analyze lib

##Useful info

###Testing Endpoints
https://akabab.github.io/superhero-api/api/all.json
