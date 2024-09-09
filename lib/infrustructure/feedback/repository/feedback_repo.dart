import 'feedback_repo_imports.dart';

class FeedbackRepository {
  final FeedbackDataProvider feedbackDataProvider;

  FeedbackRepository({required this.feedbackDataProvider});

  Future<bool> sendFeedback(Feedback feedback) async {
    try {
      bool isFeedbackSent = await feedbackDataProvider.senFeedback(feedback);
      return isFeedbackSent;
    } catch (e) {
      rethrow;
    }
  }
}
