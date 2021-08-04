import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/retrieve_attempts_state.dart';
import 'package:sofia/model/attempts.dart';
import 'package:sofia/utils/database.dart';

class RetrieveAttemptsNotifier extends StateNotifier<RetrieveAttemptsState> {
  final Database _database;

  RetrieveAttemptsNotifier(this._database) : super(RetrieveAttemptsState());

  Future<void> retrieveAttempts() async {
    try {
      state = RetrieveAttemptsState.retrieving();
      List<Attempt> attempts = await _database.retrieveAttempts();
      state = RetrieveAttemptsState.retrieved(attempts);
    } catch (error) {
      state = RetrieveAttemptsState.error(message: 'Error retrieving attempts');
    }
  }
}
