import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  // final List<Map<String, String>> genres = [
  //   {'title': 'Bollywood', 'image': 'assets/images/2.png'},
  //   {'title': 'Hollywood', 'image': 'assets/images/1.png'},
  // ];

  final List<Map<String, String>> topSearch = [
    {
      'title': 'Bad Influence',
      'image': 'assets/images/image 12.png',
      'date': '24 May 2025',
      'duration': '2h 44m 51s',
    },
    {
      'title': 'Tomorrow Was Beautiful',
      'image': 'assets/images/image 15.png',
      'date': '24 May 2025',
      'duration': '2h 44m 51s',
    },
    {
      'title': 'Inside Man: Most Wanted',
      'image': 'assets/images/image 16.png',
      'date': '24 May 2025',
      'duration': '2h 44m 51s',
    },
    {
      'title': 'A Deadly American Marriage',
      'image': 'assets/images/image 17.png',
      'date': '29 May 2025',
      'duration': '2h 44m 51s',
    },
    {
      'title': 'Tomorrow Was Beautiful',
      'image': 'assets/images/image 22.png',
      'date': '24 May 2025',
      'duration': '2h 44m 51s',
    },
    {
      'title': 'Tomorrow Was Beautiful',
      'image': 'assets/images/image 15.png',
      'date': '24 May 2025',
      'duration': '2h 44m 51s',
    },
    {
      'title': 'Bad Influence',
      'image': 'assets/images/image 12.png',
      'date': '24 May 2025',
      'duration': '2h 44m 51s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 10),
              Row(
                children: [
                  // Expanded(
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: 'Movie',
                  //       prefixIcon: const Icon(
                  //         Icons.search,
                  //         color: Colors.white,
                  //       ),
                  //       hintStyle: const TextStyle(color: Colors.grey),
                  //       filled: true,
                  //       fillColor: Colors.grey[900],
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  // ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Movie',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide
                              .none, // <-- Removes white border on focus
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: () {
                        // TODO: Add filter action
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // const Text(
              //   'Top Search',
              //   style: TextStyle(
              //     fontSize: 18,
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: topSearch.length,
                  itemBuilder: (context, index) {
                    final movie = topSearch[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              movie['image']!,
                              width: 74,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${movie['date']} | Movie | ${movie['duration']}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
