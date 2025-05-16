import 'package:for_invterview2/src/features/home/domain/domain.dart';
import 'package:for_invterview2/src/shared/aplication/aplication.dart';

abstract class HomeRepository {
  Future<Safed<BaseException, List<InformationModel>>> getHomeData({
    InformationPayload payload,
  });
}
