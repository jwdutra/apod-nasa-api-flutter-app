import 'package:core/core.dart';

import 'expandable_text_widget.dart';
import 'show_media_widget.dart';

class MediaCard extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onViewFavoritesPressed;
  final VoidCallback? onMoreImagesPressed;
  final bool showNavButtons;
  final bool isFavorite;

  const MediaCard({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.onFavoritePressed,
    this.onViewFavoritesPressed,
    this.onMoreImagesPressed,
    this.showNavButtons = true,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data: $date",
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: !isFavorite
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite, color: Colors.red),
                  onPressed: onFavoritePressed,
                ),
              ],
            ),
            SizedBox(height: 8),
            ShowMedia(imageUrl: imageUrl, mediaType: mediaType),
            SizedBox(height: 8),
            ExpandableText(text: explanation, maxLength: 100),
            SizedBox(height: 16),
            Text(
              "Tipo de Mídia: $mediaType",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Versão do Serviço: $serviceVersion",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            if (showNavButtons)
              Row(
                spacing: 8.0,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: onViewFavoritesPressed,
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text("Ver Favoritos"),
                  ),
                  FilledButton(
                    onPressed: onMoreImagesPressed,
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text("Mais imagens"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
