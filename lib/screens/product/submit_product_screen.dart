import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

class SubmitProductScreen
    extends StatefulWidget {
  const SubmitProductScreen({
    super.key,
  });

  @override
  State<SubmitProductScreen>
      createState() =>
          _SubmitProductScreenState();
}

class _SubmitProductScreenState
    extends State<
        SubmitProductScreen> {
  final nameController =
      TextEditingController();

  final priceController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final githubController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Submit Tugas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller:
                  nameController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Nama Produk",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller:
                  priceController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: "Harga",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller:
                  descriptionController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Deskripsi",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller:
                  githubController,
              decoration:
                  const InputDecoration(
                labelText:
                    "GitHub URL",
              ),
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed:
                  () async {
                final success =
                    await context
                        .read<
                            ProductProvider>()
                        .submitTugas(
                          nameController
                              .text,
                          githubController
                              .text,
                        );

                if (mounted) {
                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? "Submit berhasil"
                            : "Submit gagal",
                      ),
                    ),
                  );
                }
              },
              child:
                  const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}