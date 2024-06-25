import 'package:blowe_bloc/blowe_bloc.dart';

class TermsSwitchFormListTile extends BloweBoolFormListTile {
  TermsSwitchFormListTile({
    required super.controller,
    super.key,
    super.enabled,
  }) : super(
          title: (context) => 'I agree to the terms and conditions',
          dense: true,
          validator: (context, value) {
            if (value == false) {
              return 'You must agree to the terms and conditions';
            }
            return null;
          },
        );
}
