import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart'
    show QuillHtmlEditor, ToolBar, ToolBarStyle;
import '../../config.dart'
    show
        AppColors,
        Axis,
        Border,
        BoxDecoration,
        Center,
        CircularProgressIndicator,
        Colors,
        Column,
        Container,
        EdgeInsets,
        Get,
        TaskDetailsController,
        TextAlign,
        Widget;
Widget htmlEditor() {
  final data = Get.find<TaskDetailsController>();

  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.black),
    ),
    child: Column(
      children: [
        ToolBar.scroll(
          toolBarColor: Colors.grey.shade200,
          controller: data.comment,
          direction: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          toolBarConfig: const [
            ToolBarStyle.redo,
            ToolBarStyle.undo,
            ToolBarStyle.clean,
            ToolBarStyle.align,
            ToolBarStyle.bold,
            ToolBarStyle.italic,
            ToolBarStyle.size,
            ToolBarStyle.underline,
            ToolBarStyle.color,
            ToolBarStyle.listBullet,
            ToolBarStyle.indentAdd,
            // ToolBarStyle.separator,
          ],
        ),
        QuillHtmlEditor(
          hintText: 'Hint text goes here',
          controller: data.comment,
          isEnabled: true,
          minHeight: 300,
          textStyle: data.editorTextStyle,
          hintTextStyle: data.hintTextStyle,
          hintTextAlign: TextAlign.start,
          padding: const EdgeInsets.only(left: 10, top: 5),
          hintTextPadding: EdgeInsets.zero,
          backgroundColor: Colors.white70,
          // onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
          // onTextChanged: (text) => debugPrint('widget text change $text'),
          // onEditorCreated: () => debugPrint('Editor has been loaded'),
          // onEditingComplete: (s) => debugPrint('Editing completed $s'),
          // onEditorResized: (height) => debugPrint('Editor resized $height'),
          // onSelectionChanged: (sel) => debugPrint('${sel.index},${sel.length}'),
          loadingBuilder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 0.4,
            ));
          },
        ),
      ],
    ),
  );
}
