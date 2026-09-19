import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography — Inter (body) & Outfit (headings)
/// Uses system fallback since Google Fonts aren't bundled yet.
/// Swap fontFamily strings to 'Outfit'/'Inter' once google_fonts is added.
abstract final class AppTextStyles {
  static const String _heading = 'Outfit';
  static const String _body = 'Inter';

  // ── Headings ───────────────────────────────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontFamily: _heading,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _heading,
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: _heading,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ── Body ───────────────────────────────────────────────────────────────────
  static const TextStyle bodyLg = TextStyle(
    fontFamily: _body,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: _body,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: _body,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.4,
  );

  // ── Labels / Buttons ───────────────────────────────────────────────────────
  static const TextStyle labelLg = TextStyle(
    fontFamily: _heading,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const TextStyle labelMd = TextStyle(
    fontFamily: _heading,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle labelSm = TextStyle(
    fontFamily: _body,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );

  // ── Links ──────────────────────────────────────────────────────────────────
  static const TextStyle link = TextStyle(
    fontFamily: _body,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primary,
  );
}
