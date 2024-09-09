import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/bookmark_bloc/bloc/bookmark_bloc.dart';
import '../application/bookmark_bloc/state/bookmark_state.dart';

signOut(context) {
  BlocProvider.of<BookmarkBloc>(context).emit(InitialBookmarkState());

}
