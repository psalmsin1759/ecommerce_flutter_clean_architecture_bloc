import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state_cubit.dart';
import 'package:julybyoma_app/features/category/presentation/pages/all_categories_widget.dart';
import 'package:julybyoma_app/features/category/presentation/widgets/category_horizontal_list.dart';
import 'package:julybyoma_app/features/home/widget/promo_slider.dart';
import 'package:julybyoma_app/features/home/widget/search_widget.dart';
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
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(color: Colors.black, Icons.person_outline),
              ),
              SizedBox(width: 10),

              BlocBuilder<UserStateCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
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
              Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }
}
