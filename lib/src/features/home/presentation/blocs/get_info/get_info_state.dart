part of 'get_info_bloc.dart';

sealed class GetInfoState extends Equatable {
  const GetInfoState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(List<InformationModel> model) success,
    required T Function(BaseException) failure,
  }) {
    return switch (this) {
      GetInfoStateInitial() => initial(),
      GetInfoStateInPrepare() => inPrepare(),
      GetInfoStateSuccess(:final model) => success(model),
      GetInfoStateFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(List<InformationModel> model)? success,
    T Function(BaseException)? failure,
    required T Function() orElse,
  }) {
    return when(
      initial: initial ?? orElse,
      inPrepare: inPrepare ?? orElse,
      failure: failure ?? (_) => orElse(),
      success: success ?? (_) => orElse(),
    );
  }

  @override
  List<Object> get props => [];
}

class GetInfoStateInitial extends GetInfoState {}

class GetInfoStateInPrepare extends GetInfoState {
  const GetInfoStateInPrepare();

  @override
  List<Object> get props => [];
}

class GetInfoStateSuccess extends GetInfoState {
  final List<InformationModel> model;

  const GetInfoStateSuccess({required this.model});

  @override
  List<Object> get props => [model];
}

class GetInfoStateFailure extends GetInfoState {
  final BaseException error;

  const GetInfoStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}
