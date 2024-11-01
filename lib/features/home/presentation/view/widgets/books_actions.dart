


import 'package:flutter/material.dart';
import 'package:my_bookly_app/features/home/data/models/book_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/widgets/custom_button.dart';

class BooksActions extends StatelessWidget {
  const BooksActions({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const Expanded(
            child: CustomButton(
              text: '99.99\$',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: CustomButton(
              onPressed: ()async{
                Uri uri = Uri.parse("${bookModel.volumeInfo?.previewLink}");
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              fontSize: 15,
              text: getText(bookModel),
              backgroundColor: const Color(0xffEF8262),
              textColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

String getText(BookModel bookModel) {
  if(bookModel.volumeInfo?.previewLink == null){
    return "Not Available";
  }else{

  return "Free Preview";
  }
}
}
