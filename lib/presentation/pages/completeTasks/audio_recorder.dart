import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as flutter_sound;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_waveforms/audio_waveforms.dart'; // For audio waveform visualization

class FullScreenAudioRecorder extends StatefulWidget {
  final Function(bool, String?) onAudioRecorded;

  const FullScreenAudioRecorder({
    Key? key,
    required this.onAudioRecorded,
  }) : super(key: key);

  @override
  _FullScreenAudioRecorderState createState() =>
      _FullScreenAudioRecorderState();
}

class _FullScreenAudioRecorderState extends State<FullScreenAudioRecorder> {
  flutter_sound.FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _recordedFilePath;
  bool _isInitialized = false;
  bool _isAudioRecorded = false;

  final RecorderController _recorderController = RecorderController(); // Audio waveform controller for recording
  final PlayerController _playerController = PlayerController(); // Audio playback waveform controller

  @override
  void initState() {
    super.initState();
    _initAudioRecorder();
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    _recorderController.dispose(); // Dispose waveform controller
    _playerController.dispose(); // Dispose waveform controller
    super.dispose();
  }

  // Initialize the audio recorder
  Future<void> _initAudioRecorder() async {
    _audioRecorder = flutter_sound.FlutterSoundRecorder();
    
    // Ensure that microphone permissions are granted
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _audioRecorder!.openRecorder();
      setState(() {
        _isInitialized = true;
      });
    } else {
      throw flutter_sound.RecordingPermissionException(
          "Microphone permission not granted");
    }
  }

  // Start recording
  Future<void> _startRecording() async {
    if (!_isInitialized) return;

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/audio_record.aac';

    await _audioRecorder!.startRecorder(
      toFile: filePath,
      codec: flutter_sound.Codec.aacADTS,
    );

    _recorderController.record(); // Start waveform recording

    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath;
    });
  }

  // Stop recording
  Future<void> _stopRecording() async {
    if (!_isInitialized || !_isRecording) return;

    await _audioRecorder!.stopRecorder();
    _recorderController.stop(); // Stop waveform recording

    setState(() {
      _isRecording = false;
      _isAudioRecorded = true;
    });

    // Load the recorded file for playback
    _playerController.preparePlayer(path: _recordedFilePath!, shouldExtractWaveform: true);
  }

  // Upload an audio file
  Future<void> _uploadAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _recordedFilePath = result.files.single.path;
        _isAudioRecorded = true;
      });

      // Load waveform for uploaded audio file
      _playerController.preparePlayer(path: _recordedFilePath!, shouldExtractWaveform: true);
    }
  }

  // Display waveform for recording audio
  Widget _buildRecordingWaveform() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      child: AudioWaveforms(
        size: Size(MediaQuery.of(context).size.width, 100),
        recorderController: _recorderController,
        waveStyle: const WaveStyle(
          waveColor: Colors.blue,
          showMiddleLine: false,
        ),
        enableGesture: true,
        padding: const EdgeInsets.all(10),
      ),
    );
  }

  // Display waveform for playing audio
  Widget _buildPlaybackWaveform() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      child: AudioFileWaveforms(
        backgroundColor: Colors.black,
        size: Size(MediaQuery.of(context).size.width, 100),
        playerController: _playerController,
        // waveStyle: const WaveStyle(
        //   waveColor: Colors.green,
        //   showMiddleLine: false,
        // ),
        playerWaveStyle: const PlayerWaveStyle(
          showSeekLine: false,
          liveWaveColor: Colors.blue,
        ),
        enableSeekGesture: true,
      ),
    );
  }

  // Display play/pause button
  Widget _buildPlayPauseButton() {
    return StreamBuilder<PlayerState>(
      stream: _playerController.onPlayerStateChanged,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final isPlaying = playerState == PlayerState.playing;

        return IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          iconSize: 64.0,
          onPressed: () {
            if (isPlaying) {
              _playerController.pausePlayer();
            } else {
              _playerController.startPlayer();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record Audio"),
      ),
      body: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Hero(
            tag: 'audioHero',
            child: Material(
              color: Colors.white,
              child: _isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isRecording)
                          _buildRecordingWaveform() // Display waveform while recording
                        else if (_isAudioRecorded)
                          Column(
                            children: [
                              _buildPlaybackWaveform(), // Display waveform while playing
                              _buildPlayPauseButton(),
                            ],
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                              _isRecording ? _stopRecording : _startRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _isRecording ? Colors.red : Colors.blue,
                          ),
                          child: Text(_isRecording
                              ? 'Stop Recording'
                              : 'Start Recording'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _uploadAudioFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Upload Audio'),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _recordedFilePath = null;
                                    _isAudioRecorded = false;
                                  });
                                  _playerController.stopPlayer();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: const Text('Remove'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.onAudioRecorded(
                                      true, _recordedFilePath);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                ),
                                child: const Text('Done'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
