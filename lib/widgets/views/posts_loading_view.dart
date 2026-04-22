import 'package:flutter/material.dart';
import 'package:tech_task/resources/app_colors.dart';
import 'package:tech_task/resources/app_decorations.dart';
import 'package:tech_task/resources/app_fonts.dart';

class PostsLoadingView extends StatelessWidget {
  const PostsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          decoration: AppDecorations.card(radius: 24.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 42.0,
                height: 42.0,
                child: CircularProgressIndicator(
                  color: AppColors.black,
                  strokeWidth: 3.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Loading...',
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: AppFonts.regular,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
