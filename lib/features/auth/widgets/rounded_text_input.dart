import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Pill-shaped rounded text input matching the Quickox auth capsule design.
/// Features a leading icon, divider, double-tier floating label, and optional trailing widget.
class RoundedTextInput extends StatefulWidget {
  const RoundedTextInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixWidget,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool enabled;

  @override
  State<RoundedTextInput> createState() => _RoundedTextInputState();
}

class _RoundedTextInputState extends State<RoundedTextInput> {
  late final FocusNode _effectiveFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _effectiveFocusNode.dispose();
    } else {
      _effectiveFocusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() => _isFocused = _effectiveFocusNode.hasFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller.text,
      validator: widget.validator,
      builder: (FormFieldState<String> fieldState) {
        final hasError = fieldState.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.enabled) {
                  _effectiveFocusNode.requestFocus();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                constraints: const BoxConstraints(minHeight: 62),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                    color: hasError
                        ? AppColors.error
                        : (_isFocused ? AppColors.primary : const Color(0xFFD1D5DB)),
                    width: _isFocused || hasError ? 1.8 : 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    // ── Prefix Icon ───────────────────────────────────────────
                    if (widget.prefixIcon != null) ...[
                      Icon(
                        widget.prefixIcon,
                        size: 20,
                        color: _isFocused
                            ? AppColors.primary
                            : const Color(0xFF6B7280),
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        color: const Color(0xFFD1D5DB),
                      ),
                    ],

                    // ── Label + Input ─────────────────────────────────────────
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.labelText,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: _isFocused
                                  ? AppColors.primary
                                  : const Color(0xFF9CA3AF),
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          TextField(
                            controller: widget.controller,
                            focusNode: _effectiveFocusNode,
                            enabled: widget.enabled,
                            keyboardType: widget.keyboardType,
                            textCapitalization: widget.textCapitalization,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              letterSpacing: 0.2,
                              height: 1.2,
                            ),
                            cursorColor: AppColors.primary,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: widget.hintText,
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF9CA3AF),
                                letterSpacing: 0.2,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              filled: false,
                            ),
                            onChanged: (value) {
                              fieldState.didChange(value);
                              widget.onChanged?.call(value);
                            },
                            onSubmitted: widget.onSubmitted,
                          ),
                        ],
                      ),
                    ),

                    // ── Optional Trailing Suffix Widget ───────────────────────
                    if (widget.suffixWidget != null) widget.suffixWidget!,
                  ],
                ),
              ),
            ),

            // ── Error Message ─────────────────────────────────────────────────
            if (hasError) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  fieldState.errorText ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.error,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
