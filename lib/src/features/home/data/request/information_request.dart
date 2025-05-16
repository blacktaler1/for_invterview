import 'package:for_invterview2/src/features/home/domain/domain.dart';
import 'package:for_invterview2/src/shared/aplication/types/json.dart';
import 'package:for_invterview2/src/shared/data/data.dart';

final class InformationRequest extends RemoteRequest<InformationPayload> {
  InformationRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
