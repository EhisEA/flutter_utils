// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mhi_flutter_v3_library/mhi_flutter_v3_library.dart';

// enum _Size {
//   big,
//   small;

//   bool get isBig => this == big;
// }

// class AppFilePicker extends StatefulWidget {
//   const AppFilePicker.big({
//     super.key,
//     this.title,
//     this.isImage = false,
//     this.controller,
//     this.allowedExtensions,
//   }) : _size = _Size.big;

//   const AppFilePicker.small({
//     super.key,
//     this.title,
//     this.isImage = false,
//     this.controller,
//     this.allowedExtensions,
//   }) : _size = _Size.small;

//   final _Size _size;
//   final String? title;
//   final bool isImage;
//   final FilePickerController? controller;
//   final List<String>? allowedExtensions;

//   @override
//   State<AppFilePicker> createState() => _AppFilePickerState();
// }

// class _AppFilePickerState extends State<AppFilePicker> {
//   final FilePickerController _tempController = FilePickerController();
//   @override
//   Widget build(BuildContext context) {
//     return widget._size.isBig
//         ? _AppFilePickerBig(
//             title: widget.title,
//             isImage: widget.isImage,
//             controller: widget.controller ?? _tempController,
//             allowedExtensions: widget.allowedExtensions,
//           )
//         : _AppFilePickerSmall(
//             title: widget.title,
//             isImage: widget.isImage,
//             controller: widget.controller ?? _tempController,
//             allowedExtensions: widget.allowedExtensions,
//           );
//   }
// }

// class _AppFilePickerBig extends StatelessWidget {
//   const _AppFilePickerBig({
//     required this.title,
//     required this.controller,
//     required this.isImage,
//     required this.allowedExtensions,
//   });

//   final String? title;
//   final bool isImage;
//   final FilePickerController controller;
//   final List<String>? allowedExtensions;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null) ...[
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
//             child: AppText.body(title!, color: const Color(0xff505673)),
//           ),
//           Gap.h8,
//         ],
//         ValueListenableBuilder<FileResult?>(
//             valueListenable: controller,
//             builder: (context, file, child) {
//               return DashedBorderWidget(
//                 borderRadius: BorderRadius.circular(12),
//                 borderColor: const Color(0xffBFBFBF),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 36),
//                     child: Column(
//                       children: [
//                         file != null
//                             ? Image.asset(MHIImageAssets.pdfIcon, height: 40)
//                             : SvgPicture.asset(MHISvgAssets.cloudUpload),
//                         Gap.h16,
//                         AppText.body(
//                           file != null
//                               ? file.pickedFileName
//                               : "Choose a file or drag & drop it here.",
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                         Gap.h6,
//                         AppText.body(
//                           controller.sizeInBytes != null
//                               ? controller.sizeInBytes!
//                               : "mp4, mov and WebM up to 5 MB",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: .8,
//                           color: const Color(0xff505673),
//                         ),
//                         Gap.h32,
//                         Center(
//                           child: GestureDetector(
//                             behavior: HitTestBehavior.opaque,
//                             onTap: () async {
//                               final FileResult? pickedFile;
//                               if (isImage) {
//                                 pickedFile = await MediaServiceImpl().getImage();
//                               } else {
//                                 pickedFile =
//                                     await MediaServiceImpl().getFile(allowedExtensions: ['pdf']);
//                               }
//                               if (pickedFile != null) {
//                                 controller.file = pickedFile;
//                               }
//                             },
//                             child: Container(
//                               height: 42,
//                               width: 147,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(9),
//                                 border: Border.all(width: .8, color: const Color(0xffBFBFBF)),
//                               ),
//                               child: AppText.body(
//                                 file != null ? "Change file" : "Browse file",
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: const Color(0xff505673),
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (file != null) ...[
//                           Gap.h8,
//                           Center(
//                             child: GestureDetector(
//                               onTap: () async {
//                                 controller.clearFile();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: AppText.body(
//                                   "Delete file",
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xff993c39),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                         Gap.h12,
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ],
//     );
//   }
// }

// class _AppFilePickerSmall extends StatelessWidget {
//   const _AppFilePickerSmall({
//     required this.title,
//     required this.isImage,
//     required this.controller,
//     required this.allowedExtensions,
//   });

//   final String? title;
//   final bool isImage;
//   final FilePickerController controller;
//   final List<String>? allowedExtensions;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null) ...[
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
//             child: AppText.body(title!, color: const Color(0xff505673)),
//           ),
//           Gap.h8,
//         ],
//         ValueListenableBuilder<FileResult?>(
//           valueListenable: controller,
//           builder: (context, file, child) {
//             return GestureDetector(
//               onTap: () async {
//                 final FileResult? pickedFile;
//                 if (isImage) {
//                   pickedFile = await MediaServiceImpl().getImage();
//                 } else {
//                   pickedFile = await MediaServiceImpl().getFile(allowedExtensions: ['pdf']);
//                 }
//                 if (pickedFile != null) {
//                   controller.file = pickedFile;
//                 }
//               },
//               child: DashedBorderWidget(
//                 borderRadius: BorderRadius.circular(12),
//                 borderColor: const Color(0xffBFBFBF),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 26),
//                   child: file == null
//                       ? Row(
//                           children: [
//                             SvgPicture.asset(MHISvgAssets.cloudUpload),
//                             Gap.w12,
//                             TwoText(
//                               firstText: "Drop .pdf document here or ",
//                               secondText: "click to upload",
//                               firstTextStyle: AppTextStyle.body.copyWith(
//                                 color: const Color(0xff505673),
//                               ),
//                               secondTextStyle: AppTextStyle.body.copyWith(color: AppColors.primary),
//                             ),
//                           ],
//                         )
//                       : Row(
//                           children: [
//                             Image.asset(MHIImageAssets.pdfIcon, height: 40),
//                             Gap.w12,
//                             Expanded(child: AppText.body(file.pickedFileName)),
//                             Gap.w4,
//                             if (controller.sizeInBytes != null)
//                               AppText.body(
//                                 controller.sizeInBytes!,
//                                 color: const Color(0xff505673),
//                               ),
//                             Gap.w4,
//                             GestureDetector(
//                               onTap: () async {
//                                 controller.clearFile();
//                               },
//                               child: const Padding(
//                                 padding: EdgeInsets.all(4.0),
//                                 child: Icon(
//                                   Icons.cancel_outlined,
//                                   color: Color(0xff505673),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
