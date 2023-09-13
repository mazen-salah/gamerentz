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
          HorizontalCategory(
            title: 'New Releases',
            collectionName: 'games',
            sortBy: 'n',
          ),
          HorizontalCategory(
            title: 'Top Rated',
            collectionName: 'games',
            sortBy: 'r',
          ),
          HorizontalCategory(
            title: 'Most Popular',
            collectionName: 'games',
          ),
        ],
      ),
    );
  }
}
