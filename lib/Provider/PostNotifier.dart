import 'dart:io';
import 'package:cobed/Services/API.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PostNotifier extends ChangeNotifier {
  String title;
  String caption;
  File img;

  File get getImg => img;

  Future<bool> addPost()async{
    if(title!=null||caption!=null||img!=null){
      Map map;
      if(title==null)
        map = {"description":caption};
      else if(caption==null)
        map = {"title":title};
      else
        map = {
          "title":title,
          "description":caption
        };
      bool response = await API().addPost(image: img,body: map);
      title=null;
      caption=null;
      img=null;
      notifyListeners();
      return response;
    }
    return true;
  }

  Future<bool> editPost({String id}) async{
    if(title!=null||caption!=null||img!=null){
      Map map;
      if(title==null)
        map = {"description":caption};
      else if(caption==null)
        map = {"title":title};
      else
        map = {
          "title":title,
          "description":caption
        };
      bool response = await API().editInfo(
          body: map,image: img,urlCompleter: 'posts/$id'
      );
      title=null;
      caption=null;
      img=null;
      notifyListeners();
      return response;
    }
    return false;
  }

  Future<bool> deletePost({String id,int index})async{
    final result = await API().deletePost(id: id);
    return result;
  }

  void setPostTitle({String postTitle}) {
    title = postTitle;
    notifyListeners();
  }

  void setPostCaption({String postCaption}) {
    caption = postCaption;
    notifyListeners();
  }

  Future<void> getImgFromDevice() async {
    img = await ImagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void setNullImg() {
    img = null;
    notifyListeners();
  }
}