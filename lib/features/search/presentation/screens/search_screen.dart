// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// } 

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final ServiceSearch _serviceSearch = ServiceSearch();
//   List<Map<String, dynamic>> _searchResults = [];

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     print("Search changed: ${_searchController.text}");
//     if (_searchController.text.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//     } else {
//       _performSearch(_searchController.text);
//     }
//   }

//   void _performSearch(String query) async {
//     print("Performing search for: $query");
//     final results = await _serviceSearch.searchServices(query);
//     print("Search results: $results");
//     setState(() {
//       _searchResults = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Search Services')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _searchResults.isEmpty
//                 ? const Center(child: Text('No results found'))
//                 : ListView.builder(
//                     itemCount: _searchResults.length,
//                     itemBuilder: (context, index) {
//                       final service = _searchResults[index];
//                       return ListTile(
//                         title: Text(service['name']),
//                         onTap: () {},
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Service {
//   final String id;
//   final String name;
//   final String description;
//   final double price;

//   Service({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//   });

//   factory Service.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map<String, dynamic>;
//     return Service(
//       id: doc.id,
//       name: data['name'] ?? '',
//       description: data['description'] ?? '',
//       price: (data['price'] ?? 0).toDouble(),
//     );
//   }
// }

// class ServiceSearch {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Map<String, dynamic>>> searchServices(String query) async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     try {
//       print("Searching for: '$query'");

//       QuerySnapshot querySnapshot = await firestore
//           .collection('Services')
//           .where('name', isGreaterThanOrEqualTo: query)
//           .where('name', isLessThan: query + 'z')
//           .get();

//       print("Query completed. Documents found: ${querySnapshot.docs.length}");

//       List<Map<String, dynamic>> results = querySnapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         data['id'] = doc.id;
//         print("Document: ${doc.id}, Data: $data");
//         return data;
//       }).toList();

//       return results;
//     } catch (e) {
//       print("Error performing search: $e");
//       return [];
//     }
//   }
// }
