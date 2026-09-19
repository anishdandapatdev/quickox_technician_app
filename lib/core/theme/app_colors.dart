import 'package:flutter/material.dart';

/// Central color palette — mirrors the web design-system.md
abstract final class AppColors {
  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB); // Royal Blue
  static const Color primaryDark = Color(0xFF1D4ED8); // Pressed / hover
  static const Color secondary = Color(0xFF4F46E5); // Indigo
  static const Color tertiary = Color(0xFF0D9488); // Teal
  static const Color logoOrange = Color(0xFFE87722); // Quickox logo orange

  // ── Backgrounds ────────────────────────────────────────────────────────────
  static const Color bgPrimary = Color(0xFFFFFFFF);
  static const Color bgSecondary = Color(0xFFF8FAFC);
  static const Color bgTertiary = Color(0xFFF1F5F9);
  static const Color bgDark = Color(0xFF0F172A);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textLight = Color(0xFFF8FAFC);

  // ── Borders ────────────────────────────────────────────────────────────────
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderFocus = Color(0xFF3B82F6);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF38BDF8);

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient logoGradient = LinearGradient(
    colors: [logoOrange, Color(0xFFF5A623)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
