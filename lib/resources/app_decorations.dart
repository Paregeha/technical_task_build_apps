import 'package:flutter/material.dart';
import 'package:tech_task/resources/app_colors.dart';

class AppDecorations {
  static BoxDecoration card({double radius = 20.0}) {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: const [
        BoxShadow(
          color: AppColors.shadowPrimary,
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    );
  }

  static BoxDecoration chip({double radius = 999.0}) {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: const [
        BoxShadow(
          color: AppColors.shadowSecondary,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration filterChip({required bool isSelected}) {
    return BoxDecoration(
      color: isSelected ? AppColors.black : AppColors.chipBackground,
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(
        color: isSelected
            ? AppColors.black
            : AppColors.black.withValues(alpha: 0.06),
      ),
    );
  }

  static const BoxDecoration topFade = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.background, AppColors.transparentBackground],
    ),
  );
}
