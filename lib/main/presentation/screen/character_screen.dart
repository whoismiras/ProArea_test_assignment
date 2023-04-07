import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_area/main/business/bloc/character_bloc.dart';
import 'package:pro_area/main/data/repositories/service/character_service_impl.dart';
import 'package:pro_area/main/presentation/widget/character_body.dart';

class DisplayCharacterScreen extends StatelessWidget {
  const DisplayCharacterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc(CharacterServiceImplementation())
        ..add(const CharacterFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rick and Morty Character Wiki',
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
          ),
        ),
        body: const CharacterBody(),
      ),
    );
  }
}
