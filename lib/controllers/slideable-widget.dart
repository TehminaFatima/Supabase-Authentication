import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandableMenuController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> heightAnimation;
  final RxBool isExpanded = false.obs;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    heightAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void toggleMenu() {
    isExpanded.value
        ? animationController.reverse()
        : animationController.forward();
    isExpanded.toggle();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class ExpandableIconMenu extends StatelessWidget {
  final List<Widget> expandedChildren;
  final Widget mainIcon;
  final double spacing;

  const ExpandableIconMenu({
    super.key,
    required this.expandedChildren,
    required this.mainIcon,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExpandableMenuController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizeTransition(
          sizeFactor: controller.heightAnimation,
          axisAlignment: -1,
          child: Column(
            children: expandedChildren
                .map((child) => Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: child,
                    ))
                .toList(),
          ),
        ),
        GestureDetector(
          onTap: controller.toggleMenu,
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 300),
            turns: controller.isExpanded.value ? 0.5 : 0,
            child: mainIcon,
          ),
        ),
      ],
    );
  }
}
