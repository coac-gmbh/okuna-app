import 'package:Okuna/widgets/progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Hero(
            tag: imageUrl,
            child: ExtendedImage.network(
              imageUrl,
              fit: BoxFit.cover,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Center(child: OBProgressIndicator());
                    break;
                  case LoadState.completed:
                    return ExtendedRawImage(
                      image: state.extendedImageInfo?.image,
                    );
                    break;
                  case LoadState.failed:
                    return Image.asset('assets/images/matchmaking/error_image.png');
                    break;
                  default:
                    return Image.asset('assets/images/matchmaking/img_placeholder.png');
                    break;  
                }
              },
            ),
          ),
        ));
  }
}
