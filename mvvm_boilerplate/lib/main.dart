import 'package:flutter/material.dart';
import 'package:mvvm_boilerplate/ui/router.dart';
import 'package:provider/provider.dart';
import 'core/models/user.dart';
import 'core/services/authentication_service.dart';
import 'locator.dart';
import 'utils/constants.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User>(
      initialData: User.initial(),
      builder: (context) => locator<AuthenticationService>().userController,
      child: MaterialApp(
        title: 'Sales App',
        theme: ThemeData(),
        initialRoute: RoutingConstants.loginRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}