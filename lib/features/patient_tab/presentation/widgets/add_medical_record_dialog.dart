import 'dart:io';

import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_cubit.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/cubit/patient_states.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/custom_text_field.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/dialog_footer.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/dialog_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicalRecordDialog extends StatefulWidget {
  final String patientId;

  const AddMedicalRecordDialog({super.key, required this.patientId});

  @override
  State<AddMedicalRecordDialog> createState() => _AddMedicalRecordDialogState();
}

class _AddMedicalRecordDialogState extends State<AddMedicalRecordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _diagnosisController = TextEditingController();
  final _treatmentPlanController = TextEditingController();
  File? _prescriptionsFile;
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickFile() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _prescriptionsFile = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<PatientCubit>().addMedicalRecord(
        patientId: widget.patientId,
        diagnosis: _diagnosisController.text,
        treatmentPlan: _treatmentPlanController.text,
        prescriptions: _prescriptionsFile,
      );
    }
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _treatmentPlanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is AddMedicalRecordLoading) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is AddMedicalRecordSuccess) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Medical record added successfully')),
          );
        } else if (state is AddMedicalRecordError) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 600,
          decoration: BoxDecoration(
            color: ColorManager.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogHeader(
                  title: 'Add New Medical Record',
                  onClose: () => Navigator.of(context).pop(),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'DIAGNOSIS',
                        hint: 'e.g. Hypertension',
                        controller: _diagnosisController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter diagnosis';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'TREATMENT PLAN',
                        hint: 'Medications, procedures, follow-ups...',
                        maxLines: 3,
                        controller: _treatmentPlanController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter treatment plan';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickFile,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            color: ColorManager.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ColorManager.border,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _prescriptionsFile != null
                                    ? Icons.check_circle_outline
                                    : Icons.cloud_upload_outlined,
                                color: ColorManager.primaryBlue,
                                size: 32,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _prescriptionsFile != null
                                    ? 'File selected: ${_prescriptionsFile!.path.split('/').last}'
                                    : 'Click to upload medical images or scans',
                                style: TextStyle(
                                  color: ColorManager.textDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              if (_prescriptionsFile == null)
                                const Text(
                                  'PNG, JPG, PDF up to 10MB',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      DialogFooter(
                        onCancel: () => Navigator.of(context).pop(),
                        onSave: _isLoading ? null : _submitForm,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
