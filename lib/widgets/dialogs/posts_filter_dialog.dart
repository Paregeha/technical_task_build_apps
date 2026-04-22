import 'package:flutter/material.dart';
import 'package:tech_task/resources/app_colors.dart';
import 'package:tech_task/resources/app_decorations.dart';
import 'package:tech_task/resources/app_fonts.dart';

class PostsFilterDialog extends StatefulWidget {
  const PostsFilterDialog({
    super.key,
    required this.userIds,
    required this.initialSelectedIds,
  });

  final List<int> userIds;
  final List<int> initialSelectedIds;

  @override
  State<PostsFilterDialog> createState() => _PostsFilterDialogState();
}

class _PostsFilterDialogState extends State<PostsFilterDialog> {
  late final List<int> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List<int>.from(widget.initialSelectedIds);
  }

  void _toggleUser(int userId) {
    setState(() {
      if (_selectedIds.contains(userId)) {
        _selectedIds.remove(userId);
      } else {
        _selectedIds.add(userId);
      }
    });
  }

  void _reset() {
    Navigator.pop(context, <int>[]);
  }

  void _apply() {
    _selectedIds.sort();
    Navigator.pop(context, _selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.tune_rounded, color: AppColors.black, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Filter by users',
                  style: TextStyle(
                    fontFamily: AppFonts.fontFamily,
                    fontWeight: AppFonts.bold,
                    fontSize: 18.0,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Choose one or more users',
              style: TextStyle(
                fontFamily: AppFonts.fontFamily,
                fontWeight: AppFonts.regular,
                fontSize: 13.0,
                color: AppColors.black.withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(height: 18.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: widget.userIds.map((userId) {
                final isSelected = _selectedIds.contains(userId);

                return InkWell(
                  borderRadius: BorderRadius.circular(999.0),
                  onTap: () => _toggleUser(userId),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    decoration: AppDecorations.filterChip(
                      isSelected: isSelected,
                    ),
                    child: Text(
                      'User $userId',
                      style: TextStyle(
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: AppFonts.regular,
                        fontSize: 14.0,
                        color: isSelected ? AppColors.white : AppColors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _reset,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: AppFonts.bold,
                        color: AppColors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _apply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        fontFamily: AppFonts.fontFamily,
                        fontWeight: AppFonts.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
