import 'package:get/get.dart' show Get, Inst;
import 'view_list.dart'
    show
        AppBar,
        AppColors,
        BuildContext,
        Colors,
        Column,
        Container,
        Divider,
        EdgeInsets,
        FontWeight,
        Get,
        GetPolicyController,
        Icon,
        Icons,
        Image,
        LaunchMode,
        ListTile,
        PolicyData,
        Scaffold,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        TextStyle,
        Widget,
        kDebugMode,
        launchUrl,
        TextLine;

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    // final data= Get.find<GetPolicyController>();
    final data = Get.put(GetPolicyController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: TextLine(title: "help_&_support", fontSize: 17, isBold: true),
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          // color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ListTile(
              //   onTap: () =>
              //       Get.to(() => PolicyData(slug: 'terms_and_conditions_page')),
              //   title: const Text(
              //     'Help Center',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   trailing: const Icon(
              //     Icons.help_outline,
              //     size: 30,
              //     color: AppColors.textColor,
              //   ),
              // ),
              // const Divider(
              //   indent: 10,
              //   endIndent: 10,
              // ),
              ListTile(
                onTap: () async {
                  data.getPolicy(slug: 'privacy_policy');
                  // if (kDebugMode) {
                  //   print('test_pratik');
                  //   print(data.pageUrl.value);
                  // }

                  // if (!await launchUrl(
                  //   Uri.parse('${data.pageUrl.value}?key=demo'),
                  //   mode: LaunchMode.inAppWebView,
                  // )) {
                  //   throw Exception('Could not launch');
                  // }
                },
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Image.asset(
                  'assets/icon/privacy-policy.png',
                  height: 30,
                  width: 30,
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                onTap: () async {
                  data.getPolicy(slug: 'terms_and_conditions');
                  // if (kDebugMode) {
                  //   print('test_pratik');
                  //   print(data.pageUrl.value);
                  // }

                  // if (!await launchUrl(
                  //   Uri.parse('${data.pageUrl.value}?key=demo'),
                  //   mode: LaunchMode.inAppWebView,
                  // )) {
                  //   throw Exception('Could not launch');
                  // }
                },
                title: const Text(
                  'Terms & Condition',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.shield_outlined,
                  size: 30,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
