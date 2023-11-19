part of 'admin_home_page.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  late List<Ingredient> ingredients;

  @override
  void initState() {
    ingredients = Ingredient.getPopulation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientBloc, IngredientState>(
        builder: (context, state) {
      if (state is! IngredientLoaded) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: state.ingredients.length,
          itemBuilder: (context, index) {
            return IngredientTile(
              ingredient: state.ingredients[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent: 1,
              endIndent: 1,
              thickness: 1,
            );
          },
        ),
      );
    });
  }
}
