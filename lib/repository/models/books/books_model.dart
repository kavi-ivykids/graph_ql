import 'package:json_annotation/json_annotation.dart';

part 'books_model.g.dart';

@JsonSerializable()
class BookModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'author')
  final String author;
  @JsonKey(name: 'year')
  final int year;

  BookModel(
    this.id, {
    required this.title,
    required this.author,
    required this.year,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
