// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasePage(),
      );
    },
    ChangeBioRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeBioRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangeBioPage(
          key: args.key,
          bio: args.bio,
          uid: args.uid,
        ),
      );
    },
    ChangeNameRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeNameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangeNamePage(
          key: args.key,
          uid: args.uid,
          firstName: args.firstName,
          lastName: args.lastName,
        ),
      );
    },
    CreatingPostRoute.name: (routeData) {
      final args = routeData.argsAs<CreatingPostRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreatingPostPage(
          key: args.key,
          xfile: args.xfile,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditProfilePage(
          key: args.key,
          uid: args.uid,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(key: args.key),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfilePage(
          key: args.key,
          uid: args.uid,
        ),
      );
    },
    SearchScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SearchScreenRouteArgs>(
          orElse: () => const SearchScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchScreenPage(key: args.key),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpPage(key: args.key),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [BasePage]
class BaseRoute extends PageRouteInfo<void> {
  const BaseRoute({List<PageRouteInfo>? children})
      : super(
          BaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BaseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeBioPage]
class ChangeBioRoute extends PageRouteInfo<ChangeBioRouteArgs> {
  ChangeBioRoute({
    Key? key,
    required String bio,
    required String uid,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeBioRoute.name,
          args: ChangeBioRouteArgs(
            key: key,
            bio: bio,
            uid: uid,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeBioRoute';

  static const PageInfo<ChangeBioRouteArgs> page =
      PageInfo<ChangeBioRouteArgs>(name);
}

class ChangeBioRouteArgs {
  const ChangeBioRouteArgs({
    this.key,
    required this.bio,
    required this.uid,
  });

  final Key? key;

  final String bio;

  final String uid;

  @override
  String toString() {
    return 'ChangeBioRouteArgs{key: $key, bio: $bio, uid: $uid}';
  }
}

/// generated route for
/// [ChangeNamePage]
class ChangeNameRoute extends PageRouteInfo<ChangeNameRouteArgs> {
  ChangeNameRoute({
    Key? key,
    required String uid,
    required String firstName,
    required String lastName,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeNameRoute.name,
          args: ChangeNameRouteArgs(
            key: key,
            uid: uid,
            firstName: firstName,
            lastName: lastName,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeNameRoute';

  static const PageInfo<ChangeNameRouteArgs> page =
      PageInfo<ChangeNameRouteArgs>(name);
}

class ChangeNameRouteArgs {
  const ChangeNameRouteArgs({
    this.key,
    required this.uid,
    required this.firstName,
    required this.lastName,
  });

  final Key? key;

  final String uid;

  final String firstName;

  final String lastName;

  @override
  String toString() {
    return 'ChangeNameRouteArgs{key: $key, uid: $uid, firstName: $firstName, lastName: $lastName}';
  }
}

/// generated route for
/// [CreatingPostPage]
class CreatingPostRoute extends PageRouteInfo<CreatingPostRouteArgs> {
  CreatingPostRoute({
    Key? key,
    required XFile xfile,
    List<PageRouteInfo>? children,
  }) : super(
          CreatingPostRoute.name,
          args: CreatingPostRouteArgs(
            key: key,
            xfile: xfile,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatingPostRoute';

  static const PageInfo<CreatingPostRouteArgs> page =
      PageInfo<CreatingPostRouteArgs>(name);
}

class CreatingPostRouteArgs {
  const CreatingPostRouteArgs({
    this.key,
    required this.xfile,
  });

  final Key? key;

  final XFile xfile;

  @override
  String toString() {
    return 'CreatingPostRouteArgs{key: $key, xfile: $xfile}';
  }
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    required String uid,
    List<PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            uid: uid,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<EditProfileRouteArgs> page =
      PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.uid,
  });

  final Key? key;

  final String uid;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    Key? key,
    required String uid,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            uid: uid,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<ProfileRouteArgs> page =
      PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.uid,
  });

  final Key? key;

  final String uid;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [SearchScreenPage]
class SearchScreenRoute extends PageRouteInfo<SearchScreenRouteArgs> {
  SearchScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SearchScreenRoute.name,
          args: SearchScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchScreenRoute';

  static const PageInfo<SearchScreenRouteArgs> page =
      PageInfo<SearchScreenRouteArgs>(name);
}

class SearchScreenRouteArgs {
  const SearchScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SearchScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<SignUpRouteArgs> page = PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
