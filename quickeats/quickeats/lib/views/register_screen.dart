import 'view_list.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AssetsImage.logoBig,
              width: SizeConfig.blockSizeHorizontal = 100,
              height: SizeConfig.blockSizeVertical = 70,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          color: Colors.white,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(29.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    TextLine(
                      title: "Hello! Register to get started",
                      fontSize: 30,
                      isBold: true,
                      lines: 2,
                      color: AppColors.blackShade3,
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const TextLine(
                      title: "Enter your name and email to login",
                      fontSize: 17,
                      isBold: false,
                      lines: 2,
                      color: AppColors.blackShade3,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeVertical = 20,
                    ),
                  ],
                ),
                const RegisterWidget(testMood: false,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
