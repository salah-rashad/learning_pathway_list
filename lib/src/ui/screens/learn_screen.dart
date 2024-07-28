import 'package:flutter/material.dart';
import 'package:learning_pathway_list/src/data/models/topic.dart';
import 'package:learning_pathway_list/src/ui/widgets/topics_list.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Topic> topics = [
      Topic(
        name: 'Topic 1',
        isFinished: true,
        isOpened: true,
      ),
      Topic(
        name: 'Topic 2',
        isFinished: true,
        isOpened: true,
      ),
      Topic(
        name: 'Topic 3',
        isFinished: false,
        isOpened: true,
      ),
      Topic(
        name: 'Topic 4',
        isFinished: false,
        isOpened: false,
      ),
      Topic(
        name: 'Topic 5',
        isFinished: false,
        isOpened: false,
      ),
      Topic(
        name: 'Topic 6',
        isFinished: false,
        isOpened: false,
      ),
      Topic(
        name: 'Topic 7',
        isFinished: false,
        isOpened: false,
      ),
      Topic(
        name: 'Topic 8',
        isFinished: false,
        isOpened: false,
      ),
      Topic(
        name: 'Topic 9',
        isFinished: false,
        isOpened: false,
      ),
      Topic(
        name: 'Topic 10',
        isFinished: false,
        isOpened: false,
      ),
    ];

    return Scaffold(
      body: TopicsList(topics: topics),
    );
  }
}
