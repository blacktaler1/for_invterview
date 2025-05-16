import 'package:hive/hive.dart';

import '../../home.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class InformationHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String species;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String locationName;

  InformationHiveModel({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.species,
    required this.gender,
    required this.locationName,
  });

  InformationModel toDomain() => InformationModel(
    id: id,
    name: name,
    status: status,
    image: image,
    species: species,
    gender: gender,
    locationName: locationName,
  );

  static InformationHiveModel fromDomain(InformationModel model) =>
      InformationHiveModel(
        id: model.id,
        name: model.name,
        status: model.status,
        image: model.image,
        species: model.species,
        gender: model.gender,
        locationName: model.locationName,
      );
}
