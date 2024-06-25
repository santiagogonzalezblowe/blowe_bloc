import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/reading_frequency.dart';
import 'package:example/app/extensions/string.dart';

class ReadingFrequencyRadiusForm extends BloweRadiusForm<ReadingFrequency> {
  ReadingFrequencyRadiusForm({
    required super.controller,
    super.enabled,
    super.key,
  }) : super(
          items: ReadingFrequency.values,
          toggleable: true,
          titleBuilder: (context, item) => item.name.capitalize(),
          validator: (context, value) {
            if (value == null) {
              return 'You must select a reading frequency';
            }
            return null;
          },
        );
}
