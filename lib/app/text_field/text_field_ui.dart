import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portal_muni/app/text_field/helpers/mask.dart';
import 'package:portal_muni/app/theme/app_colors.dart';

class Input extends FormField<String> {
  Input({
    super.key,
    this.controller,
    Widget? suffixIcon,
    String? initialValue,
    FocusNode? focusNode,
    String? labelText,
    TextStyle? labelStyle,
    String? hintText,
    TextStyle? hintStyle,
    MaskText? maskText,
    InputDecoration? decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    bool? isCollapsed = true,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    super.onSaved,
    super.validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor = Colors.grey,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    MouseCursor? mouseCursor,
  })  : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(
          maxLength == null ||
              maxLength == TextField.noMaxLength ||
              maxLength > 0,
        ),
        super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _DSInputState state = field as _DSInputState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    if (labelText != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            labelText,
                            style: style?.copyWith(
                                  fontSize: style.fontSize ?? 16,
                                  fontWeight:
                                      style.fontWeight ?? FontWeight.w600,
                                  height: style.height ?? 2,
                                  color: style.color ?? AppColor.textFieldColor,
                                ) ??
                                TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 2,
                                  fontFamily: 'Montserrat',
                                  color: AppColor.textFieldColor,
                                ),
                          ),
                        ],
                      ),
                    SizedBox(
                      child: TextField(
                        restorationId: restorationId,
                        controller: state._effectiveController,
                        focusNode: focusNode,
                        decoration: effectiveDecoration.copyWith(
                          errorText: state.errorText,
                          suffixIcon: suffixIcon,
                          hintText: hintText,
                          contentPadding: decoration?.contentPadding ??
                              const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                          counterStyle: decoration?.counterStyle ??
                              TextStyle(
                                color: AppColor.textFieldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                          filled: decoration?.filled ?? true,
                          isCollapsed: decoration?.isCollapsed,
                          fillColor:
                              decoration?.fillColor ?? Colors.transparent,
                          focusColor: Colors.transparent,
                          focusedErrorBorder: decoration?.focusedErrorBorder ??
                              const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                          focusedBorder: decoration?.focusedBorder ??
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.fieldBorderColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                          hintStyle: hintStyle ??
                              const TextStyle(
                                color: Color(0xFF949494),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                          errorMaxLines: decoration?.errorMaxLines ?? 1,
                          helperStyle: decoration?.helperStyle ??
                              const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF494949),
                              ),
                          errorStyle: decoration?.errorStyle ??
                              const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                          border: decoration?.border ??
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.fieldBorderColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                          errorBorder: decoration?.errorBorder ??
                              const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                          enabledBorder: decoration?.enabledBorder ??
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.fieldBorderColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                          disabledBorder: decoration?.disabledBorder ??
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.fieldBorderColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                        ),
                        keyboardType: keyboardType,
                        textInputAction: textInputAction,
                        style: style ??
                            TextStyle(
                              color: style?.color ?? AppColor.textFieldColor,
                              fontWeight: style?.fontWeight ?? FontWeight.w400,
                              fontSize: style?.fontSize ?? 16,
                            ),
                        strutStyle: strutStyle,
                        textAlign: textAlign,
                        textAlignVertical: textAlignVertical,
                        textDirection: textDirection,
                        textCapitalization: textCapitalization,
                        autofocus: autofocus,
                        readOnly: readOnly,
                        showCursor: showCursor,
                        obscuringCharacter: obscuringCharacter,
                        obscureText: obscureText,
                        autocorrect: autocorrect,
                        smartDashesType: smartDashesType ??
                            (obscureText
                                ? SmartDashesType.disabled
                                : SmartDashesType.enabled),
                        smartQuotesType: smartQuotesType ??
                            (obscureText
                                ? SmartQuotesType.disabled
                                : SmartQuotesType.enabled),
                        enableSuggestions: enableSuggestions,
                        maxLengthEnforcement: maxLengthEnforcement,
                        maxLines: maxLines,
                        minLines: minLines,
                        expands: expands,
                        maxLength: maxLength,
                        onChanged: onChangedHandler,
                        onTap: onTap,
                        onEditingComplete: onEditingComplete,
                        onSubmitted: onFieldSubmitted,
                        inputFormatters:
                            maskText == null ? inputFormatters : [maskText],
                        enabled: (enabled == true && onTap != null) ||
                            (enabled == null && onTap == null),
                        cursorWidth: cursorWidth,
                        cursorHeight: cursorHeight,
                        cursorRadius: cursorRadius,
                        cursorColor: cursorColor,
                        scrollPadding: scrollPadding,
                        scrollPhysics: scrollPhysics,
                        keyboardAppearance: keyboardAppearance,
                        enableInteractiveSelection:
                            enableInteractiveSelection ??
                                (!obscureText || !readOnly),
                        selectionControls: selectionControls,
                        buildCounter: buildCounter,
                        autofillHints: autofillHints,
                        scrollController: scrollController,
                        enableIMEPersonalizedLearning:
                            enableIMEPersonalizedLearning,
                        mouseCursor: mouseCursor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _DSInputState();
}

class _DSInputState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _dsInput.controller ?? _controller!.value;

  Input get _dsInput => super.widget as Input;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }

    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_dsInput.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    } else {
      _dsInput.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_dsInput.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _dsInput.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _dsInput.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_dsInput.controller != null) {
        setValue(_dsInput.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _dsInput.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
