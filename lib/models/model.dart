import 'package:scoped_model/scoped_model.dart';
import 'package:supabase/supabase.dart' as sb;

class Course {
  final courseCode;
  final courseName;
  final batch;
  final year;
  final semester;

  Course(
    this.courseCode,
    this.courseName,
    this.batch,
    this.year,
    this.semester,
  );
}

class COPlatform extends Model {
  final _supabaseClient = sb.SupabaseClient(
    'https://wbuhlcfdloobzennktsc.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNTEzMzU5NSwiZXhwIjoxOTQwNzA5NTk1fQ.UAGKph4zLvAMnF1ehFGpaQFpHlhqT6Exu2x5T1Udfus',
  );

  Map<String, List> _tasks = {
    "Faculty": ["Upload Marks"],
    "HOD": ["Calculate Statistics", "Add Course"],
    "Course Coordinator": ["Assign CO Threshold"],
    "Common": ["Check Statistics"]
  };

  List<Course> _courseCoordinatorAssignedCourses = [];

  Map<String, List> get tasks => _tasks;
  List<dynamic> _roles = ["Common"];

  sb.SupabaseClient get supabaseClient => _supabaseClient;

  String? get emailId {
    return _supabaseClient.auth.user()?.email;
  }

  List<dynamic> get roles => _roles;

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

      for (int i = 0; i < roles.data.length; i++) {
        _roles.add(roles.data[i]["role"]);
      }
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

  Future<bool> addCourse(
    String courseCode,
    String batch,
    String courseName,
    String coordinatorEmail,
  ) async {
    final result = await this._supabaseClient.from('courses').upsert(
      {
        'course_code': courseCode,
        'batch': batch,
        'name': courseName,
        'coordinator_email': coordinatorEmail,
      },
    ).execute();

    if (result.error != null) {
      print(result.error?.message);
      return false;
    } else {
      // return success
      return true;
    }
  }

  Future<bool> getAssignedCoursesForCoordinator() async {
    final result = await this
        ._supabaseClient
        .from('courses')
        .select('course_code, course_name, batch')
        .match(
      {
        'coordinator_email': _supabaseClient.auth.user()?.email,
      },
    ).execute();

    if (result.error != null) {
      print(result.error?.message);
      return false;
    } else {
      // return success
      print(result.data);
      return true;
    }
  }
}
