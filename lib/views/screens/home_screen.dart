import 'package:flutter/material.dart';
import 'package:gamerentz/views/widgets/banner_widget.dart';
import 'package:gamerentz/views/widgets/horizontal_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: const [
          BannerWidget(),
          HorizontalCategory(title: 'New Releases', itemCount: 8),
          HorizontalCategory(title: 'Popular', itemCount: 2),
          HorizontalCategory(title: 'Top Rated', itemCount: 5),
        ],
      ),
    );
  }
}
