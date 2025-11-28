import 'package:flutter/material.dart';

class UpgradeToProCard extends StatelessWidget {
  const UpgradeToProCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children:  [
          Icon(Icons.lock, size: 40, color: Colors.green),
          SizedBox(height: 8),
          Text("Upgrade to PRO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 4),
          Text("Reveal Wall Street’s Top Pros. Don’t Miss out on top analysts stock recommendations",
              textAlign: TextAlign.center),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: null,
            child: Text("Unlock Now"),
            style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}
