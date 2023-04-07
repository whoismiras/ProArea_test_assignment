import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pro_area/main/presentation/widget/widget_utils.dart';

class CharacterImageWidget extends StatelessWidget {
  final String characterImage;
  final double radiusImage;

  const CharacterImageWidget({
    Key? key,
    required this.characterImage,
    this.radiusImage = 30,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radiusImage,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: characterImage,
          placeholder: (context, url) =>
              WidgetUtils.buildCircularProgressIndicator(context),
          errorWidget: (context, url, error) => CircleAvatar(
            radius: radiusImage,
            child: const ClipOval(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/image_error.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
