import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/users/user.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
class ProfileScreen extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    return FadeIn(
      child: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(124),
        ),
        bottomNavigationBar: const BottomAppBarCustom(),
        body: const ContentUserProfile(),
      ),
    );
  }
}
class ContentUserProfile extends ConsumerStatefulWidget {
  const ContentUserProfile({super.key});
  @override
  ConsumerState<ContentUserProfile> createState() => _ContentUserProfileState();
}
class _ContentUserProfileState extends ConsumerState<ContentUserProfile> {
  User cliente = User(
    ci: "1231231",
    image: 'assets/GoDely-Logo.png',
    fullname: 'Alejandro Seijas',
    phone: '0412-6120717',
    email: 'aesr00@gmail.com',
    password: '12345',
  );

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(124), bottomAppBarColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(cliente.image!),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cliente.fullname,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(cliente.phone),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(cliente.email),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Personal information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Personal information action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Security', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Security action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: const Text('Payment methods', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Payment methods action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map_sharp),
                  title: const Text('Addresses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Addresses action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Delete account action
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Edit profile action
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    disabledForegroundColor: Colors.white.withOpacity(0.38), 
                    disabledBackgroundColor: Colors.white.withOpacity(0.12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Logout action
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}