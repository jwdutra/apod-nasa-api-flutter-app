import 'package:core/core.dart';

class ShowMedia extends StatelessWidget {
  const ShowMedia({
    super.key,
    required this.imageUrl,
    required this.mediaType,
  });

  final String imageUrl;
  final String mediaType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (mediaType == 'video' && isYoutubeUrl(imageUrl)) {
                String videoId;
                videoId = YoutubePlayer.convertUrlToId(imageUrl)!;

                return YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                );
              } else {
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Container(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.no_photography,
                      size: 100.0,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  bool isYoutubeUrl(String url) {
    final youtubeRegex = RegExp(
      r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$',
    );
    return youtubeRegex.hasMatch(url);
  }
}
