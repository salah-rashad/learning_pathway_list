import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_pathway_list/src/core/assets.dart';
import 'package:learning_pathway_list/src/data/models/topic.dart';
import 'package:learning_pathway_list/src/ui/widgets/path_line_painter.dart';
import 'package:learning_pathway_list/src/ui/widgets/topic_list_item.dart';

final scrollController = ScrollController();

class TopicsList extends StatelessWidget {
  final List<Topic> topics;

  const TopicsList({
    super.key,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            // maxWidth: 600,
            ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              SvgPicture.asset(Svgs.circlePattern),
              CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: _CustomListDelegate(
                      items: topics.mapIndexed((index, topic) {
                        return TopicListItem(
                          topic: topic,
                          horizontalPosition:
                              calculateZigzagPosition(index, topics.length),
                          isCentered: index == 0 || index == topics.length - 1,
                          // onTopicChanged: onTopicChanged,
                        );
                      }).toList(),
                      itemBuilder: (context, index, previousItem, item) {
                        return CustomPaint(
                          willChange: false,
                          isComplex: false,
                          painter: PathLinePainter(
                            // repaint: scrollController,
                            color: previousItem?.topic.isFinished == true
                                ? Colors.green
                                : Colors.grey.shade300,
                            itemKey: item.painterKey,
                            endItemKey: previousItem?.painterKey,
                            previousIndex: index - 1,
                            itemPadding: TopicListItem.edgeInsets,
                            scrollOffset: scrollController.position.pixels,
                          ),
                          child: item,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int calculateZigzagPosition(int index, int topicsLength) {
    const maxPositions = TopicListItem.maxPositions;
    const centerPosition = maxPositions ~/ 2;
    index -= centerPosition;
    // int direction = (index ~/ (2 * maxPositions)) % 2;
    int positionInDirection = index % (2 * maxPositions - 2);

    int adjustedPosition = positionInDirection >= maxPositions
        ? 2 * maxPositions - 2 - positionInDirection
        : positionInDirection;

    return adjustedPosition;
  }
}

typedef ItemBuilder = Widget Function(
  BuildContext context,
  int index,
  TopicListItem? previousItem,
  TopicListItem item,
);

class _CustomListDelegate extends SliverChildBuilderDelegate {
  final List<TopicListItem> items;

  _CustomListDelegate({
    required this.items,
    required ItemBuilder itemBuilder,
  }) : super(
          (context, index) {
            return itemBuilder(
              context,
              index,
              index > 0 ? items[index - 1] : null,
              items[index],
            );
          },
          childCount: items.length,
        );

  @override
  bool shouldRebuild(covariant _CustomListDelegate oldDelegate) {
    return !identical(oldDelegate.items, items);
  }
}
