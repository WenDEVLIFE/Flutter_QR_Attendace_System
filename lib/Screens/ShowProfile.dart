import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowProfile {
  final BuildContext context;

  // Constructor for ShowProfile
  ShowProfile(this.context);

  void showProfile({required String username, required String firstname, required String role}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6E738E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close the modal bottom sheet
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage('Assets/fufu.jpg'),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Add your camera function here
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username : $username',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Status : $role',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.4, // Adjust the width as needed
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.push('/EditPassword', extra: username);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE9ECEF), // Button background color
                            ),
                            child: const Text(
                              'Edit Password',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.4, // Adjust the width as needed
                          child: ElevatedButton(
                            onPressed: () {
                              // Add change email functionality
                              Navigator.pop(context);
                              context.push('/EditEmail', extra: username);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE9ECEF), // Button background color
                            ),
                            child: const Text(
                              'Edit Email',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}