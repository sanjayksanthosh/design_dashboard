import '../../utils/media_query_values.dart';
import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  String? title;
  String? content;
   TotalWidget({
    this.title,
    this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               title!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     const Icon(
              //       Icons.keyboard_arrow_up,
              //       color: Colors.green,
              //       size: 15.0,
              //     ),
              //     SizedBox(
              //       width: context.width * 0.001,
              //     ),
              //     Text(
              //       '+24%',
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodySmall!
              //           .copyWith(color: Colors.green),
              //     ),
              //   ],
              // ),
            ],
          ),
          SizedBox(
            height: context.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   '\$',
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodySmall!
              //       .copyWith(color: Colors.grey),
              // ),
              SizedBox(
                width: context.width * 0.001,
              ),
               Text(
                content!,
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
