import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/featutres/todo/presentation/views/onboarding_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wallet App Workshop',
      theme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
      home: OnboardingView(),
    );
  }
}
