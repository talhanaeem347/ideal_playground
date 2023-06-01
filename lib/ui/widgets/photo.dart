import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final String _photoUrl;

  const PhotoWidget({required String photoUrl, Key? key})
      : _photoUrl = photoUrl,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      _photoUrl,
      fit: BoxFit.cover,
      cache: true,
      enableSlideOutPage: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return Center(
              child: TextButton(
                onPressed: () {
                  state.reLoadImage();
                },
                child: const Text('reload'),
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}
