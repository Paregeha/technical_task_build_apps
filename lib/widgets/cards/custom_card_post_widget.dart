import 'package:flutter/material.dart';
import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/resources/app_colors.dart';
import 'package:tech_task/resources/app_fonts.dart';
import 'package:tech_task/utils/string_extensions.dart';

class CustomCardPostWidget extends StatelessWidget {
  const CustomCardPostWidget({super.key, required this.post, this.onTap});

  final PostModel post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowPrimary,
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
            color: AppColors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title.capitalizeFirst(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: AppFonts.bold,
                        fontSize: 16.0,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      post.body.capitalizeFirst(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black.withValues(alpha: 0.6),
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: AppFonts.regular,
                        fontSize: 13.0,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.0,
                color: AppColors.black.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
