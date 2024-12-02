import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' show Get, Inst;

import 'view_list.dart'
    show
        AppBar,
        AppColors,
        BuildContext,
        Colors,
        Column,
        Container,
        EdgeInsets,
        FontWeight,
        Get,
        Icons,
        ProfileController,
        Scaffold,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        TextStyle,
        Widget,
        buildRoundButton,
        buildTextField,
        heightSpaceBox,
        TextLine;

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // checkInternetAndShowPopup();
    final data = Get.find<ProfileController>();
    data.reasonController.clear();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Delete Account",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: data.formKey,
            child: Column(
              children: [
                heightSpaceBox(size: 10),
                TextLine(
                  title:
                      "We're sorry to see you go. Once your account is deleted, all of your content will be permanently gone, including your profile, stories, publications, notes, and responses. Deleting your Medium account will not delete any Stripe account you have connected to your Medium account. If you're not sure about that, we suggest you deactivate or contact khamgaon.workmanagerapp.in instead.",
                  fontSize: 12,
                  lines: 10,
                ),
                TextLine(
                  title: "*_why_you_are_delete_your_account_please_reason",
                  fontSize: 12,
                  isBold: true,
                ),
                heightSpaceBox(size: 10),
                buildTextField(
                    controller: data.reasonController,
                    requiredText: 'Enter the reason',
                    label: 'Reason*',
                    icon: Icons.list)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: buildRoundButton(
            width: 700,
            height: 50,
            title: "submit",
            onPressed: () {
              if (data.formKey.currentState!.validate()) {
                data.deleteAccountApi();
              }
            },
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.white),
      ),
    );
  }
}
