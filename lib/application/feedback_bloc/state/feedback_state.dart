import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object?> get props => [];
}

class FeedbackInitialState extends FeedbackState {}

class FeedbackSubmittingState extends FeedbackState {}

class FeedbackSubmittedState extends FeedbackState {}

class FeedbackFailedState extends FeedbackState {}
