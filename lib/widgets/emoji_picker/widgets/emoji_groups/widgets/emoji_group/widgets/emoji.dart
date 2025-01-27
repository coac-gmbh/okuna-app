import 'package:Okuna/models/emoji.dart';
import 'package:Okuna/models/emoji_group.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

enum OBEmojiSize { small, medium, large }

class OBEmoji extends StatelessWidget {
  final Emoji emoji;
  final EmojiGroup emojiGroup;
  final OnEmojiPressed onEmojiPressed;
  final OBEmojiSize size;

  OBEmoji(this.emoji,
      {this.onEmojiPressed, this.emojiGroup, this.size = OBEmojiSize.medium});

  @override
  Widget build(BuildContext context) {
    double dimensions = getIconDimensions(size);

    return IconButton(
        icon: Image(
          height: dimensions,
          image: ExtendedNetworkImageProvider(
            emoji.image,
            cache: true,
          ),
        ),
        onPressed: onEmojiPressed != null
            ? () {
                onEmojiPressed(emoji, emojiGroup);
              }
            : null);
  }

  double getIconDimensions(OBEmojiSize size) {
    double iconSize;

    switch (size) {
      case OBEmojiSize.large:
        iconSize = 45;
        break;
      case OBEmojiSize.medium:
        iconSize = 25;
        break;
      case OBEmojiSize.small:
        iconSize = 15;
        break;
      default:
    }

    return iconSize;
  }
}

typedef void OnEmojiPressed(Emoji pressedEmoji, EmojiGroup emojiGroup);
