import 'package:get/get.dart'; // Make sure to import GetX
import 'package:file_picker/file_picker.dart';
import '../../config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileUploadWidget extends StatelessWidget {
  final data = Get.find<TaskDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => data.images.isEmpty
          ? GestureDetector(
              onTap: () async {
                try {
                  final FilePickerResult? pickedFiles =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.any, // Accept any file type
                  );
                  if (pickedFiles != null) {
                    print('pickedFiles.files');
                    print(pickedFiles.files);
                    data.images.value = pickedFiles.files;
                    File file = File(pickedFiles.files.single.path!);
                    data.images2.add(file.path);
                    print('data.images2');
                    print(data.images2);
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Error opening gallery: $e');
                  }
                }
              },
              child: TextLine(
                title: "click_to_upload_files_photographs",
                fontSize: 17,
                isBold: true,
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 100, // Set a width for the images
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: getFileWidget(data.images[index]),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          data.images.removeAt(index);
                        },
                        child: const Icon(
                          Icons.delete_outline_outlined,
                          size: 20,
                          color: Colors.red, // Adjust color as needed
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
    );
  }
}

Widget getFileWidget(PlatformFile file) {
  if (file.extension == 'jpg' ||
      file.extension == 'png' ||
      file.extension == 'jpeg' ||
      file.extension == 'gif' ||
      file.extension == 'avif' ||
      file.extension == 'ico') {
    return Image.file(
      File(file.path!),
      fit: BoxFit.cover,
    );
  } else if (file.extension == 'svg') {
    return SvgPicture.file(
      File(file.path!),
      fit: BoxFit.cover,
    );
  } else if (file.extension == 'mp4' ||
      file.extension == 'mov' ||
      file.extension == 'wmv' ||
      file.extension == 'avchd' ||
      file.extension == 'avi' ||
      file.extension == 'flv' ||
      file.extension == 'webm' ||
      file.extension == 'webm' ||
      file.extension == 'mkv') {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.video_collection_outlined, // File icon
            size: 40,
            color: Colors.blue, // Adjust color as needed
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              file.name, // Show the file name
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.insert_drive_file, // File icon
            size: 40,
            color: Colors.blue, // Adjust color as needed
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              file.name, // Show the file name
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
