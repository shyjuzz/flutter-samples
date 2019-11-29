import 'package:flutter/material.dart';
import 'package:mvvm_boilerplate/ui/views/login_view.dart';
import 'package:mvvm_boilerplate/utils/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutingConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
