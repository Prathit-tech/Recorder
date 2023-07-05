import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Audio Waveforms',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  bool isWaveformRefreshing = false;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setState(() {});
    } else {
      debugPrint("File not picked");
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252331),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50,0,0,0),
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isRecording
                          ? AudioWaveforms(
                        enableGesture: true,
                        size: Size(
                            MediaQuery.of(context).size.width / 2,
                            50),
                        recorderController: recorderController,
                        waveStyle: const WaveStyle(
                          waveColor: Colors.white,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: const Color(0xFF1E1B26),
                        ),
                        padding: const EdgeInsets.only(left: 18),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15),
                      )
                          : Container(
                        width:
                        MediaQuery.of(context).size.width / 1.7,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1B26),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.only(left: 18),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Type Something...",
                            hintStyle: const TextStyle(
                                color: Colors.white54),
                            contentPadding:
                            const EdgeInsets.only(top: 16),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: _pickFile,
                              icon: Icon(Icons.adaptive.share),
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isRecording) {
                          _stopRecording();
                        } else {
                          _startRecording();
                        }
                      },
                      icon: Icon(isRecording ? Icons.pause : Icons.mic),
                      color: Colors.white,
                      iconSize: 28,
                    ),
                    const SizedBox(width: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isWaveformRefreshing
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white),
                      )
                          : IconButton(
                        key: ValueKey<bool>(isRecording),
                        onPressed: () {
                          if (isRecording) {
                            _refreshWaveform();
                          }
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startRecording() async {
    try {
      await recorderController.record(path: path!);
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _stopRecording() async {
    try {
      final path = await recorderController.stop(false);

      if (path != null) {
        isRecordingCompleted = true;
        debugPrint(path);
        debugPrint("Recorded file size: ${File(path).lengthSync()}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = false;
      });
    }
  }

  void _refreshWaveform() {
    setState(() {
      isWaveformRefreshing = true;
    });

    void _refreshWaveform() {
      setState(() {
        isWaveformRefreshing = true;
      });

      recorderController.refresh();

      setState(() {
        isWaveformRefreshing = false;
      });
    }

  }
}
