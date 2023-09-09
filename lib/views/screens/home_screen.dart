import 'package:flutter/material.dart';
import 'package:gamerentz/views/widgets/banner_widget.dart';
import 'package:gamerentz/views/widgets/image_handeler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

class HorizontalCategory extends StatelessWidget {
  const HorizontalCategory({
    super.key,
    required this.title,
    required this.itemCount,
  });
  final String title;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width > 1100
        ? MediaQuery.of(context).size.width / 10
        : MediaQuery.of(context).size.width / 4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            TextButton.icon(
              onPressed: () {},
              label: const Icon(Icons.arrow_forward),
              icon: const Text('Show all'),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              itemCount,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                          width: width,
                          height: width * 1.4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const ImageHandeler(
                            image:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpXf01mydnagAOz7Ygw0enIUDyxEMxyS-ZbQ&usqp=CAU',
                          )),
                      Text('Game $index'),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
