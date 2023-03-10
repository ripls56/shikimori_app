import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/repositories/creditional_repository.dart';

class GetCreditional extends UseCase<Creditional, GetCreditionalParams> {
  final CreditionalRepository creditionalRepository;

  GetCreditional(this.creditionalRepository);

  @override
  Future<Either<Failure, Creditional>> call(GetCreditionalParams params) async {
    return await creditionalRepository.getCreditionals(params.accessToken);
  }
}

class GetCreditionalParams extends Equatable {
  final String accessToken;

  const GetCreditionalParams({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}
