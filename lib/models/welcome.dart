import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.data,
  });

  Characters data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    data: Characters.fromJson(json["characters"]),
  );

  Map<String, dynamic> toJson() => {
    "characters": data.toJson(),
  };
}

class Data {
  Data({
    this.characters,
  });

  Characters characters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    characters: json["characters"] == null ? null : Characters.fromJson(json["characters"]),
  );

  Map<String, dynamic> toJson() => {
    "characters": characters.toJson(),
  };
}

class Characters {
  Characters({
    this.results,
  });

  List<Result> results;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.status,
  });

  String id;
  String name;
  Status status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": statusValues.reverse[status],
  };
}

enum Status { ALIVE, UNKNOWN, DEAD }

final statusValues = EnumValues({
  "Alive": Status.ALIVE,
  "Dead": Status.DEAD,
  "unknown": Status.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
