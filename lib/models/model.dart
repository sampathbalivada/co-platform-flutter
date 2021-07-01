import 'package:scoped_model/scoped_model.dart';
import 'package:supabase/supabase.dart' as sb;

class COPlatform extends Model {
  final _supabaseClient = sb.SupabaseClient(
    'https://wbuhlcfdloobzennktsc.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNTEzMzU5NSwiZXhwIjoxOTQwNzA5NTk1fQ.UAGKph4zLvAMnF1ehFGpaQFpHlhqT6Exu2x5T1Udfus',
  );

  List<dynamic> _roles = [];

  sb.SupabaseClient get supabaseClient => _supabaseClient;

  String? get emailId {
    return _supabaseClient.auth.user()?.email;
  }

  // List<String> get roles => _roles;

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
      final roles = await this
          ._supabaseClient
          .from('roles_assigned')
          .select('role')
          .match({'email': emailId}).execute();

      this._roles = roles.data[0]['role'];
      return true;
    }
  }

  Future<bool> signUp(String emailId, String password) async {
    final response = await this.supabaseClient.auth.signUp(emailId, password);

    if (response.error != null) {
      print(response.error);
      // ERROR: Prompt the user to try again!
      return false;
    } else {
      // SUCCESS: User and session available!
      return true;
    }
  }
}
