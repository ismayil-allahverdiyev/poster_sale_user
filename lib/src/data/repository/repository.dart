import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../src/ui/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/local_storage.dart';
import '../../controllers/local_storage/local_storage_controller.dart';
import '../../routes/app_routes.dart';

class Repository {
  final FirebaseFirestore firestore;

  Repository({required this.firestore});
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '',
    'Accept-Language': '',
    'Cookie':
        '.AspNetCore.Identity.Application=CfDJ8IgJzIx6tadPvRZU0EAJrBPmj00xbgraQJs86mdXTFbbP0hEKlGCxvjeRbtmRzNsgfdRl1130EXCP13T6meSRhXHfi7k7xz_OxY4HW6I6LFByScJ0etGd7JQvVv6VVzGAO0gx6-B_BBZcwpZKkm26qno2kMzsxz-DoNsOPKR5L2esiUkENaipC3Pf8FUqQvwXuakDsXBOvJe_vsfXPPhW4pWCaB3GA1m0cuoHiT28NPH4oj1MJeMQwnkzvznlYcVOb3eW-_M6yEmQT5X0uIAeqJ0KaTW-onaMsUoAVwUNDYp_RnwLjtytt9rKREQD9L8c3I96v4gv7Z_1LJ9nU8ePAwbjoUqwO6q36PQVNRKddbAKM6RIdPcwjIQGkCReT-udP6WorddqFAjr8GoaCDVukP3JH1SyZ4wFI66iWNd6lTFCcmZ5mdZ-HZweCMmQqbwRx8LG7d4oKk-AA8zPJ1bCTZVCVILgiiM7_N3JHIkN5ozNPlTp9ugr8hA3tA___QoXBoReKriiS7BlovG-6joXKICVG9EiTOjRAx_AwEoBnBHgQDp-CGPaPcHfJkKVGUI1R0IPSpaxT7QfV5J2aW7JXfMWwxS2Rt5L1gG-tL2gUxC5Pt5NrVzUZ0ETulIktI6mnZCoeprXoBOKcC-LOk21n26jRmfGd5v7fLpTOvrUjWpKjQoLVYmckt-cDmLe-5xmzKsiOmnjeURcIsd390uiYEXCO2863OjBiGuN3uW14-tHi7wWOHgmLFOd_Ni_T0dGNGrEiy2FeBxrNwoN1JAFXU3r0YCaiKKzgGwBP6fCSAHv_kiPMUA4Fqr2mUjPnr_EnIjL0DlzRFLQ_--VdsL5zJBZhBm1tuEDH82IfWRaHdMYWfNsXuBjMWiPc-qa_vHzOlztTGpH-W_cQhvDBAJP3k'
  };

  var refreshToken = "";
  var authorization = "";

  getHeaders() {
    LocalStorageController localStorageController = Get.put(
        LocalStorageController(
            repository: Repository(firestore: FirebaseFirestore.instance)));
    headers['Authorization'] = "Bearer " +
        localStorageController.getStringFromLocal(LocalStorageConst.jwtToken);
    // var language = localStorageController
    //             .getStringFromLocal(LocalStorageConst.language) ==
    //         ""
    //     ? "en-US"
    //     : localStorageController.getStringFromLocal(LocalStorageConst.language);
    // headers['Accept-Language'] = language;
    return headers;
  }

  String? getUserId() {
    var localStorageController = Get.find<LocalStorageController>();
    var token =
        localStorageController.getStringFromLocal(LocalStorageConst.jwtToken);

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return decodedToken["user_id"];
  }

  Future<XFile?> getImage({required int index}) async {
    final ImagePicker picker = ImagePicker();
    var status1 = await Permission.photos.status;
    var status2 = await Permission.camera.status;
    var status3 = await Permission.storage.status;

    if (status1.isDenied) {
      await Permission.photos.request();
    } else if (status2.isDenied) {
      await Permission.camera.request();
    } else if (status3.isDenied) {
      await Permission.storage.request();
    }
    return await picker.pickImage(
      source: index == 0 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.rear,
    );
  }

  // Sign Out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    var localStorageController = Get.find<LocalStorageController>();

    localStorageController.removeFromLocal(LocalStorageConst.jwtToken);
    localStorageController.removeFromLocal(LocalStorageConst.startPage);

    Get.offAllNamed(Routes.SIGNUPOVERVIEW);
  }

  getNotificationToken() async {
    return (await FirebaseMessaging.instance.getToken()).toString();
  }

  Future<List<Map<String, dynamic>>> getData({
    required String collection,
    String? documentId,
    String? innerCollection, // Optional for nested collections
    Map<String, String>? searchCriteria, // Map of fields and search texts
    String? orderField, // Field to order by
    bool isOrderDescendant = true, // Order by descending or ascending
  }) async {
    try {
      CollectionReference collectionRef = firestore.collection(collection);

      // If a specific documentId is provided, fetch that document
      if (documentId != null) {
        if (innerCollection != null) {
          // Fetch from a nested collection
          collectionRef =
              collectionRef.doc(documentId).collection(innerCollection);
          QuerySnapshot querySnapshot = await collectionRef.get();

          return querySnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              ...data,
              'id': doc.id,
            };
          }).toList();
        } else {
          DocumentSnapshot docSnapshot =
              await collectionRef.doc(documentId).get();
          if (docSnapshot.exists) {
            return [
              {
                ...(docSnapshot.data() as Map<String, dynamic>),
                'id': docSnapshot.id,
              }
            ];
          } else {
            throw Exception("Document not found");
          }
        }
      }

      // If no search criteria are provided, fetch all documents
      if (searchCriteria == null || searchCriteria.isEmpty) {
        QuerySnapshot querySnapshot;
        if (orderField != null) {
          querySnapshot = await collectionRef
              .orderBy(orderField, descending: isOrderDescendant)
              .get();
        } else {
          querySnapshot = await collectionRef.get();
        }

        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            ...data,
            'id': doc.id,
          };
        }).toList();
      }

      // Perform multi-field search
      List<Map<String, dynamic>> results = [];
      List<Map<String, dynamic>> secondRound = [];
      bool hadFields = false;
      for (var entry in searchCriteria.entries) {
        List<String> fields = entry.key.split(" ");
        String field = fields[0];
        String text = entry.value;

        if (fields.length > 1 && fields[1] == "true") {
          // Adds second layer of search
          secondRound.add({
            "field": entry.key,
            "text": text,
          });

          continue;
        }

        QuerySnapshot querySnapshot = await collectionRef
            .orderBy(field)
            .startAt([text]).endAt(['$text\uf8ff']).get();

        results.addAll(querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            ...data,
            'id': doc.id,
          };
        }));

        hadFields = true;
      }

      if (secondRound.isNotEmpty) {
        for (var entry in secondRound) {
          List<String> fields = entry['field'].split(" ");
          String field = fields[0];
          String text = entry['text'];

          if (text == "" && results.isEmpty && !hadFields) {
            QuerySnapshot querySnapshot = await collectionRef.get();
            results = querySnapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                ...data,
                'id': doc.id,
              };
            }).toList();
          }

          results = results.where((element) {
            if (element[field]
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())) {
              return true;
            }
            return false;
          }).toList();
        }
      }

      // Remove duplicates (if any)
      return results.toSet().toList();
    } catch (error) {
      errorHandler(
        title: "Encountered a problem",
        message: error.toString(),
      );
      return [];
    }
  }

  Future<void> liveFetchData({
    required String collection,
    String? documentId,
    String secondCollectionName =
        'list', // Default to 'list' for nested collections
    required Function(List<Map<String, dynamic>>) onUpdate,
    String? sortByField, // Field to sort by
    bool isDescending = false, // Whether to sort in descending order
  }) async {
    try {
      CollectionReference collectionRef;

      if (documentId == null) {
        // Listen to the entire collection
        collectionRef = FirebaseFirestore.instance.collection(collection);
      } else {
        // Listen to the nested collection under a specific document
        collectionRef = FirebaseFirestore.instance
            .collection(collection)
            .doc(documentId)
            .collection(
                secondCollectionName); // Use the provided second collection name
      }

      // Listen to changes in the collection in real-time
      collectionRef.snapshots().listen((QuerySnapshot snapshot) {
        List<Map<String, dynamic>> results = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            ...data,
            'id': doc.id,
          };
        }).toList();

        // If a sorting field is provided, sort the results
        if (sortByField != null) {
          results.sort((a, b) {
            // Check if the field exists in the document data
            if (a[sortByField] is Comparable && b[sortByField] is Comparable) {
              final comparisonResult = (a[sortByField] as Comparable)
                  .compareTo(b[sortByField] as Comparable);
              return isDescending ? -comparisonResult : comparisonResult;
            }
            return 0; // If the field doesn't exist or is not comparable, leave as is
          });
        }

        // Call the provided callback with the updated data
        onUpdate(results);
      });
    } catch (error) {
      errorHandler(
        title: "Encountered a problem",
        message: error.toString(),
      );
    }
  }

  Future<String?> postData({
    required String collection,
    String? documentId, // Optional to specify a document ID
    String? innerCollection,
    String? innerDocumentId, // Optional for nested document ID
    required Map<String, dynamic> data,
    bool isUpdate = false, // Flag to indicate if it's an update
  }) async {
    try {
      CollectionReference collectionRef = firestore.collection(collection);

      if (documentId != null && innerCollection != null) {
        if (innerDocumentId != null) {
          // Update existing document in subcollection
          DocumentReference subDocRef = collectionRef
              .doc(documentId)
              .collection(innerCollection)
              .doc(innerDocumentId);
          if (isUpdate) {
            await subDocRef.update(data);
          } else {
            await subDocRef.set(data);
          }
          print("Data updated in subcollection with ID: $innerDocumentId");
          return innerDocumentId;
        }
        // Add to subcollection under specific document
        CollectionReference subColRef =
            collectionRef.doc(documentId).collection(innerCollection);

        DocumentReference subDocRef = await subColRef.add(data);
        print("Data posted to subcollection with ID: ${subDocRef.id}");
        return subDocRef.id;
      } else if (documentId != null) {
        if (isUpdate) {
          await collectionRef.doc(documentId).update(data);
        } else {
          await collectionRef.doc(documentId).set(data);
        }
        print("Data posted with custom ID: $documentId");
        return documentId;
      } else {
        DocumentReference docRef = await collectionRef.add(data);
        print("Data posted with generated ID: ${docRef.id}");
        return docRef.id;
      }
    } catch (error) {
      print("Error posting data: $error");
      return null;
    }
  }

  deleteData({
    required String collection,
    required String documentId,
    String? innerCollection, // Optional for nested collections
    String? innerDocumentId, // Optional for nested document ID
  }) async {
    try {
      CollectionReference collectionRef = firestore.collection(collection);

      if (innerCollection != null && innerDocumentId != null) {
        // Delete from a nested collection
        await collectionRef
            .doc(documentId)
            .collection(innerCollection)
            .doc(innerDocumentId)
            .delete();
        print("Nested document deleted: $innerDocumentId");
        return true;
      }

      // Delete the document with the specified ID
      await collectionRef.doc(documentId).delete();

      return true;
    } catch (error) {
      print("Error deleting document: $error");
      return false;
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      // Create a unique file name based on current time and a random number
      String fileName =
          'images/${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}.jpg';

      // Create a reference to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;

      // Reference to the storage location
      Reference storageRef = storage.ref().child(fileName);

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(image);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      // Handle any errors during the upload process
      print('Error uploading image: $e');
      return null;
    }
  }

  selectImage({required bool isFromGallery}) async {
    final ImagePicker picker = ImagePicker();
    var status1 = await Permission.photos.status;
    var status2 = await Permission.camera.status;
    var status3 = await Permission.storage.status;

    if (status1.isDenied) {
      await Permission.photos.request();
    } else if (status2.isDenied) {
      await Permission.camera.request();
    } else if (status3.isDenied) {
      await Permission.storage.request();
    }
    var image = (await picker.pickImage(
      source: isFromGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.rear,
    ));

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<DateTime?> selectDate() async {
    return await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
  }

  errorHandler({required String title, required String message}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      backgroundColor: lightGreyColor,
      colorText: redColor,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
    );
  }

  showMessage({required String title, required String message}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      backgroundColor: greyColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
    );
  }
}
