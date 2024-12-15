// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:school_app/core/icons/icons_broken.dart';
import 'package:school_app/provider/theme/theme_provider.dart';
import 'package:school_app/ui/widgets/gradient_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final provider = Provider.of<ThemeProvider>(context);
    double glow = provider.glowValue!;
    double blur = provider.blurValue!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        children: [
          const GradientHeader(name: "Contact - Us"),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.primary),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(glow),
                      blurRadius: 10 * blur)
                ]),
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "We'd love to hear from you!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "LexendDeca",
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "LexendDeca"),
                        labelText: 'Full Name',
                        prefixIcon: Icon(
                          Broken.user,
                          color: Theme.of(context).colorScheme.primary,
                          shadows: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(glow),
                                blurRadius: 10 * blur)
                          ],
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "LexendDeca"),
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          shadows: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(glow),
                                blurRadius: 10 * blur)
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains("@") ||
                            !value.contains(".")) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: "LexendDeca"),
                          labelText: 'Your Message',
                          prefixIcon: Icon(
                            Broken.message_2,
                            color: Theme.of(context).colorScheme.primary,
                            shadows: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(glow),
                                  blurRadius: 10 * blur)
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(20))),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () async{
                        if (formKey.currentState!.validate()) {
                            final Email email = Email(
                                body: messageController.text,
                                subject: "Message form ${nameController.text}",
                                recipients: ['principal@laidlawschool.org']);
                            try {
                              await FlutterEmailSender.send(email);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  content:
                                      const Text('Form submitted successfully!',textAlign: TextAlign.center,style: TextStyle(fontFamily: "LexendDeca"),),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.red,
                                  content: Text("Error in sending email: $e", textAlign: TextAlign.center,style: const TextStyle(fontFamily: "LexendDeca"),)));
                            }
                          }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 90),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary.withOpacity(glow),
                              blurRadius: 10 * blur
                            )
                          ]
                        ),
                        child: Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).colorScheme.surface,fontFamily: "LexendDeca"),
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
