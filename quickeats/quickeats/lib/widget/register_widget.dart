import 'package:get/get.dart';

import 'widgetList.dart';
class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key,this.testMood=false});
  final bool testMood;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final controller = Get.put(AuthController());
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.name,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey),
              ),
              fillColor: Colors.white,
              labelText: translate(AppStrings.enterName),
              labelStyle: const TextStyle(
                color: AppColors.textColor,
              ),
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextFormField(
            controller: controller.email,
            validator: (value) {
              if (value!.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return translate(AppStrings.emailValidation);
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey),
              ),
              fillColor: Colors.white,
              labelText: translate(AppStrings.enterEmail),
              labelStyle: const TextStyle(
                color: AppColors.textColor,
              ),
              prefixIcon: const Icon(Icons.email,
                  color: AppColors.textColor),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          buildRoundButton(
              width: 700,
              height: 50,
              backgroundColor: AppColors.buttonColor,
              isBold: true,
              foregroundColor: AppColors.white,
              title: AppStrings.submit,
              onPressed: () {
                   if(testMood){
                     Get.offAllNamed(AppStrings.mainPage);
                   }else{
                     controller.registerApi();
                   }
              }),
        ],
      ),
    );
  }
}
