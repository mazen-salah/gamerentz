import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamerentz/theme/theme_constants.dart';

import 'image_handeler.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _bannerImage = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer; // Add Timer variable
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    getBanners();
    startAutoScrollTimer(); // Start the auto-scroll timer
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel(); // Cancel the timer when the widget is disposed
    resetProgress();
    super.dispose();
  }

  void getBanners() async {
    final querySnapshot = await _firestore.collection('banners').get();
    for (var doc in querySnapshot.docs) {
      if (mounted) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      }
    }
  }

  void startAutoScrollTimer() {
    _autoScrollTimer?.cancel();
    resetProgress();
    const totalSeconds = 10;
    const progressInterval = 100;
    int steps = (totalSeconds * 1000) ~/ progressInterval;
    int step = 0;
    _autoScrollTimer = Timer.periodic(
      const Duration(milliseconds: progressInterval),
      (progressTimer) {
        if (mounted) {
          setState(() {
            _progress = (step + 1) / steps;
          });
        }
        step++;
        if (_progress == 1) {
          step = 0;
          if (_currentPage < _bannerImage.length - 1 &&
              _bannerImage.length > 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  void resetProgress() {
    if (mounted) {
      setState(() {
        _progress = 0.0;
      });
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    startAutoScrollTimer();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width >= 1100
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HOT STUFF',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: _buildDots(),
            ),
          ],
        ),
        Container(
          width: width,
          height: width / 2.5,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _bannerImage.length,
                itemBuilder: (context, index) {
                  return ImageHandeler(image: _bannerImage[index]);
                },
                onPageChanged: onPageChanged,
              ),
              if (_bannerImage.length > 1)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: _progress,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDots() {
    return List<Widget>.generate(
      _bannerImage.length,
      (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? primaryColor : Colors.grey,
          ),
          child: InkWell(
            onTap: () {
              onPageChanged(index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          )),
    );
  }
}
