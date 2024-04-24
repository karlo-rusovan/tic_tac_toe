import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/authentication_cubit.dart';
import '../widgets/login_widgets.dart';
import '../../Utilities/utils.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {         
              if (state.error != null) {            
                Navigator.of(context).pop(true);
                Utils.showSnackBar(text: state.error?.message(context), context: context);
              }
              if (state.loading == true) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state.registrationSuccess) {                
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
                child: Center(
                  child: Column(children: [
                    const SizedBox(height: 200),
                    Text(AppLocalizations.of(context)!.registerTitle, style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 30),
                    TextFieldWidget(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: AppLocalizations.of(context)!.emailLabel),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.done,
                      label: AppLocalizations.of(context)!.passwordLabel,
                      obscure: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.signUpButton),
                      onPressed: () {                        
                        context.read<AuthenticationCubit>().signUp(email: emailController.text, password: passwordController.text);
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                      },
                      child: Text(
                        AppLocalizations.of(context)!.logInPrompt, style: const TextStyle(color: Color.fromARGB(255, 155, 99, 177))                      
                      ),
                    ),
                  ]),
                ))));
  }
}
