import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pro_area/main/data/repositories/model/character_model.dart';
import 'package:pro_area/main/data/repositories/service/character_service.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterService characterRepository;
  int page = 1;
  bool isFetching = false;
  void fetch() => add(const CharacterFetchEvent());

  CharacterBloc(this.characterRepository) : super(const CharacterState()) {
    on<CharacterFetchEvent>(_fetch);
  }

  void _fetch(CharacterFetchEvent event, Emitter<CharacterState> emit) async {
    try {
      emit(
        const CharacterLoadingState(message: 'Loading Characters'),
      );

      isFetching = true;
      final response = await characterRepository.getAllCharacters(page);
      isFetching = false;
      emit(
        CharacterSuccessState(
          character: response.toList(),
        ),
      );

      page++;
    } on Exception catch (exc) {
      isFetching = false;
      emit(
        CharacterErrorState(
          error: exc.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }
}
