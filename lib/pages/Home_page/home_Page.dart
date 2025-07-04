// ignore_for_file: use_build_context_synchronously, use_full_hex_values_for_flutter_colors, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:kwik/bloc/Address_bloc/Address_bloc.dart';
import 'package:kwik/bloc/Address_bloc/address_event.dart';
import 'package:kwik/bloc/Address_bloc/address_state.dart';
import 'package:kwik/bloc/Cart_bloc/cart_bloc.dart';
import 'package:kwik/bloc/Cart_bloc/cart_event.dart';
import 'package:kwik/bloc/Search_bloc/Search_bloc.dart';
import 'package:kwik/bloc/Search_bloc/search_event.dart';
import 'package:kwik/bloc/all_sub_category_bloc/all_sub_category_bloc.dart';
import 'package:kwik/bloc/all_sub_category_bloc/all_sub_category_event.dart';
import 'package:kwik/bloc/force_update_bloc/force_update_bloc.dart'
    show UpdateBloc;
import 'package:kwik/bloc/force_update_bloc/force_update_event.dart';
import 'package:kwik/bloc/force_update_bloc/force_update_state.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_13_bloc/category_model_13_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_13_bloc/category_model_13_event.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_16_bloc/category_model_16_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_16_bloc/category_model_16_event.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_18_bloc/category_model_18_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_18_bloc/category_model_18_event.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_19_bloc/category_model_19_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_19_bloc/category_model_19_event.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_1_bloc/category_model1_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_2_bloc/category_model2_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_12_bloc/category_model_12_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_4_bloc/category_model_4_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_5__Bloc/category_model5__bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_5__Bloc/category_model5__event.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_6_bloc/category_model_6_bloc.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_6_bloc/category_model_6_event.dart';
import 'package:kwik/bloc/home_page_bloc/category_model_9_bloc/category_model_9_bloc.dart';
import 'package:kwik/bloc/home_Ui_bloc/home_Ui_Bloc.dart';
import 'package:kwik/bloc/home_Ui_bloc/home_Ui_Event.dart';
import 'package:kwik/bloc/home_Ui_bloc/home_Ui_State.dart';
import 'package:kwik/bloc/navbar_bloc/navbar_bloc.dart';
import 'package:kwik/bloc/product_details_page/recommended_products_bloc/recommended_products_bloc.dart';
import 'package:kwik/bloc/product_details_page/recommended_products_bloc/recommended_products_event.dart';
import 'package:kwik/bloc/product_details_page/similerproduct_bloc/similar_product_bloc.dart';
import 'package:kwik/bloc/product_details_page/similerproduct_bloc/similar_product_event.dart';
import 'package:kwik/constants/colors.dart';
import 'package:kwik/constants/network_check.dart';
import 'package:kwik/models/order_model.dart' as locationmode;
import 'package:kwik/pages/Address_management/location_search_page.dart';
import 'package:kwik/pages/Error_pages/network_error_page.dart';
import 'package:kwik/pages/Force%20Update%20page/force_update.dart';
import 'package:kwik/pages/Home_page/widgets/banner_model.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_10.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_12.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_14.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_15.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_16.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_17.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_18.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_19.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_2.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_3.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_4.dart';
import 'package:kwik/pages/Home_page/widgets/category_model_9.dart';
import 'package:kwik/pages/Home_page/widgets/descriptive_widget.dart';
import 'package:kwik/pages/No_service_page/no_service_page.dart';
import 'package:kwik/pages/No_service_page/under_maintanance_screen.dart';
import 'package:kwik/widgets/location_permission_bottom_sheet.dart';
import 'package:kwik/widgets/navbar/navbar.dart';
import 'package:kwik/widgets/shimmer/category_landing_shimmer.dart';
import 'package:kwik/widgets/shimmer/main_loading_indicator.dart';
import 'package:kwik/widgets/shimmer/shimmer1.dart';
import 'package:kwik/widgets/soft_update_popup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart'
    show
        Permission,
        PermissionActions,
        PermissionStatusGetters,
        openAppSettings;
