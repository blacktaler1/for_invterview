part of 'get_info_bloc.dart';

sealed class GetInfoEvent extends Equatable {
  const GetInfoEvent();

  @override
  List<Object> get props => [];
}

final class GetInfoEventStart extends GetInfoEvent {
  const GetInfoEventStart();

  @override
  List<Object> get props => [];
}
