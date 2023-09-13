
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ImageHandler extends StatelessWidget {
  final String image;

  const ImageHandler({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Shimmer(
          duration: const Duration(seconds: 10),
          interval: const Duration(seconds: 10),
          color: Colors.grey,
          colorOpacity: 0,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.white,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          if (kDebugMode) {
            print('Error Banner: $error');
          }
          return const Icon(Icons.error);
        },
      ),
    );
  }
}