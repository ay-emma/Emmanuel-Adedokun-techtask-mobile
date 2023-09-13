class Ingredent {
  String title;
  DateTime date;
  Ingredent({
    required this.title,
    required this.date,
  });

  factory Ingredent.fromJson(Map<String, dynamic> json) {
    //Todo: change this to the new pattern matching method
    return Ingredent(
      title: json['title'] as String,
      date: DateTime.parse(json["use-by"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'date': this.date.toString(),
    };
  }
}
