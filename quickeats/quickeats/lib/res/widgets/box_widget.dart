

import '../../config.dart';

Widget boxCard({
  required var task,
  required String taskName,
  required String image,
  required String imageIcon,
  onPressed,
  double iconSize = 30.0,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      child: SizedBox(
        width: 160,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextLine(
                            title: task.toString(),
                            fontSize: 20,
                            isBold: true,
                            color: Colors.white),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(imageIcon,height: iconSize,  width:iconSize,color: Colors.white,),),
                    ],
                  ),
                  TextLine(
                    title: taskName,
                    fontSize: 18,
                    isBold: true,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );


Widget boxCardSkl()=>Padding(
  padding: const EdgeInsets.only(bottom: 10, left: 10),
  child: SizedBox(
    width: 160,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Container(
                    height: 20,
                    width: 100,
                    color: Colors.grey.shade400, // Placeholder for title
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey.shade400, // Placeholder for icon
                  ),
                ],
              ),
              Container(
                height: 16,
                width: 120,
                color: Colors.grey.shade400, // Placeholder for task name
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);