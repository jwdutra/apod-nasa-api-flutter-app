import 'package:core/core.dart';

class SpaceMediaModel extends Equatable {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  const SpaceMediaModel(
      {this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.mediaType,
      this.serviceVersion,
      this.title,
      this.url,
      this.thumbnailUrl});

  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) {
    return SpaceMediaModel(
        copyright: json['copyright'] as String?,
        date: json['date'] as String?,
        explanation: json['explanation'] as String?,
        hdurl: json['hdurl'] as String?,
        mediaType: json['media_type'] as String?,
        serviceVersion: json['service_version'] as String?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        thumbnailUrl: json['thumbnail_url'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'copyright': copyright,
        'date': date,
        'explanation': explanation,
        'hdurl': hdurl,
        'media_type': mediaType,
        'service_version': serviceVersion,
        'title': title,
        'url': url,
        'thumbnail_url': thumbnailUrl
      };

  SpaceMediaModel copyWith(
      {String? copyright,
      String? date,
      String? explanation,
      String? hdurl,
      String? mediaType,
      String? serviceVersion,
      String? title,
      String? url,
      String? thumbnailUrl}) {
    return SpaceMediaModel(
        copyright: copyright ?? this.copyright,
        date: date ?? this.date,
        explanation: explanation ?? this.explanation,
        hdurl: hdurl ?? this.hdurl,
        mediaType: mediaType ?? this.mediaType,
        serviceVersion: serviceVersion ?? this.serviceVersion,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl);
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
      thumbnailUrl
    ];
  }
}
