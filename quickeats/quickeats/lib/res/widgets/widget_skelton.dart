import '../../config.dart'
    show
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Card,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        Icon,
        Icons,
        Padding,
        Row,
        Shimmer,
        SizeConfig,
        SizedBox,
        SliverChildBuilderDelegate,
        SliverList,
        Spacer,
        Widget;

Widget getSklContainer() => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10.00),
                width: SizeConfig.blockSizeHorizontal = 100,
                height: SizeConfig.blockSizeVertical = 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal = 236,
                height: SizeConfig.blockSizeVertical = 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal = 150,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: SizeConfig.safeBlockVertical = 17,
                              color: Colors.amber,
                            ),
                            Container(
                              width: 30,
                              height: 15,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: SizeConfig.blockSizeHorizontal = 200,
                      height: 15,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: SizeConfig.blockSizeHorizontal = 150,
                      height: 15,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          height: SizeConfig.blockSizeVertical = 20,
                          width: SizeConfig.blockSizeHorizontal = 20,
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: SizeConfig.blockSizeHorizontal = 195,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
