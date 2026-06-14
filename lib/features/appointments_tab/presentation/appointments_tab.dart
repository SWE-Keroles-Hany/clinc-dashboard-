import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/dashboard/domain/entities/appointment_entity.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  // Sample data for preview; replace with real data source when wiring
  List<AppointmentEntity> get _sampleAppointments => const [
    AppointmentEntity(
      appointmentId: 1,
      patientName: 'John Doe',
      appointmentDate: '2026-06-14T09:30:00',
      status: 'Pending',
    ),
    AppointmentEntity(
      appointmentId: 2,
      patientName: 'Mary Smith',
      appointmentDate: '2026-06-14T10:15:00',
      status: 'Completed',
    ),
    AppointmentEntity(
      appointmentId: 3,
      patientName: 'Ahmed Ali',
      appointmentDate: '2026-06-14T11:00:00',
      status: 'Cancelled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appointments = _sampleAppointments;

    return Container(
      color: ColorManager.backgroud,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header area (not an app bar)
          Text('Appointments', style: AppTextStyles.s30bold),
          const SizedBox(height: 8),
          Text(
            'Manage upcoming and past appointments',
            style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
          ),
          const SizedBox(height: 16),

          // Filters row (flow dashboard style)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('Pending'),
                _buildFilterChip('Confirmed'),
                _buildFilterChip('Completed'),
                _buildFilterChip('Cancelled'),
                // Spacer(),
                // Text("data"),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Appointment list
          Expanded(
            child: appointments.isEmpty
                ? Center(
                    child: Text(
                      'No appointments found',
                      style: AppTextStyles.s16bold,
                    ),
                  )
                : ListView.separated(
                    itemCount: appointments.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final appt = appointments[index];
                      return AppointmentCard(appointment: appt);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, [bool selected = false]) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: AppTextStyles.s14bold.copyWith(
            color: selected ? ColorManager.white : ColorManager.kGray500,
          ),
        ),
        selected: selected,
        selectedColor: ColorManager.primary,
        backgroundColor: ColorManager.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
