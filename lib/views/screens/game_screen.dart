import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamerentz/models/game_model.dart';
import 'package:gamerentz/providers/theme_provider.dart';
import 'package:gamerentz/utils/helper_widgets.dart';
import 'package:gamerentz/utils/image_handeler.dart';
import 'package:gamerentz/utils/responsive.dart';
import 'package:gamerentz/views/widgets/description.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  final Game game;

  const GameScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWideScreen = Responsive.isDesktop(context);
    final containerWidth = isWideScreen
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game details"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GamePreviewSection(
                game: game,
                containerWidth: containerWidth,
                isWideScreen: isWideScreen),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ScreenShots: ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ScreenshotsSection(
                screenshots: game.screenshots, containerWidth: containerWidth),
          ],
        ),
      ),
    );
  }
}

class GamePreviewSection extends StatelessWidget {
  final Game game;
  final double containerWidth;
  final bool isWideScreen;

  const GamePreviewSection({super.key, 
    required this.game,
    required this.containerWidth,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                _showImageDialog(context, game.coverUrl, 9 / 16);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: containerWidth * 9 / 16,
                width: containerWidth,
                child: ImageHandler(image: game.coverUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  _showImageDialog(context, game.imageUrl, 225 / 220);
                },
                child: Container(
                  margin: EdgeInsets.all(containerWidth / 30),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: containerWidth / 4,
                  height: containerWidth / 4 * 225 / 175,
                  child: ImageHandler(image: game.imageUrl),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: isWideScreen ? containerWidth / 1.5 : containerWidth,
          child: GameDetailsSection(game: game),
        ),
      ],
    );
  }
}

class GameDetailsSection extends StatelessWidget {
  final Game game;

  const GameDetailsSection({super.key, 
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Text(
                          "Platform: ",
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .fontSize,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icons/${game.platform}.svg",
                          height: 40,
                          width: 40,
                          colorFilter: ColorFilter.mode(
                            Provider.of<ThemeManager>(context).themeMode ==
                                    ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ],
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
          child: TextWithNewlines(text: game.description),
        ),
      ],
    );
  }
}

class ScreenshotsSection extends StatelessWidget {
  final List<dynamic> screenshots;
  final double containerWidth;

  const ScreenshotsSection({super.key, 
    required this.screenshots,
    required this.containerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: screenshots.map((e) {
          return GestureDetector(
            onTap: () {
              _showScreenshotGallery(
                  context, screenshots, screenshots.indexOf(e));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: containerWidth / 2,
                height: containerWidth / 2 * 9 / 16,
                child: ImageHandler(image: e),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

void _showImageDialog(BuildContext context, String imageUrl, double scale) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * scale,
            child: ImageHandler(image: imageUrl),
          ),
        ),
      );
    },
  );
}

void _showScreenshotGallery(
    BuildContext context, List<dynamic> screenshots, int initialIndex) {
  int currentIndex = initialIndex;
  PageController pageController = PageController(initialPage: initialIndex);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 9 / 16,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: screenshots.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: ImageHandler(image: screenshots[index]),
                      );
                    },
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  if (currentIndex < screenshots.length - 1)
                    Positioned(
                      right: 0,
                      child: GalleryArrowButton(
                        icon: Icons.arrow_forward,
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                  if (currentIndex > 0)
                    Positioned(
                      left: 0,
                      child: GalleryArrowButton(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class GalleryArrowButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;

  const GalleryArrowButton({super.key, 
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 9 / 16,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
