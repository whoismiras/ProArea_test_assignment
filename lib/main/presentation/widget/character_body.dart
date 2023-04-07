import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_area/main/business/bloc/character_bloc.dart';
import 'package:pro_area/main/data/repositories/model/character_model.dart';
import 'package:pro_area/main/presentation/screen/character_detail_screen.dart';
import 'package:pro_area/main/presentation/widget/character_image_widget.dart';
import 'package:pro_area/main/presentation/widget/widget_utils.dart';

class CharacterBody extends StatefulWidget {
  const CharacterBody({Key? key}) : super(key: key);

  @override
  _CharacterBodyState createState() => _CharacterBodyState();
}

class _CharacterBodyState extends State<CharacterBody> {
  DateTime now = DateTime.now();
  int number = Random().nextInt(19);
  final List<CharacterModel> _character = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: BlocConsumer<CharacterBloc, CharacterState>(
        listener: (context, characterState) {
          if (characterState is CharacterLoadingState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: WidgetUtils.buildInfoText(
                  text: characterState.message,
                  context: context,
                  size: size,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (characterState is CharacterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: WidgetUtils.buildInfoText(
                  text: characterState.error,
                  context: context,
                  size: size,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return;
        },
        builder: (context, characterState) {
          if (characterState is CharacterInitial ||
              characterState is CharacterLoadingState && _character.isEmpty) {
            return WidgetUtils.buildCircularProgressIndicator(context);
          } else if (characterState is CharacterSuccessState) {
            _character.addAll(characterState.character);
            ScaffoldMessenger.of(context).clearSnackBars();
          } else if (characterState is CharacterErrorState &&
              _character.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WidgetUtils.buildInfoText(
                  text: characterState.error,
                  context: context,
                  size: size,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }

          return Column(
            children: [
              _buildOpenContainer(number, size),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      number = Random().nextInt(19);
                      context.read<CharacterBloc>().fetch();
                    },
                    child: const Text(
                      'Another character',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: () {},
                  child: const Text(
                    'Unfortunately, there is no hive database',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildOpenContainer(int index, Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: OpenContainer(
            transitionDuration: const Duration(milliseconds: 500),
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (context, action) => _buildClosed(index, size),
            openBuilder: (context, action) =>
                CharacterDetailScreen(character: _character[index]),
            closedColor: Theme.of(context).colorScheme.primary,
            middleColor: Theme.of(context).colorScheme.background,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  _buildClosed(int index, Size size) {
    return Card(
      child: ListTile(
        leading: CharacterImageWidget(
          characterImage: _character[index].image,
        ),
        title: WidgetUtils.buildInfoText(
          text: _character[index].name,
          context: context,
          size: size,
          maxLines: 1,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(now.toString()),
            WidgetUtils.buildIndicatorText(
              '#${index + 1}',
              context,
              size,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
