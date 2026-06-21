import 'package:cached_network_image/cached_network_image.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PatientScreenHeader extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final String phoneNumber;

  const PatientScreenHeader({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: CachedNetworkImage(
              imageUrl: 'https://via.placeholder.com/100',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppTextStyles.heading1),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildDemographic(Icons.cake_outlined, '$age years old'),
                const SizedBox(width: 24),
                _buildDemographic(Icons.female, gender),
                const SizedBox(width: 24),
                _buildDemographic(Icons.phone_outlined, phoneNumber),
                const SizedBox(width: 24),
                _buildDemographic(Icons.lock_clock, "12:00 PM"),
                const SizedBox(width: 24),
                _buildDemographic(Icons.height, "120cm"),
                const SizedBox(width: 24),
                _buildDemographic(Icons.fastfood, "120 KG"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDemographic(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 25, color: ColorManager.primaryBlue),
        const SizedBox(width: 8),
        Text(text, style: AppTextStyles.subtitleText),
      ],
    );
  }
}
