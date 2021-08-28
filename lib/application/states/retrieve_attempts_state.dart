import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sofia/model/attempts.dart';

part 'retrieve_attempts_state.freezed.dart';

@freezed
class RetrieveAttemptsState with _$RetrieveAttemptsState {
  const factory RetrieveAttemptsState() = InitialAttemptData;
  const factory RetrieveAttemptsState.retrieving() = RetrievingAttempts;
  const factory RetrieveAttemptsState.retrieved(List<Attempt> attempts) =
      RetrievedAttempts;
  const factory RetrieveAttemptsState.error({String? message}) =
      ErrorRetrievingAttempts;
}
