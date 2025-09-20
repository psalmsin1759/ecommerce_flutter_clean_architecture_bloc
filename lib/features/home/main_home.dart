import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state_cubit.dart';
import 'package:julybyoma_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:julybyoma_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:julybyoma_app/features/cart/presentation/pages/cart_widget.dart';
import 'package:julybyoma_app/features/category/presentation/pages/all_categories_widget.dart';
import 'package:julybyoma_app/features/category/presentation/widgets/category_horizontal_list.dart';
import 'package:julybyoma_app/features/home/widget/promo_slider.dart';
import 'package:julybyoma_app/features/home/widget/search_widget.dart';
import 'package:julybyoma_app/features/product/presentation/widgets/featured_products_widget.dart';
import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_events.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_state.dart';
import 'package:julybyoma_app/injection.dart';

class MainHomeWidget extends StatefulWidget {
  const MainHomeWidget({super.key});

  @override
  State<MainHomeWidget> createState() => _MainHomeWidgetState();
}

class _MainHomeWidgetState extends State<MainHomeWidget> {
  @override
  void initState() {
    super.initState();

    context.read<UserStateCubit>().execute(useCase: getIt<GetUserUseCase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeEntity?.themeType == ThemeType.dark;
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            color: Colors.black45,
                            Icons.person_outline,
                          ),
                        ),
                        SizedBox(width: 10),

                        BlocBuilder<UserStateCubit, UserState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is UserLoaded) {
                              final user = state.user;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              );
                            } else if (state is UserError) {
                              return Center(
                                child: Text(
                                  "Error: ${state.message}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, cartState) {
                            int count = 0;
                            if (cartState is CartLoaded) {
                              count = cartState.count;
                            }

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartWidget(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Center(
                                      child: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    if (count > 0)
                                      Positioned(
                                        top: -2,
                                        right: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 16,
                                            minHeight: 16,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "$count",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () =>
                              context.read<ThemeBloc>().add(ToggleThemeEvent()),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              color: Colors.black45,
                              isDark
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SearchBarWithFilter(
                  controller: TextEditingController(),
                  onFilterTap: () {
                    print("Filter button tapped");
                  },
                  onSearchChanged: (query) {
                    print("Search query: $query");
                  },
                ),
                SizedBox(height: 20),
                PromoSlider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories", style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllCategoriesWidget(),
                          ),
                        );
                      },
                      child: Text("see all"),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                CategoryHorizontalListWidget(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Featured Products", style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllCategoriesWidget(),
                          ),
                        );
                      },
                      child: Text("see all"),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                FeaturedProductsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
