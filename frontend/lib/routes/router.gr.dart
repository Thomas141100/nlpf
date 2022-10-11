// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../screens/homepage.dart' as _i2;
import '../screens/jobofferspage.dart' as _i4;
import '../screens/loginpage.dart' as _i1;
import '../screens/userpage.dart' as _i3;
import 'auth_guard.dart' as _i7;

class AppRouter extends _i5.RootStackRouter {
  AppRouter({
    _i6.GlobalKey<_i6.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i7.AuthGuard authGuard;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    UserRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.UserPage(),
      );
    },
    JobOffersRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.JobOffersPage(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          LoginRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/home',
          guards: [authGuard],
        ),
        _i5.RouteConfig(
          UserRoute.name,
          path: '/user',
          guards: [authGuard],
        ),
        _i5.RouteConfig(
          JobOffersRoute.name,
          path: '/joboffers',
          guards: [authGuard],
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.UserPage]
class UserRoute extends _i5.PageRouteInfo<void> {
  const UserRoute()
      : super(
          UserRoute.name,
          path: '/user',
        );

  static const String name = 'UserRoute';
}

/// generated route for
/// [_i4.JobOffersPage]
class JobOffersRoute extends _i5.PageRouteInfo<void> {
  const JobOffersRoute()
      : super(
          JobOffersRoute.name,
          path: '/joboffers',
        );

  static const String name = 'JobOffersRoute';
}
