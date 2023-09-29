import 'package:comm/controller/UIController.dart';
import 'package:comm/controller/ServerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ParentConatainer2 extends StatelessWidget {
  final Widget widget;

  final String widgetID;
  final String parentID = "2";
  double mainHeight;
  double mainWidth;
  ParentConatainer2(
      {super.key,
      required this.widget,
      required this.widgetID,
      required this.mainHeight,
      required this.mainWidth});

  @override
  Widget build(BuildContext context) {
    double height = mainHeight;
    double width = mainWidth;
    // print("Parent2");
    return GetBuilder<ServerController>(builder: (controller) {
      return DragTarget(
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return GetBuilder<UIController>(builder: (uiController) {
            // return GestureDetector(
            //     // onTap: () => uiCOntroller.toggle(uiCOntroller.oneWidgetLg),
            //     onDoubleTap: () {
            //       print("Tapped $widgetID $parentID ");
            //       controller.handleMessage("$widgetID $parentID d");
            //     },
            //     child: widget);
            // if (controller.intialCall) {
            //   controller.parentIsVisible[0] = true;
            //   controller.parentIsVisible[1] = true;
            //   controller.parentIsVisible[2] = false;
            // controller.parentIsVisible[3] = false;
            // print(controller.parentIsVisible);
            // print("parent2");
            // }
            return VisibilityDetector(
              key: Key("2"),
              onVisibilityChanged: (info) {
                // print("changed parent2 ${info.visibleBounds}");
                if (info.visibleBounds.top == 0 &&
                    info.visibleBounds.bottom == 0 &&
                    info.visibleBounds.left == 0 &&
                    info.visibleBounds.right == 0) {
                  controller.parentIsVisible[1] = false;
                } else {
                  controller.parentIsVisible[1] = true;
                }
                // print(controller.parentIsVisible);
              },
              child: GestureDetector(
                onLongPress: () {
                  print("Tapped $widgetID $parentID ");
                  controller.handleMessage("$widgetID $parentID d");
                },
                onDoubleTap: () {
                  uiController.widgetFS[1] = !uiController.widgetFS[1];
                  if (uiController.widgetFS[1] == true) {
                    uiController.widgetHeight[1] = 1.0;
                    uiController.widgetWidth[1] = 0.65;
                    uiController.widgetHeight[0] = 0;
                    uiController.extendedConnected =
                        !uiController.extendedConnected;
                    uiController.showSideBar = true;
                  } else if (uiController.widgetFS[1] == false) {
                    uiController.widgetHeight[1] =
                        uiController.parentSize[1] ? 0.7 : 0.3;
                    uiController.widgetWidth[1] = 0.35;
                    uiController.widgetHeight[0] =
                        uiController.parentSize[0] ? 0.7 : 0.3;
                    uiController.extendedConnected =
                        !uiController.extendedConnected;
                    uiController.showSideBar = false;
                  }
                  uiController.update();
                },
                onTap: () {
                  if (!uiController.showSideBar) {
                    uiController.parentSize[0] = !uiController.parentSize[0];
                    uiController.parentSize[1] = !uiController.parentSize[1];
                    // print("Called P2 : ${uiController.parentSize}");
                    if (uiController.parentSize[1]) {
                      uiController.widgetHeight[1] = 0.7;
                      uiController.widgetHeight[0] = 0.3;
                    } else {
                      uiController.widgetHeight[0] = 0.7;
                      uiController.widgetHeight[1] = 0.3;
                    }
                  }
                  // print("Widget Height : ${uiController.widgetHeight}");
                  uiController.update();
                },
                child: AnimatedContainer(
                  duration: uiController.animationDelay,
                  height: height * uiController.widgetHeight[1],
                  // color: Colors.cyan,
                  child: widget,
                ),
              ),
            );
          });
        },
        onAccept: (String data) {
          if (parentID != data) {
            print('Accepted');
            controller.swapWidget(parentID, data);
          } else {
            print("same $data");
          }
        },
      );
    });
  }
}
