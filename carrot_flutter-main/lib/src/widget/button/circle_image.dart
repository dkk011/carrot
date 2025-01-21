import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String? image;
  const CircleImage(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundImage: image != null ? NetworkImage(image!) : null,
      backgroundColor: Colors.grey,
      child: image == null
          ? const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 30,
            )
          : null,
    );
  }
}
