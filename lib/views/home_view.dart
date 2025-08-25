import 'package:counter_app/view_models/auth/auth_view_model.dart';
import 'package:counter_app/view_models/counter/counter_view_model.dart';
import 'package:counter_app/views/login_view.dart';
import 'package:counter_app/widgets/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  static const routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.read(authProvider).user;
    final authAction = ref.read(authProvider.notifier);
    final counterState = ref.watch(counterViewModelProvider);
    final counterAction = ref.read(counterViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(radius: 28, child: Icon(Icons.person)),
              SizedBox(height: 8),
              Text(
                userState!.email ?? 'Guest',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  await authAction.logout();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginView.routeName,
                      (_) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter value : ${counterState.value}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            CounterButton(
              text: 'Increment',
              icon: Icons.add,
              onPressed: counterAction.increment,
            ),
            SizedBox(height: 10),
            CounterButton(
              text: 'Decrement',
              icon: Icons.remove,
              onPressed: counterAction.decrement,
            ),
            SizedBox(height: 10),
            CounterButton(
              text: 'Reset',
              icon: Icons.refresh,
              onPressed: counterAction.reset,
            ),
          ],
        ),
      ),
    );
  }
}
