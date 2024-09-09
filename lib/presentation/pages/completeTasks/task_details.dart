import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Question {
  String QuestionId;
  String QuestionName;
  String QuestionDescription;
  String QuestionType; 

  Question({
    required this.QuestionId,
    required this.QuestionName,
    required this.QuestionDescription,
    required this.QuestionType,
  });
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  bool _isQuestionCompleted = false;

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _recordedFilePath;

  final TextEditingController _textController = TextEditingController();

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
  void initState() {
    super.initState();
    _initAudioRecorder();
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    _audioRecorder = null;
    _textController.dispose();
    super.dispose();
  }

  Future<void> _initAudioRecorder() async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder!.openRecorder();
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/flutter_sound_recording.aac';
    await _audioRecorder!.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath;
    });
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _uploadAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _recordedFilePath = result.files.single.path!;
      });
    }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Answer:"),
          const SizedBox(height: 8),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your answer here',
            ),
            maxLines: 3,
          ),
        ],
      );
    } else if (question.QuestionType == 'audio') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Record or Upload Your Answer:"),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRecording ? Colors.red : Colors.blue,
                ),
                child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _uploadAudioFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Upload Audio'),
              ),
            ],
          ),
          if (_recordedFilePath != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Audio file: $_recordedFilePath"),
            ),
        ],
      );
    } else {
      return const Text("Invalid question type.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Task Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                        const Text(
                          "Status: 45%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: LinearProgressIndicator(
                              value: 0.45,
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
