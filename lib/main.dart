import 'package:dio/dio.dart';
import 'package:pizza_app/common/remote/auth_service.dart';
import 'package:pizza_app/common/remote/ingredient_service.dart';
import 'package:pizza_app/common/remote/interceptors/auth_interceptor.dart';
import 'package:pizza_app/common/remote/pizza_service.dart';
import 'package:pizza_app/common/theme/theme_builder.dart';
import 'package:pizza_app/data/auth/auth_repository.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository_online.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';
import 'package:pizza_app/data/repository/orders/order_repository.dart';
import 'package:pizza_app/data/repository/orders/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/repository/secure_local_storage/secure_local_storage.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository_online.dart';
import 'package:pizza_app/features/admin/home/admin_home_page.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/common/auth/login/bloc/auth_bloc.dart';
import 'package:pizza_app/features/common/auth/register/bloc/registration_bloc.dart';
import 'package:pizza_app/features/user/profile/user_bloc.dart/user_bloc.dart';
import 'package:pizza_app/features/user/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/user/order_history/bloc/history_bloc.dart';
import 'package:pizza_app/features/user/page_bloc/root_page_bloc.dart';
import 'package:pizza_app/features/common/welcome_screen.dart';
import 'package:pizza_app/features/user/user_root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool admin = false;
  final Dio _dio = Dio();
  late final AuthInterceptor authInterceptor = AuthInterceptor(_dio, SecureLocalStorage(), AuthService(), () { });
  late final PizzaRepository _pizzaRepository = PizzaRepositoryOnline(PizzaService(_dio, authInterceptor));
  late final IngredientRepository _ingredientRepository =
      IngredientRepositoryOnline(IngredientService(_dio, authInterceptor));
  final User _user = const User(
      userName: "mihaig09",
      firstName: "Mihai",
      lastName: "Gheorghe",
      email: "mihai02ghe@gmail.com",
      password: "test",
      phoneNumber: "+40747112427");
  final OrderRepository _orderRepository = OrderRepositoryImpl();
  final AuthRepository _authRepository =
      AuthRepository(SecureLocalStorage(), AuthService());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _pizzaRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(_authRepository)),
          BlocProvider(create: (_) => RegistrationBloc(_authRepository)),
          BlocProvider(
              create: (_) => PizzaBloc(_pizzaRepository)),
          BlocProvider(
              create: (_) => IngredientBloc(_ingredientRepository)),
          BlocProvider(
              create: (_) => UserBloc(_user)),
          BlocProvider(create: (_) => CartBloc(_orderRepository)),
          BlocProvider(create: (_) => RootPageBloc()),
          BlocProvider(
              create: (_) => HistoryBloc(_orderRepository)),
        ],
        child: MaterialApp(
          title: 'Slice2You',
          theme: ThemeBuilder.getThemeData(),
          home: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
            if (state is Authenticated) {
              return state.account.role == UserRole.admin
                      ? const HomePage()
                      : const UserRootScreen();
            } else {
              return const WelcomeScreen();
            }
          },
            listener: (BuildContext context, AuthState state) {
              Navigator.popUntil(context, (route) => route.isFirst);
            if(state is Authenticated){
              BlocProvider.of<PizzaBloc>(context).add(const FetchPizzas());
              BlocProvider.of<HistoryBloc>(context).add(const FetchHistory());
              BlocProvider.of<IngredientBloc>(context).add(const FetchIngredients());
            }
          },),
        ),
      ),
    );
  }
}
