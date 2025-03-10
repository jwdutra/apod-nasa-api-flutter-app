import 'package:core/core.dart';

import '../widgets/image_avatar_widget.dart';
import '../widgets/media_card_widget.dart';
import 'package:media/src/media/domain/entities/space_media_entity.dart';

import 'list_media_favorite_controller.dart';

class ListMediaFavoriteView extends GetView<ListMediaFavoriteController> {
  const ListMediaFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mídias Favoritas'),
      ),
      body: Obx(() {
        if (controller.mediaList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.mediaList.length,
          itemBuilder: (context, index) {
            final media = controller.mediaList[index];
            final urlImage =
                media.mediaType == 'video' ? media.thumbnailUrl : media.url;
            return ListTile(
                leading: ImageAvatar(urlImage: urlImage),
                title: Text(media.title ?? 'No Title'),
                subtitle: Text(media.date ?? 'No Date'),
                onTap: () async {
                  await _showModalMedia(context, media);
                });
          },
        );
      }),
    );
  }

  Future<dynamic> _showModalMedia(
      BuildContext context, SpaceMediaEntity media) async {
    controller.isFavoriteMedia(media);
    return showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return Obx(() {
          return SingleChildScrollView(
            child: MediaCard(
              title: "${media.title}",
              date: "${media.date}",
              imageUrl: "${media.url}",
              explanation: "${media.explanation}",
              hdurl: "${media.hdurl}",
              mediaType: "${media.mediaType}",
              serviceVersion: "${media.serviceVersion}",
              showNavButtons: false,
              isFavorite: controller.isFavorite.value,
              onFavoritePressed: () async {
                await controller.setFavorite(media);
              },
            ),
          );
        });
      },
    );
  }
}
