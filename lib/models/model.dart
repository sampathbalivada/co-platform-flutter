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

  int _branchCode = 0;

  Map<String, List> _tasks = {
    "Faculty": ["Upload Marks"],
    "HOD": ["Calculate Statistics", "Add Course", "Add Faculty to Course"],
    "Course Coordinator": ["Assign CO Threshold"],
    "Common": ["Check Statistics"]
  };

  Map<String, List<Course>> _coursesAssigned = {};

  List<dynamic> _roles = ["Common"];

  Course? _currentCourse;

  // Getters
  Map<String, List> get tasks => _tasks;
  sb.SupabaseClient get supabaseClient => _supabaseClient;
  String? get emailId => _supabaseClient.auth.user()?.email;
  List<dynamic> get roles => _roles;
  Map<String, List<Course>> get coursesAssigned => _coursesAssigned;
  Course? get currentCourse => _currentCourse;

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
          .select('role, branch_code')
          .match({'email': emailId}).execute();

      for (int i = 0; i < roles.data.length; i++) {
        _roles.add(roles.data[i]["role"]);
        _branchCode =
            _branchCode == 0 ? roles.data[i]["branch_code"] : _branchCode;
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
    int branchCode,
  ) async {
    final result = await this._supabaseClient.from('courses').upsert(
      {
        'course_code': courseCode,
        'batch': batch,
        'name': courseName,
        'coordinator_email': coordinatorEmail,
        'branch_code': branchCode,
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

  Future<bool> addFacultyToCourse(
    String courseCode,
    String batch,
    int branchCode,
    String facultyEmail,
  ) async {
    final facultyEmails = await this
        ._supabaseClient
        .from('courses')
        .select('faculty_emails')
        .match({
      'course_code': courseCode,
      'batch': batch,
      'branch_code': branchCode,
    }).execute();

    var facultyEmailIDsModified = facultyEmails.data[0]['faculty_emails'];

    if (facultyEmailIDsModified.contains(facultyEmail)) {
      return false;
    }

    facultyEmailIDsModified.add(facultyEmail);

    final result = await this._supabaseClient.from('courses').upsert(
      {
        'course_code': courseCode,
        'batch': batch,
        'branch_code': branchCode,
        'faculty_emails': facultyEmailIDsModified,
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
        .select('course_code, name, batch')
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

      var data = result.data;

      _coursesAssigned = {};

      for (var i = 0; i < data.length; i++) {
        if (_coursesAssigned.containsKey(data[i]['course_code'][6])) {
          _coursesAssigned[data[i]['batch']]?.add(
            Course(
              data[i]['course_code'],
              data[i]['name'],
              data[i]['batch'],
              int.parse(data[i]['course_code'][6]),
              int.parse(data[i]['course_code'][7]),
            ),
          );
        } else {
          _coursesAssigned[data[i]['batch']] = [
            Course(
              data[i]['course_code'],
              data[i]['name'],
              data[i]['batch'],
              int.parse(data[i]['course_code'][6]),
              int.parse(data[i]['course_code'][7]),
            ),
          ];
        }
      }
      // print(_coursesAssigned);
      return true;
    }
  }

  void setCurrentCourse(Course currentCourse) {
    this._currentCourse = currentCourse;
  }

  Future<bool> updateCOThreshold(List<int> thresholdValues, int mid) async {
    print('Model');

    final result = await this._supabaseClient.from('co_threshold').upsert({
      'course_code': _currentCourse?.courseCode,
      'batch': _currentCourse?.batch,
      'one': thresholdValues[0],
      'two': thresholdValues[1],
      'three': thresholdValues[2],
      'four': thresholdValues[3],
      'mid': mid,
    }).execute();

    if (result.error != null) {
      print(result.error?.message);
      return false;
    } else {
      // return success
      return true;
    }
  }

  Future<bool> getAssignedCoursesForFaculty() async {
    final result = await this
        ._supabaseClient
        .from('courses')
        .select('course_code, name, batch')
        .contains('faculty_emails', ['me@sampath.dev']).execute();

    if (result.error != null) {
      print(result.error?.message);
      return false;
    } else {
      // return success

      var data = result.data;

      _coursesAssigned = {};

      for (var i = 0; i < data.length; i++) {
        if (_coursesAssigned.containsKey(data[i]['course_code'][6])) {
          _coursesAssigned[data[i]['batch']]?.add(
            Course(
              data[i]['course_code'],
              data[i]['name'],
              data[i]['batch'],
              int.parse(data[i]['course_code'][6]),
              int.parse(data[i]['course_code'][7]),
            ),
          );
        } else {
          _coursesAssigned[data[i]['batch']] = [
            Course(
              data[i]['course_code'],
              data[i]['name'],
              data[i]['batch'],
              int.parse(data[i]['course_code'][6]),
              int.parse(data[i]['course_code'][7]),
            ),
          ];
        }
      }
      // print(_coursesAssigned);
      return true;
    }
  }
}
