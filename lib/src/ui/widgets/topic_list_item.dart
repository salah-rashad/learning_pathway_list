import 'package:flutter/material.dart';
import 'package:learning_pathway_list/src/data/models/topic.dart';

class TopicListItem extends StatelessWidget {
  final Topic topic;
  final int horizontalPosition;
  final bool isCentered;
  final GlobalKey painterKey;

  static const int maxPositions = 2;

  TopicListItem({
    super.key,
    required this.topic,
    required this.horizontalPosition,
    this.isCentered = false,
  }) : painterKey = GlobalKey();

  static const edgeInsets =
      EdgeInsets.symmetric(horizontal: 32.0, vertical: 30);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets,
      child: Row(
        children: List.generate(
          isCentered ? 3 : maxPositions,
          (i) => buildItem(context, i),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int i) {
    int pos = horizontalPosition;
    final Alignment alignment;
    if (isCentered) {
      pos = 1;
      alignment = Alignment.center;
    } else {
      // pos = i;
      if ((maxPositions % 2).isOdd) {
        if (i < maxPositions ~/ 2) {
          alignment = Alignment.centerRight;
        } else if (i > maxPositions ~/ 2) {
          alignment = Alignment.centerLeft;
        } else {
          alignment = Alignment.center;
        }
      } else {
        if (i < maxPositions / 2) {
          alignment = Alignment.centerRight;
        } else {
          alignment = Alignment.centerLeft;
        }
      }
    }

    if (i == pos) {
      return Expanded(
        child: Align(
          alignment: Alignment.center, // alignment,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: topic.isFinished ? 1 : 0.7,
              child: Container(
                key: painterKey,
                clipBehavior: Clip.antiAlias,
                // constraints: const BoxConstraints.expand(width: 300, height: 56),
                decoration: ShapeDecoration(
                  color: topic.isFinished ? Colors.green : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      width: 1,
                      color: topic.isFinished ? Colors.green : Colors.grey,
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: topic.isFinished
                          ? Colors.green.shade800
                          : Colors.grey.shade700,
                      blurRadius: 0,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_rounded,
                          weight: 40.0,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                topic.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                // style: Omnes.w700.getStyle(
                                //   fontSize: 16,
                                //   color: context.colors.headline,
                                // ),
                              ),
                              // Text(
                              //   topic.description,
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: Omnes.w500.getStyle(fontSize: 12),
                              // ),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 12,
                                    // color: context.colors.bodyText,
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      "2 minutes",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      // style: Omnes.w500.getStyle(
                                      //   fontSize: 12,
                                      //   color: context.colors.bodyText,
                                      // ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (topic.isFinished)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        else
                          SizedBox.square(
                            dimension: 16,
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 500),
                              tween: Tween(
                                begin: 0.0,
                                end: topic.isOpened ? 0.5 : 0.0,
                              ),
                              builder: (context, value, child) {
                                return CircularProgressIndicator(
                                  value: value,
                                  color: Colors.blue,
                                  backgroundColor: Colors.blue.withOpacity(0.5),
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 4,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: isCentered ? 40 : 80,
      height: 0,
    );
  }
}
