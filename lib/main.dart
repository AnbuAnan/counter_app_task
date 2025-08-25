import 'package:counter_app/view_models/auth/auth_view_model.dart';
import 'package:counter_app/views/home_view.dart';
import 'package:counter_app/views/login_view.dart';
import 'package:counter_app/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) {

          return authState.user == null ? const SignupView() : HomeView();
        },
        LoginView.routeName: (_) => const LoginView(),
        SignupView.routeName: (_) => const SignupView(),
        HomeView.routeName: (_) => const HomeView(),
      },
    );
  }
}
