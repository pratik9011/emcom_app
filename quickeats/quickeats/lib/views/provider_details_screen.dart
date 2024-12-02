import 'package:get/get.dart';

import 'view_list.dart';

class ProviderDetailsScreen extends StatelessWidget {
  const ProviderDetailsScreen(
      {super.key, required this.providerId, required this.providerName});

  final String providerId;
  final String providerName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderDetailsController());
    controller.providerDetailsApi(providerId: providerId ?? '');
    controller.providerUnderServicesApi(providerId: providerId);
    return Scaffold(
      appBar: appBarName(name: providerName ?? ''),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProviderDetailsBody(),
            ProviderUnderService(),
          ],
        ),
      ),
      bottomNavigationBar: const CallNowButtonProvider(),
    );
  }
}
