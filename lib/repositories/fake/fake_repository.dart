import 'dart:convert';

import 'package:atym_flutter_app/core/api/app_exceptions/fetch_data_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/offline_exception.dart';
import 'package:atym_flutter_app/core/api/app_exceptions/wrong_asset_exception.dart';
import 'package:atym_flutter_app/core/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum RepositoryResponseType {
  fromData,
  offline,
  fetchException,
}

typedef ModelParserCallback<T> = T Function(dynamic json);

class ConfigurationData {
  String dataSourcePath;
  RepositoryResponseType repositoryResponseType;

  ConfigurationData({
    required this.dataSourcePath,
    RepositoryResponseType? repositoryResponseType,
  }) : this.repositoryResponseType =
            repositoryResponseType ?? RepositoryResponseType.fromData;
}

class FakeRepository {
  final ConfigurationData _data;

  const FakeRepository({
    required ConfigurationData data,
  }) : this._data = data;

  Future<ApiResponse<T>> readFromPathByType<T extends Object>({
    required ModelParserCallback<T> parser,
  }) async {
    switch (_data.repositoryResponseType) {
      case RepositoryResponseType.fromData:
        final model = await readFromAssets();
        return ApiResponse(
          data: model != null ? parser.call(model) : null,
          exception:
              model == null ? WrongAssetException(_data.dataSourcePath) : null,
        );
      case RepositoryResponseType.offline:
        return ApiResponse(
          data: null,
          exception: OfflineException(),
        );
      case RepositoryResponseType.fetchException:
        return ApiResponse(
          data: null,
          exception: FetchDataException(),
        );
    }
  }

  void updateConfiguration({
    String? dataSourcePath,
    RepositoryResponseType? repositoryResponseType,
  }) {
    this._data.dataSourcePath = dataSourcePath ?? this._data.dataSourcePath;
    this._data.repositoryResponseType =
        repositoryResponseType ?? this._data.repositoryResponseType;
  }

  Future<dynamic> readFromAssets() async {
    try {
      final String response = await rootBundle.loadString(
        _data.dataSourcePath,
        cache: false,
      );
      final data = await json.decode(response);
      return data;
    } catch (e) {
      debugPrint(
        'Unable to loadString from provided asset with path: ${_data.dataSourcePath}',
      );
      return null;
    }
  }
}
