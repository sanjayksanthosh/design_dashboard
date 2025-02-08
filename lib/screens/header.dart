import 'package:flutter/material.dart';
import 'package:hidden_dash_new/widgets/search_form_field.dart';

import '../../utils/media_query_values.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height ,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: NetworkImage("https://img.freepik.com/free-photo/abstract-gradient-neon-lights_23-2149279139.jpg?semt=ais_hybrid")),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,      // Gradient starts at the top-left corner
            //   end: Alignment.bottomRight,      // Gradient ends at the bottom-right corner
            //   colors: [
            //  Color(0xff8e9eab),
            //  Color(0xffeef2f3),
            //                // Orange in the ending corner
            //   ],
            // ),
          ),
      // const BoxDecoration(
        
        // image: DecorationImage(
        //   alignment: Alignment.bottomCenter,
        //   image: AssetImage(
        //     'assets/images/header_image.jpeg',
        //   ),
        //   fit: BoxFit.cover,
        // ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            
              SizedBox(
                width: context.width * 0.01,
              ),
              Text(
                'Sun, 4 Jan 2024',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey[200]),
              ),
            ],
          ),
          const SearchFormField(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.nights_stay,
              ),
              SizedBox(
                width: context.width * 0.01,
              ),
            
              SizedBox(
                width: context.width * 0.01,
              ),
              const Icon(
                Icons.notifications,
              ),
              SizedBox(
                width: context.width * 0.01,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 20.0,
                    // backgroundImage: NetworkImage(
                    //   'https://media.licdn.com/dms/image/D4E03AQHirihVTwk9sA/profile-displayphoto-shrink_800_800/0/1678926297499?e=2147483647&v=beta&t=AXEpUxgTP1zcc3eP1U4jN6oiu9N9yzL1hHj83WZjZtU',
                    // ),
                  ),
                  SizedBox(
                    width: context.width * 0.007,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Samad ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.005,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 12.0,
                          ),
                        ],
                      ),
                      Text(
                        'Samad@gmail.com',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
