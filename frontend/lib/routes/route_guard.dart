import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/module/auth.dart';
import 'package:fht_linkedin/routes/router.gr.dart';

class RouteGuard extends AutoRedirectGuard {
  final AuthService authService;
  RouteGuard(this.authService) {
    authService.addListener(() {
      if (!authService.authenticated) {
        reevaluate();
      }
    });
  }
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authService.authenticated) return resolver.next();
    router.push(const LoginRoute());
  }
}
