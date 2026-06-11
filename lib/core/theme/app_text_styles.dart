import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle get s20bold => const TextStyle(
    color: ColorManager.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get s17bold => const TextStyle(
    color: ColorManager.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get s16bold => const TextStyle(
    color: ColorManager.teal,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get s15semibold => const TextStyle(
    color: ColorManager.teal,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get s14medium => const TextStyle(
    color: ColorManager.teal,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get s14regular => const TextStyle(
    color: ColorManager.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static TextStyle get s13medium => const TextStyle(
    color: ColorManager.teal,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get s13regular => const TextStyle(
    color: ColorManager.textSecondary,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get s15bold => const TextStyle(
    color: ColorManager.textOnTeal,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.3,
  );

  static TextStyle get s10medium => const TextStyle(
    color: ColorManager.textSecondary,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
  );

  // ── Profile screen additions ──────────────────────────────────────

  static TextStyle get s22bold => const TextStyle(
    color: ColorManager.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get s18bold => const TextStyle(
    color: ColorManager.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get s18boldTeal => const TextStyle(
    color: ColorManager.teal,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get s16medium => const TextStyle(
    color: ColorManager.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get s15regular => const TextStyle(
    color: ColorManager.white,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get s13teal => const TextStyle(
    color: ColorManager.teal,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get s9capsLabel => const TextStyle(
    color: ColorManager.textSecondary,
    fontSize: 9,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static TextStyle get s16logoutRed => const TextStyle(
    color: ColorManager.logoutText,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // ── State-dependent styles ────────────────────────────────────────

  static TextStyle s12medium({required bool selected}) => TextStyle(
    color: selected ? ColorManager.teal : ColorManager.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle s13semibold({required bool selected}) => TextStyle(
    color: selected ? ColorManager.textOnTeal : ColorManager.textSecondary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  // ── Booking screen additions ──────────────────────────────────────

  /// App bar title — "Book Appointment"
  static TextStyle get bookingAppBarTitle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorManager.bookingTextPrimary,
    letterSpacing: 0.2,
  );

  /// Section header — "Nearby Specialists"
  static TextStyle get bookingSectionTitle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ColorManager.bookingTextPrimary,
    letterSpacing: 0.1,
  );

  /// "See all" link
  static TextStyle get bookingSeeAll => const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ColorManager.bookingPrimary,
  );

  /// Doctor name inside card
  static TextStyle get bookingDoctorName => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: ColorManager.bookingTextPrimary,
    letterSpacing: 0.1,
  );

  /// Specialty + experience line
  static TextStyle get bookingDoctorSpecialty => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorManager.bookingIconDefault,
  );

  /// Price per session
  static TextStyle get bookingDoctorPrice => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: ColorManager.bookingPrimary,
  );

  /// Rating number (e.g. 4.9)
  static TextStyle get bookingRatingValue => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ColorManager.bookingTextPrimary,
  );

  /// Review count (e.g. "(120 reviews)")
  static TextStyle get bookingRatingCount => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorManager.bookingIconDefault,
  );

  /// "TOP RATED" badge text
  static TextStyle get bookingTopRatedBadge => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: ColorManager.topRatedBadgeText,
    letterSpacing: 0.5,
  );

  /// Selected filter chip label
  static TextStyle get bookingChipSelected => const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: ColorManager.chipSelectedText,
  );

  /// Unselected filter chip label
  static TextStyle get bookingChipUnselected => const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ColorManager.chipUnselectedText,
  );

  /// Search bar hint
  static TextStyle get bookingSearchHint => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorManager.bookingIconDefault,
  );

  /// Search bar input text
  static TextStyle get bookingSearchInput => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorManager.bookingTextPrimary,
  );

  /// "Available Today" toggle title
  static TextStyle get bookingToggleTitle => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorManager.bookingTextPrimary,
  );

  /// "Show doctors with immediate slots" subtitle
  static TextStyle get bookingToggleSubtitle => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorManager.bookingIconDefault,
  );

  /// "Book Now" primary button label
  static TextStyle get bookingButtonPrimary => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: ColorManager.bookingTextOnPrimary,
    letterSpacing: 0.3,
  );

  /// "Chat" secondary button label
  static TextStyle get bookingButtonSecondary => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorManager.bookingTextPrimary,
  );

  /// Bottom nav active label
  static TextStyle get bookingBottomNavActive => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: ColorManager.bookingBottomNavActive,
  );

  /// Bottom nav inactive label
  static TextStyle get bookingBottomNavInactive => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorManager.bookingBottomNavInactive,
  );
}
