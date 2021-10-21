import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/models.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final recipes = snapshot.data?.todayRecipes ?? [];
            return SingleChildScrollView(
              child: Column(children: [
                TodayRecipeListView(recipes: recipes),
                const SizedBox(height: 16),
                // Container(
                //   height: 600,
                //   color: Colors.green,
                // ),
                FriendPostListView(
                    friendPosts: snapshot.data?.friendPosts ?? []),
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
