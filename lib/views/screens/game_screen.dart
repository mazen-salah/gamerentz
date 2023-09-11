import 'package:flutter/material.dart';
import 'package:gamerentz/utils/helper_widgets.dart';
import 'package:gamerentz/utils/image_handeler.dart';
import 'package:gamerentz/utils/responsive.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isWideScreen = Responsive.isDesktop(context);
    final containerWidth = isWideScreen
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Details"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildGamePreview(containerWidth, isWideScreen, context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ScreenShots: ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _buildScreenshots(containerWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildGamePreview(
      double containerWidth, bool isWideScreen, BuildContext context) {
    return Flex(
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              child: const ImageHandeler(
                  image:
                      'https://w0.peakpx.com/wallpaper/464/664/HD-wallpaper-mortal-kombat-11-ultimate.jpg'),
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
                child: const ImageHandeler(
                    image:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpXf01mydnagAOz7Ygw0enIUDyxEMxyS-ZbQ&usqp=CAU'),
              ),
            )
          ],
        ),
        SizedBox(
          width: isWideScreen ? containerWidth / 1.5 : containerWidth,
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
    );
  }

  Widget _buildScreenshots(double containerWidth) {
    return SingleChildScrollView(
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
            child: const ImageHandeler(
                image:
                    'https://w0.peakpx.com/wallpaper/464/664/HD-wallpaper-mortal-kombat-11-ultimate.jpg'),
          ),
        ),
      ),
    );
  }
}
