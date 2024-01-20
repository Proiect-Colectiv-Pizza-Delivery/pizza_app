import 'package:dio/dio.dart';
import 'package:pizza_app/common/remote/auth_service.dart';
import 'package:pizza_app/common/remote/interceptors/auth_interceptor.dart';
import 'package:pizza_app/common/theme/theme_builder.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/auth_repository.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository_impl.dart';
import 'package:pizza_app/data/repository/orders/order_repository.dart';
import 'package:pizza_app/data/repository/orders/order_repository_impl.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/repository/secure_local_storage.dart';
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
  final PizzaRepository _pizzaRepository = PizzaRepositoryImpl();
  final IngredientRepository _ingredientRepository = IngredientRepositoryImpl();
  final User _user = const User(
      firstName: "Mihai",
      lastName: "Gheorghe",
      email: "mihai02ghe@gmail.com",
      userName: "MihaiG09",
      phoneNumber: "+40747112427");
  final OrderRepository _orderRepository = OrderRepositoryImpl();
  final Dio _dio = Dio();
  late final AuthInterceptor authInterceptor = AuthInterceptor(_dio, SecureLocalStorage(), AuthService(), () { });
  final AuthRepository _authRepository =
  AuthRepository(SecureLocalStorage(), AuthService());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _pizzaRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  PizzaBloc(_pizzaRepository)..add(const FetchPizzas())),
          BlocProvider(
              create: (_) => IngredientBloc(_ingredientRepository)
                ..add(const FetchIngredients())),
          BlocProvider(create: (_) => UserBloc(_user)..add(const FetchUser())),
          BlocProvider(create: (_) => CartBloc(_orderRepository)),
          BlocProvider(create: (_) => RootPageBloc()),
          BlocProvider(
              create: (_) =>
                  HistoryBloc(_orderRepository)..add(const FetchHistory())),
          BlocProvider(create: (_) => AuthBloc(_authRepository)),
          BlocProvider(create: (_) => RegistrationBloc(_authRepository))
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
              if(state is Authenticated){
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },),
        ),
      ),
    );
  }
}