import '../../bloc/home_page_bloc/category_model_1_bloc/category_model1_event.dart';
import '../../bloc/home_page_bloc/category_model_2_bloc/category_model2_event.dart';
import '../../bloc/home_page_bloc/category_model_10_bloc/category_model_10_bloc.dart';
import '../../bloc/home_page_bloc/category_model_10_bloc/category_model_10_event.dart';
import '../../bloc/home_page_bloc/category_model_12_bloc/category_model_12_event.dart';
import '../../bloc/home_page_bloc/category_model_4_bloc/category_model_4_event.dart';
import '../../bloc/home_page_bloc/category_model_7_bloc/category_model_7_bloc.dart';
import '../../bloc/home_page_bloc/category_model_7_bloc/category_model_7_event.dart';
import '../../bloc/home_page_bloc/category_model_9_bloc/category_model_9_event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bloc/navbar_bloc/navbar_event.dart';
import 'widgets/category_model_1.dart';
import 'widgets/category_model_5.dart';
import 'widgets/category_model_6.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<AddressState> _addressSubscription;
  bool _isInitialized = false;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkUtils.checkConnection(context);
    });
    forceupdate();
    getwarehousedata();
    _initializeApp().then((_) {
      {
        context.read<HomeUiBloc>().add(FetchUiDataEvent());
        context.read<CartBloc>().add(
            SyncCartWithServer(userId: FirebaseAuth.instance.currentUser!.uid));
        context.read<AddressBloc>().add(const GetsavedAddressEvent());
      }
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> getwarehousedata() async {
    print("calledddddd");
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission && mounted) {
        await _showLocationPermissionSheet();
        // return; // Don't proceed if permission is not granted
      }
      context.read<AddressBloc>().add(const GetsavedAddressEvent());
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print("print placemark ${placemarks}");
      final postalCode = placemarks.first.postalCode;
      print(postalCode);
      if (postalCode != null) {
        context.read<AddressBloc>().add(GetWarehousedetailsEvent(
              postalCode,
              locationmode.Location(
                lat: position.latitude,
                lang: position.longitude,
              ),
            ));
      } else {
        // Handle case where postal code is not available
        if (mounted) {
          // Optionally show an error or try a different approach
          print("Postal code not found");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initializeApp() async {
    print("Initialize state calledaaa");

    final addressBloc = context.read<AddressBloc>();
    final homeUiBloc = context.read<HomeUiBloc>();
    final cartBloc = context.read<CartBloc>();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null && mounted) {
      GoRouter.of(context).go('/loginPage');
      return;
    }
    final currentState = context.read<AddressBloc>().state;
    print(currentState);
    print(currentState);
    if (currentState is LocationSearchResults &&
        currentState.addresslist.isEmpty) {
      print("1111111111111111111");
      print(currentState.addresslist.length);
      print(currentState.pincode);

      // HapticFeedback.mediumImpact();
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => const LocationSearchPage()),
      // );
    }
    if (_isInitialized) {
      print("Skipped the initial call");
      return;
    }
    _isInitialized = true;

    // Initial data fetch
    homeUiBloc.add(FetchUiDataEvent());
    cartBloc.add(SyncCartWithServer(userId: user!.uid));
    addressBloc.add(const GetsavedAddressEvent());

    // Listen for address-related navigation events ONCE after initial load
    _addressSubscription = addressBloc.stream.take(1).listen((state) {
      if (!mounted) return;
      print("address state");
      print(state);
      if (state is NowarehousefoudState) {
        GoRouter.of(context).go('/no-service');
      } else if (state is LocationSearchResults &&
          state.warehouse?.underMaintenance == true) {
        print("status ${state.warehouse?.underMaintenance}");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              UnderMaintananceScreen(warehouse: state.warehouse!),
        ));
      }
    });

    // Fetch warehouse based on current location if no saved address is available initially
    final addressState = addressBloc.state;
    if (addressState is! LocationSearchResults ||
        addressState.selecteaddress == null) {
      await _checkLocationAndFetchWarehouse();
    }
  }

  forceupdate() async {
    context.read<UpdateBloc>().add(CheckForUpdate(context));
    final updateBloc = BlocProvider.of<UpdateBloc>(context);
    final updateState = updateBloc.state;

    if (updateState is UpdateAvailable) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForceUpdatePage(
            title: updateState.title,
            description: updateState.description,
            downloadUrl: updateState.downloadUrl,
          ),
        ),
      );
    } else {}
  }

  Future<void> _checkLocationAndFetchWarehouse() async {
    print("calledddddd");
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission && mounted) {
        await _showLocationPermissionSheet();
        return; // Don't proceed if permission is not granted
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print("print placemark ${placemarks}");
      final postalCode = placemarks.first.postalCode;
      print(postalCode);
      if (postalCode != null) {
        context.read<AddressBloc>().add(GetWarehousedetailsEvent(
              postalCode,
              locationmode.Location(
                lat: position.latitude,
                lang: position.longitude,
              ),
            ));
      } else {
        // Handle case where postal code is not available
        if (mounted) {
          // Optionally show an error or try a different approach
          print("Postal code not found");
        }
      }
    } catch (e) {
      if (mounted) {
        print("Error fetching location or warehouse: $e");
        // Optionally show an error to the user
      }
    }
  }

  Future<bool> _checkLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) return true;
    if (status.isDenied || status.isLimited || status.isRestricted) {
      final result = await Permission.location.request();
      return result.isGranted;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return false;
  }

  Future<void> _showLocationPermissionSheet() async {
    await showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: const LocationPermissionBottomSheet(),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    context.read<HomeUiBloc>().add(ClearUiCacheEvent());

    // Clear all category caches
    final blocsToClear = [
      BlocProvider.of<CategoryBlocModel1>(context),
      BlocProvider.of<CategoryBlocModel2>(context),
      BlocProvider.of<CategoryModel4Bloc>(context),
      BlocProvider.of<CategoryBloc5>(context),
      BlocProvider.of<CategoryBlocModel6>(context),
      BlocProvider.of<CategoryModel7Bloc>(context),
      BlocProvider.of<CategoryBloc9>(context),
      BlocProvider.of<CategoryModel10Bloc>(context),
      BlocProvider.of<CategoryBloc12>(context),
      BlocProvider.of<CategoryBloc13>(context),
      BlocProvider.of<CategoryBlocModel16>(context),
      BlocProvider.of<CategoryBloc18>(context),
      BlocProvider.of<CategoryBloc19>(context),
      BlocProvider.of<SubcategoryProductBloc>(context),
      BlocProvider.of<SearchBloc>(context),
      BlocProvider.of<RecommendedProductsBloc>(context),
    ];

    for (final bloc in blocsToClear) {
      if (bloc is CategoryBlocModel1)
        bloc.add(ClearCache());
      else if (bloc is CategoryBlocModel2)
        bloc.add(ClearCacheCM2());
      else if (bloc is CategoryModel4Bloc)
        bloc.add(Clearsubcatproduct1Cache());
      else if (bloc is CategoryBloc5)
        bloc.add(ClearCacheEventCM5());
      else if (bloc is CategoryBlocModel6)
        bloc.add(ClearCacheCM6());
      else if (bloc is CategoryModel7Bloc)
        bloc.add(Clearsubcatproduct7Cache());
      else if (bloc is CategoryBloc9)
        bloc.add(ClearCacheEventCM9());
      else if (bloc is CategoryModel10Bloc)
        bloc.add(Clearsubcatproduct10Cache());
      else if (bloc is CategoryBloc12)
        bloc.add(ClearCacheEventCM12());
      else if (bloc is CategoryBloc13)
        bloc.add(ClearCacheEventCM13());
      else if (bloc is CategoryBlocModel16)
        bloc.add(ClearCacheCM16());
      else if (bloc is CategoryBloc18)
        bloc.add(ClearCacheEventCM18());
      else if (bloc is CategoryBloc19)
        bloc.add(ClearCacheEventCM19());
      else if (bloc is SubcategoryProductBloc)
        bloc.add(ClearSimilarCache());
      else if (bloc is SearchBloc)
        bloc.add(ClearCachesearch());
      else if (bloc is RecommendedProductsBloc)
        bloc.add(ClearRecommendedproductCache());
    }
    context.read<AllSubCategoryBloc>().add(const ClearAllCategoryCache());
    context.read<HomeUiBloc>().add(FetchUiDataEvent());
  }

  @override
  void dispose() {
    _addressSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeUiBloc, HomeUiState>(
      builder: (context, homeUiState) {
        final addressState = context.watch<AddressBloc>().state;

        if (homeUiState is UiInitial ||
            homeUiState is UiLoading ||
            addressState is AddressLoading) {
          return const Center(child: MainLoadingIndicator());
        }

        // Show HomePageContent ONLY when both HomeUi is loaded AND warehouse data is available
        if (homeUiState is UiLoaded &&
            addressState is LocationSearchResults &&
            addressState.warehouse != null) {
          return _HomePageContent(
            uiData: homeUiState.uiData,
            searchTerm: homeUiState.searchterm,
            onRefresh: _onRefresh,
          );
        }

        // Navigate and show "No Service" Page
        if (addressState is NowarehousefoudState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/no-service');
          });
          return const SizedBox(); // Return an empty widget,  Navigator is handled.
        }

        //show error
        if (addressState is AddressError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Home Page')),
            body: Center(child: Text('Error: ${addressState.message}')),
          );
        }

        // Handle cases where HomeUi is loaded but warehouse is still loading or not found
        if (homeUiState is UiLoaded &&
            addressState is LocationSearchResults &&
            addressState.warehouse == null) {
          return const NoServicePage();
        }

        // Default case when HomeUi might not be loaded yet or other AddressStates
        return const SizedBox();
      },
    );
  }
}

