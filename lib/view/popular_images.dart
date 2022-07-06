import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import '../provider/homescreen_provider.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Popular Images"),
      ),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, snapshot, child) => snapshot.photosModel == null
              ? const Center(
            child: CupertinoActivityIndicator(),
          )
              : Padding(
            padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: LazyLoadScrollView(
              // The callback when reaching the end of the list
              scrollOffset:
              50, // Pixels from the bottom that should trigger a callback
              onEndOfPage: () => snapshot.loadMore(),
              child: StaggeredGridView.countBuilder(
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  itemCount: snapshot.photosModel!.photos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        snapshot.downloadImage(
                            snapshot.images[index]['src']['original'],
                            context);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15))),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15)),
                                child: FadeInImage.assetNetwork(
                                  placeholderFit: BoxFit.contain,
                                  placeholder:
                                  'assets/images/pexels-logo.png',
                                  image: snapshot.photosModel!
                                      .photos[index].src.portrait,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: snapshot.photosModel!
                                        .photos[index].alt !=
                                        ""
                                        ? Text(
                                      snapshot.photosModel!
                                          .photos[index].alt,
                                      maxLines: 2,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.black54),
                                    )
                                        : const Text(
                                      'No Title Available',
                                      maxLines: 2,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(
                        1, index.isEven ? 1.8 : 2.0);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
