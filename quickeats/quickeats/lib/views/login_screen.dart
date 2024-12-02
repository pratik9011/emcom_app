import 'package:get/get.dart' show BoolExtension, Get, GetNavigation, Inst, Obx, RxBoolExt;
import 'package:quickeats/config.dart';
import 'view_list.dart'
    show
        AppColors,
        AutovalidateMode,
        BorderRadius,
        BorderSide,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        Form,
        GestureDetector,
        Get,
        GetPolicyController,
        Icon,
        IconButton,
        Icons,
        Image,
        InputDecoration,
        AuthController,
        MainAxisAlignment,
        MediaQuery,
        OutlineInputBorder,
        RoundedRectangleBorder,
        Row,
        Scaffold,
        SingleChildScrollView,
        SizeConfig,
        SizedBox,
        StatelessWidget,
        Text,
        TextFormField,
        TextInputAction,
        TextInputType,
        TextStyle,
        Widget,
        heightSpaceBox,
        TextLine;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final login = Get.find<AuthController>();
    final data = Get.put(GetPolicyController());
    var passwordVisible = true.obs;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: login.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              heightSpaceBox(size: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsImage.logoBig,
                    width: SizeConfig.blockSizeHorizontal = 150,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(29.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "SIGN IN TO YOUR ACCOUNT",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const TextLine(
                          title: ' ',
                          color: AppColors.blackShade2,
                          fontSize: 10,
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical = 10,
                    ),
                   const LoginWidget(testMood: false,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
