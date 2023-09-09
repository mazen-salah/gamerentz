import 'package:flutter/material.dart';
import 'package:gamerentz/utils/helper_widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 1100;
    final containerWidth = isWideScreen ? screenWidth / 2 : screenWidth;

    return ListView(
      children: [
        Flex(
          direction: isWideScreen ? Axis.horizontal : Axis.vertical,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: containerWidth / 2.5,
                  width: containerWidth,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.all(containerWidth / 30),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: containerWidth / 2.5 * 0.75 / 1.4,
                    height: containerWidth / 2.5 * 0.75,
                  ),
                )
              ],
            ),
            horizontalSpace(10),
            SizedBox(
              width: isWideScreen ? screenWidth / 2.5 : screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Game Name",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Buy"),
                        ),
                        horizontalSpace(10),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Rent"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "This is the Game description " * 10,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ScreenShots: ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              9,
              (index) => Container(
                margin: const EdgeInsets.all(8),
                width: containerWidth / 2,
                height: containerWidth / 2 * 9 / 16,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
