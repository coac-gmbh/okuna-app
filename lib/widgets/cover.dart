import 'dart:io';

import 'package:Okuna/provider.dart';
import 'package:Okuna/widgets/progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class OBCover extends StatelessWidget {
  final String coverUrl;
  final File coverFile;
  static const double largeSizeHeight = 230.0;
  static const double mediumSizedHeight = 190.0;
  static const double smallSizeHeight = 160.0;
  static const COVER_PLACEHOLDER = 'assets/images/fallbacks/cover-fallback.jpg';
  final OBCoverSize size;
  final bool isZoomable;

  OBCover(
      {this.coverUrl,
      this.coverFile,
      this.size = OBCoverSize.large,
      this.isZoomable = true});

  @override
  Widget build(BuildContext context) {
    Widget image;

    double coverHeight;

    switch (size) {
      case OBCoverSize.large:
        coverHeight = largeSizeHeight;
        break;
        case OBCoverSize.medium:
        coverHeight = mediumSizedHeight;
        break;
      case OBCoverSize.small:
        coverHeight = smallSizeHeight;
        break;
      default:
        break;
    }

    if (coverFile != null) {
      image = FadeInImage(
        placeholder: AssetImage(COVER_PLACEHOLDER),
        image: FileImage(coverFile),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      );
    } else if (coverUrl == null) {
      image = _getCoverPlaceholder(coverHeight);
    } else {
      image = ExtendedImage.network(
        coverUrl,
        fit: BoxFit.cover,
        cache: true,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Center(child: OBProgressIndicator());
              break;
            case LoadState.completed:
              return null;
              break;
            case LoadState.failed:
              return Image.asset('assets/images/matchmaking/img_placeholder'
                            '.png');
              break;
            default:
              return Image.asset('assets/images/matchmaking/img_placeholder'
                            '.png');
              break;  
          }
        },
      );
      

      if (isZoomable) {
        image = GestureDetector(
          child: image,
          onTap: () {
            OpenbookProviderState openbookProvider =
                OpenbookProvider.of(context);
            openbookProvider.dialogService
                .showZoomablePhotoBoxView(imageUrl: coverUrl, context: context);
          },
        );
      }
    }

    return SizedBox(
      height: coverHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              child: image,
            ),
          )
        ],
      ),
    );
  }

  Widget _getCoverPlaceholder(double coverHeight) {
    return Image.asset(
      COVER_PLACEHOLDER,
      height: coverHeight,
      fit: BoxFit.cover,
    );
  }
}

enum OBCoverSize { large, small , medium}
