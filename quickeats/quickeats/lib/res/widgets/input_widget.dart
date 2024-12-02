import '../../config.dart';

Widget buildTextField(
    {required TextEditingController controller,
      required String label,
       String requiredText="",
      required IconData icon,
      bool isEnable = true,
      String? hint}) {
  return TextFormField(
    controller: controller,
    autovalidateMode:
    AutovalidateMode.onUserInteraction,
    validator: (value) => value!.isEmpty
        ? requiredText
        : null,
    decoration: InputDecoration(
      enabled: isEnable,
      prefixIcon: Icon(icon, color: AppColors.buttonColor),
      // Your button color
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
        const BorderSide(color: AppColors.textColor), // Your button color
      ),
      filled: true,
      border: const OutlineInputBorder(
        borderSide:
        BorderSide(color: AppColors.textColor), // Your button color
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
        BorderSide(color: AppColors.textColor), // Your button color
      ),
      fillColor: Colors.white,
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(
          color: Colors.black, fontSize: 12), // Adjust as needed
    ),
  );
}