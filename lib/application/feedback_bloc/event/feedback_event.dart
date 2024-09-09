import '../../../domain/feedback/feedback.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object?> get props => [];
}

class SubmitFeedbackEvent extends FeedbackEvent {
  final Feedback feedback;

  const SubmitFeedbackEvent({required this.feedback});

  @override
  List<Object?> get props => [feedback];
}

class DisposeFeedbackEvent extends FeedbackEvent {
  const DisposeFeedbackEvent();

  @override
  List<Object?> get props => [];
}
