import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FillUpProfileController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isSuccess = false.obs;
  DateTime? _selectedDate;

  final Rx<File?> _profileImage = Rx<File?>(null);

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  DateTime? get selectedDate => _selectedDate;
  File? get profileImage => _profileImage.value;

  set selectedDate(DateTime? date) {
    _selectedDate = date;
    update();
  }

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _profileImage.value = File(picked.path);
      update();
    }
  }

  /// Capture image from camera
  Future<void> pickFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      _profileImage.value = File(picked.path);
      update();
    }
  }

  /// Remove image
  void removeImage() {
    _profileImage.value = null;
    update();
  }

  Future<void> submitProfile({
    required String fullName,
    required String nickname,
    required String email,
    required String phone,
    required String bio,
    required String? gender,
    required DateTime? dateOfBirth,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;
    update();

    try {
      await Future.delayed(const Duration(seconds: 2));
      final randomSuccess = Random().nextBool();

      if (randomSuccess) {
        _isSuccess.value = true;
        print('Profile saved: $fullName, $email, $phone, image: ${_profileImage.value}');
      } else {
        throw Exception('Failed to save profile. Please try again.');
      }
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void clearError() {
    _errorMessage.value = '';
    update();
  }

  void reset() {
    _isLoading.value = false;
    _errorMessage.value = '';
    _isSuccess.value = false;
    _selectedDate = null;
    _profileImage.value = null;
    update();
  }

  @override
  void onClose() {
    _isLoading.close();
    _errorMessage.close();
    _isSuccess.close();
    super.onClose();
  }
}
