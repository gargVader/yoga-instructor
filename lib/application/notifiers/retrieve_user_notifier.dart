import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/retrieve_user_state.dart';
import 'package:sofia/model/attempts.dart';
import 'package:sofia/model/user.dart';
import 'package:sofia/utils/database.dart';

class RetrieveUserNotifier extends StateNotifier<RetrieveUserState> {
  final Database _database;

  RetrieveUserNotifier(this._database) : super(RetrieveUserState());

  Future<void> retrieveUser() async {
    try {
      state = RetrieveUserState.retrieving();
      MyUser user = await _database.retrieveUserInfo();
      List<Attempt> attempts = await _database.retrieveAttempts();
      state = RetrieveUserState.retrieved(user, attempts);
      if (user.accuracy != null) {
        state = RetrieveUserState.hasAccuracyData(user, attempts);
      }
    } catch (error) {
      state = RetrieveUserState.error(message: 'Error retrieveing user info');
    }
  }
}
