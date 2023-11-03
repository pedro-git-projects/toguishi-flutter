import 'package:flutter/material.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  JobSearchScreenState createState() => JobSearchScreenState();
}

class JobSearchScreenState extends State<JobSearchScreen> {
  String searchQuery = ''; // Store the search query
  String selectedFilter = 'banho'; // Set an initial value
  List<String> filterOptions = ['banho', 'tosa', 'penteado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Search'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              textInputAction: TextInputAction.search,
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search for job openings',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchQuery = '';
                    });
                  },
                ),
              ),
            ),
          ),

          // Filter Dropdown
          DropdownButton(
            value: selectedFilter,
            items: filterOptions.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedFilter = value;
                }
              });
            },
          ),

          // Display Search Results
          Expanded(
            child: Center(
              child: Text('Search results for: $searchQuery'),
            ),
          ),
        ],
      ),
    );
  }
}
