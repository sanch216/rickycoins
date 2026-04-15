import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rickyshit/ui/cabinet_page.dart';
import 'package:rickyshit/ui/home_page.dart';
import 'package:rickyshit/ui/auth/login_page.dart';
import 'package:rickyshit/ui/auth/registration_page.dart';
import 'package:rickyshit/ui/info_page.dart';
import 'package:rickyshit/ui/market_page.dart';
import 'package:rickyshit/ui/offerta_page.dart';
import 'package:rickyshit/ui/payment_page.dart';
import 'package:rickyshit/components/pdf_viewer.dart';
import 'package:rickyshit/components/word_viewer.dart';

class AppNavigation {
  static const String home = '/';
  static const String market = '/market';
  static const String cabinet = '/cabinet';
  static const String dashboard = '/dashboard';
  static const String offerta = '/offerta';
  static const String payment = '/payment';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String pdfView = '/pdf_view';
  static const String wordView = '/word_view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final List<String> protectedRoutes = [market, cabinet, payment, pdfView];

    if (protectedRoutes.contains(settings.name) && !isLoggedIn) {
      return MaterialPageRoute(builder: (_) => LoginPage());
    }

    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registration:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case market:
        return MaterialPageRoute(builder: (_) => MarketPage());
      case cabinet:
        return MaterialPageRoute(builder: (_) => CabinetPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const InfoPage());
      case offerta:
        return MaterialPageRoute(builder: (_) => OffertaPage());
      case payment:
        return MaterialPageRoute(builder: (_) => PaymentPage());
      case pdfView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => PDFViewScreen(
                url: args['url'],
                title: args['title'],
                authorId: args['authorId'],
              ),
        );
      case wordView:
        final argsW = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => WordReadingPage(
                url: argsW['url'],
                title: argsW['title'],
                authorId: argsW['authorId'],
              ),
        );

      default:
        // Fallback to home if route is unknown
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}