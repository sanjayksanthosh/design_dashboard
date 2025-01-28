import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';

import '../../utils/colors.dart';
import 'custom_button.dart';
import 'outline_button.dart';

class StockWidget extends StatelessWidget {
  const StockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: context.width * .20,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 22.0,
        ),
        transform: Matrix4.translationValues(0, -75, 0),
        decoration: BoxDecoration(
          color: lightBlack,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: context.width * 0.04,
                    height: context.height * 0.07,
                    decoration: BoxDecoration(
                      color: chocolateMelange,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(
                      Icons.credit_card,
                      color: primaryColor,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.01,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Details',
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.01,
                      ),
                      const Text(
                        '(Frozen, Active, Blocked)',
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.03,
              ),
              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: darkGrey.withOpacity(0.2),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: darkGrey,
                tabs: const [
                  Tab(text: 'Frozen'),
                  Tab(text: 'Active'),
                  Tab(text: 'Blocked'),
                ],
              ),
              SizedBox(
                height: context.height * 0.03,
              ),
              SizedBox(
                height: context.height * 0.5, // Constrain the height
                child: TabBarView(
                  children: [
                    _buildCardList(context, 'Frozen'),
                    _buildCardList(context, 'Active'),
                    _buildCardList(context, 'Blocked'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardList(BuildContext context, String status) {
    // Example list of cards
    final List<Map<String, String>> cards = [
      {
        'cardNumber': '**** **** **** 1234',
        'balance': '\$1,000.00',
        'status': status,
      },
      {
        'cardNumber': '**** **** **** 5678',
        'balance': '\$2,500.00',
        'status': status,
      },
      {
        'cardNumber': '**** **** **** 9101',
        'balance': '\$5,000.00',
        'status': status,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _buildCardItem(context, card);
      },
    );
  }

  Widget _buildCardItem(BuildContext context, Map<String, String> card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: darkGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Card Number: ${card['cardNumber']}',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 14.0,
                ),
              ),
              const Icon(
                Icons.copy,
                color: secondPrimaryColor,
                size: 18.0,
              ),
            ],
          ),
          SizedBox(
            height: context.height * 0.01,
          ),
          Text(
            'Balance: ${card['balance']}',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: context.height * 0.01,
          ),
          Text(
            'Status: ${card['status']}',
            style: TextStyle(
              color: card['status'] == 'Active' ? Colors.green : Colors.red,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Padding accountsWidget(BuildContext context, String title, String value,
      {bool isPercentage = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: context.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: darkGrey),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isPercentage ? Colors.green : darkGrey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}