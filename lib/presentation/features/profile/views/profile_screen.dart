import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_coaches/core/constants/app_constants.dart';
import 'package:gym_coaches/core/providers/providers.dart';
import 'package:gym_coaches/core/utils/formatters.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_text_field.dart';
import 'package:gym_coaches/presentation/features/auth/viewmodels/auth_viewmodel.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditing = false;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final trainer = ref.read(currentTrainerProvider).value;

    nameController = TextEditingController(text: trainer?.name ?? '');
    phoneController = TextEditingController(
      text: Formatters.formatPhoneNumber(trainer?.phoneNumber ?? ''),
    );
    emailController = TextEditingController(text: trainer?.email ?? '');
    addressController = TextEditingController(text: trainer?.address ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainer = ref.watch(currentTrainerProvider).value;
    final userName = trainer?.name ?? 'Kullanıcı';
    final email = trainer?.email ?? 'email@example.com';
    final phone = trainer?.phoneNumber ?? 'Telefon numarası yok';
    final address = trainer?.address ?? 'Adres bilgisi yok';

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profil Fotoğrafı
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage(
                    'assets/images/default_avatar.png',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Profil resmi değiştirme mantığı burada eklenecek
                  },
                ),
              ],
            ),
            const SizedBox(height: AppConstants.mediumPadding),

            // Ad Soyad
            CustomTextField(
              controller: nameController,
              hintText: "Ad Soyad",
              enabled: isEditing,
            ),
            const SizedBox(height: AppConstants.mediumPadding),

            // E-posta (readonly)
            CustomTextField(
              controller: TextEditingController(text: email),
              hintText: "E-posta",
              enabled: false,
            ),
            const SizedBox(height: AppConstants.mediumPadding),

            // Telefon
            CustomTextField(
              controller: phoneController,
              hintText: "Telefon",
              keyboardType: TextInputType.phone,
              enabled: isEditing,
            ),
            const SizedBox(height: AppConstants.mediumPadding),

            // Adres
            CustomTextField(
              controller: addressController,
              hintText: "Adres",
              keyboardType: TextInputType.streetAddress,
              enabled: isEditing,
            ),

            // Şifre Değiştir Butonu
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // Şifre değiştirme işlemi burada tetiklenecek
                },
                icon: const Icon(Icons.lock_outline),
                label: const Text("Şifreyi Değiştir"),
              ),
            ),
            const SizedBox(height: AppConstants.largePadding),

            // Çıkış Butonu
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () async {
                final viewModel = ref.read(authViewModelProvider.notifier);
                await viewModel.signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text("Çıkış Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
