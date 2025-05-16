import 'package:for_invterview2/src/features/home/domain/models/models.dart';
import 'package:for_invterview2/src/shared/aplication/aplication.dart';

import '../../../../shared/data/data.dart';

final class InformationListDto extends ListJsonDto<InformationModel> {
  final Json json;

  InformationListDto.fromJson(this.json) : super.fromJson(json);

  @override
  List<InformationModel> model() {
    final List results = json['results'];
    return results
        .map(
          (e) => InformationModel(
            id: e['id'],
            name: e['name'],
            status: e['status'],
            image: e['image'],
            species: e['species'],
            gender: e['gender'],
            locationName: e['location']['name'],
          ),
        )
        .toList();
  }
}
