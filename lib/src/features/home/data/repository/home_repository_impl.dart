import 'package:for_invterview2/src/features/home/home.dart';
import 'package:for_invterview2/src/shared/aplication/exceptions/base_exception.dart';
import 'package:for_invterview2/src/shared/aplication/utils/safed.dart';

final class HomRepositoryImpl extends HomeRepository {
  final HomeRemoteSource remote;

  HomRepositoryImpl({required this.remote});
  @override
  Future<Safed<BaseException, List<InformationModel>>> getHomeData({
    InformationPayload payload = const InformationPayload(),
  }) async {
    return remote
        .getHomeData(request: InformationRequest.fromPayload(payload))
        .map<BaseException, List<InformationModel>>(
          success: (dto) => (dto as InformationListDto?)?.model() ?? [],
        );
  }
}
