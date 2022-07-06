// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../provider/homescreen_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState()  {
    Provider.of<HomeProvider>(context, listen: false).getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Popular"),
      ),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, snapshot, child) => snapshot.images == null ?
          const Center(child: CupertinoActivityIndicator(),)
          : Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: LazyLoadScrollView(// The callback when reaching the end of the list
              scrollOffset: 50,// Pixels from the bottom that should trigger a callback
              onEndOfPage: () => snapshot.loadMore(),
              child:  StaggeredGridView.countBuilder(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 5),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
                shrinkWrap: true,
                itemCount: snapshot.images.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      snapshot.downloadImage(snapshot.images[index]['src']['original'], context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15))
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                             Radius.circular(15)),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.images[index]['src']['portrait'],fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }
            ),
        ),
          ),
        ),
      ),
    );
  }
}
