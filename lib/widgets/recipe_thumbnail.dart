import 'package:flutter/material.dart';

class RecipeThumbnail extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;

  RecipeThumbnail(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
