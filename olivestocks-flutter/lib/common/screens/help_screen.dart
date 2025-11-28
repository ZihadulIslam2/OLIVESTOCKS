import 'package:flutter/material.dart';

import '../widgets/expandable_list_widget.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        title: const Text(
          'Help',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras finibus nibh in enim suscipit, sed ultrices enim efficitur. Suspendisse potenti. Fusce dapibus placerat ornare. Nam sit amet venenatis risus. Aenean eget ligula sit amet magna auctor fringilla. Sed a scelerisque tortor. Nunc ornare interdum justo. Duis gravida ac ex vel bibendum. Phasellus ut libero quam. Vestibulum turpis purus, tristique a diam sit amet, porttitor malesuada nisi. Duis eget leo suscipit, ornare nibh non, bibendum ut.',
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.justify,
              ),
              _bulletPoint("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
              _bulletPoint("Duis non erat eget enim fringilla luctus nec sit amet nisi."),
              _bulletPoint("Nulla quis sapien malesuada, laoreet lacus vel, bibendum enim."),
              _bulletPoint("Nam eu felis ac nulla lobortis eleifend."),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras finibus nibh in enim suscipit, sed ultrices enim efficitur. Suspendisse potenti. Fusce dapibus placerat ornare. Nam sit amet venenatis risus. Aenean eget ligula sit amet magna auctor fringilla. Sed a scelerisque tortor. Nunc ornare interdum justo. Duis gravida ac ex vel bibendum. Phasellus ut libero quam. Vestibulum turpis purus, tristique a diam sit amet, porttitor malesuada nisi. Duis eget leo suscipit, ornare nibh non, bibendum ut.',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.justify,
                  ),
                  _bulletPoint("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                  _bulletPoint("Duis non erat eget enim fringilla luctus nec sit amet nisi."),
                  _bulletPoint("Nulla quis sapien malesuada, laoreet lacus vel, bibendum enim."),
                  _bulletPoint("Nam eu felis ac nulla lobortis eleifend."),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse hendrerit a ex eget accumsan. Aliquam ullamcorper porttitor odio.',
                    style: TextStyle(fontSize: 10, color: Color(0xff737373)),
                  ),
                  const SizedBox(height: 10),
                  // Constrained ListView inside a SizedBox
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
                    child: ListView.builder(
                      itemCount: 5, // Number of items in the list
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return ExpandableListItem(index: index);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Container(
            height: 4,
            width: 4,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}