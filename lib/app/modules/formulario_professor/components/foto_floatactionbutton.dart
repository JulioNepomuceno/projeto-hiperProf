import 'package:flutter/material.dart';

class FotoFloatActionButton extends StatelessWidget {
  final String? img;
  const FotoFloatActionButton({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Visibility(
          visible: img != null,
          replacement: const Icon(Icons.person),
          child: CircleAvatar(
            backgroundImage: NetworkImage(img ?? ''),
            radius: 30,
          ),
        ),
        Positioned(
          left: img != null ? 30 : 10,
          bottom: img != null ? -15 : -30,
          child: IconButton(
            onPressed: () {},
            icon: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        )
      ],
    );
  }
}