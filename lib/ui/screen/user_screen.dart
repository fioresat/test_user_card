import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_user_card/ui/widgets/audioplayer_widget.dart';
import '../../consts/images.dart';
import '../../sample_data/sample_data.dart';
import '../widgets/animation_widget.dart';
import '../widgets/back_images.dart';
import '../widgets/front_part.dart';
import 'dart:ui';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int i = 0;

  double deviceHeight = window.physicalSize.height;
  PageController pageController = PageController();
  bool isHeartAnimation = false;
  bool isStarAnimation = false;
  bool isRewindAnimation = false;
  bool isPlaying = false;
  AudioPlayerWidget audioPlayerWidget =
      AudioPlayerWidget(audioasset: users[1].audio);

  @override
  void initState() {
    pageController.addListener(() {
      if (pageController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          users[i].isBrokenHeart = true;
        });
      } else {
        setState(() {
          users[i].isBrokenHeart = false;
        });
      }
      setState(() {
        double a = pageController.page!;
        i = a.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blueGrey,
        strokeWidth: 5,
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 2));
        },
        child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              isHeartAnimation = true;
            });
          },
          child: Stack(
            children: [
              PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: widthScreen,
                      height: heightScreen,
                      child: Stack(
                        children: [
                          BackImages(
                            width: widthScreen,
                            images: users[index].images,
                            height: heightScreen,
                          ),
                          Opacity(
                            opacity: users[index].isBrokenHeart ? 1 : 0,
                            child: AnimationWidget(
                              duration: const Duration(milliseconds: 1000),
                              onEnd: () => setState(() {
                                users[index].isBrokenHeart = false;
                              }),
                              isAnimating: users[index].isBrokenHeart,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(imageBrokenHeart),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              FrontPart(
                onMoreTap: () {
                  _showActionSheet(context);
                },
                onStarTap: () {
                  setState(() {
                    isStarAnimation = true;
                  });
                },
                user: users[i],
                width: widthScreen,
                height: heightScreen,
                audioWidget: audioPlayerWidget,
              ),
              Opacity(
                opacity: isHeartAnimation ? 1 : 0,
                child: AnimationWidget(
                  onEnd: () => setState(() {
                    isHeartAnimation = false;
                  }),
                  isAnimating: isHeartAnimation,
                  endOffset: const Offset(0.7, 0.2),
                  duration: const Duration(milliseconds: 1200),
                  startOffset: const Offset(0.7, 2),
                  child: Image.asset(imageHeart),
                ),
              ),
              Opacity(
                opacity: isStarAnimation ? 1 : 0,
                child: AnimationWidget(
                  duration: const Duration(milliseconds: 700),
                  onEnd: () => setState(() {
                    isStarAnimation = false;
                  }),
                  isAnimating: isStarAnimation,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(imageStarHeart),
                  ),
                ),
              ),
              Opacity(
                opacity: isRewindAnimation ? 1 : 0,
                child: AnimationWidget(
                  duration: const Duration(milliseconds: 1000),
                  onEnd: () => setState(() {
                    isRewindAnimation = false;
                  }),
                  isAnimating: isRewindAnimation,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(imageRewind),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('First Action'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Second Action'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
