import 'package:flutter/material.dart';
import 'package:tech_task/src/models/api_response.dart';
import 'package:tech_task/src/models/ingredent.dart';
import 'package:tech_task/src/pages/recipe_page.dart';
import 'package:tech_task/src/pages/widgets/ingredent_card.dart';

import 'package:tech_task/src/repository/launch_repo.dart';
import 'package:tech_task/src/repository/network_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.networkInterface});
  final NetworkInterface networkInterface;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime(2020, 2, 15);
  late Future<ApiResponse> getIngredients;
  @override
  void initState() {
    super.initState();
    getIngredients = LaunchRepo(widget.networkInterface).getIngredents();
  }

  List<int> selectedIndex = [];
  List<Ingredent> selectedIngredents = [];

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
                initialDate: selectedDate,
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
                  "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
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
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Ingredients available in \nthe fridge.",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder<ApiResponse>(
                future: getIngredients,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    final response = snapshot.data!;

                    return switch (response) {
                      Error() => Center(
                          child: Text(response.message),
                        ),
                      Success<List<Ingredent>>() => GridView.builder(
                          itemCount: response.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 2.5,
                          ),
                          itemBuilder: (context, index) {
                            final value = response.data[index];
                            return IngredientCard(
                              ingredent: value,
                              onTap: value.date.isBefore(selectedDate)
                                  ? null
                                  : () {
                                      if (selectedIndex.contains(index)) {
                                        selectedIndex.remove(index);
                                        selectedIngredents.remove(value);
                                      } else {
                                        selectedIndex.add(index);
                                        selectedIngredents.add(value);
                                      }
                                      print(selectedIndex);
                                      print(selectedIngredents);
                                    },
                            );
                          }),
                      _ => Center(
                          child: Text("Can't find match"),
                        ),
                    };
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error!.toString()),
                    );
                  }
                  return Center(
                    child: Text("Can't find match"),
                  );
                },
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 300,
            height: 65,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecipePage(
                      ingredients: selectedIngredents,
                      networkInterface: widget.networkInterface,
                    ),
                  ),
                );
              },
              child: Text("Submit"),
            ),
          ),
        )
      ],
    );
  }
}