class _HomePageContent extends StatelessWidget {
  final Map<String, dynamic> uiData;
  final String searchTerm;
  final Future<void> Function() onRefresh;

  const _HomePageContent({
    required this.uiData,
    required this.searchTerm,
    required this.onRefresh,
  });

  List<Map<String, dynamic>> _buildTemplates() {
    final categoryRef =
        List<String>.from(uiData["categorylist"]["category_ref"]);
    final templates = [
      // Banner templates
      {
        'template': BannerModel1(
          titlecolor: uiData["template2"]["title_color"],
          bgColor: uiData["template2"]["background_color"],
          bannerId: 1,
          height: 100,
          horizontalpadding: 10,
          borderradious: 20,
          showbanner: uiData["template2"]["show_Category"],
        ),
        'order': uiData["template2"]["ui_order_number"]
      },
      {
        'template': BannerModel1(
          titlecolor: uiData["template5"]["title_color"],
          bgColor: uiData["template5"]["background_color"],
          bannerId: 3,
          height: 300,
          borderradious: 0,
          showbanner: uiData["template5"]["show_Category"],
        ),
        'order': uiData["template5"]["ui_order_number"]
      },
      {
        'template': BannerModel1(
          titlecolor: uiData["template21"]["title_color"],
          bgColor: uiData["template21"]["background_color"],
          bannerId: 4,
          height: 210,
          viewportFraction: .8,
          verticalpadding: 10,
          borderradious: 20,
          showbanner: uiData["template21"]["show_Category"],
        ),
        'order': uiData["template21"]["ui_order_number"]
      },

      // Home page dynamic widgets in the created order

      {
        'template': CategoryModel1(
          title: uiData["categorylist"]["title"],
          bgColor: uiData["categorylist"]["background_color"],
          categories: categoryRef,
          titlecolor: uiData["categorylist"]["title_color"],
          textcolor: uiData["categorylist"]["subcategory_color"],
          showcategory: uiData["categorylist"]["show_Category"],
        ),
        'order': uiData["categorylist"]["ui_order_number"]
      },

      {
        'template': CategoryModel2(
          categoryId: uiData["template7"]["category_ref"],
          bgcolor: uiData["template7"]["background_color"],
          titleColor: uiData["template7"]["title_color"],
          subcatColor: uiData["template7"]["subcat_color"],
          showcategory: uiData["template7"]["show_Category"],
          title: uiData["template7"]["title"],
        ),
        'order': uiData["template7"]["ui_order_number"]
      },
      {
        'template': CategoryModel3(
          maincategories:
              List<String>.from(uiData["template3"]["main_sub_category"]),
          secondarycategories:
              List<String>.from(uiData["template3"]["secondary_sub_category"]),
          categoryId: uiData["template3"]["category_ref"],
          bgcolor: uiData["template3"]["background_color"],
          titleColor: uiData["template3"]["title_color"],
          subcatColor: uiData["template3"]["subcat_color"],
          showcategory: uiData["template3"]["show_Category"],
          title: uiData["template3"]["title"],
        ),
        'order': uiData["template3"]["ui_order_number"]
      },
      {
        'template': CategoryModel3(
          maincategories:
              List<String>.from(uiData["template4"]["main_sub_category"]),
          secondarycategories:
              List<String>.from(uiData["template4"]["secondary_sub_category"]),
          categoryId: uiData["template4"]["category_ref"],
          bgcolor: uiData["template4"]["background_color"],
          titleColor: uiData["template4"]["title_color"],
          subcatColor: uiData["template4"]["subcat_color"],
          showcategory: uiData["template4"]["show_Category"],
          title: uiData["template4"]["title"],
        ),
        'order': uiData["template4"]["ui_order_number"]
      },

      {
        'template': CategoryModel4(
          categoryref: uiData["template6"]["category_ref"],
          buttonbgcolor: uiData["template6"]["buttonbgcolor"],
          buttontextcolor: uiData["template6"]["buttontextcolor"],
          offerbgcolor: uiData["template6"]["offerbgcolor"],
          offertextcolor: uiData["template6"]["offertextcolor"],
          offertext2: uiData["template6"]["offertext2"],
          offerborder: uiData["template6"]["offerborder"],
          unitcolor: uiData["template6"]["unitcolor"],
          seeAllButtonBG: uiData["template6"]["seeAllButtonBG"],
          seeAllButtontext: uiData["template6"]["seeAllButtontext"],
          mrpColor: uiData["template6"]["mrp_color"],
          sellingpricecolor: uiData["template6"]["selling_price_color"],
          title: uiData["template6"]["title"],
          subtitle: uiData["template6"]["subtitle"],
          subCategoryId: uiData["template6"]["sub_category_ref"],
          bgcolor: uiData["template6"]["background_color"],
          titleColor: uiData["template6"]["title_color"],
          subtitlecolor: uiData["template6"]["title_color"],
          productColor: uiData["template6"]["subcat_color"],
          showcategory: uiData["template6"]["show_Category"],
        ),
        'order': uiData["template6"]["ui_order_number"]
      },

      {
        'template': CategoryModel5(
          producttextcolor: uiData["template8"]["producttextcolor"],
          maincategories:
              List<String>.from(uiData["template8"]["sub_categories"]),
          categoryId: uiData["template8"]["category_ref"],
          bgcolor: uiData["template8"]["background_color"],
          titleColor: uiData["template8"]["title_color"],
          subcatColor: uiData["template8"]["subcat_color"],
          offerBGcolor: uiData["template8"]["offer_bg_color"],
          mrpColor: uiData["template8"]["mrp_color"],
          productBgColor: uiData["template8"]["product_background_color"],
          sellingPriceColor: uiData["template8"]["saleprice_color"],
          categoryName: uiData["template8"]["category_name"],
          brandImage: uiData["template8"]["brand_image"],
          showcategory: uiData["template8"]["show_Category"],
          buttonbgcolor: uiData["template8"]["buttonbgcolor"],
          buttontextcolor: uiData["template8"]["buttontextcolor"],
          indicatercolor: uiData["template8"]["indicatercolor"],
          offertextcolor: uiData["template8"]["offertextcolor"],
          unitcolor: uiData["template8"]["unitcolor"],
          unitbgcolor: uiData["template8"]["unitbgcolor"],
          seeallbuttonbg: uiData["template8"]["seeallbuttonbg"],
          seeallbuttontext: uiData["template8"]["seeallbuttontext"],
        ),
        'order': uiData["template8"]["ui_order_number"]
      },

      {
        'template': CategoryModel6(
          title: uiData["template9"]["title"],
          outerbordercolor: uiData["template9"]["outerbordercolor"],
          subcategories:
              List<String>.from(uiData["template9"]["sub_categories"]),
          bgcolor: uiData["template9"]["background_color"],
          titleColor: uiData["template9"]["title_color"],
          catnamecolor: uiData["template9"]["subcat_color"],
          offertextcolor: uiData["template9"]["offer_text_color"],
          offerbgcolor: uiData["template9"]["offer_bg_color"],
          catnamebgcolor: uiData["template9"]["subcatbg_color"],
          showcategory: uiData["template9"]["show_Category"],
        ),
        'order': uiData["template9"]["ui_order_number"]
      },

      {
        'template': CategoryModel9(
          seeAllButtonBG: uiData["template12"]["seeAllButtonBG"],
          seeAllButtontext: uiData["template12"]["seeAllButtontext"],
          maincategories:
              List<String>.from(uiData["template12"]["maincategories"]),
          categoryId: uiData["template12"]["categoryId"],
          bgcolor: uiData["template12"]["bgcolor"],
          titleColor: uiData["template12"]["titleColor"],
          subcatColor: uiData["template12"]["offerBGcolor"],
          offerBGcolor: uiData["template12"]["offerBGcolor"],
          mrpColor: uiData["template12"]["mrpColor"],
          productBgColor: uiData["template12"]["productBgColor"],
          sellingPriceColor: uiData["template12"]["sellingPriceColor"],
          buttontextcolor: uiData["template12"]["buttontextcolor"],
          buttonbgcolor: uiData["template12"]["button_bgcolor"],
          offerTextcolor: uiData["template12"]["offerTextcolor"],
          title: uiData["template12"]["title"],
          unitTextcolor: uiData["template12"]["unitTextcolor"],
          unitbgcolor: uiData["template12"]["unitbgcolor"],
          showcategory: uiData["template12"]["show_Category"],
        ),
        'order': uiData["template12"]["ui_order_number"]
      },
      {
        'template': CategoryModel10(
          subCatID: uiData["template13"]["category_ref"],
          offerbgcolor: uiData["template13"]["offer_bg_color"],
          offertextcolor: uiData["template13"]["offer_text_color"],
          title: uiData["template13"]["title"],
          titleColor: uiData["template13"]["titleColor"],
          bgcolor: uiData["template13"]["background_color"],
          image: uiData["template13"]["image"],
          cartbuttontextcolor: uiData["template13"]["cartbuttontextcolor"],
          mrpcolor: uiData["template13"]["mrpcolor"],
          crosscolor: uiData["template13"]["crosscolor"],
          prodoductbgcolor: uiData["template13"]["prodoductbgcolor"],
          productTextColor: uiData["template13"]["productTextColor"],
          sellingpricecolor: uiData["template13"]["sellingpricecolor"],
          seeAllButtonBG: uiData["template13"]["seeAllButtonBG"],
          seeAllButtontext: uiData["template13"]["seeAllButtontext"],
          showcategory: uiData["template13"]["show_Category"],
          buttonbgcolor: uiData["template13"]["Button_bg_color"],
          buttontextcolor: uiData["template13"]["button_text_color"],
          unitTextcolor: uiData["template13"]["unitTextcolor"],
          unitbgcolor: uiData["template13"]["unitbgcolor"],
        ),
        'order': uiData["template13"]["ui_order_number"]
      },

      {
        'template': CategoryModel12(
          producttextcolor: uiData["template14"]["producttextcolor"],
          topimage: uiData["template14"]["top_image"],
          seeAllButtonBG: uiData["template14"]["seeAllButtonBG"],
          seeAllButtontext: uiData["template14"]["seeAllButtontext"],
          maincategories:
              List<String>.from(uiData["template14"]["maincategories"]),
          categoryId: uiData["template14"]["category_ref"],
          bgcolor: uiData["template14"]["bgcolor"],
          subcatColor: uiData["template14"]["bgcolor"],
          mrpColor: uiData["template14"]["mrpColor"],
          productBgColor: uiData["template14"]["productBgColor"],
          sellingPriceColor: uiData["template14"]["sellingPriceColor"],
          buttontextcolor: uiData["template14"]["buttontextcolor"],
          buttonbgcolor: uiData["template14"]["btton_bg_color"],
          offerTextcolor: uiData["template14"]["offerTextcolor"],
          offerbgcolor: uiData["template14"]["offerBGcolor"],
          unitTextcolor: uiData["template14"]["unitTextcolor"],
          unitbgcolor: uiData["template14"]["unitbgcolor"],
          showcategory: uiData["template14"]["show_Category"],
        ),
        'order': uiData["template14"]["ui_order_number"]
      },

      {
        'template': CategoryModel14(
          producttextcolor: uiData["template15"]["producttextcolor"],
          maincategories:
              List<String>.from(uiData["template15"]["sub_categories"]),
          categoryId: uiData["template15"]["category_ref"],
          bgcolor: uiData["template15"]["background_color"],
          bgcolor2: uiData["template15"]["bgcolor2"],
          titleColor: uiData["template15"]["titleColor"],
          subcatColor: uiData["template15"]["subcat_color"],
          offerBGcolor: uiData["template15"]["offer_bg_color"],
          mrpColor: uiData["template15"]["mrp_color"],
          productBgColor: uiData["template15"]["product_background_color"],
          sellingPriceColor: uiData["template15"]["saleprice_color"],
          categoryName: uiData["template15"]["category_name"],
          brandImage: uiData["template15"]["brand_image"],
          indicatercolor: uiData["template15"]["indicatercolor"],
          buttonbgcolor: uiData["template15"]["buttonbgcolor"],
          buttontextcolor: uiData["template15"]["buttontextcolor"],
          offertextcolor: uiData["template15"]["offertextcolor"],
          unitbgcolor: uiData["template15"]["unitbgcolor"],
          unitcolor: uiData["template15"]["unit_text_color"],
          subcatbgcolor: uiData["template15"]["subcatbgcolor"],
          seeallbgclr: uiData["template15"]["seeallbgclr"],
          seealltextcolor: uiData["template15"]["seealltextcolor"],
          showcategory: uiData["template15"]["show_Category"],
        ),
        'order': uiData["template15"]["ui_order_number"]
      },
      {
        'template': CategoryModel15(
          topimage: uiData["template16"]["top_image"],
          seeAllButtonBG: uiData["template16"]["seeAllButtonBG"],
          seeAllButtontext: uiData["template16"]["seeAllButtontext"],
          productnamecolor: uiData["template16"]["producttitlecolor"],
          offerbgcolor: uiData["template16"]["offerbgcolor"],
          maincategories:
              List<String>.from(uiData["template16"]["maincategories"]),
          categoryId: uiData["template16"]["category_ref"],
          bgcolor: uiData["template16"]["bgcolor"],
          subcatColor: uiData["template16"]["bgcolor"],
          mrpColor: uiData["template16"]["mrpColor"],
          productBgColor: uiData["template16"]["productBgColor"],
          sellingPriceColor: uiData["template16"]["sellingPriceColor"],
          buttontextcolor: uiData["template16"]["buttontextcolor"],
          buttonbgcolor: uiData["template16"]["buttonbgcolor"],
          offerTextcolor: uiData["template16"]["offerTextcolor"],
          unitTextcolor: uiData["template16"]["unitTextcolor"],
          unitbgcolor: uiData["template16"]["unitbgcolor"],
          showcategory: uiData["template16"]["show_Category"],
        ),
        'order': uiData["template16"]["ui_order_number"]
      },
      {
        'template': CategoryModel16(
          subcategroylist:
              List<String>.from(uiData["template17"]["subcategorylist"]),
          categorybgcolor: uiData["template17"]["categorybgcolor"],
          offerbgcolor: uiData["template17"]["offerbgcolor"],
          offertext1: uiData["template17"]["offertext1"],
          offertext2: uiData["template17"]["offertext2"],
          title: uiData["template17"]["title"],
          categoryId: uiData["template17"]["category"],
          bgcolor: uiData["template17"]["background_color"],
          titleColor: uiData["template17"]["titleColor"],
          subcattitleColor: uiData["template17"]["subcattitleColor"],
          showcategory: uiData["template17"]["show_Category"],
        ),
        'order': uiData["template17"]["ui_order_number"]
      },
      {
        'template': CategoryModel17(
          category: uiData["template18"]["categoryid"],
          categoryId1: uiData["template18"]["categoryId1"],
          categoryId2: uiData["template18"]["categoryId2"],
          categoryId3: uiData["template18"]["categoryId3"],
          image1: uiData["template18"]["image1"],
          image2: uiData["template18"]["image2"],
          image3: uiData["template18"]["image3"],
          title: uiData["template18"]["title"],
          bgcolor: uiData["template18"]["background_color"],
          titleColor: uiData["template18"]["title_color"],
          showcategory: uiData["template18"]["show_Category"],
        ),
        'order': uiData["template18"]["ui_order_number"]
      },
      {
        'template': CategoryModel18(
          maincategories:
              List<String>.from(uiData["template19"]["maincategories"]),
          categoryId: uiData["template19"]["category_ref"],
          bgcolor: uiData["template19"]["background_color"],
          offerBGcolor: uiData["template19"]["offer_bg_color"],
          showcategory: uiData["template19"]["show_Category"],
          bannerimageurl: uiData["template19"]["bannerimageurl"],
          categoryBgColor: uiData["template19"]["categoryBgColor"],
          categorytitlecolor: uiData["template19"]["categorytitlecolor"],
          offertextcolor1: uiData["template19"]["offertextcolor1"],
          offertextcolor2: uiData["template19"]["offertextcolor2"],
          seeallbuttonbgcolor: uiData["template19"]["seeallbuttonbg"],
          seeallbuttontextcolor: uiData["template19"]["seeallbuttontext"],
        ),
        'order': uiData["template19"]["ui_order_number"]
      },
      {
        'template': CategoryModel19(
          producttextcolor: uiData["template20"]["producttextcolor"],
          topimage: uiData["template20"]["topimage"],
          maincategories:
              List<String>.from(uiData["template20"]["sub_categories"]),
          categoryId: uiData["template20"]["category_ref"],
          bgcolor: uiData["template20"]["background_color"],
          subcatColor: uiData["template20"]["subcat_color"],
          offerBGcolor1: uiData["template20"]["offer_bg_color"],
          mrpColor: uiData["template20"]["mrp_color"],
          productBgColor: uiData["template20"]["product_background_color"],
          sellingPriceColor: uiData["template20"]["saleprice_color"],
          showcategory: uiData["template20"]["show_Category"],
          buttonbgcolor: uiData["template20"]["buttonbgcolor"],
          buttontextcolor: uiData["template20"]["buttontextcolor"],
          indicatercolor: uiData["template20"]["indicatercolor"],
          offertextcolor1: uiData["template20"]["offertextcolor"],
          unitcolor: uiData["template20"]["unitcolor"],
          unitbgcolor: uiData["template20"]["unitbgcolor"],
          seeallbgcolorl: uiData["template20"]["seeallbgcolor"],
          seealltextcolor: uiData["template20"]["seealltextcolor"],
          offerBGcolor2: uiData["template20"]["offerBGcolor2"],
          offerBordercolor: uiData["template20"]["offerBordercolor"],
          offertextcolor2: uiData["template20"]["offertextcolor2"],
        ),
        'order': uiData["template20"]["ui_order_number"]
      },
      {
        'template': const DescriptiveWidget(
          title: "Skip the store, we're at your door!",
          logo: "assets/images/kwiklogo.png",
          showcategory: true,
        ),
        'order': "88888"
      },
      // Add all other templates here following the same pattern...
      // This is just a sample, include all your templates
    ];

    templates.sort(
      (a, b) => int.parse(a['order']).compareTo(int.parse(b['order'])),
    );

    return templates;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = parseColor(uiData["template1"]["appbarcolor"]);
    final searchFieldFillColor =
        parseColor(uiData["template1"]["searchfieldfillcolor"]);
    final searchFieldTextColor =
        parseColor(uiData["template1"]["searchfieldtextclr"]);
    final hintText = uiData["template1"]["hinttext"];
    final topText1Bg = parseColor(uiData["template1"]["toptext1bg"]);
    final topText2Color = parseColor(uiData["template1"]["toptext2clr"]);
    final iconColor = parseColor(uiData["template1"]["iconcolor"]);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [.08, .1, .2, .5, .7, 1.0],
          colors: [
            appBarColor,
            appBarColor,
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: InkWell(
            onTap: () {
              context
                  .read<NavbarBloc>()
                  .add(const UpdateNavBarVisibility(true));
            },
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    pinned: false,
                    snap: true,
                    expandedHeight: 93,
                    collapsedHeight: 93,
                    backgroundColor: appBarColor,
                    foregroundColor: appBarColor,
                    flexibleSpace: _AppBarContent(
                      bgcolor: appBarColor,
                      topText1: uiData["template1"]["toptext1"],
                      topText1Bg: topText1Bg,
                      topText2: uiData["template1"]["toptext2"],
                      topText2Color: topText2Color,
                      iconColor: iconColor,
                      toptextclr:
                          parseColor(uiData["template1"]["toptext1clr"]),
                      addresscolor:
                          parseColor(uiData["template1"]["addressclr"]),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 12),
                        child: InkWell(
                          onTap: () => context.push('/profile'),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Image(
                                image:
                                    AssetImage("assets/images/User_fill.png")),
                          ),
                        ),
                      )
                    ],
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: false,
                    delegate: SearchBarDelegate(hintText
                        // hintText: hintText,
                        // searchFieldFillColor: searchFieldFillColor,
                        // searchFieldTextColor: searchFieldTextColor,
                        // searchText: searchTerm == "no" ? null : searchTerm,
                        ),
                  ),
                  ..._buildTemplates().map((template) {
                    return SliverToBoxAdapter(
                      child: template['template'],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const Navbar(),
      ),
    );
  }
}

