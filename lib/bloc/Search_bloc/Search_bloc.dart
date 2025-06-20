import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:kwik/bloc/Search_bloc/search_event.dart';
import 'package:kwik/bloc/Search_bloc/search_state.dart';
import 'package:kwik/models/product_model.dart';
import 'package:kwik/repositories/search_repo.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo repository;
  final Box box = Hive.box('search_productCache');
  final Box searchHistoryBox = Hive.box('search_history');

  SearchBloc({required this.repository}) : super(ProductInitial()) {
    on<Clearsearchhistory>((event, emit) async {
      repository.clearsearch();

      if (state is SearchresultProductLoaded) {
        final currentState = state as SearchresultProductLoaded;
        emit(SearchresultProductLoaded(
          products: currentState.products,
          searchHistory: [],
        ));
      } else if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(
          products: currentState.products,
          searchHistory: [],
        ));
      }
    });

    on<SearchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await repository.searchProducts(
            event.query, event.userId, event.isSearch);

        // Parse the products
        final products = (response['products'] as List)
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();

        // Get search history if available
        final searchHistory =
            (response['searchHistory'] as List?)?.cast<String>() ?? [];

        emit(SearchresultProductLoaded(
          products: products, // Send the actual products, not empty list
          searchHistory: searchHistory,
        ));
      } catch (e) {
        print("Error in SearchProducts event: $e");
        emit(ProductError());
      }
    });

    on<LoadInitialProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        List<String> searchHistory = [];
        bool needToFetchFromApi = false;

        // Load search history from Hive
        final storedHistory = searchHistoryBox.get('history');
        if (storedHistory != null && storedHistory is List) {
          // searchHistory = storedHistory.cast<String>();
          needToFetchFromApi = true;
        } else {
          needToFetchFromApi = true;
        }

        // Load product cache from Hive
        List<ProductModel> cachedProducts = [];
        if (box.containsKey('initialProducts')) {
          // cachedProducts = (jsonDecode(box.get('initialProducts')) as List)
          //     .map((data) => ProductModel.fromJson(data))
          //     .toList();
          needToFetchFromApi = true;
        } else {
          needToFetchFromApi = true;
        }

        if (needToFetchFromApi) {
          final products = await repository.getInitialProducts();
          final apiProducts = products["products"] as List<ProductModel>;
          final apiSearchHistory = List<String>.from(products["searchHistory"]);

          // // Cache both
          // await box.put('initialProducts',
          //     jsonEncode(apiProducts.map((p) => p.toJson()).toList()));
          // await searchHistoryBox.put('history', apiSearchHistory);

          emit(ProductLoaded(
              products: apiProducts, searchHistory: apiSearchHistory));
        } else {
          emit(ProductLoaded(
              products: cachedProducts, searchHistory: searchHistory));
        }
      } catch (_) {
        emit(ProductError());
      }
    });

    on<ClearCachesearch>((event, emit) async {
      await box.delete('search_productCache');
      await searchHistoryBox.delete('history');
      emit(ProductInitial());
    });
  }
}
