import 'package:flutter/material.dart';
import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/resources/app_colors.dart';
import 'package:tech_task/resources/app_decorations.dart';
import 'package:tech_task/resources/app_fonts.dart';
import 'package:tech_task/utils/string_extensions.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final title = post.title.capitalizeFirst();
    final body = post.body.capitalizeFirst();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 8.0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: const Text(
          'Post Details',
          style: TextStyle(
            color: AppColors.black,
            fontFamily: AppFonts.fontFamily,
            fontWeight: AppFonts.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              decoration: AppDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      _InfoChip(
                        label: 'User ID',
                        value: post.userId.toString(),
                      ),
                      _InfoChip(label: 'Post ID', value: post.id.toString()),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: AppFonts.bold,
                      fontSize: 22.0,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18.0),
              decoration: AppDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      color: AppColors.black.withValues(alpha: 0.65),
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: AppFonts.regular,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    body,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: AppFonts.regular,
                      fontSize: 16.0,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            color: AppColors.black.withValues(alpha: 0.55),
            fontFamily: AppFonts.fontFamily,
            fontWeight: AppFonts.regular,
            fontSize: 13.0,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                color: AppColors.black,
                fontFamily: AppFonts.fontFamily,
                fontWeight: AppFonts.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
