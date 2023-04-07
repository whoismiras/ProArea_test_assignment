import 'package:pro_area/main/data/repositories/model/character_model.dart';

abstract class CharacterService {
  Future<List<CharacterModel>> getAllCharacters(int page);

  // void addCharacter(CharacterModel characterModel) {box.add(CharacterModel())}
}
