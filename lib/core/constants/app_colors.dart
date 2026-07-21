import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryDark = Color(0xFF4338CA);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primarySoft = Color(0xFFEEF2FF);

  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF4F46E5),
    Color(0xFF4338CA),
  ];

  // Surfaces
  static const Color background = Color(0xFFF7F8FC);
  static const Color backgroundDark = Color(0xFF0F1120);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1C2E);
  static const Color surfaceMuted = Color(0xFFF1F2F8);
  static const Color surfaceMutedDark = Color(0xFF23253A);

  // Text
  static const Color textPrimary = Color(0xFF14162B);
  static const Color textPrimaryDark = Color(0xFFF3F4FA);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textSecondaryDark = Color(0xFF9CA3C0);
  static const Color textMuted = Color(0xFFA1A5B7);

  // Semantic
  static const Color success = Color(0xFF16A34A);
  static const Color successSoft = Color(0xFFDCFCE7);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerSoft = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSoft = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF0EA5E9);
  static const Color infoSoft = Color(0xFFE0F2FE);

  static const Color border = Color(0xFFE7E8F2);
  static const Color borderDark = Color(0xFF2C2F45);

  // Category accent colors
  static const Color catFood = Color(0xFFF59E0B);
  static const Color catTransport = Color(0xFF0EA5E9);
  static const Color catShopping = Color(0xFFEC4899);
  static const Color catHealth = Color(0xFF22C55E);
  static const Color catEntertainment = Color(0xFF8B5CF6);
  static const Color catBills = Color(0xFF14B8A6);
  static const Color catOther = Color(0xFF64748B);

  static Color shadow = Colors.black.withValues(alpha: 0.06);
}