class _AppBarContent extends StatelessWidget {
  final String topText1;
  final Color bgcolor;
  final Color topText1Bg;
  final String topText2;
  final Color topText2Color;
  final Color iconColor;
  final Color toptextclr;
  final Color addresscolor;

  const _AppBarContent({
    required this.topText1,
    required this.topText1Bg,
    required this.topText2,
    required this.topText2Color,
    required this.iconColor,
    required this.bgcolor,
    required this.toptextclr,
    required this.addresscolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgcolor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const MainLoadingIndicator()),
                );
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NetworkErrorPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: topText1Bg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    topText1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: toptextclr,
                        ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const LocationSearchPage()),
                );
              },
              child: Row(
                children: [
                  Text(topText2,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: topText2Color,
                          )),
                  IconButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LocationSearchPage()),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: iconColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const LocationSearchPage()),
                );
              },
              child: Row(
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/images/addresshome_icon.svg"),
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      if (state is LocationSearchResults) {
                        return Text(
                          "${state.currentlocationaddress.characters.take(35).string}...",
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12,
                                    color: addresscolor,
                                  ),
                        );
                      }
                      return const Shimmer(width: 200, height: 12);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final String searchText;

  SearchBarDelegate(this.searchText);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<HomeUiBloc, HomeUiState>(builder: (context, state) {
      if (state is UiInitial) {
        context.read<HomeUiBloc>().add(FetchUiDataEvent());
        return const Center(child: MainLoadingIndicator());
      } else if (state is UiLoading) {
        return const Center(child: MainLoadingIndicator());
      } else if (state is UiLoaded) {
        final uiData = state.uiData;
        return SafeArea(
          child: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              context.push('/searchpage');
            },
            child: Container(
              height: 80,
              color: parseColor(uiData["template1"]["appbarcolor"]),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color:
                      parseColor(uiData["template1"]["searchfieldfillcolor"]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/search.svg",
                      fit: BoxFit.contain,
                      width: 30,
                      height: 20,
                      color:
                          parseColor(uiData["template1"]["searchfieldtextclr"]),
                    ),
                    const SizedBox(width: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        uiData["template1"]["hinttext"] == "no"
                            ? 'Search "$searchText"'
                            : uiData["template1"]["hinttext"],
                        key: ValueKey(searchText),
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: parseColor(
                                uiData["template1"]["searchfieldtextclr"]),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
