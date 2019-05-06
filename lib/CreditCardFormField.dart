library credit_card_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardFormField extends StatelessWidget {
  CreditCardFormField({
    this.key,
    this.controller,
    this.decoration,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
  }) : super(key: key);

  final Key key;
  final TextEditingController controller;
  final InputDecoration decoration;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      decoration: this.decoration,
      controller: this.controller,
      validator: this.validator,
      obscureText: this.obscureText,
    );
  }
}

class CVVFormField extends StatelessWidget {
  CVVFormField(
      {this.key,
      this.controller,
      this.decoration,
      this.validator,
      this.obscureText = false,
      this.enabled = true,
      this.inputFormatters,
        this.onSubmit,
        this.onChanged
      })
      : super(key: key);

  final List<TextInputFormatter> inputFormatters;
  final Key key;
  final TextEditingController controller;
  final InputDecoration decoration;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool enabled;
  final Function onSubmit ;
  final ValueChanged<String> onChanged;



  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      decoration: this.decoration,
      onChanged:this.onChanged ,
      controller: this.controller,
      obscureText: this.obscureText,
      inputFormatters: this.inputFormatters,
      onSubmitted: this.onSubmit,

    );
  }
}

class ExpirationFormField extends StatefulWidget {
  //TODO make controller optional
  ExpirationFormField({
    this.key,
    @required this.controller,
    this.decoration,
    this.obscureText = false,
    this.enabled = true,
  this.onSubmit,
    this.onChanged


  }) : super(key: key);

  final Key key;
  final TextEditingController controller;
  final InputDecoration decoration;
  final bool obscureText;
  final bool enabled;
  final Function onSubmit ;
  final ValueChanged<String> onChanged;


  @override
  _ExpirationFormFieldState createState() => _ExpirationFormFieldState();
}

class _ExpirationFormFieldState extends State<ExpirationFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      controller: widget.controller,
      decoration: widget.decoration,
      onChanged: widget.onChanged,
      cursorWidth: 0.0,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      onSubmitted:widget.onSubmit ,

    );
  }
}
