import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/DraweHeader/bloc/profile_pic_bloc.dart';
import 'dart:ui' as ui;

import 'package:flutter_frontend/service/auth_service.dart';

class DrawerProfileHead extends StatefulWidget {
  const DrawerProfileHead({super.key});

  @override
  State<DrawerProfileHead> createState() => _DrawerProfileHeadState();
}


class _DrawerProfileHeadState extends State<DrawerProfileHead> {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue, 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              BlocBuilder<ProfilePicBloc, ProfilePicState>(
                builder: (context, state) {
                  if (state is ProfilePicLoading) {
                    return const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProfilePicLoaded) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                FullScreenImage(imageBytes: state.imageBytes),
                            opaque: false,
                            barrierColor: Colors
                                .transparent, // Ensures the background is transparent
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: MemoryImage(state.imageBytes),
                      ),
                    );
                  } else if (state is ProfilePicError) {
                    return const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.error,
                        size: 40,
                        color: Colors.red,
                      ),
                    );
                  } else {
                    return const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blue,
                      ),
                    );
                  }
                },
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: PopupMenuButton<String>(
                  icon: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                  onSelected: (value) async {
                    final bloc = context.read<ProfilePicBloc>();
                    switch (value) {
                      case 'edit':
                        bloc.add(PickImageEvent());
                        bloc.add(GetImageEvent());
                        break;
                      case 'delete':
                        bloc.add(DeleteImageEvent());
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            // "",
            AuthService().name!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final Uint8List imageBytes;

  const FullScreenImage({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent background
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent, // Container also ensures transparency
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent, // Ensures no color overlay
                backgroundImage: MemoryImage(imageBytes),
                radius: 160, // Adjust size as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
