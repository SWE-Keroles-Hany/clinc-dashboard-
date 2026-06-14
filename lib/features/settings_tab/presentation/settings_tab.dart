import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isEditing = false;

  late final TextEditingController clinicNameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController websiteController;
  late final TextEditingController addressController;
  late final TextEditingController profileNameController;
  late final TextEditingController personalEmailController;

  @override
  void initState() {
    super.initState();
    clinicNameController = TextEditingController(
      text: 'MedCore General Hospital',
    );
    phoneController = TextEditingController(text: '+1 (555) 902-1000');
    emailController = TextEditingController(text: 'admin@medcore.hospital');
    websiteController = TextEditingController(text: 'https://medcore.hospital');
    addressController = TextEditingController(
      text: '1200 Healthcare Way, Medical District, San Francisco, CA 94103',
    );
    profileNameController = TextEditingController(text: 'Dr. Jonathan Smith');
    personalEmailController = TextEditingController(
      text: 'j.smith@medcore.hospital',
    );
  }

  @override
  void dispose() {
    clinicNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    addressController.dispose();
    profileNameController.dispose();
    personalEmailController.dispose();
    super.dispose();
  }

  Widget _label(String text) => Text(
    text,
    style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
  );

  InputDecoration _inputDecoration() => InputDecoration(
    filled: true,
    fillColor: ColorManager.lightGray,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Settings saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.backgroud,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Top row with title and save button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('System Settings', style: AppTextStyles.s30bold),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your clinic preferences and administrative details.',
                      style: AppTextStyles.s14bold.copyWith(
                        color: ColorManager.kGray500,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Main content two-column layout
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left main column
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Clinic Information card
                      Card(
                        color: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.apartment,
                                        color: ColorManager.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Clinic Information',
                                        style: AppTextStyles.s20bold,
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: _toggleEdit,
                                    child: Text(_isEditing ? 'Cancel' : 'Edit'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Grid of inputs
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Clinic Name'),
                                        const SizedBox(height: 6),
                                        TextFormField(
                                          controller: clinicNameController,
                                          readOnly: !_isEditing,
                                          decoration: _inputDecoration(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Phone Number'),
                                        const SizedBox(height: 6),
                                        TextFormField(
                                          controller: phoneController,
                                          readOnly: !_isEditing,
                                          decoration: _inputDecoration(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Email Address'),
                                        const SizedBox(height: 6),
                                        TextFormField(
                                          controller: emailController,
                                          readOnly: !_isEditing,
                                          decoration: _inputDecoration(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Official Website'),
                                        const SizedBox(height: 6),
                                        TextFormField(
                                          controller: websiteController,
                                          readOnly: !_isEditing,
                                          decoration: _inputDecoration(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _label('Clinic Address'),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: addressController,
                                readOnly: !_isEditing,
                                maxLines: 3,
                                decoration: _inputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Account Settings card
                      Card(
                        color: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: ColorManager.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Account Settings',
                                    style: AppTextStyles.s20bold,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Profile Name'),
                                        const SizedBox(height: 6),
                                        TextFormField(
                                          controller: profileNameController,
                                          readOnly: !_isEditing,
                                          decoration: _inputDecoration(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Personal Email'),
                                        const SizedBox(height: 6),
                                        TextFormField(
                                          controller: personalEmailController,
                                          readOnly: !_isEditing,
                                          decoration: _inputDecoration(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 12),
                              // TextButton.icon(
                              //   onPressed: () {},
                              //   icon: const Icon(Icons.lock_outline),
                              //   label: const Text('Change Password'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Right sidebar
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Card(
                        color: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.tune,
                                    color: ColorManager.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Preferences',
                                    style: AppTextStyles.s18bold,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _label('Language Selection'),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorManager.lightGray,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButton<String>(
                                  value: 'English (US)',
                                  items: ['English (US)', 'Arabic']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (_) {},
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dark Mode',
                                    style: AppTextStyles.s14bold,
                                  ),
                                  Switch(value: false, onChanged: (_) {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Card(
                        color: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Need Help?', style: AppTextStyles.s18bold),
                              const SizedBox(height: 8),
                              Text(
                                'Our clinical support team is available 24/7 for system assistance.',
                                style: AppTextStyles.s14bold.copyWith(
                                  color: ColorManager.kGray500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.white,
                                  side: BorderSide(
                                    color: ColorManager.kGray500,
                                  ),
                                ),
                                child: Text(
                                  'Contact Support',
                                  style: AppTextStyles.s14bold.copyWith(
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
