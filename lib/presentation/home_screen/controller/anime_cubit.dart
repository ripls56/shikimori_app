import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/feature/data/models/anime/anime.dart';
import 'package:shikimori_app/feature/domain/use_cases/anime/get_animes.dart';
import 'anime_page_state.dart';

class AnimeCubit extends Cubit<AnimePageState> {
  AnimeCubit(this.getAnimes) : super(AnimePageEmptyState());
  final GetAnimes getAnimes;
  List<AnimeModel> animes = [];

  Future<void> getAnimeList(int page) async {
    try {
      emit(AnimePageEmptyState());
      await Future.delayed(const Duration(seconds: 3));
      final loadedOrFailure = await getAnimes.call(GetAnimesParams(page: page));
      loadedOrFailure.fold(
        (error) => {emit(AnimePageErrorState(errorMessage: 'error'))},
        (loaded) => {emit(AnimePageLoadedState(animeList: loaded))},
      );
    } catch (_) {
      emit(AnimePageErrorState(errorMessage: 'error'));
    }
  }
}