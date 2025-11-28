import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BeforeMyExpertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'See experts you are following',
              style: TextStyle(fontSize: screenWidth * 0.035, color: const Color(0xff595959),fontStyle: FontStyle.italic),
            ),
            SizedBox(height: screenHeight * 0.015),
            Divider(height: 1, color: const Color(0xff595959)),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                  child: Text(
                    'Expert',
                    style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xff595959)),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Text(
                    'Success Rate',
                    style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xff595959)),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Text(
                    'Average Return',
                    style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xff595959)),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Divider(height: 1, color: Colors.black),
            SizedBox(height: 64,),
        Center(child: Text('You are currently not following any experts',style: TextStyle(color: Color(0xff595959)),)),
            SizedBox(height: 16,),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add, size: screenWidth * 0.05,color: Colors.white,weight: screenWidth * 0.05),
            label: Text(
              'Add Expert',
              style: TextStyle(fontSize: screenWidth * 0.04,color: Colors.white,fontWeight:FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
            ),
          ),
        ),

          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black,
      title: const Text(
        'My Exports',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
      ),
    );
  }
}
