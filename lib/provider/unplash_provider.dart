import 'package:flutter/foundation.dart';
import 'package:wallpapper_app/services/api_services.dart';

class CollectionsProvider with ChangeNotifier {
  final UnplashApiService _apiService = UnplashApiService();
  List<Map<String, dynamic>> _collections = [];
  bool _isLoading = false;
  int _page = 1;
  bool _hasError = false;
  String _errorMessage = '';

  List<Map<String, dynamic>> get collections => _collections;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> loadCollections() async {
    if (_isLoading) return;

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final newImages = await _apiService.fetchPhotos(page: _page);

      _collections.addAll(List<Map<String, dynamic>>.from(newImages));
      _page++;
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to load images. Please try again.';
      print('Error loading collections: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCollections() async {
    _collections = [];
    _page = 1;
    _hasError = false;
    await loadCollections();
  }
}
