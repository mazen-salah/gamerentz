import 'package:flutter/material.dart';
import 'package:gamerentz/utils/image_handeler.dart';
import 'package:gamerentz/views/screens/game_screen.dart';

class GameCard extends StatefulWidget {
  GameCard({
    super.key,
    required this.width,
    required this.index,
    required this.isFav,
  });

  final double width;
  final int index;
  bool isFav;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.isFav;
    bool isAddedToCart = false;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const GameScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: widget.width,
                  height: widget.width * 1.4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const ImageHandeler(
                    image:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpXf01mydnagAOz7Ygw0enIUDyxEMxyS-ZbQ&usqp=CAU',
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isFav =
                            !widget.isFav; // Update the parent widget's state
                      });
                    },
                    icon: widget.isFav
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),
            Text('Game ${widget.index}'),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
