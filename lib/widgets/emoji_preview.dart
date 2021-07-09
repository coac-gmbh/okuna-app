import 'package:Okuna/models/emoji.dart';
import 'package:Okuna/widgets/icon.dart';
import 'package:Okuna/widgets/progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class OBEmojiPreview extends StatelessWidget {
  final Emoji emoji;
  final OBEmojiPreviewSize size;
  static double emojiSizeLarge = 45;
  static double emojiSizeMedium = 25;
  static double emojiSizeSmall = 15;
  static double emojiSizeExtraSmall = 10;

  OBEmojiPreview(this.emoji, {this.size = OBEmojiPreviewSize.medium});

  @override
  Widget build(BuildContext context) {
    double emojiSize = _getEmojiSize(size);

    return ExtendedImage.network(
        emoji.image,
        fit: BoxFit.cover,
        cache: true,
        height: emojiSize,
        width: emojiSize,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Center(child: OBProgressIndicator());
              break;
            case LoadState.failed:
              return OBIcon(OBIcons.error);
              break;
            default:
              return OBIcon(OBIcons.error);
              break;  
          }
        },
      );
  }

  double _getEmojiSize(OBEmojiPreviewSize size) {
    double emojiSize;

    switch (size) {
      case OBEmojiPreviewSize.large:
        emojiSize = emojiSizeLarge;
        break;
      case OBEmojiPreviewSize.medium:
        emojiSize = emojiSizeMedium;
        break;
      case OBEmojiPreviewSize.small:
        emojiSize = emojiSizeSmall;
        break;
      case OBEmojiPreviewSize.extraSmall:
        emojiSize = emojiSizeExtraSmall;
        break;
    }

    return emojiSize;
  }
}

enum OBEmojiPreviewSize { small, medium, large, extraSmall }
