import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';


void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    AudioServiceBackground.setState(
        playing: true,
        processingState: AudioProcessingState.connecting
    );
    await _audioPlayer.setAsset('assets/music/background.mp3');
    _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.setSpeed(1);

    AudioServiceBackground.setState(
        playing: true, processingState: AudioProcessingState.ready);
  }

  @override
  Future<void> onStop() async {
    AudioServiceBackground.setState(
        playing: false,
        processingState: AudioProcessingState.stopped,
    );
    await _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.setState(
        playing: true,
        processingState: AudioProcessingState.ready
    );
    await _audioPlayer.play();
    return super.onPlay();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(
        playing: false,
        processingState: AudioProcessingState.ready
    );
    await _audioPlayer.pause();
    return super.onPause();
  }

}