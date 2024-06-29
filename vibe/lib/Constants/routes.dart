import 'package:go_router/go_router.dart';
import 'package:vibe/Screens/userchat.dart';
import 'package:vibe/components/session_activity.dart';
import 'package:vibe/screens/authenticate/authentication.dart';
import 'package:vibe/screens/authenticate/screens/login/login.dart';
import 'package:vibe/screens/authenticate/screens/profileinit/profile_init.dart';
import 'package:vibe/screens/authenticate/screens/register/register.dart';
import 'package:vibe/screens/authenticate/screens/resetpass/reset_pass.dart';
import 'package:vibe/screens/home/navigation.dart';
import 'package:vibe/screens/session/create_session/create_session.dart';
import 'package:vibe/screens/session/player_queue/player_queue.dart';
import 'package:vibe/screens/session/session_player/session_player.dart';
import 'package:vibe/wrapper.dart';

class AppRoutes {
  AppRoutes._();

  static const String INITIALROUTE = "/";
  static const String AUTHROUTE = "/auth";
  static const String LOGINROUTE = "/login";
  static const String REGISTERROUTE = "/register";
  static const String RESETROUTE = "/resetpass";
  static const String PROFILEINITROUTE = "/profileinit";
  static const String CREATESESSIONROUTE = "/create_session";
  static const String QUEUEROUTE = "/queue";
  static const String USERCHATROUTE = "/userchat";
  static const String SESSIONPLAYERROUTE = "/sessionplayer";
  static const String HOMEROUTE = "/home";
  static const String FRIENDSROUTE = "/friends";
  static const String NOTIFICATIONROUTE = "/notification";
  static const String PROFILEROUTE = "/profile";

  static final GoRouter router = GoRouter(
    initialLocation: INITIALROUTE,
    routes: [
      GoRoute(
        path: INITIALROUTE,
        builder: (context, state) => Wrapper(),
      ),
      GoRoute(
        path: AUTHROUTE,
        builder: (context, state) => const AuthenticationPage(),
      ),
      GoRoute(
        path: LOGINROUTE,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: REGISTERROUTE,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RESETROUTE,
        builder: (context, state) => ResetPassword(),
      ),
      GoRoute(
        path: PROFILEINITROUTE,
        builder: (context, state) => const ProfileInit(),
      ),
      GoRoute(
        path: CREATESESSIONROUTE,
        builder: (context, state) => const SessionCreate(),
      ),
      GoRoute(
        path: QUEUEROUTE,
        builder: (context, state) => QueueListView(),
      ),
      GoRoute(
          path: USERCHATROUTE,
          builder: (context, state) {
            return UserChat();
          }),
      GoRoute(
          path: SESSIONPLAYERROUTE,
          builder: (context, state) {
            return SessionPlayer();
          }),
      GoRoute(
        path: HOMEROUTE,
        builder: (context, state) => const NavigatorPage(initialIndex: 0),
      ),
      GoRoute(
        path: FRIENDSROUTE,
        builder: (context, state) => const NavigatorPage(initialIndex: 1),
      ),
      GoRoute(
        path: NOTIFICATIONROUTE,
        builder: (context, state) => const NavigatorPage(initialIndex: 2),
      ),
      GoRoute(
        path: PROFILEROUTE,
        builder: (context, state) => const NavigatorPage(initialIndex: 3),
      ),
    ],
  );
}
