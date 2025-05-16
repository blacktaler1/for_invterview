import '../../../../shared/domain/domain.dart';

class CharacterEntity extends Model {
  final int id;
  final String name;
  final String status;
  final String image;
  final String species;
  final String gender;
  final String locationName;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.species,
    required this.gender,
    required this.locationName,
  });

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
