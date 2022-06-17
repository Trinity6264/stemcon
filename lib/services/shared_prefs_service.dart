import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsservice {

  Future savedProjectId(String projectId) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('projectId', projectId);
  }

  Future loadProjectId() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('projectId');
  }

  // saving data

  Future savedUserState(int state) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('isLogin', state);
  }

  Future savedUserPhotoId(int state) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('photoId', state);
  }
  Future savedId(int state) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('ids', state);
  }

  Future<int?> loadUserPhotoId() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('photoId');
  }

  Future<int?> loadUserState() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('isLogin');
  }

  Future savedUserData({
    required String key,
    required dynamic value,
    required int index,
  }) async {
    final _prefs = await SharedPreferences.getInstance();
    index == 0 ? _prefs.setInt(key, value) : _prefs.setString(key, value);
  }

  // reload latest data been stored shared prefs
  Future<void> reloadData() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.reload();
  }

  // TODO: Retrive User data from shared prefs

  Future<int?> loadUserId() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('id');
  }

  Future<String?> loadUserCompanyCode() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('company_code');
  }

  Future<String?> loadUserCountryCode() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('country_code');
  }

  Future<String?> loadUserOtp() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('otp');
  }

  Future<String?> loadUserIsAdmin() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('is_admin');
  }

  Future<String?> loadUserStatus() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('status');
  }

  Future<int?> loadUserAuthenticationToken() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('authentication_token');
  }

  Future<String?> loadUserCreatedAt() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('created_at');
  }

  Future<String?> loadUserUpdatedAt() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('updated_at');
  }

  // this id for the edit profile
  Future<int?> loadId() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('ids');
  }

  // clear values
  Future clearData() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.clear();
  }
}
