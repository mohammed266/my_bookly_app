import 'package:flutter/material.dart';

import 'custom_book_image.dart';

class CustomBookItem extends StatelessWidget {
  const CustomBookItem({super.key, required this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return CustomBookImage(
      imageUrl: imageUrl,
    );
  }
}
