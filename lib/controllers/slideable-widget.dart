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
  final Color iconColor;

  const ExpandableIconMenu({
    super.key,
    required this.expandedChildren,
    required this.mainIcon,
    this.spacing = 10,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExpandableMenuController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height:
              controller.isExpanded.value ? expandedChildren.length * 60 : 0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: expandedChildren
                  .map((child) => Padding(
                        padding: EdgeInsets.only(bottom: spacing),
                        child: IconTheme(
                          data: IconThemeData(color: iconColor),
                          child: child,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        GestureDetector(
          onTap: controller.toggleMenu,
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 300),
            turns: controller.isExpanded.value ? 0.5 : 0,
            child: IconTheme(
              data: IconThemeData(color: iconColor),
              child: mainIcon,
            ),
          ),
        ),
      ],
    );
  }
}
