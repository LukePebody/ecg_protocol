import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart';

@JsonSerializable()
class CardData {
  final String id;
  final String name;
  final String faceImageUrl;
  final String backImageUrl;
  final String exposedFaceImageUrl; // Simple card image for mobile/hand view
  final bool isFaceUp;
  final int ranking;
  final String? suit;
  final Map<String, dynamic>? metadata;

  CardData({
    required this.id,
    required this.name,
    required this.faceImageUrl,
    required this.backImageUrl,
    required this.exposedFaceImageUrl,
    required this.isFaceUp,
    required this.ranking,
    this.suit,
    this.metadata,
  });

  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}
