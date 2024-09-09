// import 'package:flutter_auth/domain/bookmarks/bookmarks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/bookmark_event.dart';
import '../state/bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(InitialBookmarkState()) {
    on<LoadBookmarkEvent>((event, emit) async {
      emit(BookmarkLoadingState());
      try {
        emit(const BookmarkSuccessState([]));
        // detectedLeafBox.close();
      } catch (error) {
        emit(BookmarkFailureState());
      }
    });

    on<AddBookmarkEvent>((event, emit) async {
      emit(AddBookmarkLoadingState());
      try {
        emit(const AddBookmarkSuccessState(bookmarked: true));
      } catch (error) {
        emit(BookmarkFailureState());
      }
    });
  }
}
