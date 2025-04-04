import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:kwik/models/product_model.dart';
import 'package:kwik/widgets/produc_model_1.dart';
import 'package:kwik/widgets/shimmer/category_model_9_shimmer.dart';
import 'package:kwik/widgets/shimmer/product_model1_list.dart';
import '../../../bloc/home_page_bloc/category_model_9_bloc/category_model_9_bloc.dart';
import '../../../bloc/home_page_bloc/category_model_9_bloc/category_model_9_event.dart';
import '../../../bloc/home_page_bloc/category_model_9_bloc/category_model_9_state.dart';
import '../../../constants/colors.dart';
import '../../../repositories/category_model9_repo.dart';

class CategoryModel9 extends StatelessWidget {
  final String categoryId;
  final String bgcolor;
  final String titleColor;
  final String subcatColor;
  final String title;
  final List<String> maincategories;
  final String offerTextcolor;
  final String offerBGcolor;
  final String productBgColor;
  final String mrpColor;
  final String sellingPriceColor;
  final String buttontextcolor;
  final String unitbgcolor;
  final String unitTextcolor;
  final String seeAllButtonBG;
  final String seeAllButtontext;
  final bool showcategory;

  const CategoryModel9({
    super.key,
    required this.categoryId,
    required this.bgcolor,
    required this.titleColor,
    required this.subcatColor,
    required this.title,
    required this.maincategories,
    required this.offerBGcolor,
    required this.productBgColor,
    required this.mrpColor,
    required this.sellingPriceColor,
    required this.offerTextcolor,
    required this.seeAllButtonBG,
    required this.seeAllButtontext,
    required this.buttontextcolor,
    required this.unitbgcolor,
    required this.unitTextcolor,
    required this.showcategory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return showcategory
        ? BlocProvider(
            create: (_) =>
                CategoryBloc9(categoryRepository: Categorymodel9Repository())
                  ..add(FetchCategoryAndProductsEvent(
                    subCategoryIds:
                        maincategories, // Dispatch event to fetch category and products
                  )),
            child: Container(
              color: parseColor(bgcolor),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: parseColor(titleColor),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<CategoryBloc9, CategoryModel9State>(
                    builder: (context, state) {
                      if (state is SubCategoriesLoading) {
                        return const Center(child: CategoryModel9Shimmer());
                      } else if (state is CategoryErrorState) {
                        return Center(child: Text(state.message));
                      } else if (state is CategoryLoadedState) {
                        return Column(
                          children: [
                            state.products.isNotEmpty
                                ? StaggeredGrid.count(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 25,
                                    crossAxisSpacing: 25,
                                    children: List.generate(
                                        state.products.length <= 6
                                            ? state.products.length
                                            : 6, (index) {
                                      return StaggeredGridTile.extent(
                                        crossAxisCellCount: 1,
                                        mainAxisExtent: 252,
                                        child: InkWell(
                                          onTap: () => context.push(
                                            '/productdetails',
                                            extra: {
                                              'product': state.products[index],
                                              'subcategoryref':
                                                  maincategories.first,
                                            },
                                          ),
                                          child: productItem(
                                              // bgcolor: "FFFFFF",
                                              product: state.products[index],
                                              mrpColor: mrpColor,
                                              price: 85,
                                              offertextcolor: offerTextcolor,
                                              productcolor: productBgColor,
                                              sellingpricecolor:
                                                  sellingPriceColor,
                                              buttontextcolor: buttontextcolor,
                                              offerBGcolor: offerBGcolor,
                                              productBgColor: productBgColor,
                                              sellingPriceColor:
                                                  sellingPriceColor,
                                              unitTextcolor: unitTextcolor,
                                              unitbgcolor: unitbgcolor,
                                              seeAllButtonBG: seeAllButtonBG,
                                              seeAllButtontext:
                                                  seeAllButtontext,
                                              theme: theme),
                                        ),
                                      );
                                    }),
                                  )
                                : const SizedBox(
                                    child: Text("No data"),
                                  ),
                          ],
                        );
                      }
                      return const Center(child: Text('No Data Available'));
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => context.push(
                        "/allsubcategorypage?categoryId=$categoryId&selectedsubcategory=${maincategories.first}"),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: parseColor(seeAllButtonBG)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('See all products',
                                  style: TextStyle(
                                      color: parseColor(seeAllButtontext),
                                      fontSize: 18)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 14.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: parseColor("00AE11"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

Widget productItem({
  required ProductModel product,
  required double price,
  required String productcolor,
  required String sellingpricecolor,
  required String mrpColor,
  required String offertextcolor,
  required String offerBGcolor,
  required String productBgColor,
  required String sellingPriceColor,
  required String buttontextcolor,
  required String unitbgcolor,
  required String unitTextcolor,
  required String seeAllButtonBG,
  required String seeAllButtontext,
  required ThemeData theme,
}) {
  return SizedBox(
    child: Stack(
      clipBehavior: Clip.none, // Allows elements to overflow
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: const Color.fromARGB(255, 233, 255, 234),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: parseColor(productcolor),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.productImages[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: parseColor(unitbgcolor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "100 g",
                          style: TextStyle(
                              fontSize: 12, color: parseColor(unitTextcolor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  product.productName,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                  child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 15,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 15,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 15,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 15,
                  ),
                  Icon(
                    Icons.star_outline_rounded,
                    color: Colors.amber,
                    size: 15,
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  Text("₹ 137",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: parseColor(sellingpricecolor))),
                  Text("₹ 137",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: parseColor(mrpColor)))
                ],
              )
            ],
          ),
        ),
        ClipPath(
          clipper: ZigZagClipper(),
          child: Container(
            width: 40,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "30%",
                  style: theme.textTheme.bodyMedium!.copyWith(
                      color: parseColor("233D4D"),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "OFF",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: parseColor("233D4D"),
                    fontFamily: "Inter",
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 95,
          right: -10,
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: (parseColor(seeAllButtonBG)),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: parseColor(buttontextcolor)),
            ),
            child: Center(
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: parseColor(seeAllButtontext),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
