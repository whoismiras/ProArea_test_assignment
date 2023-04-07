import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_area/core/constants/app_assets.dart';
import 'package:pro_area/main/business/bloc/character_bloc.dart';
import 'package:pro_area/main/data/repositories/model/character_model.dart';
import 'package:pro_area/main/data/repositories/service/character_service_impl.dart';
import 'package:pro_area/main/presentation/widget/character_image_widget.dart';
import 'package:pro_area/main/presentation/widget/widget_utils.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sizeBoxHeight = size.height / 120;
    return BlocProvider(
      create: (context) => CharacterBloc(CharacterServiceImplementation())
        ..add(const CharacterFetchEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.backGround),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: _buildCharacterImage(character.image, size),
                    ),
                    SizedBox(
                      height: size.height / 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AutoSizeText(
                        character.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: size.width / 9,
                            ),
                        maxLines: 1,
                      ),
                    ),
                    _buildStatusInfoText(context, size),
                    SizedBox(height: sizeBoxHeight),
                    AutoSizeText(
                      'Character Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: size.width / 14,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            decorationColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    WidgetUtils.buildIndicatorText('Gender:', context, size),
                    WidgetUtils.buildInfoText(
                      text: character.gender,
                      context: context,
                      size: size,
                      maxLines: 1,
                    ),
                    SizedBox(height: sizeBoxHeight),
                    WidgetUtils.buildIndicatorText('Species:', context, size),
                    WidgetUtils.buildInfoText(
                      text: character.species,
                      context: context,
                      size: size,
                      maxLines: 1,
                    ),
                    SizedBox(height: sizeBoxHeight),
                    WidgetUtils.buildIndicatorText(
                        'Last known location:', context, size),
                    WidgetUtils.buildInfoText(
                      text: character.location.name == 'unknown'
                          ? 'Unknown'
                          : character.location.name,
                      context: context,
                      size: size,
                      maxLines: 1,
                    ),
                    SizedBox(height: sizeBoxHeight),
                    WidgetUtils.buildIndicatorText('Origin:', context, size),
                    WidgetUtils.buildInfoText(
                      text: character.origin.name == 'unknown'
                          ? 'Unknown'
                          : character.origin.name,
                      context: context,
                      size: size,
                      maxLines: 1,
                    ),
                  ],
                ),
                const Positioned(
                  top: 5,
                  left: 5,
                  child: BackButton(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildStatusInfoText(
    BuildContext context,
    Size size,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: character.status == 'Alive'
                ? Colors.green
                : character.status == 'Dead'
                    ? Colors.red
                    : Colors.grey,
          ),
        ),
        const SizedBox(width: 5),
        WidgetUtils.buildInfoText(
          text: character.status == 'unknown' ? 'Unknown' : character.status,
          context: context,
          size: size,
        ),
      ],
    );
  }

  _buildCharacterImage(
    String characterImage,
    Size size,
  ) {
    return SizedBox(
      width: double.infinity,
      height: size.height / 3.2,
      child: Container(
        alignment: const Alignment(0.0, 2.5),
        child: CharacterImageWidget(
          characterImage: characterImage,
          radiusImage: size.height / 10,
        ),
      ),
    );
  }
}
