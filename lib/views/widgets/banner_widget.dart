import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamerentz/theme/theme_constants.dart';
import 'package:gamerentz/utils/helper_widgets.dart';

import '../../utils/image_handeler.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PageController _pageController = PageController();
  final List<String> _bannerImage = [];
  Timer? _autoScrollTimer;
  double _progress = 0.0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _getBanners();
    _startAutoScrollTimer();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();

    super.dispose();
  }

  void _getBanners() async {
    final querySnapshot = await _firestore.collection('banners').get();
    setState(() {
      _bannerImage
          .addAll(querySnapshot.docs.map((doc) => doc['image'] as String));
    });
  }

  void _startAutoScrollTimer() {
    _autoScrollTimer?.cancel();

    const totalSeconds = 10;
    const progressInterval = 100;
    const steps = (totalSeconds * 1000) ~/ progressInterval;
    var step = 0;

    _autoScrollTimer = Timer.periodic(
      const Duration(milliseconds: progressInterval),
      (progressTimer) {
        setState(() {
          _progress = (step + 1) / steps;
        });

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

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _progress = 0.0;
    });
    _startAutoScrollTimer();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width >= 1100
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'HOT STUFF',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              horizontalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: _buildDots(),
              ),
            ],
          ),
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
                onPageChanged: _onPageChanged,
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
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index ? primaryColor : Colors.grey,
        ),
        child: InkWell(
          onTap: () {
            _onPageChanged(index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
