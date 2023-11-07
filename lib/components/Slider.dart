import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderHome extends StatefulWidget {
  const SliderHome({super.key});

  @override
  State<SliderHome> createState() => _SliderHomeState();
}

class _SliderHomeState extends State<SliderHome> {
  final CarouselController carouselController = CarouselController();

  int index = 0;

List<Map<String, dynamic>> data = [
  {
    "image":"assets/images/Banner1.png",
  },
  {
    "image":"assets/images/Banner2.png",
  },
  {
    "image":"assets/images/Banner3.png",
  },
  {
    "image":"assets/images/Banner4.png",
  },
  {
    "image":"assets/images/Banner5.png",
  }
];


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: data.map((dt) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            image: DecorationImage(image: AssetImage(dt['image']),fit: BoxFit.fill)
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
        enlargeFactor: 0.25,
        autoPlay: true,
        enlargeCenterPage: true, // 
      )
    );
  }
}