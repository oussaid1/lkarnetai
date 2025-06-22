import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String? email;
        String? username;

        if (state is Authenticated) {
          email = state.user.email;
          username = state.user.displayName ?? state.user.email?.split('@').first;
        }

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (email != null) ...[
                Text('Username: ${username ?? "-"}'),
                Text('Email: $email'),
                const SizedBox(height: 24),
              ],
              ElevatedButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }
}
