import 'package:core/core.dart';

import '../widgets/image_avatar_widget.dart';
import '../widgets/media_card_widget.dart';
import 'list_media_controller.dart';
import 'package:media/src/media/domain/entities/space_media_entity.dart';

class ListMediaView extends GetView<ListMediaController> {
  const ListMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mídias'),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDateRangePickerModal(context);
        },
        icon: const Icon(Icons.date_range_outlined),
        label: const Text('Selecione mais imagens'),
      ),
    );
  }

  void _showDateRangePickerModal(BuildContext context) {
    DialogInfo.showDialogInfo(
      //context,
      type: TypeDialogEnum.info,
      title: 'Selecione um intervalo de datas para buscar mais imagens',
      titleButton: 'Selecione aqui um intervalo de datas',
      onClickButton: () async {
        DateTimeRange? picked = await _showRangePicker(context);
        if (picked != null && context.mounted) {
          Navigator.of(context).pop();
          controller.startDate.value = picked.start;
          controller.endDate.value = picked.end;
          controller.getMediaList();
        }
      },
    );
  }

  Future<DateTimeRange?> _showRangePicker(BuildContext context) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          child: child!,
        );
      },
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
