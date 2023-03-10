// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/user_rate/user_rate_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/user_rate/user_rate.dart';
import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';

class UserRateRemoteDataSourceImpl implements UserRateRemoteDataSource {
  final _dio = Dio();
  UserRateRemoteDataSourceImpl() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _dio.options.headers = {
      'User-Agent': 'mpt coursework',
      'Authorization': 'Bearer $ACCESS_TOKEN'
    };
  }

  @override
  Future<List<UserRate>> addAnimeInUserRates(UserRate rate) async {
    var response = await _dio.post(
      '$HOSTV2/user_rates/',
      data: {
        "user_rate": {
          "chapters": rate.chapters,
          "episodes": rate.episodes,
          "rewatches": rate.rewatches,
          "score": rate.score,
          "status": rate.status,
          "target_id": rate.targetId,
          "target_type": rate.targetType,
          "text": rate.text,
          "user_id": rate.userId,
          "volumes": rate.volumes
        }
      },
    );
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map((e) => UserRateModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
    //TODO Распарсить модель тут надо
  }

  @override
  Future<UserRate> getUserRateById(int userId, int animeId) async {
    // TODO: implement getAllUserRates
    throw UnimplementedError();
  }

  @override
  Future<List<UserRate>> getAllUserRates(int userId) async {
    final response = await _dio
        .get('$HOSTV2/user_rates/', queryParameters: {'user_id': userId});
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map((e) => UserRateModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
