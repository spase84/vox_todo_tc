import 'package:flutter/material.dart';
import 'package:vox_todo/app/features/widgets/decorated_input_container.dart'
    show DecoratedInputContainer;
import 'package:vox_todo/app/settings/colors.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({
    required this.title,
    required this.onChanged,
    this.initialValue,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String title;
  final String? initialValue;

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          const SizedBox(height: 16),
          DecoratedInputContainer(
            child: TextFormField(
              controller: _controller,
              onChanged: widget.onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.textGray),
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                isDense: true,
              ),
              minLines: 1,
              maxLines: 15,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              keyboardAppearance: Brightness.dark,
              textInputAction: TextInputAction.newline,
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }
}
