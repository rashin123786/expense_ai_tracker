import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';

class ScanReceiptSheet extends StatelessWidget {
  const ScanReceiptSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 72,
              height: 72,
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
            Center(
              child: Text(
                'Scan Your Receipt',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Our AI instantly extracts merchant, amount, and date from any receipt.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final file = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                );

                if (file != null) {
                  if (context.mounted) {
                    Navigator.pop(context, file);
                  }
                }
              },
              icon: const Icon(Icons.crop_free_rounded),
              label: const Text('Scan Receipt'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                final picker = ImagePicker();

                final file = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 70,
                );

                if (file != null) {
                  if (context.mounted) {
                    Navigator.pop(context, file);
                  }
                }
              },
              icon: const Icon(Icons.image_outlined),
              label: const Text('Upload from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
