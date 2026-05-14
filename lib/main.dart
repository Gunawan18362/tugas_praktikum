import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false,
        title: 'PBM 2026',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed:
              Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}