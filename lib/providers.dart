import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/notifiers/auth_current_user_notifier.dart';
import 'package:sofia/application/notifiers/auth_sign_in_notifier.dart';
import 'package:sofia/application/notifiers/retrieve_attempts_notifier.dart';
import 'package:sofia/application/notifiers/retrieve_poses_notifier.dart';
import 'package:sofia/application/notifiers/retrieve_tracks_notifier.dart';
import 'package:sofia/application/notifiers/retrieve_user_notifier.dart';
import 'package:sofia/application/notifiers/store_user_data_notifier.dart';
import 'package:sofia/application/notifiers/store_user_score_notifier.dart';
import 'package:sofia/application/notifiers/voice_listen_notifier.dart';
import 'package:sofia/utils/authentication_client.dart';
import 'package:sofia/utils/database.dart';

import 'application/states/auth_current_user_state.dart';
import 'application/states/auth_sign_in_state.dart';
import 'application/states/retrieve_attempts_state.dart';
import 'application/states/retrieve_tracks_state.dart';
import 'application/states/retrieve_user_state.dart';
import 'application/states/store_user_data_state.dart';
import 'application/states/store_user_score_state.dart';
import 'application/states/voice_listen_state.dart';

final authenticationClientProvider = Provider<AuthenticationClient>(
  (ref) => AuthenticationClient(),
);

final databaseProvider = Provider<Database>(
  (ref) => Database(),
);

final authSignInNotifierProvider =
    StateNotifierProvider<AuthSignInNotifier, AuthSignInState>(
  (ref) => AuthSignInNotifier(ref.watch(authenticationClientProvider)),
);

final authCurrentUserNotifierProvider =
    StateNotifierProvider<AuthCurrentUserNotifier, AuthCurrentUserState>(
  (ref) => AuthCurrentUserNotifier(
    ref.watch(authenticationClientProvider),
    ref.watch(databaseProvider),
  ),
);

final storeUserDataNotifierProvider =
    StateNotifierProvider<StoreUserDataNotifier, StoreUserDataState>(
  (ref) => StoreUserDataNotifier(ref.watch(databaseProvider)),
);

final storeUserScoreNotifierProvider =
    StateNotifierProvider<StoreUserScoreNotifier, StoreUserScoreState>(
  (ref) => StoreUserScoreNotifier(ref.watch(databaseProvider)),
);

final retrieveAttemptsNotifierProvider =
    StateNotifierProvider<RetrieveAttemptsNotifier, RetrieveAttemptsState>(
  (ref) => RetrieveAttemptsNotifier(ref.watch(databaseProvider)),
);

final StateNotifierProviderFamily<RetrievePosesNotifier, dynamic, dynamic>?
    retrievePosesNotifierProvider = StateNotifierProvider.family(
  (ref, dynamic trackName) =>
      RetrievePosesNotifier(ref.watch(databaseProvider), trackName),
);

final retrieveTracksNotifierProvider =
    StateNotifierProvider<RetrieveTracksNotifier, RetrieveTracksState>(
  (ref) => RetrieveTracksNotifier(ref.watch(databaseProvider)),
);

final retrieveUserNotifierProvider =
    StateNotifierProvider<RetrieveUserNotifier, RetrieveUserState>(
  (ref) => RetrieveUserNotifier(ref.watch(databaseProvider)),
);

final voiceListenNotifierProvider =
    StateNotifierProvider<VoiceListenNotifier, VoiceListenState>(
  (ref) => VoiceListenNotifier(),
);
