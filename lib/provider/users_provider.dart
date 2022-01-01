import 'package:android_dev_test/api/api_service.dart';
import 'package:android_dev_test/model/user_result.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { Loading, NoData, HasData, Error }

class UsersProvider extends ChangeNotifier {
  late final ApiService apiService;

  UsersProvider({required this.apiService}) {
    fetchAllUser(1);
  }

  late UserResult _userResult;

  late ResultState _state;

  String _message = '';

  String get message => _message;

  UserResult get result => _userResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllUser(int page) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final user = await apiService.getUser(page);
      if (user.data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty User';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _userResult = user;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No internet connection';
    }
  }
}
