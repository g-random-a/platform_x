class Feedback {
  String feedbackId;
  String subject;
  String body;

  static final List<String> hospitalFields = [
    'feedbackId',
    'subject',
    'body',
  ];

  Feedback({
    required this.feedbackId,
    required this.subject,
    required this.body,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      feedbackId: json['feedbackId'],
      subject: json['subject'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    // json['feedbackId'] = feedbackId;
    json['subject'] = subject ?? "";
    json['content'] = body;
    return json;
  }

  @override
  String toString() {
    return "feedback body $body";
  }
}
