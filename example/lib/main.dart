import 'package:flutter/material.dart';
import 'package:flutter_pip_example/controllers/pip_controller.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pip/flutter_pip.dart';
import 'package:video_player/video_player.dart';
import 'bindings/binding_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingController(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video PIP'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Play Video"),
            onPressed: () {
              Get.to(() => const PictureInPicturePage());
            },
          ),
        ),
      ),
    );
  }
}

class PictureInPicturePage extends GetView<PipVideoController> {
  const PictureInPicturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(controller.videoPlayerController.value!),
                ),
                IconButton(
                    onPressed: () {
                      controller.enablePip();
                    },
                    icon: const Icon(
                      Icons.branding_watermark,
                      color: Colors.white,
                    )),
              ],
            ),
            Positioned.fill(
              child: SizedBox(
                height: 60,
                width: 60,
                child: Obx(() {
                  return GestureDetector(
                      onTap: () {
                        controller.togglePlay();
                      },
                      child: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 45,
                      ));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
