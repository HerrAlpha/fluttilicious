library fluttilicious;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomMenuBar extends StatelessWidget {
  final List<Widget> pages;
  final List<IconData> icons;
  final List<String> titles;
  final List<Color> iconColors;
  final Color iconColor;
  final bool wantUseDefaultAppBar;
  final bool multiColor;
  final bool iconText;
  final double iconSize;
  final RxInt selectedIndex = 0.obs; // Use RxInt for reactive state
  final RxInt hoveredIndex = RxInt(-1); // Added to track the hovered index

  BottomMenuBar.uniColor({
    Key? key,
    required this.pages,
    required this.icons,
    required this.titles,
    this.iconColor = Colors.blue,
    this.wantUseDefaultAppBar = false,
    this.iconText = false,
    this.iconSize = 24,
  })  : iconColors = List.generate(icons.length, (_) => iconColor),
        multiColor = false,
        super(key: key);

  BottomMenuBar.multiColor({
    Key? key,
    required this.pages,
    required this.icons,
    required this.titles,
    required this.iconColors,
    this.wantUseDefaultAppBar = false,
    this.iconText = false,
    this.iconSize = 24,
  })  : iconColor = Colors.transparent,
        multiColor = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wantUseDefaultAppBar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: SafeArea(
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          titles[selectedIndex.value],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Stack(
            alignment: Alignment.bottomCenter,
            // overflow: Overflow.visible,
            children: [
              Container(
                  padding: EdgeInsets.only(
                    bottom: 70,
                    top: wantUseDefaultAppBar ? 70 : 0,
                  ),
                  child: Obx(() => pages[selectedIndex.value])),
              Container(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        icons.length,
                        (index) {
                          final isHovered = hoveredIndex.value == index;
                          final isSelected = selectedIndex.value == index;
                          return MouseRegion(
                            onEnter: (_) {
                              hoveredIndex.value = index;
                            },
                            onExit: (_) {
                              hoveredIndex.value = -1;
                            },
                            child: GestureDetector(
                              onTap: () {
                                selectedIndex.value = index;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ],
                                  color: isSelected
                                      ? iconColors[index].withOpacity(0.4)
                                      : isHovered
                                          ? iconColors[index].withOpacity(0.2)
                                          : Colors.grey.withOpacity(0.2),
                                  // borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icons[index],
                                      size: iconSize,
                                      color: isSelected
                                          ? multiColor
                                              ? iconColors[index]
                                              : iconColor
                                          : Colors.grey,
                                    ),
                                    if (iconText)
                                      Text(
                                        titles[index],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isSelected
                                              ? multiColor
                                                  ? iconColors[index]
                                                  : iconColor
                                              : Colors.grey,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ]),
      ),
    );
  }
}

class SideMenuBar extends StatelessWidget {
  final List<String> headTitle;
  final List<IconData> headIcon;
  final List<Color> headColor;
  final List<Widget> pages;
  final Color backgroundColor;

  SideMenuBar({
    Key? key,
    required this.headTitle,
    required this.headIcon,
    required this.headColor,
    required this.pages,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final selectedMenuItem = RxInt(0);
  final hoveredIndex = RxInt(-1); // Using RxInt for hovered index,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            // left for side menu with floating design and rounded corner
            Container(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 250,
                height: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: ListView.builder(
                  itemCount: headTitle.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final isHovered = hoveredIndex.value == index;
                      return MouseRegion(
                        onEnter: (_) {
                          hoveredIndex.value = index;
                        },
                        onExit: (_) {
                          hoveredIndex.value = -1;
                        },
                        child: InkWell(
                          onTap: () {
                            selectedMenuItem.value = index;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: selectedMenuItem.value == index
                                  ? headColor[index].withOpacity(0.2)
                                  : isHovered
                                      ? headColor[index].withOpacity(0.1)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    headIcon[index],
                                    color: selectedMenuItem.value == index
                                        ? headColor[index]
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  headTitle[index],
                                  style: TextStyle(
                                    color: selectedMenuItem.value == index
                                        ? headColor[index]
                                        : Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),

            // right side for content
            Expanded(
              child: Obx(
                () {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // app bar

                        Text(
                          headTitle[selectedMenuItem.value],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),

                        // content
                        Expanded(
                          child: pages[selectedMenuItem.value],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
