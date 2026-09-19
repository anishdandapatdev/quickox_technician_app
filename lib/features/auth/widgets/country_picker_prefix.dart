import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/country_code.dart';

/// Reusable Country Picker Selector widget with bottom sheet modal
class CountryPickerPrefix extends StatelessWidget {
  const CountryPickerPrefix({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final CountryCode selected;
  final ValueChanged<CountryCode> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final chosen = await showModalBottomSheet<CountryCode>(
          context: context,
          backgroundColor: AppColors.bgPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
          ),
          builder: (ctx) => _CountryPickerSheet(
            countries: CountryCode.supportedCountries,
            selected: selected,
          ),
        );
        if (chosen != null) onChanged(chosen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selected.flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 4),
            Text(
              selected.code,
              style: AppTextStyles.labelMd.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: 4),
            Container(
              width: 1,
              height: 20,
              color: AppColors.border,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatelessWidget {
  const _CountryPickerSheet({
    required this.countries,
    required this.selected,
  });

  final List<CountryCode> countries;
  final CountryCode selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('Select Country', style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border),
          ...countries.map(
            (c) => ListTile(
              leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
              title: Text(
                '${c.name} (${c.iso})',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                c.code,
                style: AppTextStyles.bodySm.copyWith(color: AppColors.textMuted),
              ),
              trailing: c == selected
                  ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                  : null,
              onTap: () => Navigator.pop(context, c),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
