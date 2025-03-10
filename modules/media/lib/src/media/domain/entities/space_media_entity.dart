import 'package:core/core.dart';

class SpaceMediaEntity extends Equatable {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;
  final String? thumbnailUrl;
  final bool? isFavorite;

  const SpaceMediaEntity({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
    this.isFavorite,
  });

  factory SpaceMediaEntity.fromJson(Map<String, dynamic> json) {
    return SpaceMediaEntity(
      copyright: json['copyright'] as String?,
      date: json['date'] as String?,
      explanation: json['explanation'] as String?,
      hdurl: json['hdurl'] as String?,
      mediaType: json['media_type'] as String?,
      serviceVersion: json['service_version'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      isFavorite: json['is_favorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'copyright': copyright,
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'media_type': mediaType,
      'service_version': serviceVersion,
      'title': title,
      'url': url,
      'thumbnail_url': thumbnailUrl,
      'is_favorite': isFavorite,
    };
  }

  @override
  List<Object?> get props {
    return [
      copyright,
      date,
      explanation,
      hdurl,
      mediaType,
      serviceVersion,
      title,
      url,
      thumbnailUrl,
      isFavorite,
    ];
  }
}
