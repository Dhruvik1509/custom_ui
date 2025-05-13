import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MaterialApp(home: MediaTrimmerPage()));

class MediaTrimmerPage extends StatefulWidget {
  @override
  _MediaTrimmerPageState createState() => _MediaTrimmerPageState();
}

class _MediaTrimmerPageState extends State<MediaTrimmerPage> {
  final Trimmer _videoTrimmer = Trimmer();
  final Trimmer _audioTrimmer = Trimmer();

  double _videoStart = 0.0;
  double _videoEnd = 0.0;
  double _audioStart = 0.0;
  double _audioEnd = 0.0;

  bool _isVideoPlaying = false;
  bool _isAudioPlaying = false;
  bool _progressVisible = false;

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      await _videoTrimmer.loadVideo(videoFile: File(result.files.single.path!));
      setState(() {});
    }
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      await _audioTrimmer.loadVideo(videoFile: File(result.files.single.path!)); // Works for audio too
      setState(() {});
    }
  }

  void _saveTrimmedVideo() {
    setState(() => _progressVisible = true);
    _videoTrimmer.saveTrimmedVideo(
      startValue: _videoStart,
      endValue: _videoEnd,
      onSave: (path) {
        setState(() => _progressVisible = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Video saved at: $path')));
      },
    );
  }

  void _saveTrimmedAudio() {
    setState(() => _progressVisible = true);
    _audioTrimmer.saveTrimmedVideo(
      startValue: _audioStart,
      endValue: _audioEnd,
      onSave: (path) {
        setState(() => _progressVisible = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Audio saved at: $path')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video & Audio Trimmer")),
      body: _progressVisible
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("🎬 Video Trimmer", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(height: 200, child: VideoViewer(trimmer: _videoTrimmer)),
            Column(
              children: [
                TrimViewer(
                  trimmer: _videoTrimmer,
                  viewerHeight: 50,
                  viewerWidth: MediaQuery.of(context).size.width,
                  maxVideoLength: Duration(seconds: 30),
                  onChangeStart: (val) => _videoStart = val,
                  onChangeEnd: (val) => _videoEnd = val,
                  onChangePlaybackState: (isPlaying) => setState(() => _isVideoPlaying = isPlaying),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isVideoPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () async {
                    bool isPlaying = await _videoTrimmer.videoPlaybackControl(
                      startValue: _videoStart,
                      endValue: _videoEnd,
                    );
                    setState(() => _isVideoPlaying = isPlaying);
                  },
                ),
                ElevatedButton(
                  onPressed: _saveTrimmedVideo,
                  child: Text("Save Trimmed Video"),
                ),
              ],
            ),
            Divider(),
            Text("🎵 Audio Trimmer", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(height: 200, child: VideoViewer(trimmer: _audioTrimmer)),
            TrimViewer(
              trimmer: _audioTrimmer,

              viewerHeight: 50,
              viewerWidth: MediaQuery.of(context).size.width,
              maxVideoLength: Duration(seconds: 30),
              onChangeStart: (val) => _audioStart = val,
              onChangeEnd: (val) => _audioEnd = val,
              onChangePlaybackState: (isPlaying) => setState(() => _isAudioPlaying = isPlaying),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isAudioPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () async {
                    bool isPlaying = await _audioTrimmer.videoPlaybackControl(
                      startValue: _audioStart,
                      endValue: _audioEnd,
                    );
                    setState(() => _isAudioPlaying = isPlaying);
                  },
                ),
                ElevatedButton(
                  onPressed: _saveTrimmedAudio,
                  child: Text("Save Trimmed Audio"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'videoPicker',
            onPressed: _pickVideo,
            child: Icon(Icons.video_library),
            tooltip: 'Pick Video',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'audioPicker',
            onPressed: _pickAudio,
            child: Icon(Icons.audiotrack),
            tooltip: 'Pick Audio',
          ),
        ],
      ),
    );
  }
}
