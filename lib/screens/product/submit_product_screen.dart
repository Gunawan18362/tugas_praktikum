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

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    githubController.dispose();
    super.dispose();
  }

  Future<void> submitTask() async {
    // VALIDASI
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        githubController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Semua field wajib diisi"),
        ),
      );
      return;
    }

    final price = int.tryParse(
      priceController.text,
    );

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harga harus angka"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await context
        .read<ProductProvider>()
        .submitTugas(
          nameController.text,
          githubController.text,
        );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            success ? Colors.green : Colors.red,
        content: Text(
          success
              ? "Tugas berhasil disubmit"
              : "Submit gagal",
        ),
      ),
    );

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffE8F5E9),
                  Color(0xffB7D7B0),
                ],
              ),
            ),
          ),

          // SHAPE TOP LEFT
          Positioned(
            top: -120,
            left: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.18,
                ),
                borderRadius:
                    BorderRadius.circular(140),
              ),
            ),
          ),

          // SHAPE BOTTOM RIGHT
          Positioned(
            bottom: -140,
            right: -120,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.18,
                ),
                borderRadius:
                    BorderRadius.circular(160),
              ),
            ),
          ),

          // CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // BACK BUTTON
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // TITLE
                  const Text(
                    "Submit Tugas",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Submit produk beserta repository GitHub",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // CARD
                  Container(
                    padding:
                        const EdgeInsets.all(
                      24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.75),
                      borderRadius:
                          BorderRadius.circular(
                        35,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(
                            0.08,
                          ),
                          blurRadius: 25,
                          offset:
                              const Offset(
                            0,
                            10,
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // NAMA
                        TextField(
                          controller:
                              nameController,
                          decoration:
                              InputDecoration(
                            labelText:
                                "Nama Produk",
                            hintText:
                                "Macbook Pro M5",
                            filled: true,
                            fillColor:
                                Colors.white,
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // HARGA
                        TextField(
                          controller:
                              priceController,
                          keyboardType:
                              TextInputType
                                  .number,
                          decoration:
                              InputDecoration(
                            labelText:
                                "Harga",
                            hintText:
                                "32000000",
                            prefixText:
                                "Rp ",
                            filled: true,
                            fillColor:
                                Colors.white,
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // DESKRIPSI
                        TextField(
                          controller:
                              descriptionController,
                          maxLines: 5,
                          decoration:
                              InputDecoration(
                            labelText:
                                "Deskripsi",
                            hintText:
                                "Masukkan deskripsi produk...",
                            filled: true,
                            fillColor:
                                Colors.white,
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // GITHUB
                        TextField(
                          controller:
                              githubController,
                          decoration:
                              InputDecoration(
                            labelText:
                                "GitHub URL",
                            hintText:
                                "https://github.com/username/repository",
                            filled: true,
                            fillColor:
                                Colors.white,
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),

                        // BUTTON
                        SizedBox(
                          width:
                              double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed:
                                isLoading
                                    ? null
                                    : submitTask,
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.green,
                              foregroundColor:
                                  Colors.white,
                              elevation: 0,
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child:
                                        CircularProgressIndicator(
                                      color: Colors
                                          .white,
                                      strokeWidth:
                                          2,
                                    ),
                                  )
                                : const Text(
                                    "Submit Tugas",
                                    style:
                                        TextStyle(
                                      fontSize:
                                          16,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}