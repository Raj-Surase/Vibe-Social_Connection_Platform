import 'package:go_router/go_router.dart';
import 'package:vibe/Pages/friendspage.dart';
import 'package:vibe/Pages/home.dart';
import 'package:vibe/Pages/navigation.dart';
import 'package:vibe/Pages/notifications.dart';
import 'package:vibe/Pages/profilepage.dart';
import 'package:vibe/Screens/authenticate/login.dart';
import 'package:vibe/Screens/authenticate/register.dart';
import 'package:vibe/Screens/createsession.dart';

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
      path: '/navigator',
      builder: (context, state) => NavigatorPage(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: 'friends',
          builder: (context, state) => FriendsPage(),
        ),
        GoRoute(
          path: 'notifications',
          builder: (context, state) => NotificationPage(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => ProfilePage(),
        ),
        GoRoute(
          path: 'create_session',
          builder: (context, state) => SessionCreate(),
        ),
      ],
    ),
  ],
);
