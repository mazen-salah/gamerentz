import 'package:flutter/material.dart';
import 'package:gamerentz/utils/responsive.dart';
import 'package:gamerentz/views/widgets/game_card.dart';

class HorizontalCategory extends StatelessWidget {
  const HorizontalCategory({
    Key? key,
    required this.title,
    required this.itemCount,
  }) : super(key: key);

  final String title;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final width = Responsive.isDesktop(context)
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
                return GameCard(
                  width: width,
                  index: index,
                  isFav: false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
