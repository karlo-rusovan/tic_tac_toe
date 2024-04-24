import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/authentication_cubit.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context,state) {
        if (state.userId != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      }
    );
  }
}
