import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/genre.dart';
import 'package:example/app/enums/reading_frequency.dart';

class LoginBloc extends BloweLoadBloc<void, LoginParams> {
  LoginBloc();

  @override
  Future<void> load(LoginParams params) {
    return Future.delayed(const Duration(seconds: 2));
  }
}

class LoginParams {
  LoginParams({
    required this.email,
    required this.password,
    required this.readingFrequency,
    required this.genre,
  });

  final String email;
  final String password;
  final ReadingFrequency readingFrequency;
  final Genre genre;
}
