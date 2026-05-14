import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() =>
      _AddProductScreenState();
}

class _AddProductScreenState
    extends State<AddProductScreen> {
  final nameController = TextEditingController();

  final priceController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> saveProduct() async {
    // VALIDASI
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty) {
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
        .addProduct(
          nameController.text,
          price,
          descriptionController.text,
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
              ? "Produk berhasil ditambahkan"
              : "Gagal menambahkan produk",
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
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xffF4F4F4),
          ),

          // SHAPE KIRI ATAS
          Positioned(
            top: 80,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.22,
                ),
                borderRadius:
                    BorderRadius.circular(140),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.15),
                    blurRadius: 30,
                    offset:
                        const Offset(10, 10),
                  ),
                ],
              ),
            ),
          ),

          // SHAPE KIRI
          Positioned(
            top: 250,
            left: -120,
            child: Container(
              width: 240,
              height: 300,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.35,
                ),
                borderRadius:
                    BorderRadius.circular(140),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.15),
                    blurRadius: 30,
                    offset:
                        const Offset(10, 10),
                  ),
                ],
              ),
            ),
          ),

          // SHAPE KANAN BAWAH
          Positioned(
            bottom: -120,
            right: -100,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.25,
                ),
                borderRadius:
                    BorderRadius.circular(160),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.15),
                    blurRadius: 30,
                    offset:
                        const Offset(10, 10),
                  ),
                ],
              ),
            ),
          ),

          // SHAPE KECIL
          Positioned(
            top: 200,
            right: 70,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.45,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1),
                    blurRadius: 10,
                    offset:
                        const Offset(3, 3),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 220,
            left: 70,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color:
                    Colors.green.withOpacity(
                  0.45,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1),
                    blurRadius: 10,
                    offset:
                        const Offset(3, 3),
                  ),
                ],
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

                  const Text(
                    "Tambah Produk",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Tambahkan draft produk baru dengan tampilan modern",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // FORM CARD
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
                            8,
                            8,
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
                          height: 35,
                        ),

                        // BUTTON
                        SizedBox(
                          width:
                              double.infinity,
                          height: 58,
                          child: FilledButton(
                            onPressed:
                                isLoading
                                    ? null
                                    : saveProduct,
                            style:
                                FilledButton.styleFrom(
                              backgroundColor:
                                  Colors.green,
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
                                    width: 25,
                                    height: 25,
                                    child:
                                        CircularProgressIndicator(
                                      color: Colors
                                          .white,
                                      strokeWidth:
                                          2,
                                    ),
                                  )
                                : const Text(
                                    "Simpan Produk",
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