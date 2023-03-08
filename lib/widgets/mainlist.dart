import 'package:flutter/material.dart';

import '../screens/fullscreen_page.dart';

class MainList extends StatelessWidget {
  final String imageUrl;
  final List images1;
  final String fullscreenUrl;
  final int index1;
  const MainList(
      {super.key,
      required this.imageUrl,
      required this.fullscreenUrl,
      required this.images1,
      required this.index1
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreen(
                image2: images1,
                index2: index1,
              ),
            ),
          );
        },
        child: Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
