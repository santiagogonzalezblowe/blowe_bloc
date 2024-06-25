import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/genre.dart';
import 'package:example/app/enums/reading_frequency.dart';
import 'package:example/app/widgets/dropdown_button_form_field/genre_dropdown_button_form_field.dart';
import 'package:example/app/widgets/radius_form/reading_frequency_radius_form.dart';
import 'package:example/app/widgets/switch_form_list_tile/terms_switch_form_list_tile.dart';
import 'package:example/app/widgets/text_form_field/email_text_form_field.dart';
import 'package:example/app/widgets/text_form_field/password_text_form_field.dart';
import 'package:example/features/login/logic/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _aceptTerms = BloweBoolFormController();
  final _readingFrequency = BloweRadiusFormController<ReadingFrequency>();
  Genre? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          BloweBlocSelector<LoginBloc>(
            builder: (context, enabled) => EmailTextFormField(
              controller: _emailController,
              enabled: enabled,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: 16),
          BloweBlocSelector<LoginBloc>(
            builder: (context, enabled) => PasswordTextFormField(
              controller: _passwordController,
              enabled: enabled,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: 16),
          BloweBlocSelector<LoginBloc>(
            builder: (context, enabled) => TermsSwitchFormListTile(
              controller: _aceptTerms,
              enabled: enabled,
            ),
          ),
          const SizedBox(height: 16),
          BloweBlocSelector<LoginBloc>(
            builder: (context, enabled) => ReadingFrequencyRadiusForm(
              controller: _readingFrequency,
              enabled: enabled,
            ),
          ),
          const SizedBox(height: 16),
          BloweBlocSelector<LoginBloc>(
            builder: (context, enabled) => GenreDropdownButtonFormField(
              value: _selectedGenre,
              enabled: enabled,
              onChanged: (value) => setState(() => _selectedGenre = value),
            ),
          ),
          const SizedBox(height: 16),
          BloweBlocButton<LoginBloc, ElevatedButton>(
            text: 'Sign in',
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              context.read<LoginBloc>().add(BloweFetch(params));
            },
          ),
        ],
      ),
    );
  }

  LoginParams get params => LoginParams(
        email: _emailController.text,
        password: _passwordController.text,
        genre: _selectedGenre!,
        readingFrequency: _readingFrequency.value!,
      );
}
