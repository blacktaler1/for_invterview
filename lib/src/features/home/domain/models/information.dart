import 'package:for_invterview2/src/shared/domain/domain.dart';

class InformationModel extends Model {
  final int id;
  final String name;
  final String status;
  final String image;
  final String species;
  final String gender;
  final String locationName;

  const InformationModel({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.species,
    required this.gender,
    required this.locationName,
  });

  factory InformationModel.fromMap(Map<String, dynamic> map) {
    return InformationModel(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      image: map['image'] as String,
      species: map['species'] as String,
      gender: map['gender'] as String,
      locationName: map['locationName'] as String,
    );
  }

  @override
  List<String> get props => [
    "id: $id",
    "name: $name",
    "status: $status",
    "image: $image",
    "species: $species",
    "gender: $gender",
    "locationName: $locationName",
  ];
}
