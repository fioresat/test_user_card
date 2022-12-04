import 'package:flutter/material.dart';
import 'package:test_user_card/consts/images.dart';
import '../../model/user.dart';
import '../style/custom_text_style.dart';

class FrontPart extends StatelessWidget {
  final double width;
  final double height;
  final User user;
  final Widget audioWidget;
  final void Function()? onStarTap;
  final void Function()? onMoreTap;

  const FrontPart(
      {Key? key,
      required this.width,
      required this.height,
      required this.user,
      this.onStarTap,
      this.onMoreTap,
      required this.audioWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              topRows(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(imageLogo2),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.02 * width),
                        child: Image.asset(imageFriends),
                      ),
                      Image.asset(imageDate),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.02 * width),
                        child: Image.asset(imageButtonLoud),
                      ),
                      Image.asset(imageNewMessage),
                    ],
                  ),
                ],
              ),
              topRows(
                [
                  Text(
                    "${user.name}, ${user.age}",
                    style: customTextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: onMoreTap,
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 0.05 * width),
                  child: Text(
                    user.location,
                    style: customTextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              roundButtons(Image.asset(imageButtonInstantMatch), () {}),
              roundButtons(Image.asset(imageButtonSuperlike), onStarTap),
              roundButtons(Image.asset(imageButtonSave), () {}),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.05 * width, vertical: 0.05 * height),
                child: Row(
                  children: [
                    audioWidget,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 0.05 * width),
                      width: width * 0.13 * user.favourites.length,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const VerticalDivider(
                                        width: 0,
                                        color: Colors.transparent,
                                      ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: user.favourites.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Image.asset(user.favourites[index]);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget topRows(List<Widget> children) {
    return Padding(
      padding: EdgeInsets.only(
          left: 0.05 * width, right: 0.05 * width, top: 0.05 * height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  Widget roundButtons(Widget child, void Function()? onTap) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 0.02 * width, bottom: 0.02 * width),
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
