import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  const CachedImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: url,
      placeholder: (context, url) => Center(
        child: Image.asset("assets/images/loading.gif"),
      ),
      errorWidget: (context, url, error) =>
          Image.asset("assets/images/image_not_available.jpg"),
    );
  }
}
