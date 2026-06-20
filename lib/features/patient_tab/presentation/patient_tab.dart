import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_cubit.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_states.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_list.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_welcome_header.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_row_labels.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/search_text_field.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/total_patients.dart';
import 'package:easy_localization/easy_localization.dart';
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
            //! Header
            PatientWelcomeHeader(),
            SizedBox(height: 28.h),
            //! ======
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Directory Card Controls
                    Row(
                      children: [
                        Text(
                          'patient_directory'.tr(),
                          style: AppTextStyles.s20bold.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        BlocBuilder<PatientCubit, PatientState>(
                          builder: (context, state) {
                            if (state is PatientSuccess) {
                              return TotalPatients(
                                patients: state.patients.length,
                              );
                            }
                            return TotalPatients(patients: 0);
                          },
                        ),
                        const Spacer(),
                        // Search Box
                        Container(
                          width: 500.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: ColorManager.lightGray.withValues(
                              alpha: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ColorManager.lightGray),
                          ),
                          child: SearchTextField(
                            onChanged: (p0) {
                              context.read<PatientCubit>().getPatients();
                              //! search
                            },
                            searchController: _searchController,
                          ),
                        ),

                        // Download button
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Table Headers
                    PatientMainRowLabels(),
                    SizedBox(height: 12.h),
                    //! Patients
                    Expanded(
                      child: BlocBuilder<PatientCubit, PatientState>(
                        builder: (context, state) {
                          if (state is PatientError) {
                            return Text(
                              state.message,
                              style: AppTextStyles.s20bold.copyWith(
                                color: ColorManager.black,
                              ),
                            );
                          } else if (state is PatientLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is PatientSuccess &&
                              state.patients.isEmpty) {
                            return PatientList(filteredPatients: []);
                          } else if (state is PatientSuccess) {
                            return PatientList(
                              filteredPatients: state.patients,
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    //! Pagination Control Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<PatientCubit, PatientState>(
                          builder: (context, state) {
                            final count = state is PatientSuccess
                                ? state.patients.length
                                : 0;
                            final rangeText = count == 0 ? '0' : '1-$count';
                            return Text(
                              'showing_patients'.tr(
                                args: [rangeText, '$count'],
                              ),
                              style: AppTextStyles.s14bold.copyWith(
                                fontSize: 12.sp,
                                color: ColorManager.kGray500,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              color: ColorManager.kGray500,
                              onPressed: () {}, // Disabled in mock pagination
                            ),
                            //! pagaintio , numberss (1..100)
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! Directory Card Controls
                          Row(
                            children: [
                              Text(
                                "Patient Directory",
                                style: AppTextStyles.s20bold.copyWith(
                                  color: ColorManager.black,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              TotalPatients(patients: patients),
                              const Spacer(),
                              // Search Box
                              Container(
                                width: 500.w,
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
                                child: SearchTextField(
                                  onChanged: (p0) {
                                    context.read<PatientCubit>().getPatients();
                                    //! search
                                  },
                                  searchController: _searchController,
                                ),
                              ),

                              // Download button
                            ],
                          ),
                          SizedBox(height: 20.h),
                          // Table Headers
                          const PatientMainRowLabels(),
                          SizedBox(height: 12.h),
                          //! Patients
                          Expanded(
                            child: patients.isEmpty
                                ? Center(
                                    child: Text(
                                      'no_patients_found'.tr(),
                                      style: AppTextStyles.s16bold.copyWith(
                                        color: ColorManager.kGray500,
                                      ),
                                    ),
                                  )
                                : PatientList(filteredPatients: patients),
                          ),
                          SizedBox(height: 16.h),
                          //! Pagination Control Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Showing 1-${patients.length} of ${patients.length} patients",
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
                                        () {}, // Disabled in mock pagination
                                  ),
                                  //! pagaintio , numberss (1..100)
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
                  

*/
