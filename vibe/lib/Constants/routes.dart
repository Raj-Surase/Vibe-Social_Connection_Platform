import 'package:go_router/go_router.dart';
import 'package:vibe/Pages/friendspage.dart';
import 'package:vibe/Pages/home.dart';
import 'package:vibe/Pages/navigation.dart';
import 'package:vibe/Pages/notifications.dart';
import 'package:vibe/Pages/profilepage.dart';
import 'package:vibe/Screens/authenticate/authenticate.dart';
import 'package:vibe/Screens/authenticate/login.dart';
import 'package:vibe/Screens/authenticate/register.dart';
import 'package:vibe/Screens/authenticate/resetpass.dart';
import 'package:vibe/Screens/createsession.dart';
import 'package:vibe/Screens/userchat.dart';
import 'package:vibe/wrapper.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Wrapper(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const Authenticate(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/resetpass',
      builder: (context, state) => ResetPassword(),
    ),
    GoRoute(
      path: '/create_session',
      builder: (context, state) => const SessionCreate(),
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
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/navigator/friends',
          builder: (context, state) => const FriendsPage(),
        ),
        GoRoute(
          path: '/navigator/notifications',
          builder: (context, state) => const NotificationPage(),
        ),
        GoRoute(
          path: '/navigator/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);
