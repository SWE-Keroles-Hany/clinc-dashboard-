import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_cubit.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_states.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_welcome_header.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_row_labels.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_row_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class PatientTab extends StatefulWidget {
  const PatientTab({super.key});

  @override
  State<PatientTab> createState() => _PatientTabState();
}

class _PatientTabState extends State<PatientTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PatientCubit>().getPatients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroud,
      body: Container(
        padding: EdgeInsets.fromLTRB(32.r, 32.r, 32.r, 24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PatientWelcomeHeader(),
            SizedBox(height: 28.h),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: BlocConsumer<PatientCubit, PatientState>(
                  listener: (context, state) {
                    if (state is PatientError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final patients = state.patients ?? [];
                    final filteredPatients = state.filteredPatients ?? [];
                    final isLoading = state is PatientLoading;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Directory Card Controls
                        Row(
                          children: [
                            Text(
                              "Patient Directory",
                              style: AppTextStyles.s20bold.copyWith(
                                color: ColorManager.black,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.lightGray,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                "${patients.length} TOTAL",
                                style: AppTextStyles.s14bold.copyWith(
                                  fontSize: 11.sp,
                                  color: ColorManager.kGray500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Search Box
                            Container(
                              width: 320.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: ColorManager.lightGray.withValues(
                                  alpha: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: ColorManager.lightGray,
                                ),
                              ),
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  context.read<PatientCubit>().searchPatients(
                                    value,
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      "Search patients by name, ID or phone...",
                                  hintStyle: AppTextStyles.s14bold.copyWith(
                                    color: ColorManager.kGray500,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: ColorManager.kGray500,
                                    size: 18.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                  ),
                                ),
                              ),
                            ),
                            // Download button
                            
                          ],
                        ),
                        SizedBox(height: 20.h),
                        // Table Headers
                        const PatientRowLabels(),
                        SizedBox(height: 12.h),
                        // Directory Rows
                        Expanded(
                          child: isLoading && patients.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : filteredPatients.isEmpty
                              ? Center(
                                  child: Text(
                                    "No patients found",
                                    style: AppTextStyles.s16bold.copyWith(
                                      color: ColorManager.kGray500,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: filteredPatients.length,
                                  separatorBuilder: (context, _) =>
                                      SizedBox(height: 10.h),
                                  itemBuilder: (context, index) {
                                    final patient = filteredPatients[index];
                                    return PatientRowInfo(
                                      patient: patient,
                                      onViewPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Viewing profile of ${patient.fullName}",
                                            ),
                                          ),
                                        );
                                      },
                                      onEditPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Editing ${patient.fullName}'s information",
                                            ),
                                          ),
                                        );
                                      },
                                      onHistoryPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Viewing medical history of ${patient.fullName}",
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                        SizedBox(height: 16.h),
                        // Pagination Control Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Showing 1-${filteredPatients.length} of ${filteredPatients.length} patients",
                              style: AppTextStyles.s14bold.copyWith(
                                fontSize: 12.sp,
                                color: ColorManager.kGray500,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  color: ColorManager.kGray500,
                                  onPressed:
                                      null, // Disabled in mock pagination
                                ),
                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    "1",
                                    style: AppTextStyles.s14bold.copyWith(
                                      color: ColorManager.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                _buildPageButton("2"),
                                SizedBox(width: 4.w),
                                _buildPageButton("3"),
                                SizedBox(width: 4.w),
                                Text(
                                  "...",
                                  style: AppTextStyles.s14bold.copyWith(
                                    color: ColorManager.kGray500,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                _buildPageButton("85"),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right),
                                  color: ColorManager.kGray500,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageButton(String pageNum) {
    return Container(
      width: 32.w,
      height: 32.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        pageNum,
        style: AppTextStyles.s14bold.copyWith(
          color: ColorManager.kGray500,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
