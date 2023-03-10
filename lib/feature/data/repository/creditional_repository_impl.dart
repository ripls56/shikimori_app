import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/domain/repositories/creditional_repository.dart';

class CreditionalRepositoryImpl implements CreditionalRepository {
  CreditionalRemoteDataSource creditional = CreditionalRemoteDataSourceImpl();
  @override
  Future<Either<Failure, Creditional>> getCreditionals(String token) async {
    return await _getCreditionals(() => creditional.getCreditionals(token));
  }

  Future<Either<Failure, Creditional>> _getCreditionals(
      Future<Creditional> Function() creditional) async {
    try {
      final model = await creditional();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
