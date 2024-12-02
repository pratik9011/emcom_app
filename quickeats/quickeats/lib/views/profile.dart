import 'package:get/get.dart'
    show Get, GetNavigation, Inst, Obx, RxBoolExt, Trans;
import 'view_list.dart'
    show
        AppBar,
        AppColors,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Card,
        Center,
        CircleAvatar,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        Get,
        Icon,
        IconButton,
        Icons,
        ListTile,
        NetworkImage,
        ProfileController,
        Radius,
        Scaffold,
        SharedPreferences,
        SingleChildScrollView,
        SizeConfig,
        SizedBox,
        StatelessWidget,
        Widget,
        heightSpaceBox,
        showDialogYesNoWithImage,
        TextLine,
        widthSpaceBox;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // checkInternetAndShowPopup();
    final data = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpaceBox(size: 30),
              Center(
                child: Column(
                  children: [
                    Obx(() => data.isLoading.isTrue
                        ? CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.white,
                            backgroundImage:
                                NetworkImage(data.data['profile_image']),
                          )),
                    widthSpaceBox(size: 5),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical = 10,
                    ),
                    Obx(
                      () => data.isLoading.isTrue
                          ? const SizedBox()
                          : TextLine(
                              title: data.data['name'],
                              fontSize: 23,
                              isBold: true,
                              color: AppColors.textColor),
                    ),
                    Obx(
                      () => data.isLoading.isTrue
                          ? const SizedBox()
                          : TextLine(
                              title: data.data['role'],
                              fontSize: 10,
                              isBold: true,
                              color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
              heightSpaceBox(size: 20),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Card(
                  color: AppColors.whiteShade1,
                  child: ListTile(
                    onTap: () => Get.toNamed("profileEdit"),
                    leading: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.buttonColor,
                      size: 30,
                    ),
                    title: const TextLine(
                        title: "Edit Profile",
                        fontSize: 14,
                        isBold: true,
                        color: AppColors.blackShade4),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: IconButton(
                        onPressed: () => Get.toNamed("profileEdit"),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              heightSpaceBox(size: 10),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Card(
                  color: AppColors.whiteShade1,
                  child: ListTile(
                    onTap: () => Get.toNamed("/helpSupport"),
                    leading: const Icon(
                      Icons.contact_support_outlined,
                      color: AppColors.buttonColor,
                      size: 30,
                    ),
                    title: const TextLine(
                        title: "Help_&_Support",
                        fontSize: 14,
                        isBold: true,
                        color: AppColors.blackShade4),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: IconButton(
                        onPressed: () => Get.toNamed("/helpSupport"),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              heightSpaceBox(size: 10),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Card(
                  color: AppColors.whiteShade1,
                  child: ListTile(
                    onTap: () => Get.toNamed("/deleteAccount"),
                    leading: const Icon(
                      Icons.delete_outline_outlined,
                      color: AppColors.buttonColor,
                      size: 30,
                    ),
                    title: const TextLine(
                        title: "delete_account",
                        fontSize: 14,
                        isBold: true,
                        color: AppColors.blackShade4),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: IconButton(
                        onPressed: () => Get.toNamed("/deleteAccount"),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              heightSpaceBox(size: 10),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Card(
                  color: AppColors.whiteShade1,
                  child: ListTile(
                    onTap: () => showDialogYesNoWithImage(
                      title: 'are_you_Sure',
                      btnTitle: 'logout',
                      content: 'are_you_Sure_to_logout',
                      image: 'assets/icon/logout.png',
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        Get.offAllNamed('login');
                      },
                    ),
                    leading: const Icon(
                      Icons.logout,
                      color: AppColors.buttonColor,
                      size: 30,
                    ),
                    title: const TextLine(
                        title: "logout",
                        fontSize: 14,
                        isBold: true,
                        color: AppColors.blackShade4),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: IconButton(
                        onPressed: () => showDialogYesNoWithImage(
                          title: 'are_you_Sure',
                          btnTitle: 'logout',
                          content: 'are_you_Sure_to_logout',
                          image: 'assets/images/logout.png',
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            Get.offAllNamed('login');
                          },
                        ),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
