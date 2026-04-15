import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickyshit/states/local_user_provider.dart';

class TopBarWidget extends StatelessWidget {
  final bool showLogoutButton;

  const TopBarWidget({super.key, this.showLogoutButton = false});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;
    final userProvider = context.watch<UserProvider>();
    // Note: currentRoute is defined in your image but not used in the visible UI logic
    // final currentRoute = ModalRoute.of(context)?.settings.name;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (currentUser == null) {
                Navigator.pushNamed(context, '/login');
              } else {
                // Handle profile tap if needed
              }
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: (currentUser == null ||
                      userProvider.userData?.avatar == null ||
                      userProvider.userData!.avatar.isEmpty)
                  ? const AssetImage("images/images/who_is_pfoto.jpeg") as ImageProvider
                  : NetworkImage(userProvider.userData!.avatar),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (currentUser == null) ? "Click avatar\nto login" : "User name:",
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  userProvider.userData?.nickname ?? "Guest",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (currentUser != null)
                  Text(
                    "Balance: ${userProvider.userData?.coins ?? 0} Rc\$",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          if (currentUser != null && showLogoutButton)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: () async {
                await auth.signOut();
              },
            ),
        ],
      ),
    );
  }
}