import 'package:comm/controller/UIController.dart';
import 'package:comm/controller/ServerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ParentConatainer5 extends StatelessWidget {
  final Widget widget;

  final String widgetID;
  final String parentID = "5";
  double mainHeight;
  double mainWidth;
  ParentConatainer5(
      {super.key,
      required this.widget,
      required this.widgetID,
      required this.mainHeight,
      required this.mainWidth});

  @override
  Widget build(BuildContext context) {
    double height = mainHeight;
    double width = mainWidth;
    // print("Parent5");
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
            //   controller.parentIsVisible[4] = true;
            //   controller.parentIsVisible[5] = true;
            //   controller.parentIsVisible[6] = false;
            //   controller.parentIsVisible[7] = false;
            print(controller.parentIsVisible);
            print("parent5");
            // }
            return VisibilityDetector(
              key: Key("5"),
              onVisibilityChanged: (info) {
                print("changed parent5 ${info.visibleBounds}");
                // print("changed parent3 ${info.visibleBounds.left}");
                // print("changed parent3 ${info.visibleBounds.right.round()}");
                // print("changed parent3 ${info.visibleBounds.bottom.round()}");
                // print("changed parent3 ${info.visibleBounds.top}");
                if (info.visibleBounds.top == 0 &&
                    info.visibleBounds.bottom == 0 &&
                    info.visibleBounds.left == 0 &&
                    info.visibleBounds.right == 0) {
                  controller.parentIsVisible[4] = false;
                } else {
                  controller.parentIsVisible[4] = true;
                }
                print(controller.parentIsVisible);
              },
              child: GestureDetector(
                onLongPress: () {
                  print("Tapped $widgetID $parentID ");
                  controller.handleMessage("$widgetID $parentID d");
                },
                onDoubleTap: () {
                  uiController.widgetFS[4] = !uiController.widgetFS[4];
                  if (uiController.widgetFS[4] == true) {
                    uiController.widgetHeight[4] = 1.0;
                    uiController.widgetWidth[4] = 0.65;
                    uiController.widgetHeight[5] = 0;
                    uiController.extendedConnected =
                        !uiController.extendedConnected;
                    uiController.showSideBar = true;
                  } else if (uiController.widgetFS[4] == false) {
                    uiController.widgetHeight[4] =
                        uiController.parentSize[4] ? 0.7 : 0.3;
                    uiController.widgetWidth[4] = 0.35;
                    uiController.widgetHeight[5] =
                        uiController.parentSize[5] ? 0.7 : 0.3;
                    uiController.extendedConnected =
                        !uiController.extendedConnected;
                    uiController.showSideBar = false;
                  }
                  uiController.update();
                },
                onTap: () {
                  if (!uiController.showSideBar) {
                    uiController.parentSize[4] = !uiController.parentSize[4];
                    uiController.parentSize[5] = !uiController.parentSize[5];
                    print("Called P5 : ${uiController.parentSize}");
                    if (uiController.parentSize[4]) {
                      uiController.widgetHeight[4] = 0.7;
                      uiController.widgetHeight[5] = 0.3;
                    } else {
                      uiController.widgetHeight[5] = 0.7;
                      uiController.widgetHeight[4] = 0.3;
                    }
                    uiController.update();
                  }
                  print("Widget Height : ${uiController.widgetHeight}");
                },
                child: AnimatedContainer(
                  duration: uiController.animationDelay,
                  height: height * uiController.widgetHeight[4],
                  // color: Colors.orange,
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
