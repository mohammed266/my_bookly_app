import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/shimmer_featured.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, this.imageUrl});

  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 2.6 / 4,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: imageUrl!,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: const ShimmerFeaturedList(),
          ),
        ),
      ),
    );
  }
}
