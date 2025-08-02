class QuestionAnswerModel {
  List<QuestionAnswer> questionsAnswers;

  QuestionAnswerModel({required this.questionsAnswers});

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAnswerModel(
      questionsAnswers: List<QuestionAnswer>.from(
        json["questions_answers"].map((x) => QuestionAnswer.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "questions_answers": List<dynamic>.from(
      questionsAnswers.map((x) => x.toJson()),
    ),
  };
}

class QuestionAnswer {
  String? question;
  String? valueType;
  String? answer;

  QuestionAnswer({
     this.question,
     this.valueType,
     this.answer,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
    question: json["question"]??"",
    valueType: json["value_type"]??"",
    answer: json["answer"]??"",
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "value_type": valueType,
    "answer": answer,
  };
}
