import 'package:flutter/material.dart';

class ExploroTextBox extends StatefulWidget {
  String? hintText = "";
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  TextInputType? keyboardType;
  String? initialValue;

  int maxLines = 1;
  bool disabled = false;
  bool obscureText;
  bool validated;

  ExploroTextBox(
      {Key? key,
        this.hintText,
        this.validator,
        this.onChanged,
        this.keyboardType,
        this.maxLines = 1,
        this.disabled = false,
        this.obscureText = false,
        this.validated = false,
        this.initialValue})
      : super(key: key);

  @override
  State<ExploroTextBox> createState() => _ExploroTextBoxState();
}

class _ExploroTextBoxState extends State<ExploroTextBox> {
  late TextEditingController _textController;
  bool focused = false;
  bool showPassword = false;

  @override
  void initState() {
    _textController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 15,
      ),
      Focus(
          onFocusChange: (focused) {
            if (focused) {
              setState(() {
                this.focused = true;
              });
            } else {
              setState(() {
                this.focused = false;
              });
            }
          },
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: focused
                      ? widget.validated
                      ? Colors.green
                      : Colors.black
                      : Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(20),
              color: focused
                  ? widget.validated
                  ? Colors.green.withOpacity(0.1)
                  : Colors.grey.shade200.withOpacity(0.8)
                  : Colors.grey.shade100.withOpacity(0.3),
            ),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                      controller: _textController,
                      obscureText: widget.obscureText && !showPassword,
                      onChanged: widget.onChanged,
                      keyboardType: widget.keyboardType,
                      cursorHeight: 25,
                      cursorColor: Colors.indigo,
                      maxLines: widget.maxLines,
                      enabled: !widget.disabled,
                      validator: widget.validator,
                      decoration: InputDecoration(
                          hintText: widget.hintText, border: InputBorder.none),
                      style: const TextStyle(
                          fontSize: 18, fontFamily: "ColabRegular"))),
              widget.obscureText
                  ? Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)),
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(!showPassword ? Icons.remove_red_eye_outlined : Icons.password)))))
                  : Container()
            ]),
          )),
    ]);
  }
}