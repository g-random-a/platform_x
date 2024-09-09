import 'bookmark_page_imports.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<BookmarkBloc>(context).add(const LoadBookmarkEvent());
        await Future.delayed(const Duration(milliseconds: 100));
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return BlocBuilder<BookmarkBloc, BookmarkState>(
              builder: (context, st) {
            // print(st);
            if (st is BookmarkLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (st is InitialBookmarkState ||
                st is AddBookmarkLoadingState ||
                st is AddBookmarkSuccessState ||
                st is AddBookmarkFailureState) {
              BlocProvider.of<BookmarkBloc>(context)
                  .add(const LoadBookmarkEvent());
            }

            if (st is BookmarkSuccessState) {
              return SafeArea(
                child: Scaffold(
                    body: CustomScrollView(
                        // mainAxisSize: MainAxisSize.min,
                        slivers: [
                      SliverAppBar(
                        leading: null,
                        pinned: true,
                        // leading: Icon(Icons.keyboard_double_arrow_right_rounded),
                        snap: true,
                        backgroundColor: kPrimaryColor,
                        // title: Text("hello"),
                        // title: getAppBar(),
                        floating: true,
                        expandedHeight: MediaQuery.of(context).size.height / 5,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          // background: Icon(Icons.bookmark_border,
                          //     color: Colors.white.withAlpha(150),
                          //     size: MediaQuery.of(context).size.height / 9),
                          title: Text(
                            'Bookmarks',
                            style: TextStyle(
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .whiteColor),
                          ),
                          // background: FlutterLogo(),
                          // background: AnimatedContainer(
                          //   child: Container(),
                          //   duration: Duration(milliseconds: 300),
                          // ),
                        ),
                      ),
                      // const Text(
                      //   "Bookmarks",
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       color: Color(0xFF1899B4),
                      //       fontSize: 24.43,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      st.bookmarks.isNotEmpty
                          ? SliverList.builder(
                              itemCount: st.bookmarks.length,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: InkWell(
                                    onTap: () async {
                                      // color = !color;
                                      // BlocProvider.of<DetailPageBloc>(context)
                                      //     .add(LoadDetailPageEvent(
                                              // leaf: st.bookmarks[index]));
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: ((context) =>
                                      //             const DetailPage())));
                                    },
                                    child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 100),
                                        child: Container(
                                          margin: index == 0
                                              ? EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03)
                                              : const EdgeInsets.all(0),
                                          child: Container(
                                            color: index % 2 == 0
                                                ? BlocProvider.of<ThemeBloc>(
                                                        context)
                                                    .state
                                                    .whiteColor
                                                : BlocProvider.of<ThemeBloc>(
                                                                context)
                                                            .state
                                                        is LightThemeState
                                                    ? greyColor.shade100
                                                    : BlocProvider.of<
                                                            ThemeBloc>(context)
                                                        .state
                                                        .whiteColor,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.14,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: FileImage(
                                                                  File(st
                                                                      .bookmarks[
                                                                          index]
                                                                      .detectedimagelocation)))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${st.bookmarks[index].filename}",
                                                            style: TextStyle(
                                                                color: BlocProvider.of<
                                                                            ThemeBloc>(
                                                                        context)
                                                                    .state
                                                                    .blackColor,
                                                                fontSize: 17)),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              st.bookmarks[index].diseases
                                                                          .length >
                                                                      1
                                                                  ? "${st.bookmarks[index].diseases.length} diseases"
                                                                  : "${st.bookmarks[index].diseases.length} disease",
                                                              style: const TextStyle(
                                                                  color:
                                                                      kSecondaryColor,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .03),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.chevron_right_sharp,
                                                      color: kPrimaryColor,
                                                      size: 30,
                                                    )),
                                                  )
                                                ]),
                                          ),
                                        )),
                                  ),
                                );
                              })
                          : SliverList.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      AssetFiles.NoBookmarksSvg,
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .5,
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      "Bookmarks Empty",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: BlocProvider.of<ThemeBloc>(
                                                  context)
                                              .state
                                              .blackColor,
                                          fontSize: 25),
                                    )
                                  ],
                                );
                              })
                    ])),
              );
            }

            return Center(
              child: Column(
                children: [
                  const Text("Can not load bookmarks, please try again later!"),
                  FilledButton(
                      onPressed: () {
                        BlocProvider.of<BookmarkBloc>(context)
                            .add(const LoadBookmarkEvent());
                      },
                      child: const Text("Reload"))
                ],
              ),
            );
          });
        },
      ),
    );

    //   // bottomNavigationBar: BottomNavigationBar(
    //   //     backgroundColor: Colors.green[300],
    //   //     items: [
    //   //       BottomNavigationBarItem(
    //   //           icon: const Icon(Icons.search),
    //   //           activeIcon: const Icon(
    //   //             Icons.search,
    //   //             color: Colors.purple,
    //   //           ),
    //   //           label: "Search",
    //   //           backgroundColor: Colors.amber[400]),
    //   //       BottomNavigationBarItem(
    //   //           icon: const Icon(Icons.camera),
    //   //           label: "Camera",
    //   //           activeIcon: const Icon(
    //   //             Icons.camera,
    //   //             color: Colors.purple,
    //   //           ),
    //   //           backgroundColor: Colors.amber[400]),
    //   //       BottomNavigationBarItem(
    //   //           icon: const Icon(Icons.settings),
    //   //           label: "Setting",
    //   //           activeIcon: const Icon(
    //   //             Icons.search,
    //   //             color: Colors.purple,
    //   //           ),
    //   //           backgroundColor: Colors.amber[400])
    //   //     ],
    //   //     currentIndex: 0)
    // );
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       const SliverAppBar(
    //         pinned: true,
    //         snap: true,
    //         floating: true,
    //         expandedHeight: 160.0,
    //         flexibleSpace: FlexibleSpaceBar(
    //           title: Text('Bookmarks'),
    //           background: FlutterLogo(),
    //         ),
    //       ),
    //       // // const SliverToBoxAdapter(
    //       //   child: Padding(
    //       //     padding: EdgeInsets.all(10.0),
    //       //     child: Text(
    //       //       'Bookmarks',
    //       //       style: TextStyle(fontSize: 30),
    //       //     ),
    //       //   ),
    //       // ),
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //           (BuildContext context, int index) {
    //             return Container(
    //               color: index.isOdd ? BlocProvider.of<ThemeBloc>(context).state.whiteColor : BlocProvider.of<ThemeBloc>(context).state.blackColor,
    //               height: 100.0,
    //               child: Center(
    //                 child: Text('$index', textScaleFactor: 5),
    //               ),
    //             );
    //           },
    //           childCount: 20,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
