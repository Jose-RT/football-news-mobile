// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

List<NewsEntry> newsEntryFromJson(String str) => List<NewsEntry>.from(json.decode(str).map((x) => NewsEntry.fromJson(x)));

String newsEntryToJson(List<NewsEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsEntry {
    Model model;
    String pk;
    Fields fields;

    NewsEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    dynamic get user => fields.user;
    String get title => fields.title;
    String get content => fields.content;
    String get category => fields.category;
    String? get thumbnail => fields.thumbnail;
    int get newsViews => fields.newsViews;
    DateTime get createdAt => fields.createdAt;
    bool get isFeatured => fields.isFeatured;

    factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    dynamic user;
    String title;
    String content;
    String category;
    String? thumbnail;
    int newsViews;
    DateTime createdAt;
    bool isFeatured;

    Fields({
        required this.user,
        required this.title,
        required this.content,
        required this.category,
        required this.thumbnail,
        required this.newsViews,
        required this.createdAt,
        required this.isFeatured,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        content: json["content"],
        category: json["category"],
        thumbnail: json["thumbnail"] ?? "",
        newsViews: json["news_views"],
        createdAt: DateTime.parse(json["created_at"]),
        isFeatured: json["is_featured"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "content": content,
        "category": category,
        "thumbnail": thumbnail,
        "news_views": newsViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
    };
}

enum Model {
    mainNews
}

final modelValues = EnumValues({
    "main.news": Model.mainNews
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
