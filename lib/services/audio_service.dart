import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';


void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    print('start');
    await _audioPlayer.setAsset('assets/music/background.mp3');
    _audioPlayer.setLoopMode(LoopMode.one);

  }

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    await _audioPlayer.play();
    return super.onPlay();
  }

  @override
  Future<void> onPause() async {
    await _audioPlayer.pause();
    return super.onPause();
  }

  @override
  Future<void> onSeekTo(Duration position) {
    _audioPlayer.seek(position);
    AudioServiceBackground.setState(position: position);
    return super.onSeekTo(position);
  }

  @override
  Future<void> onClose() async{
    await _audioPlayer.pause();
    await _audioPlayer.dispose();
    return super.onClose();
  }

}