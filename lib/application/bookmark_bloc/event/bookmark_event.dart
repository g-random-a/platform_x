import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

class LoadBookmarkEvent extends BookmarkEvent {
  @override
  List<Object> get props => [];

  const LoadBookmarkEvent();
}

class AddBookmarkEvent extends BookmarkEvent {
  final bookmark;

  @override
  List<Object> get props => [bookmark];

  const AddBookmarkEvent({required this.bookmark});
}
