import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/store_user_data_state.dart';
import 'package:sofia/model/user.dart';
import 'package:sofia/utils/database.dart';

class StoreUserDataNotifier extends StateNotifier<StoreUserDataState> {
  final Database _database;

  StoreUserDataNotifier(this._database) : super(StoreUserDataState());

  Future<void> storeData({
    required String uid,
    required String email,
    required String imageUrl,
    required String accountName,
    required String userName,
    required String gender,
    required String age,
  }) async {
    try {
      state = StoreUserDataState.storing();
      MyUser userData = await _database.storeUserData(
        uid: uid,
        email: email,
        imageUrl: imageUrl,
        accountName: accountName,
        userName: userName,
        gender: gender,
        age: age,
      );
      print('USER DATA: $userData');
      state = StoreUserDataState.stored(userData);
    } catch (error) {
      state = StoreUserDataState.error(message: 'Error storing user data');
    }
  }
}
