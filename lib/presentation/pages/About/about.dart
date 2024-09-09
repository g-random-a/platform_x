import 'about_imports.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: getAppBar(context),
        appBar: appBarTransparent(context),
        body: SafeArea(
          child: Container(
            color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final screenWidth = constraints.maxWidth;
                  final screenHeight = constraints.maxHeight;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image:  AssetImage(AssetFiles.AILogo),
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "About Us",
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend',
                                // color: const Color.fromRGBO(1, 155, 113, 1.0),
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "Detect coffee leaf diseases with ease using our powerful image segmentation technology.",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend',
                                // color: const Color.fromRGBO(1, 155, 113, 1.0),
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .blackColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Our mobile application is designed to help coffee farmers and enthusiasts identify and mitigate diseases that can affect coffee plants",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend',
                                // color: const Color.fromRGBO(1, 155, 113, 1.0),
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .blackColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Our mobile application is designed to help coffee farmers and enthusiasts identify and mitigate diseases that can affect coffee plants",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend',
                                // color: const Color.fromRGBO(1, 155, 113, 1.0),
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .blackColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Our mobile application is designed to help coffee farmers and enthusiasts identify and mitigate diseases that can affect coffee plants",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend',
                                // color: const Color.fromRGBO(1, 155, 113, 1.0),
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .blackColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.08),
                            ElevatedButton(
                              onPressed: () async {
                                var url = Uri(scheme: "https", host: 'aic.et');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    screenWidth * 0.6, screenHeight * 0.0001),
                                // primary: const Color.fromRGBO(
                                //     9, 120, 52, 1.0), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenWidth *
                                          0.1), // Button border radius
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.03,
                                  horizontal: screenWidth * 0.04,
                                ), // Button padding
                              ),
                              child: Text(
                                'Visit our website',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.green,
        //   onPressed: () {},
        //   child: const Icon(Icons.camera),
        // ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterDocked,
        // bottomNavigationBar: BottomAppBar(
        //   shape: const CircularNotchedRectangle(),
        //   notchMargin: 5,
        //   child: SizedBox(
        //     height: 60,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Expanded(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: <Widget>[
        //               IconButton(
        //                 onPressed: () {
        //                   // setState(() {
        //                   //   currentScreen = SplashScreen();
        //                   //   currentTab = 0;
        //                   // });
        //                 },
        //                 icon: const Icon(Icons.home),
        //               ),
        //               IconButton(
        //                 onPressed: () {
        //                   // setState(() {
        //                   //   currentScreen = RecentPage();
        //                   //   currentTab = 1;
        //                   // });
        //                 },
        //                 icon: const Icon(Icons.grid_view_sharp),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               IconButton(
        //                 onPressed: () {
        //                   // setState(() {
        //                   //   currentScreen = BookmarkPage();
        //                   //   currentTab = 2;
        //                   // });
        //                 },
        //                 icon: const Icon(Icons.bookmark),
        //               ),
        //               IconButton(
        //                 onPressed: () {
        //                   // setState(() {
        //                   //   currentScreen = SplashScreen();
        //                   //   currentTab = 3;
        //                   // });
        //                 },
        //                 icon: const Icon(Icons.settings),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
