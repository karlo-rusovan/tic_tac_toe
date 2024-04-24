import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 81, 59, 121),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppLocalizations.of(context)!.userName}: ${userModel.userName}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${AppLocalizations.of(context)!.gameCount}: ${userModel.gameCount}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${AppLocalizations.of(context)!.winRate}: ${(userModel.winRate! * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}