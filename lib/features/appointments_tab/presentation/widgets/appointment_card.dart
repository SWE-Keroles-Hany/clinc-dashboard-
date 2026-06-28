import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentEntity appointment;
  final Function(int newStatus)? onStatusChanged;
  final bool isUpdating;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onStatusChanged,
    this.isUpdating = false,
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.appointment.status;
  }

  @override
  void didUpdateWidget(covariant AppointmentCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appointment.status != widget.appointment.status ||
        oldWidget.appointment.appointmentId !=
            widget.appointment.appointmentId) {
      _currentStatus = widget.appointment.status;
    }
  }

  static const List<String> _allStatuses = [
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  int _statusValue(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 1;
      case 'confirmed':
        return 2;
      case 'completed':
        return 3;
      case 'cancelled':
        return 4;
      default:
        return 1;
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return ColorManager.completed;
      case 'confirmed':
        return ColorManager.confirmed;
      case 'pending':
        return ColorManager.pending;
      case 'cancelled':
      case 'canceled':
        return ColorManager.error;
      default:
        return ColorManager.kGray500;
    }
  }

  Color _statusBg(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return ColorManager.completedBg;
      case 'confirmed':
        return ColorManager.confirmedBg;
      case 'pending':
        return ColorManager.pendingBg;
      case 'cancelled':
      case 'canceled':
        return ColorManager.errordBg;
      default:
        return ColorManager.white;
    }
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'pending';
      case 'confirmed':
        return 'confirmed';
      case 'completed':
        return 'completed';
      case 'cancelled':
      case 'canceled':
        return 'cancelled';
      default:
        return status.toLowerCase();
    }
  }

  String _formatTime(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return DateFormat('EEE, dd MMM - hh:mm a').format(dt);
    } catch (_) {
      return iso;
    }
  }

  void _showStatusDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 300.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('change_status'.tr(), style: AppTextStyles.s20bold),
                const SizedBox(height: 16),
                ..._allStatuses.map(
                  (status) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.onStatusChanged?.call(_statusValue(status));
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _currentStatus == status
                                ? _statusBg(status)
                                : ColorManager.lightGray,
                            borderRadius: BorderRadius.circular(8),
                            border: _currentStatus == status
                                ? Border.all(
                                    color: _statusColor(status),
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _translateStatus(status).tr(),
                                style: AppTextStyles.s14bold.copyWith(
                                  color: _statusColor(status),
                                ),
                              ),
                              if (_currentStatus == status)
                                Icon(
                                  Icons.check_circle,
                                  color: _statusColor(status),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = _currentStatus;
    return Material(
      color: ColorManager.white,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            //! Leading avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: ColorManager.lightGray,
              child: Text(
                widget.appointment.patientName
                    .split(' ')
                    .map((e) => e.isEmpty ? '' : e[0])
                    .take(2)
                    .join(),
                style: AppTextStyles.s18bold.copyWith(
                  color: ColorManager.primary,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            //! Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.appointment.patientName,
                    style: AppTextStyles.s20bold,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTime(widget.appointment.appointmentDate),
                    style: AppTextStyles.s14bold.copyWith(
                      color: ColorManager.kGray500,
                    ),
                  ),
                ],
              ),
            ),

            //! Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _statusBg(status),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _translateStatus(status).tr(),
                style: AppTextStyles.s14bold.copyWith(
                  color: _statusColor(status),
                ),
              ),
            ),
            IconButton(
              onPressed: widget.isUpdating ? null : _showStatusDialog,
              icon: widget.isUpdating
                  ? SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.edit),
              color: ColorManager.primary,
            ),
          ],
        ),
      ),
    );
  }
}
