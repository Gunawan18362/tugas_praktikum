import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../product/add_product_screen.dart';
import '../product/submit_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<ProductProvider>()
          .fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<ProductProvider>();

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
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // TITLE
                  const Text(
                    "Katalog Produk",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Daftar draft produk kamu",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // LIST PRODUCT
                  Expanded(
                    child: provider.isLoading

                        ? const Center(
                            child:
                                CircularProgressIndicator(
                              color:
                                  Colors.green,
                            ),
                          )

                        : provider.products.isEmpty

                            ? Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [

                                    Icon(
                                      Icons
                                          .inventory_2_outlined,
                                      size: 90,
                                      color: Colors
                                          .green
                                          .withOpacity(
                                        0.5,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    const Text(
                                      "Belum ada produk",
                                      style:
                                          TextStyle(
                                        fontSize:
                                            20,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        color: Colors
                                            .black54,
                                      ),
                                    ),
                                  ],
                                ),
                              )

                            : ListView.builder(
                                itemCount:
                                    provider
                                        .products
                                        .length,

                                itemBuilder:
                                    (
                                      context,
                                      index,
                                    ) {

                                  final product =
                                      provider
                                              .products[
                                          index];

                                  return Container(

                                    margin:
                                        const EdgeInsets.only(
                                      bottom: 20,
                                    ),

                                    padding:
                                        const EdgeInsets.all(
                                      20,
                                    ),

                                    decoration:
                                        BoxDecoration(
                                      color: Colors
                                          .white
                                          .withOpacity(
                                        0.75,
                                      ),

                                      borderRadius:
                                          BorderRadius.circular(
                                        28,
                                      ),

                                      boxShadow: [

                                        BoxShadow(
                                          color: Colors
                                              .black
                                              .withOpacity(
                                            0.08,
                                          ),

                                          blurRadius:
                                              20,

                                          offset:
                                              const Offset(
                                            0,
                                            10,
                                          ),
                                        ),
                                      ],
                                    ),

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        // HEADER
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,

                                          children: [

                                            Expanded(
                                              child: Text(
                                                product
                                                    .name,

                                                style:
                                                    const TextStyle(
                                                  fontSize:
                                                      22,

                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                            // DELETE BUTTON
                                            IconButton(
                                              onPressed:
                                                  () async {

                                                final confirm =
                                                    await showDialog(

                                                  context:
                                                      context,

                                                  builder:
                                                      (_) {

                                                    return AlertDialog(

                                                      title:
                                                          const Text(
                                                        "Hapus Produk",
                                                      ),

                                                      content:
                                                          const Text(
                                                        "Yakin ingin menghapus produk ini?",
                                                      ),

                                                      actions: [

                                                        TextButton(
                                                          onPressed:
                                                              () {

                                                            Navigator.pop(
                                                              context,
                                                              false,
                                                            );
                                                          },

                                                          child:
                                                              const Text(
                                                            "Batal",
                                                          ),
                                                        ),

                                                        FilledButton(
                                                          style:
                                                              FilledButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),

                                                          onPressed:
                                                              () {

                                                            Navigator.pop(
                                                              context,
                                                              true,
                                                            );
                                                          },

                                                          child:
                                                              const Text(
                                                            "Hapus",
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );

                                                if (confirm ==
                                                    true) {

                                                  final success =
                                                      await context
                                                          .read<
                                                              ProductProvider>()
                                                          .deleteProduct(
                                                            product.id,
                                                          );

                                                  if (!context
                                                      .mounted) {
                                                    return;
                                                  }

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(

                                                    SnackBar(

                                                      backgroundColor:
                                                          success
                                                              ? Colors.green
                                                              : Colors.red,

                                                      content:
                                                          Text(

                                                        success
                                                            ? 'Produk berhasil dihapus'
                                                            : 'Gagal menghapus produk',
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },

                                              icon: const Icon(
                                                Icons
                                                    .delete_outline,

                                                color:
                                                    Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        // PRICE
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal:
                                                14,

                                            vertical:
                                                8,
                                          ),

                                          decoration:
                                              BoxDecoration(
                                            color: Colors
                                                .green
                                                .withOpacity(
                                              0.12,
                                            ),

                                            borderRadius:
                                                BorderRadius.circular(
                                              12,
                                            ),
                                          ),

                                          child: Text(
                                            "Rp ${product.price}",

                                            style:
                                                const TextStyle(
                                              color:
                                                  Colors.green,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 15,
                                        ),

                                        // DESCRIPTION
                                        Text(
                                          product
                                              .description,

                                          style:
                                              const TextStyle(
                                            fontSize:
                                                15,

                                            color:
                                                Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // FLOATING BUTTON
      floatingActionButton: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [

          // ADD PRODUCT
          FloatingActionButton.extended(

            heroTag: "1",

            backgroundColor:
                Colors.green,

            elevation: 10,

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder:
                      (_) =>
                          const AddProductScreen(),
                ),
              );
            },

            label: const Text(
              "Tambah",

              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          // SUBMIT PRODUCT
          FloatingActionButton.extended(

            heroTag: "2",

            backgroundColor:
                Colors.white,

            elevation: 10,

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder:
                      (_) =>
                          const SubmitProductScreen(),
                ),
              );
            },

            label: const Text(
              "Submit",

              style: TextStyle(
                color: Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            icon: const Icon(
              Icons.send,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}