import 'package:flutter/material.dart';
import 'package:portal_muni/app/text_field/text_field_ui.dart';
import 'package:portal_muni/app/theme/app_colors.dart';

class InputSelect extends StatefulWidget {
  const InputSelect({
    super.key,
    required this.options,
    required this.onChanged,
    this.validator,
    this.labelText,
    this.hintText,
    this.hitSearchText,
    this.decoration,
    this.backgroundColor,
    this.radius,
    this.optionStyle,
    this.contentPadding,
    this.leading,
    this.iconColor,
    this.controller,
    this.headPadding,
    this.optionSelected = '',
    this.optionColor,
    this.optionSelectedColor = Colors.white,
  });

  final String optionSelected;
  final TextEditingController? controller;
  final List<Option> options;
  final ValueChanged<Option>? onChanged;
  final String? labelText;
  final String? hintText;
  final String? hitSearchText;
  final InputDecoration? decoration;
  final Color? backgroundColor;
  final double? radius;
  final Color? optionColor;
  final Color? iconColor;
  final Color? optionSelectedColor;
  final TextStyle? optionStyle;
  final EdgeInsets? contentPadding;
  final EdgeInsets? headPadding;
  final Widget? leading;
  final FormFieldValidator<String>? validator;
  @override
  State<InputSelect> createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {
  late List<Option> filteredOptions;
  late List<Option> options;

  @override
  void initState() {
    options = widget.options;
    filteredOptions = options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<Option>(
          context: context,
          builder: (ctx) => Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: content(ctx),
          ),
        ).then(
          (Option? value) {
            if (value != null) {
              widget.controller?.text = value.value;
              widget.onChanged!(value);
            }
          },
        );
      },
      child: Input(
        suffixIcon: Icon(
          Icons.expand_more,
          color: widget.iconColor ?? AppColor.fieldBorderColor,
        ),
        controller: widget.controller,
        labelText: widget.labelText,
        hintText: widget.hintText ?? '',
        validator: widget.validator,
        readOnly: true,
        enabled: false,
        isCollapsed: true,
        onChanged: (value) {},
      ),
    );
  }

  bool isSelected({String? id, String? value, int index = 0}) {
    bool existId = false;
    bool existValue = false;
    if (id != null) {
      existId = filteredOptions[index]
          .id!
          .toLowerCase()
          .contains(widget.optionSelected.toLowerCase());
    }
    if (value != null) {
      existValue = filteredOptions[index]
          .value
          .toLowerCase()
          .contains(widget.optionSelected.toLowerCase());
    }

    if (existId) {
      return true;
    }

    if (existValue) {
      return true;
    }

    return false;
  }

  Widget content(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 280.0,
        minHeight: 280.0,
        maxHeight: 400.0,
        maxWidth: 400.0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(widget.radius ?? 16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: StatefulBuilder(
        builder: (BuildContext _, StateSetter setState) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: ListView.builder(
                  padding: widget.contentPadding ??
                      const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  itemCount: filteredOptions.length,
                  itemBuilder: (contextBuilder, index) {
                    final option = filteredOptions[index];
                    return Container(
                      decoration: BoxDecoration(
                        //  border: Border.all(color: AppColor.fieldBorderColor),
                        color: isSelected(
                          id: option.id,
                          value: option.value,
                          index: index,
                        )
                            ? widget.optionSelectedColor
                            : widget.optionColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        minLeadingWidth: 30,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            widget.leading ??
                                Icon(
                                  Icons.circle,
                                  size: 12,
                                  color: AppColor.icon1,
                                ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop(filteredOptions[index]);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        title: Text(
                          filteredOptions[index].value,
                          style: widget.optionStyle ??
                              const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                        ),
                        subtitle: Text(
                          filteredOptions[index].alternativeValue ?? '',
                          style: widget.optionStyle ??
                              const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: widget.headPadding ??
                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Input(
                  hintText: widget.hitSearchText ?? '',
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      filteredOptions = filteredOptions
                          .where((item) => item.value
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    } else {
                      filteredOptions = widget.options;
                    }
                    setState(() => filteredOptions);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Option {
  final String value;
  final String? id;
  final String? alternativeValue;
  final int? index;

  Option({
    this.id,
    required this.value,
    this.alternativeValue = '',
    this.index = 0,
  });
}
