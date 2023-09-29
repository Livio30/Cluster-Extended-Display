import 'package:comm/controller/UIController.dart';
import 'package:comm/controller/ServerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ParentConatainer8 extends StatelessWidget {
  final Widget widget;

  final String widgetID;
  final String parentID = "8";
  double mainHeight;
  double mainWidth;
  ParentConatainer8(
      {super.key,
      required this.widget,
      required this.widgetID,
      required this.mainHeight,
      required this.mainWidth});

  @override
  Widget build(BuildContext context) {
    double height = mainHeight;
    double width = mainWidth;
    // print("Parent8");
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
            //   controller.parentIsVisible[4] = false;
            //   controller.parentIsVisible[5] = false;
            //   controller.parentIsVisible[6] = true;
            //   controller.parentIsVisible[7] = true;
            print(controller.parentIsVisible);
            print("parent8");
            // }
            // print("Toggle");
            // if(controller.intialCall){
            //   controller.intialCall = false;
            // }
            // // if(controller.intialCall == true ){
            //   controller.intialCall = false;
            // }
            // else{
            //   controller.intialCall = !controller.intialCall;
            // }
            return VisibilityDetector(
              key: Key("8"),
              onVisibilityChanged: (info) {
                print("changed parent8 ${info.visibleBounds}");
                // print("changed parent3 ${info.visibleBounds.left}");
                // print("changed parent3 ${info.visibleBounds.right.round()}");
                // print("changed parent3 ${info.visibleBounds.bottom.round()}");
                // print("changed parent3 ${info.visibleBounds.top}");
                if (info.visibleBounds.top == 0 &&
                    info.visibleBounds.bottom == 0 &&
                    info.visibleBounds.left == 0 &&
                    info.visibleBounds.right == 0) {
                  controller.parentIsVisible[7] = false;
                } else {
                  controller.parentIsVisible[7] = true;
                }
                print(controller.parentIsVisible);
              },
              child: GestureDetector(
                onLongPress: () {
                  print("Tapped $widgetID $parentID ");
                  controller.handleMessage("$widgetID $parentID d");
                },
                onDoubleTap: () {
                  uiController.widgetFS[7] = !uiController.widgetFS[7];
                  if (uiController.widgetFS[7] == true) {
                    uiController.widgetHeight[7] = 1.0;
                    uiController.widgetWidth[7] = 0.65;
                    uiController.widgetHeight[6] = 0;
                    uiController.extendedConnected =
                        !uiController.extendedConnected;
                    uiController.showSideBar = true;
                  } else if (uiController.widgetFS[7] == false) {
                    uiController.widgetHeight[7] =
                        uiController.parentSize[7] ? 0.7 : 0.3;
                    uiController.widgetWidth[7] = 0.325;
                    uiController.widgetHeight[6] =
                        uiController.parentSize[6] ? 0.7 : 0.3;
                    uiController.extendedConnected =
                        !uiController.extendedConnected;
                    uiController.showSideBar = false;
                  }
                  uiController.update();
                },
                onTap: () {
                  if (!uiController.showSideBar) {
                    uiController.parentSize[7] = !uiController.parentSize[7];
                    uiController.parentSize[6] = !uiController.parentSize[6];
                    if (uiController.parentSize[7]) {
                      uiController.widgetHeight[7] = 0.7;
                      uiController.widgetHeight[6] = 0.3;
                    } else {
                      uiController.widgetHeight[6] = 0.7;
                      uiController.widgetHeight[7] = 0.3;
                    }
                    uiController.update();
                  }
                },
                child: AnimatedContainer(
                  duration: uiController.animationDelay,
                  height: height * uiController.widgetHeight[7],
                  // color: Colors.deepPurple,
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
