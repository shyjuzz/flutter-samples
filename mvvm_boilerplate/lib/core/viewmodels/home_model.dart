import 'package:mvvm_boilerplate/core/services/api.dart';
import 'package:mvvm_boilerplate/utils/enums/viewstate.dart';

import '../../locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Post> posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
//    posts = await _api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}

class Post {
}