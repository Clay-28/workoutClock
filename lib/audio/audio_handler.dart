import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:audio_session/audio_session.dart';




class MyAudioHandler extends BaseAudioHandler
    with QueueHandler, // mix in default queue callback implementations
        SeekHandler {




  MyAudioHandler() {
    initAudioService(); /// Sets the audio session of this app
    setMusic(); /// creates an audio player and set the audio to a local asset mp3
  }


  initAudioService() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation,
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

  late ja.AudioPlayer player;


  void setMusic() async{
    player = ja.AudioPlayer(
        handleAudioSessionActivation: false,
        handleInterruptions: false
    );
    //await player.setAsset("asset:///assets/audio/countdown.mp3");
    await player.setAsset('assets/audio/countdown.mp3');
    await player.setVolume(1);
  }

  @override
  Future<void> play() async {
    /*
    var content = await rootBundle
        .load("assets/countdown.mp3");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/intro.mp3");
    file.writeAsBytesSync(content.buffer.asUint8List());
    await player.setFilePath(file.path);
     */

    //await player.setAsset('assets/audio/countdown.mp3');
    player.play();
  }

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {
    player;
  }

  @override
  Future<void> seek(Duration position) async {
    player.seek(position);
    await player.play();
  }

}

