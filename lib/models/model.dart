import 'package:scoped_model/scoped_model.dart';
import 'package:supabase/supabase.dart' as sb;

class COPlatform extends Model {
  final _supabaseClient = sb.SupabaseClient(
    'https://wbuhlcfdloobzennktsc.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNTEzMzU5NSwiZXhwIjoxOTQwNzA5NTk1fQ.UAGKph4zLvAMnF1ehFGpaQFpHlhqT6Exu2x5T1Udfus',
  );
  sb.User? _user;
  sb.Session? _session;

  sb.SupabaseClient get supabaseClient => _supabaseClient;
  sb.User? get user => _user;
  sb.Session? get session => _session;

  Future<bool> signIn(String emailId, String password) async {
    final response = await this
        .supabaseClient
        .auth
        .signIn(email: emailId, password: password);

    if (response.error != null) {
      print(response.error);
      return false;
      // ERROR: Prompt the user to try again!
    } else {
      // SUCCESS: User and session available!
      print(response.user);
      this._user = response.user;
      this._session = response.data;

      return true;
    }
  }

  Future<bool> signUp(String emailId, String password) async {
    final response = await this.supabaseClient.auth.signUp(emailId, password);

    if (response.error != null) {
      print(response.error);
      return false;
      // ERROR: Prompt the user to try again!
    } else {
      // SUCCESS: User and session available!
      print(response.user);
      this._user = response.user;
      this._session = response.data;

      return true;
    }
  }
}
