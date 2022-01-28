import 'package:flutter_pip/flutter_pip.dart';
import 'package:flutter_pip_example/config/endpoint.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PipVideoController extends GetxController with WidgetsBindingObserver {
  //late BetterPlayerController betterPlayerController;
  final GlobalKey betterPlayerKey = GlobalKey();
  //late VideoPlayerController videoPlayerController;

  final Rxn<VideoPlayerController> _videoPlayerController =
      Rxn<VideoPlayerController>().obs.value;
  Rxn<VideoPlayerController> get videoPlayerController =>
      _videoPlayerController;
  @override
  void onInit() {
    WidgetsBinding.instance!.addObserver(this);
    _videoPlayerController.value =
        VideoPlayerController.network(EndPoint.videoUrl);
    _videoPlayerController.value?.initialize();
    _videoPlayerController.value?.setLooping(true);
    _videoPlayerController.value?.play();
    playVideo();
    super.onInit();
  }

  @override
  void onClose() {
    _videoPlayerController.value?.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.inactive == state) {
      enablePip();
    }
  }

  final RxBool _isPipSupported = RxBool(false).obs.value;
  RxBool get isPipSupported => _isPipSupported;
  final RxBool _isPipEnabled = RxBool(false).obs.value;
  RxBool get isPipEnabled => _isPipEnabled;

  enablePip() {
    FlutterPip.pip();
  }

  final Rxn<VideoPlayerValue> _videoPlayerValue =
      Rxn<VideoPlayerValue>().obs.value;
  Rxn<VideoPlayerValue> get videoPlayerValue => _videoPlayerValue;
 
  playVideo() {
    _videoPlayerValue.value = videoPlayerController.value!.value;
  }

  RxBool get isPlaying =>
      RxBool(videoPlayerValue.value?.isPlaying ?? false).obs.value;
  void togglePlay() {
    playVideo();
    isPlaying.value ? pause() : play();
  }

  /// Pause the video.
  Future<void> pause() async {
    await _videoPlayerController.value?.pause();
  }

  Future<void> play() async {
    await _videoPlayerController.value!.play();
  }

  
}
