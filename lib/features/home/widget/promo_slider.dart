import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  final PageController _pageController = PageController();

  final _slides = [
    "assets/images/banner1.png",
    "assets/images/banner1.png",
    "assets/images/banner1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          clipBehavior: Clip.antiAlias, // ensures rounded corners clip
          child: PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return Image.asset(
                slide,
                fit: BoxFit.fill,
                width: double.infinity,
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        SmoothPageIndicator(
          controller: _pageController,
          count: _slides.length,
          effect: ExpandingDotsEffect(
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: Colors.grey.shade400,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 6,
          ),
        ),
      ],
    );
  }
}
