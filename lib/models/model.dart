import 'package:scoped_model/scoped_model.dart';
import 'package:supabase/supabase.dart' as sb;

class Course {
  final courseCode;
  final courseName;
  final batch;
  final year;
  final semester;
  final id;
  final branchCode;

  Course(
    this.courseCode,
    this.courseName,
    this.batch,
    this.year,
    this.semester,
    this.id,
    this.branchCode,
  );
}

class Question {
  final int number;
  final int maxMarks;
  // ignore: non_constant_identifier_names
  final int COMapped;

  Question(
    this.number,
    this.maxMarks,
    this.COMapped,
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

  int _mid = 1;

  Course? _currentCourse;

  List<Question> _questions = [];

  // =============
  // ===Getters===
  // =============
  Map<String, List> get tasks => _tasks;
  sb.SupabaseClient get supabaseClient => _supabaseClient;
  String? get emailId => _supabaseClient.auth.user()?.email;
  List<dynamic> get roles => _roles;
  Map<String, List<Course>> get coursesAssigned => _coursesAssigned;
  Course? get currentCourse => _currentCourse;
  List<Question> get questions => _questions;
  int get mid => _mid;

  // =============
  // ===Setters===
  // =============

  void setCurrentCourse(Course currentCourse) {
    this._currentCourse = currentCourse;
  }

  // =============
  // === AUTH ====
  // =============

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

  // =============
  // ==== HOD ====
  // =============

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

    var facultyEmailIDsModified;

    if (facultyEmails.data[0]['faculty_emails'] == null) {
      facultyEmailIDsModified = [];
    } else {
      facultyEmailIDsModified = facultyEmails.data[0]['faculty_emails'];
    }

    print(facultyEmailIDsModified);

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
      final result = await this._supabaseClient.from('roles_assigned').upsert(
        {
          'email': facultyEmail,
          'role': 'Faculty',
          'branch_code': 0,
        },
      ).execute();

      if (result.error != null) {
        print(result.error?.message);
        return false;
      } else {
        return true;
      }
    }
  }

  // =====================
  // ==== Coordinator ====
  // =====================

  Future<bool> getAssignedCoursesForCoordinator() async {
    final result = await this
        ._supabaseClient
        .from('courses')
        .select('course_code, name, batch, branch_code, course_id')
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
              data[i]['course_id'],
              data[i]['branch'],
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
              data[i]['course_id'],
              data[i]['branch'],
            ),
          ];
        }
      }
      // print(_coursesAssigned);
      return true;
    }
  }

  void storeCOMapping(
    int numberOfQuestions,
    // ignore: non_constant_identifier_names
    List<int> COMapping,
    List<int> maxMarks,
    int mid,
  ) {
    _mid = mid;

    List<Question> questions = [];

    for (var i = 0; i < numberOfQuestions; i++) {
      questions.add(Question(i + 1, maxMarks[i], COMapping[i]));
    }

    _questions = questions;

    print(questions);
  }

  Future<bool> updateCOMappingAndThreshold(List<int> thresholdValues) async {
    int courseMidIdentifierID;

    // Push values to course_mid_dentifier
    final addNewMidForCourse =
        await this._supabaseClient.from('course_mid_identifier').upsert(
      {
        'course_id': _currentCourse?.id,
        'mid': _mid.toString(),
      },
    ).execute();

    if (addNewMidForCourse.error != null) {
      print('Error: Add Mid For Course');
      print(addNewMidForCourse.error?.message);
      return false;
    } else {
      print(addNewMidForCourse.data);
      // Get ID from course_mid_identifier
      courseMidIdentifierID = addNewMidForCourse.data[0]['id'];
    }

    // Push values to co_mapping
    var questionCOMapping = [];

    for (var question in _questions) {
      questionCOMapping.add({
        'id': courseMidIdentifierID,
        'question_number': question.number,
        'max_marks': question.maxMarks,
        'co': question.COMapped,
      });
    }

    final pushValesToCOMapping = await this
        ._supabaseClient
        .from('co_mapping')
        .upsert(questionCOMapping)
        .execute();

    if (pushValesToCOMapping.error != null) {
      print('Error: Push Values to CO Mapping');
      print(pushValesToCOMapping.error?.message);
      return false;
    } else {
      print(pushValesToCOMapping.data);
    }

    // Push values to co_threshold
    // ignore: non_constant_identifier_names
    var COThresholdMapping = [];

    for (var i = 0; i < thresholdValues.length; i++) {
      COThresholdMapping.add({
        'id': courseMidIdentifierID,
        'co': i + 1,
        'threshold': thresholdValues[i],
      });
    }

    final result = await this
        ._supabaseClient
        .from('co_threshold')
        .upsert(COThresholdMapping)
        .execute();

    if (result.error != null) {
      print('Error: Push Values to CO Threshold');
      print(result.error?.message);
      return false;
    } else {
      // return success
      return true;
    }
  }

  // =================
  // ==== Faculty ====
  // =================

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
              data[i]['course_id'],
              data[i]['branch'],
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
              data[i]['course_id'],
              data[i]['branch'],
            ),
          ];
        }
      }
      // print(_coursesAssigned);
      return true;
    }
  }
}
