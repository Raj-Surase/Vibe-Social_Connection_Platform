import 'package:go_router/go_router.dart';
import 'package:vibe/Screens/authenticate/screens/login.dart';
import 'package:vibe/Screens/authenticate/screens/profileinit.dart';
import 'package:vibe/Screens/authenticate/screens/register.dart';
import 'package:vibe/Screens/authenticate/screens/resetpass.dart';
import 'package:vibe/Screens/home/navigation.dart';
import 'package:vibe/Screens/session/createsession.dart';
import 'package:vibe/components/queue_listview.dart';
import 'package:vibe/Screens/authenticate/authentication.dart';
import 'package:vibe/Screens/userchat.dart';
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
  static const String SESSIONACTIVITYROUTE = "/sessionactivity";
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
            final String title = state.extra as String;
            return UserChat(title: title);
          }),
      GoRoute(
          path: SESSIONACTIVITYROUTE,
          builder: (context, state) {
            final String title = state.extra as String;
            return UserChat(title: title);
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
