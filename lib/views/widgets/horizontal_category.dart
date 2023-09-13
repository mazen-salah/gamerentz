import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamerentz/models/game_model.dart';
import 'package:gamerentz/views/widgets/game_card.dart';

class HorizontalCategory extends StatefulWidget {
  const HorizontalCategory({
    Key? key,
    required this.title,
    required this.collectionName,
    this.sortBy = '',
  }) : super(key: key);

  final String title;
  final String collectionName;
  final String sortBy;

  @override
  State<HorizontalCategory> createState() => _HorizontalCategoryState();
}

class _HorizontalCategoryState extends State<HorizontalCategory> {
  late Future<List<Game>> _categoryData;

  @override
  void initState() {
    super.initState();
    _categoryData = _fetchCategoryData();
  }

  Future<List<Game>> _fetchCategoryData() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(widget.collectionName);

    Query query = widget.sortBy.isEmpty
        ? collection.limit(10)
        : collection.orderBy(widget.sortBy, descending: true).limit(10);

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((document) {
      return Game(
        id: document.id,
        title: document['title'] ?? 'No title available',
        imageUrl: document['image'] ?? '',
        coverUrl: document['cover'] ?? '',
        description: document['description'] ?? 'No description available',
        screenshots: document['screenshots'] ?? [],
        platform:  setPlatformFromString(document['platform'] ?? 'ps4')
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleSmall),
            TextButton.icon(
              onPressed: () {
                // Handle the "Show all" button click here
              },
              label: const Icon(Icons.arrow_forward),
              icon: const Text('Show all'),
            ),
          ],
        ),
        FutureBuilder<List<Game>>(
          future: _categoryData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available');
            }

            final games = snapshot.data!;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: games
                    .map(
                      (game) => GameCard(
                        game: game, // Pass the Game object
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
