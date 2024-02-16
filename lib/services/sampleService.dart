import 'package:shared_preferences/shared_preferences.dart';

updateUserLocally(String fname, String lname, String email, String enrollNo,
    String college, String branch) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("fname", fname);
  prefs.setString("lname", lname);
  prefs.setString("email", email);
  prefs.setString("enrollNo", enrollNo);
  prefs.setString("college", college);
  prefs.setString("branch", branch);
}
