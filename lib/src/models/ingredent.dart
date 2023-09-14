import 'package:equatable/equatable.dart';

class Ingredent extends Equatable {
  final String title;
  final DateTime date;
  Ingredent({
    required this.title,
    required this.date,
  });

  factory Ingredent.fromJson(Map<String, dynamic> json) {
    return Ingredent(
      title: json['title'] as String,
      date: DateTime.parse(json["use-by"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'use-by': this.date.toString(),
    };
  }

  @override
  List<Object?> get props => [title, date];

  @override
  bool? get stringify => true;
}
