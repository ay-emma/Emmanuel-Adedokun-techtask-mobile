import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/src/pages/home_page.dart';
import 'package:tech_task/src/pages/widgets/ingredent_card.dart';
import 'package:tech_task/src/repository/network_api.dart';

void main() {
  testWidgets('Test Home page has all static widgets ...', (tester) async {
    // Build the homepage with a fake network interface
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(networkInterface: FakeNetworkApi()),
      ),
    );

    // Verify that the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the title of the AppBar is correct
    expect(find.text('Recipe App'), findsOneWidget);

    await tester.pumpAndSettle();
    // Verify that the initial date is displayed.
    expect(
        find.text(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'),
        findsOneWidget);

    // Tap on the InkWell widget to show the date picker
    await tester.tap(find.byType(Icon));
    await tester.pumpAndSettle();

    // Verify that the showDatePicker dialog appeared
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.pumpAndSettle();

    //Verify sub heading
    expect(find.text("Ingredients available in \nthe fridge."), findsOneWidget);

    // Verify that the GridView.builder is present
    //Really don't understand why we have 2 in the widget tree
    expect(find.byType(GridView), findsNWidgets(2));

    //Verify that we have 5 IngredientCard from the mock api in the gridview
    expect(find.byType(IngredientCard), findsNWidgets(5));

    // Verify that the persistent footer buttons are present
    expect(find.byType(FilledButton), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    //Simulate a tap on the FilledButton
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
  });
}
