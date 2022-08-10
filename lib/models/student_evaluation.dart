class StudentEvaluation {
  final String courseName;
  final int quizzes;
  final int quarterlyExam;
  final month;

  StudentEvaluation(
      {required this.courseName,
      required this.quizzes,
      required this.quarterlyExam,
      this.month});

  factory StudentEvaluation.fromJson(dynamic json) {
    return StudentEvaluation(
        courseName: json['course_name'],
        quizzes: json['quizzes'],
        quarterlyExam: json['quarterly_exam'],
        month: json['month'].toString() ?? "");
  }
}

class EvaluationResponse {
  final bool status;
  final String errorNum;
  final String msg;
  final List<StudentEvaluation> evaluation;

  EvaluationResponse(
      {required this.status,
      required this.errorNum,
      required this.msg,
      required this.evaluation});

  factory EvaluationResponse.fromJson(dynamic json) {
    var list = (json['evaluation'] == null) ? [] : (json['evaluation'] as List);
    var evaluation = list.map((e) => StudentEvaluation.fromJson(e)).toList();

    return EvaluationResponse(
      status: json['status'] as bool,
      errorNum: json['errNum'] as String,
      msg: json['msg'] as String,
      evaluation: evaluation,
    );
  }

  factory EvaluationResponse.empty() {
    return EvaluationResponse(
        errorNum: '', status: false, msg: 'Error', evaluation: []);
  }
}

class StudentAnnualEvaluation {
  final String courseName;
  final int mark;
  final int finalExam;
  final int finalMark;

  StudentAnnualEvaluation({
    required this.courseName,
    required this.mark,
    required this.finalExam,
    required this.finalMark,
  });

  factory StudentAnnualEvaluation.fromJson(dynamic json) {
    return StudentAnnualEvaluation(
      courseName: json['course_name'],
      mark: int.parse(json['quizzes_sum']),
      finalExam: int.parse(json['quarterly_exam_sum']),
      finalMark: int.parse(json['quizzes_sum']) + int.parse(json['quarterly_exam_sum']),
    );
  }
}

class AnnualEvaluationResponse {
  final bool status;
  final String errorNum;
  final String msg;
  final List<StudentAnnualEvaluation> evaluation;

  AnnualEvaluationResponse(
      {required this.status,
      required this.errorNum,
      required this.msg,
      required this.evaluation});

  factory AnnualEvaluationResponse.fromJson(dynamic json) {
    var list = (json['users'] == null) ? [] : (json['users'] as List);
    var evaluation =
        list.map((e) => StudentAnnualEvaluation.fromJson(e)).toList();

    return AnnualEvaluationResponse(
      status: json['status'] as bool,
      errorNum: json['errNum'] as String,
      msg: json['msg'] as String,
      evaluation: evaluation,
    );
  }

  factory AnnualEvaluationResponse.empty() {
    return AnnualEvaluationResponse(
        errorNum: '', status: false, msg: 'Error', evaluation: []);
  }
}
