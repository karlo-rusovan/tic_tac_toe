import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
    final bool success;
    final bool emailInUse;
    final bool loginError;
    final bool registerError;
    final bool credentialError;
    final int? userId;
    final String token;
    final String username;

    const AuthResponse({
      this.success = false,
      this.emailInUse = false,
      this.loginError = false,
      this.registerError = false,
      this.credentialError = false,
      this.userId,
      this.username = "",
      this.token = ""
    });

    @override
    List<Object?> get props => [success, emailInUse, loginError, registerError, credentialError, userId, token, username];
} 