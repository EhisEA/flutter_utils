import 'package:freezed_annotation/freezed_annotation.dart';

import '../failure/api_failure.dart';

part 'view_model_state.freezed.dart';

@freezed
class ViewModelState with _$ViewModelState {
  const factory ViewModelState.idle() = _Idle;
  const factory ViewModelState.error(ApiFailure failure) = _Error;
  const factory ViewModelState.busy() = _Busy;
}
