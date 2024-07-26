import 'package:fixit/features/authentication/presentation/bloc/User/user_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void onSignUpButtonPressed(BuildContext context, String name, String email,
    String phone, String password) {
  context.read<UserBloc>().add(UpdateName(name));
  context.read<UserBloc>().add(UpdateEmail(email));
  context.read<UserBloc>().add(UpdatePhone(phone));
  context.read<UserBloc>().add(UpdateIsServiceProvider(false));
  context.read<SignUpBloc>().add(SendOTPEvent(phone, email, password));
}
