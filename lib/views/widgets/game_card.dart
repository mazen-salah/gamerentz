import 'package:flutter/material.dart';
import 'package:gamerentz/models/game_model.dart';
import 'package:gamerentz/models/user_model.dart';
import 'package:gamerentz/providers/users_provider.dart';
import 'package:gamerentz/utils/image_handeler.dart';
import 'package:gamerentz/utils/responsive.dart';
import 'package:gamerentz/views/screens/game_screen.dart';
import 'package:provider/provider.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final width = MediaQuery.of(context).size.width / (isDesktop ? 8 : 3);

    // Access the UserProvider from the main app widget's context
    final userProvider = Provider.of<UserProvider>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GameScreen(
              game: game,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildGameCardContents(width, userProvider.user),
      ),
    );
  }

  Widget _buildGameCardContents(double width, User? user) {
    return Column(
      children: [
        Stack(
          children: [
            _buildGameImage(width),
            Positioned(
              top: 0,
              right: 0,
              child: FutureBuilder<Widget>(
                future: _buildFavoriteButton(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildGameTitle(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGameImage(double width) {
    return Container(
      width: width,
      height: width * 225 / 175,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ImageHandler(
        image: game.imageUrl,
      ),
    );
  }

  Future<Widget> _buildFavoriteButton(User? user) async {
    return IconButton(
      onPressed: () async {
        if (user != null) {
          // Check if the game is already in favorites
          if (await user.isGameInFavorites(game.id)) {
            // Remove it from favorites
            user.removeGameFromFavorites(game.id);
          } else {
            // Add it to favorites
            user.addGameToFavorites(game.id);
          }
        }
      },
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border.fromBorderSide(
            BorderSide(color: Colors.grey, width: 1.0),
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            user != null && await user.isGameInFavorites(game.id)
                ? Icons.favorite // Display filled heart if in favorites
                : Icons
                    .favorite_border, // Display border heart if not in favorites
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildGameTitle() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.deepPurple,
            Colors.deepPurple,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(
        game.title,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
