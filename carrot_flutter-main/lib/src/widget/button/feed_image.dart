import 'package:flutter/material.dart';

class FeedImage extends StatelessWidget {
  final String? image;
  const FeedImage(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: image == null
                ? Border.all(color: Colors.grey, width: 1.0)
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image == null
                ? const Icon(
                    Icons.camera_alt_outlined,
                    size: 40.0,
                    color: Colors.grey,
                  )
                : Image.network(
                    image!,
                    fit: BoxFit.cover,
                    width: 80.0,
                    height: 80.0,
                  ),
          ),
        ),
      ],
    );
  }
}
