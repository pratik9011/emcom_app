import '../res_list.dart'
    show
        AlwaysScrollableScrollPhysics,
        AppColors,
        Border,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Center,
        CircleAvatar,
        CircularProgressIndicator,
        Color,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        Divider,
        EdgeInsets,
        FontWeight,
        InkWell,
        Key,
        ListView,
        MainAxisAlignment,
        NetworkImage,
        NeverScrollableScrollPhysics,
        Padding,
        Row,
        ScrollController,
        Shimmer,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget,
        rowTextLine,
        showAllDetails,
        TextLine,
        widthSpaceBox;

Widget bigCardSkl() => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 20, // Height of each shimmer item
                  width: double.infinity,
                  color: Colors.white, // The shimmer effect background color
                ),
              );
            }),
          ),
        ),
      ),
    );

Widget bigCard({required List tasks, required ScrollController controller}) =>
    SizedBox(
      height: 200.0 * tasks.length,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          controller: controller,
          itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => showAllDetails(tasks[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    rowTextLine(
                                        title: tasks[index]['task_name']
                                            .toString(),
                                        fontSize: 18,
                                        isBold: true,
                                        color: AppColors.black,
                                        lines: 2,
                                        textWidth: 220),
                                    tasks[index]['status_color'] == ''
                                        ? const SizedBox()
                                        : Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(int.parse(
                                                    tasks[index]
                                                        ['status_color'])),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 2,
                                                  left: 7,
                                                  right: 7),
                                              child: TextLine(
                                                  title: tasks[index]['status']
                                                      .toString(),
                                                  fontSize: 12,
                                                  isBold: true,
                                                  color: Color(int.parse(
                                                      tasks[index]
                                                          ['status_color']))),
                                            ),
                                          ),
                                  ],
                                ),
                                TextLine(
                                    title: tasks[index]['code'].toString(),
                                    fontSize: 12,
                                    isBold: false,
                                    color: AppColors.textColor),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Assigned By",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColor),
                                ),
                                TextLine(
                                    title: 'department',
                                    fontSize: 12,
                                    isBold: true,
                                    color: AppColors.textColor),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage(tasks[index]
                                              ['profile_image']
                                          .toString()),
                                    ),
                                    widthSpaceBox(size: 5),
                                    TextLine(
                                        title: tasks[index]['assigned_by']
                                            .toString(),
                                        fontSize: 12,
                                        isBold: false,
                                        color: AppColors.textColor),
                                  ],
                                ),
                                TextLine(
                                    title:
                                        tasks[index]['department'].toString(),
                                    fontSize: 12,
                                    isBold: true,
                                    color: AppColors.textColor),
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Assigned Date',
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textColor),
                                ),
                                Text(
                                  'Deadline Date',
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextLine(
                                    title:
                                        tasks[index]['created_date'].toString(),
                                    fontSize: 12,
                                    isBold: false,
                                    color: AppColors.black),
                                TextLine(
                                    title: tasks[index]['deadline'].toString(),
                                    fontSize: 12,
                                    isBold: false,
                                    color: AppColors.black),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    );
