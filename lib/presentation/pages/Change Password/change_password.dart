import 'change_password_imports.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarTransparent(context),
        body: BlocConsumer<ChangePasswordBloc, ChangePasswordStates>(
            listener: (context, state) async {
          if (state is LoadingChangePasswordState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          // TODO: implement listener
          if (state is ChangePasswordSuccessState) {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              onConfirmBtnTap: () {
                // print("confirm tapped");
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                BlocProvider.of<ChangePasswordBloc>(context)
                    .emit(ChangePasswordInitialState());
              },
              title: 'Success',
              text: 'Your Password has been changed successfully.',
              confirmBtnText: 'Ok',
              confirmBtnColor: Colors.green,
            );
          }
          if (state is ChangePasswordFailedState) {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              onConfirmBtnTap: () {
                // print("confirm tapped");
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
                BlocProvider.of<ChangePasswordBloc>(context)
                    .add(LoadChangePasswordEvent());
              },
              title: 'Error',
              text:
                  'Could not change your password, please check your internet connection or contact the support team if this issue persists to happen.',
              confirmBtnText: 'Retry',
              confirmBtnColor: Colors.red,
            );
          }
        }, builder: (context, state) {
          return SafeArea(
            child: LoaderOverlay(
              overlayColor:
                  BlocProvider.of<ThemeBloc>(context).state.blackColor,
              useDefaultLoading: false,
              overlayWidgetBuilder:(context) => Builder(
                  builder: (BuildContext context) => const SpinKitChasingDots(
                color: kPrimaryColor,
                size: 100.0,
              ),
              ),
              child: SingleChildScrollView(
                child: Responsive(
                  mobile: const MobileLoginScreen(),
                  desktop: Row(
                    children: [
                      const Expanded(
                        child: ResetPasswordScreenTopImage(),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .9,
                              child: const ResetPasswordForm(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ResetPasswordScreenTopImage(),
        // Row(
        //   children: const [
        // Spacer(),
        // Expanded(
        // flex: 8,
        // child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ResetPasswordForm(),
        ),
        // ),
        // Spacer(),
        // ],
        // ),
      ],
    );
  }
}
