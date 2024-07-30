import 'package:fixit/features/chats/presentation/screens/chat_screen.dart';
import 'package:fixit/features/home/presentation/screens/home_screen.dart';
import 'package:fixit/features/main_navigation/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:fixit/features/main_navigation/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_event.dart';
import 'package:fixit/features/main_navigation/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_state.dart';
import 'package:fixit/features/service_provider/presentation/screen/service_provider_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainNavigationBloc(),
      child: MainScreenContent(),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  final List<Widget> _pages = [
    const HomeScreen(),
    ServiceProviderListingScreen(),
    const ChatScreen()
  ];

  MainScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationBloc, MainNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state.selectedIndex],
          bottomNavigationBar: BottomNavBar(
            selectedIndex: state.selectedIndex,
            onItemTapped: (index) {
              context.read<MainNavigationBloc>().add(NavigateToIndex(index));
            },
          ),
        );
      },
    );
  }
}
