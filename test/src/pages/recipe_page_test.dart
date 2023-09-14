import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/src/models/ingredent.dart';
import 'package:tech_task/src/pages/recipe_page.dart';
import 'package:tech_task/src/repository/network_api.dart';

void main() {
  testWidgets('Recipe page test ...', (tester) async {
    // Create a list of mock ingredients
    final mockIngredients = <Ingredent>[
      Ingredent(title: "Cheese", date: DateTime.now()),
      Ingredent(title: "Bread", date: DateTime.now())
    ];

    // Build the homepage with a fake network interface
    await tester.pumpWidget(
      MaterialApp(
        home: RecipePage(
          networkInterface: FakeNetworkApi(),
          ingredients: mockIngredients,
        ),
      ),
    );

    // Verify that the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the title of the AppBar is correct
    expect(find.text("Available Recipe"), findsOneWidget);

    // Simulate waiting for the future to complete
    await tester.pump(Duration.zero);

    // Verify that the ListView.builder is present
    expect(find.byType(ListView), findsOneWidget);

    //Verify we have 2 expansion tile according to mock
    expect(find.byType(ExpansionTile), findsNWidgets(2));

    //verify that when expansion tile is tapped, it will show the list of ingredents
    const testKey = Key('ExpansionTile0');
    await tester.tap(find.byKey(testKey));
    await tester.pump();

    //Verify that it is expanded
    expect(find.byKey(testKey), findsOneWidget);
    // Verify that an ingredent is show
    expect(find.text("Butter"), findsOneWidget);
  });
}
