import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinterest_clone/model/images_model.dart';

class HomeProvider extends ChangeNotifier {
  var api = "https://api.pexels.com/v1/curated?per_page=80";
  List images = [];
  int page = 1;
  PhotosModel? photosModel;

  Future getImages() async {
    var url = Uri.parse(api);
    debugPrint(url.toString());
    await http.get(url, headers: {
      'Authorization':
          '563492ad6f91700001000001c1fb25ae0b524b77a4a8a739b99dde57'
    }).then((value) {
      Map result = jsonDecode(value.body);
      print(result);
      images = result['photos'];
    });
    notifyListeners();
  }

  Future loadMore() async {
    page = page + 1;
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString() ;
    var newUrl = Uri.parse(url);
    await http.get(newUrl, headers: {
      'Authorization':
      '563492ad6f91700001000001c1fb25ae0b524b77a4a8a739b99dde57'
    }).then((value) {
      Map result = jsonDecode(value.body);
      images.addAll(result['photos']);
      notifyListeners();
    });
    notifyListeners();
  }
}
