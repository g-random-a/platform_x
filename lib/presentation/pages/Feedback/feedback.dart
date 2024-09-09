import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes.dart';
import 'feedback_page_imports.dart';
import '../../../domain/feedback/feedback.dart' as feedback;

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void deactivate() {
    BlocProvider.of<FeedbackBloc>(context).add(const DisposeFeedbackEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const CircleBorder(side: BorderSide(width: 500)),
      // insetPadding: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
          return BlocConsumer<FeedbackBloc, FeedbackState>(
              listener: (context, feedbackState) {
            if (feedbackState is FeedbackSubmittedState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(
                        //   'assets/icons/thankyou.svg',
                        //   height: 40,
                        //   width: 40,
                        // ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Thank You!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    content: const Text(
                      'Thank you for sending your feedback! We appreciate your support.',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }, builder: (context, feedbackState) {
            return Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .66,
              // width: MediaQuery.of(context).size.width * 0.9, // Adjust the width to 90% of the screen width
              // height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment
                              .bottomLeft, // Aligns the text to the top left corner
                          child: Text(
                            "Give Us Your Feedback",
                            // style: TextStyle(
                            //   fontSize: 23,
                            //   fontFamily: 'Advent Pro',
                            //   fontWeight: FontWeight.bold,
                            // ),
                            style: GoogleFonts.adventPro(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: theme.blackColor),
                          ),
                        ),
                        const Divider(
                          color: Color.fromRGBO(217, 217, 217,
                              1.0), // Customize the divider color
                          thickness: 1.0, // Customize the divider thickness
                        ),

                        feedbackState is FeedbackFailedState
                            ? const Text("Can not send, please try again.",
                                style: TextStyle(color: Colors.red))
                            : Container(),
                        feedbackState is FeedbackFailedState
                            ? const SizedBox(
                                height: 5,
                              )
                            : Container(),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Enter subject for your comment:",
                            style: GoogleFonts.average(
                                fontSize: 16, color: theme.blackColor),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          controller: _subjectController,
                          validator: (value) {
                            return value != null && value.isNotEmpty
                                ? null
                                : "please enter subject";
                          },
                          style: TextStyle(color: theme.blackColor),
                          decoration: InputDecoration(
                            filled: false,
                            hintText: "Enter your subject",
                            focusColor: Colors.white,
                            hintStyle: TextStyle(
                                color: theme.blackColor.withAlpha(100)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(239, 188, 8, 1))),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(239, 188, 8, 0.6)),
                              // Color of the border when focused
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(239, 188, 8, 1))),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(239, 188, 8, 1)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Align(
                          alignment: Alignment
                              .topLeft, // Aligns the text to the top left corner
                          child: Text(
                            "Please enter your comments here:",
                            style: GoogleFonts.average(
                              color: theme.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _bodyController,
                          maxLines: 5,
                          validator: (value) {
                            return value != null && value.isNotEmpty
                                ? null
                                : "please enter your comments";
                          },
                          style: TextStyle(color: theme.blackColor),
                          decoration: InputDecoration(
                            filled: false,
                            hintStyle: TextStyle(
                                color: theme.blackColor.withAlpha(100)),
                            hintText: "Enter your comments",
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(239, 188, 8, 1))),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(239, 188, 8, 0.6)),
                              // Color of the border when focused
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(239, 188, 8, 1))),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(239, 188, 8, 1)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Text(
                        //   "If you would like us to respond to you, please enter your email address:",
                        //   style: GoogleFonts.average(
                        //     fontSize: 16,
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //     hintText: "Enter your email address",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),

                        ElevatedButton(
                          // onPressed: null,
                          onPressed: feedbackState is FeedbackSubmittingState
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    // Handle submit button press
                                    String body = _subjectController.text;
                                    String subject = _subjectController.text;
                                    // Handle the feedback submission here
                                    // You can use a Bloc or perform any other logic
                                    // For this example, we print the feedback to the console
                                    BlocProvider.of<FeedbackBloc>(context).add(
                                        SubmitFeedbackEvent(
                                            feedback: feedback.Feedback(
                                                feedbackId: "feedbackId",
                                                subject: subject,
                                                body: body)));
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(133, 40),
                            // primary: kPrimaryColor,
                            // Set the background color
                            textStyle: GoogleFonts.average(
                              fontSize: 16,
                            ), // Set the text style
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  17), // Set the button shape
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 18), // Set the button padding
                          ),
                          child: feedbackState is FeedbackSubmittingState
                              ? CircularProgressIndicator(
                                  color: kPrimaryColor,
                                )
                              : Text("Submit"),
                        ),
                        const SizedBox(height: 5),

                        ElevatedButton(
                          onPressed: feedbackState is FeedbackSubmittingState
                              ? null
                              : () {
                                  print("123123213213 cle");
                                  Navigator.of(context).pop();
                                },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(133, 40),
                            backgroundColor: greyColor,
                            // Set the background color
                            textStyle: GoogleFonts.average(
                              fontSize: 16,
                            ), // Set the text style
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  17), // Set the button shape
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 18), // Set the button padding
                          ),
                          child: Text("Cancel"),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
