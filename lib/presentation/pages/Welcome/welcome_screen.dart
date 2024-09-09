import 'package:platform_x/presentation/constants.dart';

import '../../../infrustructure/auth/repository/auth_repo_imports.dart';

import 'welcome_screen_imports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is InitialThemeState) {
          BlocProvider.of<ThemeBloc>(context).add(const LoadThemeEvent());
        }
      },
      child: const SafeArea(
        child: Scaffold(
          body: MobileWelcomeScreen(),
        ),
        // ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // const WelcomeImage(),
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.8,
            child: Image.asset(
              AssetFiles.WellcomeImage,
              fit: BoxFit.fitHeight,
            )),
        const Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
