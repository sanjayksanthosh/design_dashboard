import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the current user details from your provider.
    final User? user = Provider.of<UserProvider>(context).currentUser;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 220,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // A semi-transparent gradient to simulate the glass effect.
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // A subtle white border enhances the frosted look.
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          // A slightly higher blur to intensify the glass effect.
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Stack(
            children: [
              // Decorative element: a soft, glowing circle at the top-left.
              Positioned(
                top: -40,
                left: -40,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Decorative element: a larger soft circle at the bottom-right.
              Positioned(
                bottom: -50,
                right: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Main content of the card.
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: user == null
                    ? Center(
                        child: Text(
                          'No user details available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top header with title and a decorative icon.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width:280,
                                child: AutoSizeText(
                                  maxLines: 2,
                                  user.fullName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              // A sample icon – you can replace this with a custom graphic.
                              Icon(
                                Icons.credit_card,
                                color: Colors.white.withOpacity(0.8),
                                size: 28,
                              ),
                            ],
                          ),
                          // A subtle divider line.
                          Divider(
                            color: Colors.white.withOpacity(0.5),
                            thickness: 1,
                          ),
                          // User details section.
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            
                              const SizedBox(height: 4),
                              Text(
                                "User ID: ${user.userId}",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Emirates ID: ${user.emiratesIdNo}",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Country: India",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
