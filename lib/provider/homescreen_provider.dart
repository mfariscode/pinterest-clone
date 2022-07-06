import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pinterest_clone/model/images_model.dart';
import 'package:image_downloader/image_downloader.dart';

import '../utils/show_snackbar.dart';

class HomeProvider extends ChangeNotifier {

  var api = "https://api.pexels.com/v1/curated?per_page=80";
  List images = [];
  int page = 1;
  PhotosModel? photosModel;

  ////For Api Fetching

  Future getImages() async {
    var url = Uri.parse(api);
    debugPrint(url.toString());
    var response = await http.get(url, headers: {
      'Authorization':
          '563492ad6f91700001000001c1fb25ae0b524b77a4a8a739b99dde57'
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      photosModel = PhotosModel.fromJson(jsonResponse);
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
    notifyListeners();
  }

  ////For Lazy Loading

  Future loadMore() async {
    page = page + 1;
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization':
      '563492ad6f91700001000001c1fb25ae0b524b77a4a8a739b99dde57'
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      photosModel = PhotosModel.fromJson(jsonResponse);
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
    notifyListeners();
  }


  ////For Downloading Image


  Future downloadImage(url, context) async {
    try {
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return;
      }
      var path = await ImageDownloader.findPath(imageId);
      showSnackBar(message: 'Image Downloaded', context: context);
    } on PlatformException catch (error) {
      print(error);
    }
  }
}
