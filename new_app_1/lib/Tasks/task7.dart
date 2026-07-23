import 'package:flutter/material.dart';

// Root Widget
class Task7 extends StatelessWidget {
  const Task7({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isFollowing ? "Following Profile" : "Flutter Profile",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isFollowing ? Colors.green : Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Photo
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage(
                "assets/images/pic.png",
              ),

              // Agar photo nahi hai to ye use karo
              // child: Icon(Icons.person,size:70),
            ),

            const SizedBox(height: 20),

            const Text(
              "Love Agrawal",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Flutter Developer",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "loveagrawal80295@gmail.com",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 35),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isFollowing = !isFollowing;
                });
              },

              icon: Icon(
                isFollowing ? Icons.check : Icons.person_outline,
                color: Colors.white,
              ),

              label: Text(
                isFollowing ? "Following" : "Follow",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isFollowing ? Colors.green : Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}