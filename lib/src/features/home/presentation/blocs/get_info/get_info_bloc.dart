import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../home.dart';

part 'get_info_event.dart';
part 'get_info_state.dart';

class GetInfoBloc extends Bloc<GetInfoEvent, GetInfoState> {
  final HomeRepository repository;
  GetInfoBloc({required this.repository}) : super(GetInfoStateInitial()) {
    on<GetInfoEventStart>(_onGetInfoEventStart);
  }
  Future<void> _onGetInfoEventStart(
    GetInfoEventStart event,
    Emitter<GetInfoState> emit,
  ) async {
    emit(const GetInfoStateInPrepare());
    final result = await repository.getHomeData();

    result.when(
      success: (model) => emit(GetInfoStateSuccess(model: model)),
      failure: (error) => emit(GetInfoStateFailure(error: error)),
    );
  }
}
