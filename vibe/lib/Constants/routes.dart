import 'package:go_router/go_router.dart';
import 'package:vibe/Pages/friendspage.dart';
import 'package:vibe/Pages/home.dart';
import 'package:vibe/Pages/navigation.dart';
import 'package:vibe/Pages/notifications.dart';
import 'package:vibe/Pages/profilepage.dart';
import 'package:vibe/Screens/authenticate/login.dart';
import 'package:vibe/Screens/authenticate/register.dart';
import 'package:vibe/Screens/createsession.dart';
import 'package:vibe/Screens/userchat.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/create_session',
      builder: (context, state) => SessionCreate(),
    ),
    GoRoute(
        path: '/userchat',
        builder: (context, state) {
          final String title = state.extra as String;
          return UserChat(title: title);
        }),
    GoRoute(
        path: '/sessionactivity',
        builder: (context, state) {
          final String title = state.extra as String;
          return UserChat(title: title);
        }),
    ShellRoute(
      builder: (context, state, child) {
        return NavigatorPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/navigator/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/navigator/friends',
          builder: (context, state) => FriendsPage(),
        ),
        GoRoute(
          path: '/navigator/notifications',
          builder: (context, state) => NotificationPage(),
        ),
        GoRoute(
          path: '/navigator/profile',
          builder: (context, state) => ProfilePage(),
        ),
      ],
    ),
  ],
);
