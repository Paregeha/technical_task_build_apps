import 'package:flutter/material.dart';
import 'package:tech_task/resources/app_colors.dart';
import 'package:tech_task/resources/app_decorations.dart';
import 'package:tech_task/resources/app_fonts.dart';

class ActiveUsersChip extends StatelessWidget {
  const ActiveUsersChip({super.key, required this.selectedUserIds});

  final List<int> selectedUserIds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: AppDecorations.chip(),
          child: Text(
            'Users: ${selectedUserIds.join(', ')}',
            style: const TextStyle(
              fontFamily: AppFonts.fontFamily,
              fontWeight: AppFonts.regular,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
