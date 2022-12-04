import 'package:flutter/material.dart';

class BackImages extends StatelessWidget {
  final List<String> images;
  final double width;
  final double height;

  const BackImages(
      {Key? key,
      required this.images,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
              //shape: BoxShape.circle,
            ),
          );
        });
  }
}
