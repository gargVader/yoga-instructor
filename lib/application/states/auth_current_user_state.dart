import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sofia/model/user.dart';

part 'auth_current_user_state.freezed.dart';

@freezed
class AuthCurrentUserState with _$AuthCurrentUserState {
  const factory AuthCurrentUserState() = InitialUser;
  const factory AuthCurrentUserState.finding() = Finding;
  const factory AuthCurrentUserState.alreadySignedIn(MyUser user) =
      SignedInUser;
  const factory AuthCurrentUserState.detailsNotUploaded(User user) =
      DetailsNotUploaded;
  const factory AuthCurrentUserState.notSignedIn() = NotSignedInUser;
  const factory AuthCurrentUserState.error({String? message}) = Error;
}
