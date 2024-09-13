class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      gender: json["gender"],
      origin: Origin.fromJson(json["origin"]),
      location: Location.fromJson(json["location"]),
      image: json["image"],
    );
  }
}

class Origin {
  final String name;
  final String url;

  Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json["name"],
      url: json["url"],
    );
  }
}

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      url: json["url"],
    );
  }
}
// class Character {
//
//   late int id;
//   late String name;
//   late String status;
//   late String species;
//   late String gender;
//   late List<dynamic> origin;
//   late List<dynamic> location;
//   late String image;
//
//   Character.fromJson(Map<String,dynamic> json){
//     id=json["id"];
//     name=json["name"];
//     status=json["status"];
//     species=json["species"];
//     gender=json["gender"];
//     origin=json["origin"];
//     location=json["location"];
//     image=json["image"];
//   }
//
// }

