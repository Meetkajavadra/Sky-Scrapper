import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../modal/modals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random People's Data"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: FutureBuilder(
        future: UserAPI.userAPI.fetchUserAPI(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            RandomData? data = snapshot.data;
            return Container(
              height: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 0),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      data!.image,
                    ),
                    backgroundColor: Colors.grey,
                    radius: 85,
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "${data.title} ${data.firstName} ${data.lastName}",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  customRow("Username", data.username),
                  customRow("Email", data.email),
                  customRow("Phone", data.phone),
                  customRow("Gender", data.gender),
                  customRow("Age", data.age),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      "Address\n\n${data.address}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  customRow(fldName, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "$fldName",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                "$data",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}