import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final nimController = TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    nimController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (nimController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Semua field wajib diisi"),
        ),
      );
      return;
    }

    final provider =
        context.read<AuthProvider>();

    final success = await provider.login(
      nimController.text,
      passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Login gagal"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<AuthProvider>();

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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1),
                    blurRadius: 30,
                    offset:
                        const Offset(8, 8),
                  ),
                ],
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1),
                    blurRadius: 30,
                    offset:
                        const Offset(8, 8),
                  ),
                ],
              ),
            ),
          ),

          // CONTENT
          Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Container(
                padding:
                    const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.75),
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.08),
                      blurRadius: 25,
                      offset:
                          const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [

                    // TITLE
                    const Text(
                      "Tugas PBM Praktikum",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Login selalu menggunakan NIM anda yaa",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // NIM FIELD
                    TextField(
                      controller:
                          nimController,
                      decoration: InputDecoration(
                        hintText: "Masukkan NIM",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
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

                    const SizedBox(height: 20),

                    // PASSWORD FIELD
                    TextField(
                      controller:
                          passwordController,
                      obscureText:
                          obscurePassword,
                      decoration: InputDecoration(
                        hintText:
                            "Masukkan Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword =
                                  !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons
                                    .visibility
                                : Icons
                                    .visibility_off,
                            color:
                                Colors.green,
                          ),
                        ),
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

                    const SizedBox(height: 35),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed:
                            provider.isLoading
                                ? null
                                : login,
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
                        child: provider
                                .isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(
                                  color:
                                      Colors.white,
                                  strokeWidth:
                                      2,
                                ),
                              )
                            : const Text(
                                "LOGIN",
                                style:
                                    TextStyle(
                                  fontSize: 16,
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
            ),
          ),
        ],
      ),
    );
  }
}