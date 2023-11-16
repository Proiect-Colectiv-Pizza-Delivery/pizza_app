part of 'admin_home_page.dart';

class PizzaPage extends StatefulWidget {
  const PizzaPage({super.key});
  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> {
  late List<Pizza> codes;

  @override
  void initState() {
    codes = Pizza.getPopulation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      builder: (context, state) {
        if (state is! PizzaLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView.separated(
            itemCount: state.codes.length,
            itemBuilder: (context, index) {
              return PizzaTile(
                pizza: state.codes[index],
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
      },
    );
  }
}
