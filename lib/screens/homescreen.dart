// screens/home_screen_new.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/services/socket_services.dart';
import 'package:provider/provider.dart';
import 'header.dart';
import 'sidebar.dart';
import '../utils/media_query_values.dart';
import '../widgets/alertContainer.dart';
import '../widgets/firstcard.dart';
import '../widgets/loading_widget.dart';
import '../widgets/overview_statistic_widget.dart';
import '../widgets/stock_widget.dart';
import 'package:lottie/lottie.dart';

class HomeScreenNew extends StatelessWidget {
  const HomeScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the SocketService if you need to use it in your widget.
    // For example, you could listen for specific events or emit events.
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SideBar(),
          Expanded(
            child: Stack(
              children: [
                const Header(),
                // The connection is already active and its logs are printed in the console.
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const OverallPortfolioCard(),
                              Container(
                                width: context.width / 1.55,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OverviewStatistic(),
                                    AlertsContainer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const StockWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
