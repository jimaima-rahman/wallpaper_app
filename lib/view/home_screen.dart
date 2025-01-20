import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpapper_app/provider/unplash_provider.dart';
import 'package:wallpapper_app/view/widgets/image_tile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper Collections'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     onPressed: () {
        //       context.read<CollectionsProvider>().refreshCollections();
        //     },
        //   ),
        // ],
      ),
      body: Consumer<CollectionsProvider>(
        builder: (context, provider, child) {
          if (provider.collections.isEmpty && provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.refreshCollections(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!provider.isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                provider.loadCollections();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: provider.refreshCollections,
              child: GridView.custom(
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  pattern: [
                    const WovenGridTile(1),
                    const WovenGridTile(
                      5 / 7,
                      crossAxisRatio: 0.9,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= provider.collections.length) {
                      return null;
                    }
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ImageTile(image: provider.collections[index]));
                  },
                  childCount: provider.collections.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
