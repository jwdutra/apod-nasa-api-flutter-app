import 'package:core/core.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    super.key,
    required this.urlImage,
  });

  final String? urlImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage ?? '',
      placeholder: (context, url) => CircleAvatar(
        backgroundColor: Colors.grey[400],
        radius: 20,
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: 20,
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        child: Icon(
          Icons.no_photography,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
