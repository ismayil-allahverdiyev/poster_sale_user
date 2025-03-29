import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/constants/data.dart';
import 'package:poster_sale_user/src/controllers/home/home_controller.dart';
import 'package:poster_sale_user/src/data/models/poster/poster_model.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';
import '../../constants/assets.dart';
import '../theme/app_colors.dart';
import 'source/custom_icon_button.dart';
import 'source/custom_tabbar_view.dart';
import 'package:shimmer/shimmer.dart';

class PosterAnimatedWidget extends GetWidget<HomeController> {
  const PosterAnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.allPosters.isEmpty
            ? const SizedBox()
            : CustomTabBarView(
                tabController: controller.tabController,
                widgets: controller.allPosters
                    .map((poster) => PosterWidget(poster: poster))
                    .toList(),
                animate: controller.animate,
                height: Get.width * 1.2 + 32,
                hasControlledAnimation: true,
              );
      },
    );
  }
}

class PosterWidget extends StatefulWidget {
  final PosterModel poster;
  const PosterWidget({
    super.key,
    required this.poster,
  });

  @override
  _PosterWidgetState createState() => _PosterWidgetState();
}

class _PosterWidgetState extends State<PosterWidget> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after the first frame
    Future.delayed(Duration.zero, () {
      setState(() {
        _isInitialized = true;
      });
    });
  }

  Duration _randomAnimationDuration() {
    // Generate a random duration between 1 to 3 seconds
    return Duration(seconds: 1 + Random().nextInt(2));
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final borderWidth = Get.width * 0.02;

    // Randomly determine the total number of boxes (2 or 3)
    final int totalBoxes =
        2 + random.nextInt(2); // Ensures at least 2 and at most 3

    // Random size for containers within specified ranges
    double randomSizeFactor(double min, double max) =>
        min + random.nextDouble() * (max - min);

    // Define sizes for full white container
    double fullBoxWidth = Get.width * randomSizeFactor(0.25, 0.4);
    double fullBoxHeight = Get.width * randomSizeFactor(0.35, 0.5);

    // Define sizes for containers with borders
    List<Map<String, double>> borderedBoxes = [];
    for (int i = 0; i < totalBoxes; i++) {
      borderedBoxes.add({
        'width': Get.width * randomSizeFactor(0.15, 0.3),
        'height': Get.width * randomSizeFactor(0.25, 0.5),
      });
    }

    // Avoid collision by ensuring different sides for bordered boxes
    List<Positioned> createBorderedContainers(String oppositeSide) {
      List<Positioned> containers = [];
      double verticalSpacing = 0;

      // Ensure that we have at least 2 bordered boxes on the opposite side
      for (int i = 0; i < 2; i++) {
        if (i < borderedBoxes.length) {
          containers.add(Positioned(
            top: verticalSpacing,
            left: oppositeSide == 'left' ? 0 : null,
            right: oppositeSide == 'right' ? 0 : null,
            child: AnimatedSize(
              duration: _randomAnimationDuration(), // Use random duration
              curve: Curves.easeOut,
              child: Container(
                width: _isInitialized ? borderedBoxes[i]['width'] : 0,
                height: _isInitialized ? borderedBoxes[i]['height'] : 0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: borderWidth, // Keep border width constant
                  ),
                ),
              ),
            ),
          ));
          if (oppositeSide == 'left') {
            oppositeSide = 'right';
          } else {
            oppositeSide = 'left';
          }
          verticalSpacing += borderedBoxes[i]['height']! +
              borderWidth * 2; // Update space for next box
        }
      }

      // If there's a third box, position it on the left side
      if (totalBoxes == 3 && borderedBoxes.length > 2) {
        containers.add(Positioned(
          top: verticalSpacing,
          left: 0, // Place this container on the left
          child: AnimatedSize(
            duration: _randomAnimationDuration(), // Use random duration
            curve: Curves.easeOut,
            child: Container(
              width: _isInitialized ? borderedBoxes[2]['width'] : 0,
              height: _isInitialized ? borderedBoxes[2]['height'] : 0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: borderWidth, // Keep border width constant
                ),
              ),
            ),
          ),
        ));
      }

      return containers;
    }

    // Randomly choose a corner for the full white container
    List<Alignment> corners = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight
    ];

    // Pick a random corner for the full white container
    Alignment fullWhiteCorner = corners[random.nextInt(4)];

    // Determine the opposite side
    String oppositeSide;
    if (fullWhiteCorner == Alignment.topLeft ||
        fullWhiteCorner == Alignment.bottomLeft) {
      oppositeSide = 'right'; // Full white container on the left
    } else {
      oppositeSide = 'left'; // Full white container on the right
    }

    // Full white container in a random corner
    Widget fullWhiteContainer = Align(
      alignment: fullWhiteCorner,
      child: AnimatedSize(
        duration: _randomAnimationDuration(), // Use random duration
        curve: Curves.easeOut,
        child: Container(
          width: _isInitialized ? fullBoxWidth : 0,
          height: _isInitialized ? fullBoxHeight : 0,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );

    // Create bordered containers on the opposite side of the full white container
    List<Positioned> borderedContainers =
        createBorderedContainers(oppositeSide);

    // Create a smaller white container that is 50% the size of the full white container
    double smallBoxWidth = fullBoxWidth * 0.5;
    double smallBoxHeight = fullBoxHeight * 0.5;

    // Place the smaller white container in the opposite corner
    Widget smallWhiteContainer = Align(
      alignment: fullWhiteCorner == Alignment.topLeft
          ? Alignment.bottomRight
          : fullWhiteCorner == Alignment.topRight
              ? Alignment.bottomLeft
              : fullWhiteCorner == Alignment.bottomLeft
                  ? Alignment.topRight
                  : Alignment.topLeft,
      child: AnimatedSize(
        duration: _randomAnimationDuration(), // Use random duration
        curve: Curves.easeOut,
        child: Container(
          width: _isInitialized ? smallBoxWidth : 0,
          height: _isInitialized ? smallBoxHeight : 0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: _isInitialized
                    ? borderWidth
                    : 0, // Keep border width constant
              )),
        ),
      ),
    );

    // Randomly positioned text container
    double textVerticalPosition =
        random.nextDouble() * (Get.width * 1.2 - (Get.width * 0.05));

    // Calculate bounds for text container to avoid collision with the full white container
    double fullWhiteTop = fullWhiteCorner.y == 1.0 ? 0 : 0;
    double fullWhiteBottom = fullWhiteCorner.y == 1.0
        ? fullWhiteTop + fullBoxHeight
        : Get.width * 1.2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.PRODUCT,
              parameters: {
                "id": widget.poster.id,
              },
            );
          },
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.poster.images[0],
                imageBuilder: (context, imageProvider) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: Get.width * 1.2,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, progress) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomShimmer(
                    child: Container(
                      height: Get.width * 1.2,
                      width: Get.width,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              ...borderedContainers,
              fullWhiteContainer,
              smallWhiteContainer, // Add the smaller white container
              // Randomly positioned text container
              Positioned(
                bottom: textVerticalPosition,
                left: oppositeSide == 'left' ? -1 : null,
                right: oppositeSide == 'right' ? -1 : null,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.width * 0.01,
                    ),
                    child: Text(
                      "${MonthNames[widget.poster.startDate.month - 1]} ${widget.poster.startDate.year} - ${MonthNames[widget.poster.endDate.month - 1]} ${widget.poster.endDate.year}",
                      style: const TextStyle(
                        color: lightBlueTextColor, // lightBlueTextColor
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CustomIconButton(
            assetPath: Assets.icon_dots,
            onTap: () {},
            height: 32,
          ),
        )
      ],
    );
  }
}
