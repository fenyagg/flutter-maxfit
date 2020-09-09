import 'package:flutter/material.dart';
import 'package:flutter_app/domain/appUser.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'home.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<AppUser>(context);
    final bool isLoggedIn = user != null;

    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}
