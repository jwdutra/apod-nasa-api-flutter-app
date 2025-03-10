import 'package:core/core.dart';

import '../widgets/media_card_widget.dart';
import 'media_controller.dart';

class MediaView extends GetView<MediaController> {
  const MediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mídia do dia'),
      ),
      body: Obx(() {
        final media = controller.media.value;
        if (media == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: MediaCard(
            title: "${media.title}",
            date: "${media.date}",
            imageUrl: "${media.url}",
            explanation: "${media.explanation}",
            hdurl: "${media.hdurl}",
            mediaType: "${media.mediaType}",
            serviceVersion: "${media.serviceVersion}",
            isFavorite: controller.isFavorite.value,
            onFavoritePressed: () {
              controller.setFavorite(media);
            },
            onViewFavoritesPressed: () {
              Get.toNamed(AppRoute.media.favorites);
            },
            onMoreImagesPressed: () {
              Get.toNamed(AppRoute.media.list);
            },
          ),
        );
      }),
    );
  }
}
