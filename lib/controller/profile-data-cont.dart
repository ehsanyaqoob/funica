import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

class FillUpProfileController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isSuccess = false.obs;
  DateTime? _selectedDate;
  final Rx<File?> _profileImage = Rx<File?>(null);
  final RxString _userName = ''.obs;
  final RxString _nickname = ''.obs;
  final RxString _email = ''.obs;
  final RxString _phone = ''.obs;
  final RxString _bio = ''.obs;
  final RxString _gender = ''.obs;

  final GetStorage _storage = GetStorage();

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  DateTime? get selectedDate => _selectedDate;
  File? get profileImage => _profileImage.value;
  String get userName => _userName.value;
  String get nickname => _nickname.value;
  String get email => _email.value;
  String get phone => _phone.value;
  String get bio => _bio.value;
  String get gender => _gender.value;

  set selectedDate(DateTime? date) {
    _selectedDate = date;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
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

  /// Submit profile & save in GetStorage
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
        // Save in controller
        _userName.value = fullName;
        _nickname.value = nickname;
        _email.value = email;
        _phone.value = phone;
        _bio.value = bio;
        _gender.value = gender ?? '';
        _selectedDate = dateOfBirth;

        // Save in storage
        await _storage.write('userName', fullName);
        await _storage.write('nickname', nickname);
        await _storage.write('email', email);
        await _storage.write('phone', phone);
        await _storage.write('bio', bio);
        await _storage.write('gender', gender ?? '');
        await _storage.write('dob', dateOfBirth?.toIso8601String() ?? '');
        if (_profileImage.value != null) {
          await _storage.write('profileImage', _profileImage.value!.path);
        }

        _isSuccess.value = true;
        print('Profile saved successfully!');
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

  /// Load saved profile from storage
  void _loadFromStorage() {
    _userName.value = _storage.read('userName') ?? '';
    _nickname.value = _storage.read('nickname') ?? '';
    _email.value = _storage.read('email') ?? '';
    _phone.value = _storage.read('phone') ?? '';
    _bio.value = _storage.read('bio') ?? '';
    _gender.value = _storage.read('gender') ?? '';
    final dobStr = _storage.read('dob') ?? '';
    if (dobStr.isNotEmpty) {
      _selectedDate = DateTime.tryParse(dobStr);
    }
    final imagePath = _storage.read('profileImage') ?? '';
    if (imagePath.isNotEmpty) {
      _profileImage.value = File(imagePath);
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
    _userName.value = '';
    _nickname.value = '';
    _email.value = '';
    _phone.value = '';
    _bio.value = '';
    _gender.value = '';
    _storage.erase();
    update();
  }

  @override
  void onClose() {
    _isLoading.close();
    _errorMessage.close();
    _isSuccess.close();
    _userName.close();
    _nickname.close();
    _email.close();
    _phone.close();
    _bio.close();
    _gender.close();
    _profileImage.close();
    super.onClose();
  }
}
