import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/use_cases/creditional/get_creditional.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getCreditional) : super(ProfileEmpty());
  final GetCreditional getCreditional;

  Future<void> getCreditionals() async {
    try {
      final loadedOrFailure = await getCreditional
          .call(GetCreditionalParams(accessToken: ACCESS_TOKEN));
      loadedOrFailure.fold(
          (error) => {
                emit(
                  ProfileEmpty(),
                )
              },
          (loaded) => {
                emit(ProfileInitial(loaded)),
              });
    } catch (ex) {
      emit(ProfileEmpty());
    }
  }
}
