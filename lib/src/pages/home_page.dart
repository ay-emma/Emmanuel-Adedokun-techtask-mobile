import 'package:flutter/material.dart';
import 'package:tech_task/src/models/api_response.dart';
import 'package:tech_task/src/models/ingredent.dart';
import 'package:tech_task/src/repository/launch_repo.dart';
import 'package:tech_task/src/repository/network_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        centerTitle: false,
        elevation: 10,
        actions: [
          InkWell(
            onTap: () async {
              final newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2024),
              );
              if (newDate != null) {
                setState(() {
                  selectedDate = newDate;
                });
              }
            },
            child: Row(
              children: [
                Text(
                  "${selectedDate.day}-${selectedDate.month}-${selectedDate.year} ",
                ),
                Icon(Icons.edit_calendar),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Expanded(
            child: Text(
              "Ingredients available in \nthe fridge.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
              child: FutureBuilder<ApiResponse>(
                  future: LaunchRepo(NetworkApi()).getIngredents(),
                  builder: (context, snapshot) {
                    return ListView(
                      children: [Text("I could not Get sleep")],
                    );
                  }))
        ]),
      ),
      persistentFooterButtons: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 300,
            height: 65,
            child: FilledButton(
              onPressed: () {},
              child: Text("Submit"),
            ),
          ),
        )
      ],
    );
  }
}
