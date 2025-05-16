import '../../../../../shared/shared.dart';
import '../../../home.dart';

final class HomeRemoteSource extends RemoteSource {
  HomeRemoteSource({required super.client});

  Future<Safed<BaseException, InformationListDto>> getHomeData({
    required InformationRequest request,
  }) async {
    final response = await apiGet(path: '/character', request: request);

    return response.map(
      success: (json) {
        final data = switch (json) {
          {'data': final innerJson} => innerJson as Json,
          _ => json,
        };
        return InformationListDto.fromJson(data);
      },
    );
  }
}
