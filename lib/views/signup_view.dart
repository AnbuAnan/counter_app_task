import 'package:counter_app/view_models/auth/auth_view_model.dart';
import 'package:counter_app/views/login_view.dart';
import 'package:counter_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  static const routeName = '/signup';
  const SignupView({super.key});

  @override
  SignupViewState createState() => SignupViewState();
}

class SignupViewState extends ConsumerState<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = false;

  final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*]).{8,}$',
  );

  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Email is Required';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(email)) return 'Please, Enter the valid E-mail Id';
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is Required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final authAction = ref.read(authProvider.notifier);
      final resultOfSignup = await authAction.signup(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (resultOfSignup && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.tealAccent,
            content: Text(
              'SignUp successful,please login.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacementNamed(LoginView.routeName);
        });
      } else {
        final err = ref.read(authProvider).error ?? 'Signup failed';
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                err,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.red),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SignUp Page',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
        
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsetsGeometry.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'User Email Id',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(14),
                        hintText: 'Enter the user email',
                        hintStyle: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w400,
                            ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      validator: _emailValidator,
                    ),
                    const SizedBox(height: 12),
        
                    RichText(
                      text: TextSpan(
                        text: 'Password',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_obscure,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(14),
                        hintText: 'Enter the password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
        
                        hintStyle: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w400,
                            ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      validator: _passwordValidator,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      label: 'Create Account',
                      loading: authState.loading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginView.routeName);
                        },
        
                        child: const Text('Already have an Account? Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
