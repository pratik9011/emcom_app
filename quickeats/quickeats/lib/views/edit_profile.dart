import 'package:get/get.dart' show Get, Inst, Obx, RxBoolExt, RxStringExt;
import 'package:image_cropper/image_cropper.dart';
import 'view_list.dart'
    show AppBar, AppColors, BuildContext, Center, CircleAvatar, Colors, Column, Container, EdgeInsets, File, FontWeight, GestureDetector, Get, Icon, Icons, Image, ImagePicker, ImageSource, NetworkImage, Padding, PopScope, Positioned, ProfileController, Scaffold, SingleChildScrollView, SizedBox, Stack, StatelessWidget, Text, TextFieldSkeleton, TextStyle, Widget, buildRoundButton, buildTextField;

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // checkInternetAndShowPopup();
    final data = Get.find<ProfileController>();
    data.imagePath.value = "";
    data.getProfileApi();
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        data.getProfileApi();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text("Edit Profile",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: <Widget>[
                      Obx(
                            () =>
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: data.imagePath.isNotEmpty
                                  ? Image
                                  .file(File(data.imagePath.value))
                                  .image
                                  : NetworkImage(data.data['profile_image']),
                            ),
                      ),
                      Positioned(
                        right: 1,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              final croppedFile = await ImageCropper()
                                  .cropImage(
                                  sourcePath: pickedFile.path,
                                  maxHeight: 300,
                                  maxWidth: 300,
                                  aspectRatio:
                                  const CropAspectRatio(ratioX: 1, ratioY: 1),
                                  uiSettings: [
                                    AndroidUiSettings(
                                      toolbarTitle: 'Cropper',
                                      toolbarColor: AppColors.buttonColor,
                                      toolbarWidgetColor: Colors.white,

                                    )
                                  ]);
                              data.imagePath.value = croppedFile!.path;
                            }
                          },
                          child: const CircleAvatar(
                            foregroundColor: Colors.white,
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit_outlined,
                              color:
                              AppColors.buttonColor, // Use your button color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Profile Photo",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() =>
                data.isLoading.isTrue
                    ? const SizedBox(height: 50, child: TextFieldSkeleton())
                    : buildTextField(
                    controller: data.nameController,
                    label: "Enter Name*",
                    icon: Icons.person_2_outlined)),
                const SizedBox(height: 10),
                Obx(
                      () =>
                  data.isLoading.isTrue
                      ? const SizedBox(height: 50, child: TextFieldSkeleton())
                      : buildTextField(
                      controller: data.emailController,
                      label: "Email",
                      isEnable: false,
                      icon: Icons.mail_outline,
                      hint: "xyz@gmail.com"),
                ),

                const SizedBox(height: 10),
                Obx(
                      () =>
                  data.isLoading.isTrue
                      ? const SizedBox(height: 50, child: TextFieldSkeleton())
                      : buildTextField(
                      controller: data.mobileNoController,
                      label: "Phone",
                      isEnable: false,
                      icon: Icons.call_outlined,
                      hint: "+91 1234567890"),
                ),

                const SizedBox(height: 50), // Adjust as needed
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
                  () =>
                  buildRoundButton(
                      width: 720,
                      height: 50,
                      title: "Save",
                      isLoading: data.isButton.value,
                      onPressed: () => data.updateProfile(),
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}

