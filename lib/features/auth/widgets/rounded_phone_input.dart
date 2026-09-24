import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../models/country_code.dart';
import 'country_picker_prefix.dart';

/// Pill-shaped rounded phone input with internal "Mobile number" label and country code prefix.
/// Matches the Quickox rounded design with primary color accent.
class RoundedPhoneInput extends StatefulWidget {
  const RoundedPhoneInput({
    super.key,
    required this.controller,
    required this.selectedCountry,
    required this.onCountryChanged,
    this.labelText = 'Mobile number',
    this.hintText = '1234567890',
    this.validator,
    this.onChanged,
    this.focusNode,
    this.enabled = true,
  });

  final TextEditingController controller;
  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountryChanged;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final bool enabled;

  @override
  State<RoundedPhoneInput> createState() => _RoundedPhoneInputState();
}

class _RoundedPhoneInputState extends State<RoundedPhoneInput> {
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
                height: 62,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                    // ── Country Code ──────────────────────────────────────────
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.enabled
                          ? () async {
                              final chosen = await showCountryPickerSheet(
                                context,
                                selected: widget.selectedCountry,
                              );
                              if (chosen != null) {
                                widget.onCountryChanged(chosen);
                              }
                            }
                          : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.selectedCountry.code,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Vertical Divider ──────────────────────────────────────
                    Container(
                      width: 1,
                      height: 24,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      color: const Color(0xFFD1D5DB),
                    ),

                    // ── Mobile Number Label + Input ───────────────────────────
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              letterSpacing: 0.5,
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
                                letterSpacing: 0.5,
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
                          ),
                        ],
                      ),
                    ),
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
