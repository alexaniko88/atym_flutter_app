import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/offline_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/wrong_asset_exception.dart';
import 'package:atym_flutter_app/repositories/fake/fake_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockModel {
  final String? name;
  final String? phone;
  final String? address;

  MockModel({
    this.name,
    this.address,
    this.phone,
  });

  factory MockModel.fromJson(Map<String, dynamic> json) => MockModel(
    name: json['name'],
    address: json['address'],
    phone: json['phone'],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeRepository repository;

  setUpAll(() {
    repository = FakeRepository(
      data: ConfigurationData(
        dataSourcePath: 'assets/fake_models/fake_data.json',
      ),
    );
  });

  group(
    'Fake repository Test',
        () {
      test('readFromPathByType -> reading from asset', () async {
        final result = await repository.readFromPathByType(
          parser: (data) => MockModel.fromJson(data),
        );
        expect(result.data?.name, 'name');
        expect(result.data?.address, 'address');
        expect(result.data?.phone, '666777888');
      });

      test('readFromPathByType -> reading from wrong asset ', () async {
        repository.updateConfiguration(dataSourcePath: 'path');
        final result = await repository.readFromPathByType(
          parser: (data) => MockModel.fromJson(data),
        );
        expect(result.data, null);
        expect(result.exception is WrongAssetException, true);
      });

      test('readFromPathByType -> fetch data exception ', () async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.fetchException,
        );
        final result = await repository.readFromPathByType(
          parser: (data) => MockModel.fromJson(data),
        );
        expect(result.data, null);
        expect(result.exception is FetchDataException, true);
      });

      test('readFromPathByType -> offline exception ', () async {
        repository.updateConfiguration(
          repositoryResponseType: RepositoryResponseType.offline,
        );
        final result = await repository.readFromPathByType(
          parser: (data) => MockModel.fromJson(data),
        );
        expect(result.data, null);
        expect(result.exception is OfflineException, true);
      });
    },
  );
}
