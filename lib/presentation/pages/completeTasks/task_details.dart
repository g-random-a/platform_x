import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_x/application/theme_bloc/bloc/theme_bloc.dart';
import 'package:platform_x/application/theme_bloc/event/theme_event.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/presentation/pages/Forget%20Password/components/imports.dart';

import '../../../domain/task/questions.dart';
import 'audio_recorder.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  bool _isQuestionCompleted = false;
  bool _isAudioRecorded = false;
  String? _recordedFilePath;

  // Text field controller
  final TextEditingController _textController = TextEditingController();

  // Sample questions
  final List<Question> _questions = [
    Question(
      QuestionId: "1",
      QuestionName: "What is Flutter?",
      QuestionDescription: "Explain briefly what Flutter is.",
      QuestionType: "text",
    ),
    Question(
      QuestionId: "2",
      QuestionName: "Describe Flutter in audio",
      QuestionDescription: "Record or upload your description about Flutter.",
      QuestionType: "audio",
    ),
  ];

  @override
  void dispose() {
    _textController.dispose();
    // state = teamstate
    BlocProvider.of<ThemeBloc>(context).add(const LoadThemeEvent());
    super.dispose();
  }

  // Callback to handle when the audio is recorded/uploaded
  void _onAudioRecorded(bool isRecorded, String? filePath) {
    setState(() {
      _isAudioRecorded = isRecorded;
      _recordedFilePath = filePath;
    });
  }

  void _completeQuestion() {
    setState(() {
      _isQuestionCompleted = true;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isQuestionCompleted = false;
        _textController.clear();
        _recordedFilePath = null;
        _isAudioRecorded = false;
      });
      _pageController.animateToPage(
        _currentQuestionIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildAnswerField(Question question) {
    if (question.QuestionType == 'text') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Your Answer:"),
          const SizedBox(height: 8),
          Hero(
            tag: 'answerTextField', // Unique tag for Hero animation
            child: Material(
              color: Colors.transparent, // To avoid background color glitch
              child: InkWell(
                onTap: () async{
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FullScreenTextField(
                      controller: _textController,
                      question: question.QuestionDescription,
                    ),
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _textController.text.isEmpty
                        ? 'Tap to answer'
                        : _textController.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (question.QuestionType == 'audio') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Audio Answer:"),
          const SizedBox(height: 8),
          Hero(
            tag: 'audioHero',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FullScreenAudioRecorder(
                      onAudioRecorded: _onAudioRecorded,
                    ),
                  ));
                },
                child: ElevatedButton(
                  onPressed: null, // No action on main screen
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Audio Answer'),
                      if (_isAudioRecorded) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Text("Invalid question type.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery to handle keyboard open event
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents content from being hidden by the keyboard
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('Task Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding), // Adjust padding when keyboard opens
        child: Column(
          children: [
            // Header Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Name: Complete Survey",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Reward: 25\$",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Status: ${(_currentQuestionIndex+1)/_questions.length * 100}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: LinearProgressIndicator(
                                value: (_currentQuestionIndex+1)/_questions.length,
                                backgroundColor: Colors.grey[300],
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // PageView for Questions
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Prevent user from scrolling manually
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Question ${index + 1}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              question.QuestionDescription,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 32),
                            _buildAnswerField(question),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _isQuestionCompleted
                              ? _nextQuestion
                              : _completeQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isQuestionCompleted
                                ? Colors.green
                                : Colors.blue,
                          ),
                          child: Text(
                            _isQuestionCompleted
                                ? 'Next Question'
                                : 'Complete Question',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenTextField extends StatelessWidget {
  final TextEditingController controller;
  final String question;

  const FullScreenTextField({Key? key, required this.controller, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Answer Question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Hero(
          tag: 'answerTextField',
          child: Container(
            child: Column(
              children: [
                Text(
                  question,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: controller,
                  maxLines: null, // Allow for multiple lines
                  autofocus: true, // Open keyboard automatically
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Enter your answer...',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // keybord disable
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save Answer'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
