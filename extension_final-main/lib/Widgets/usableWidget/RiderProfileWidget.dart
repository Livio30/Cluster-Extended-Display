import 'package:comm_client/Widgets/variableSizeWidget/RiderProfile.dart';
import 'package:comm_client/controller/UIController.dart';
import 'package:comm_client/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RiderProfileWidget extends StatelessWidget {
  RiderProfileWidget({
    super.key,
  });

  static String id = "8";
  String parentId = "8";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientController>(builder: (controller) {
      // print("Spotify ${controller.w1ParentID}");
      return GetBuilder<UIController>(builder: (uiCOntroller) {
        return Stack(
          children: [
            GetBuilder<UIController>(builder: (uiCOntroller) {
              return AnimatedCrossFade(
                firstChild: uiCOntroller.widgetFs[int.parse(controller.getParentID(id))]
                    ? RiderProfileLg()
                    : RiderProfileMd(),
                secondChild: RiderProfileSm(),
                crossFadeState:
                    uiCOntroller.parentSize[int.parse(controller.getParentID(id))]
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                duration: uiCOntroller.animationDelay,
              );
            }),
            Center(
              child: Draggable(
                data: parentId,
                feedback: Container(
                  height: 150,
                  width: 150,
                  color: Colors.black,
                  margin: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Rider Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  height: 150,
                  width: 150,
                  color: Colors.blueGrey,
                  margin: const EdgeInsets.all(5),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  color: const Color.fromARGB(0, 255, 193, 7),
                ),
              ),
            )
          ],
        );
      });
    });
  }
}
