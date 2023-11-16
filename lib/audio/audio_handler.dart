import 'package:WorkoutClock/main.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:audio_session/audio_session.dart';


/// What did we learn
///


class MyAudioHandler extends BaseAudioHandler
    with QueueHandler, // mix in default queue callback implementations
        SeekHandler {

  late  var ducking = initAudioService();



  MyAudioHandler() {
    player.setAsset('asset:///assets/countdown.mp3');
    initAudioService(); /// Sets the audio session of this app
  }


  initAudioService() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions
          .notifyOthersOnDeactivation,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType
          .gainTransientMayDuck,
      androidWillPauseWhenDucked: true,
    ));
    return session.setActive(false); // by setActive == false -> it removes ducking

    //INITIALIZE audio_service
    /*
    return await AudioService.init(
      builder: () => AudioPlayerService(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.YOUR_COMPANY.YOUR_APP_NAME.audio',
        androidNotificationChannelName: 'Audio Service Demo',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
     */
  }


  final player = ja.AudioPlayer(
    handleAudioSessionActivation: false,
    handleInterruptions: false
  );


  @override
  Future<void> play() async {
    player.play();
  }

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {
    //player.stop();
    player;
  }

  @override
  Future<void> seek(Duration position) async {
    player.seek(position);
    await player.play();
  }

}

