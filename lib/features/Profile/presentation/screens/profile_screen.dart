import 'package:fixit/common/common_widgets/cutom_app_bar.dart';
import 'package:fixit/features/Profile/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:fixit/features/Profile/presentation/screens/about_us_screen.dart';
import 'package:fixit/features/Profile/presentation/screens/contact_us_screen.dart';
import 'package:fixit/features/Profile/presentation/screens/feedback_screen.dart';
import 'package:fixit/features/Profile/presentation/widgets/profile_items.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserDetailsBloc>().add(LoadUserDetails());
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileHeader(context),
                const SizedBox(height: 20),
                buildProfileOptions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      builder: (context, state) {
        if (state is UserDetailsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hey.',
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                state.user.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              )
            ],
          );
        } else {
          return const Center(
            child: Text('DATA PROCESSING'),
          );
        }
      },
    );
  }

  Widget buildProfileOptions(BuildContext context) {
    return Column(
      children: [
        ProfileItems(
            title: 'Account',
            widget: Column(
              children: [
                buildOptionTile('Logout', Icons.logout, () {
                  showDeleteConfirmationDialog(context, () async {
                    AuthLocalDataService.setLoginStatus(false);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()),
                        (route) => false);
                  });
                }),
                buildOptionTile('Feedback', Icons.feedback, () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => ReviewForm()));
                })
              ],
            )),
        ProfileItems(
            title: 'Other',
            widget: Column(
              children: [
                buildOptionTile('contact us', Icons.logout, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const ContactUsScreen()));
                }),
                buildOptionTile('about us', Icons.emoji_emotions_rounded, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AboutUsScreen()));
                }),
                buildOptionTile('privacy policy', Icons.feedback, () {
                  _launchURL();
                })
              ],
            ))
      ],
    );
  }

  Widget buildOptionTile(String title, IconData icon, Function() onTap) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap);
  }

  Widget buildSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(thickness: 1),
    );
  }
}

void _launchURL() async {
  const url =
      'https://www.freeprivacypolicy.com/live/c18fd8e7-b179-4595-97c8-c137ec014c6f';
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void showDeleteConfirmationDialog(
    BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text(
            'Are you sure you want to Logout? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
