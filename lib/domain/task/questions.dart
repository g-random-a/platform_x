// "id": 5,
// "questionTitle": "Would you recommend us to others?",
// "questionDescription": "Yes or No.",
// "questionType": "ShortAnswer"

class  Question {
  String QuestionId;
  String QuestionName;
  String QuestionDescription;
  String QuestionType;
  
  static final List<String> hospitalFields = [
    'QuestionId',
    'QuestionName',
    'QuestionDescription',
    'QuestionType',
  ];

  Question({
    required this.QuestionId,
    required this.QuestionName,
    required this.QuestionDescription,
    required this.QuestionType,
  });

  factory  Question.fromJson(Map<String, dynamic> json) {
    return Question(
      QuestionId: json['QuestionId'],
      QuestionName: json['QuestionName'],
      QuestionDescription: json['QuestionDescription'],
      QuestionType: json['QuestionType'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    // json['feedbackId'] = feedbackId;
    json['QuestionId'] = QuestionId;
    json['QuestionName'] = QuestionName;
    json['QuestionDescription'] = QuestionDescription;
    json['QuestionType'] = QuestionType;
    return json;
  }

  @override
  String toString() {
    return " Question: $QuestionName";
  }
}
