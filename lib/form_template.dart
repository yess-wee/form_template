library form_template;
import 'package:flutter/material.dart';

class FormBuilder extends StatefulWidget {
  final List<FormField> fields;
  final String? title;
  final String submitButtonText;
  final Function(Map<String, dynamic>)? onSubmit;
  final EdgeInsets? padding;

  const FormBuilder({
    super.key,
    required this.fields,
    this.title,
    this.submitButtonText = "SUBMIT",
    this.onSubmit,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (var field in widget.fields) {
      if (field is TextFieldConfig || field is TextAreaConfig || field is NumberFieldConfig) {
        _controllers[field.key] = TextEditingController(text: field.initialValue?.toString() ?? '');
      }
      if (field.initialValue != null) {
        _formData[field.key] = field.initialValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: widget.padding!,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.fields.map((field) => _buildField(field)),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF18446B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _handleSubmit,
                    child: Text(
                      widget.submitButtonText,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(FormField field) {
    Widget fieldWidget;

    switch (field.runtimeType) {
      case TextFieldConfig:
        fieldWidget = _buildTextField(field as TextFieldConfig);
        break;
      case TextAreaConfig:
        fieldWidget = _buildTextArea(field as TextAreaConfig);
        break;
      case NumberFieldConfig:
        fieldWidget = _buildNumberField(field as NumberFieldConfig);
        break;
      case DropdownConfig:
        fieldWidget = _buildDropdown(field as DropdownConfig);
        break;
      case CheckboxConfig:
        fieldWidget = _buildCheckbox(field as CheckboxConfig);
        break;
      case CheckboxGroupConfig:
        fieldWidget = _buildCheckboxGroup(field as CheckboxGroupConfig);
        break;
      case RadioGroupConfig:
        fieldWidget = _buildRadioGroup(field as RadioGroupConfig);
        break;
      case SwitchConfig:
        fieldWidget = _buildSwitch(field as SwitchConfig);
        break;
      case DatePickerConfig:
        fieldWidget = _buildDatePicker(field as DatePickerConfig);
        break;
      case TimePickerConfig:
        fieldWidget = _buildTimePicker(field as TimePickerConfig);
        break;
      case SliderConfig:
        fieldWidget = _buildSlider(field as SliderConfig);
        break;
      case SectionHeaderConfig:
        fieldWidget = _buildSectionHeader(field as SectionHeaderConfig);
        break;
      case SpacerConfig:
        fieldWidget = _buildSpacer(field as SpacerConfig);
        break;
      default:
        fieldWidget = const SizedBox.shrink();
    }

    return Column(
      children: [
        fieldWidget,
        SizedBox(height: field.spacing ?? 20),
      ],
    );
  }

  Widget _buildTextField(TextFieldConfig config) {
    return TextFormField(
      controller: _controllers[config.key],
      decoration: InputDecoration(
        labelText: config.label,
        hintText: config.hint,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF18446B), width: 2.0),
        ),
      ),
      validator: config.isRequired
          ? (value) => value?.isEmpty ?? true ? 'This field is required' : null
          : null,
      onChanged: (value) => _formData[config.key] = value,
    );
  }

  Widget _buildTextArea(TextAreaConfig config) {
    return TextFormField(
      controller: _controllers[config.key],
      maxLines: config.maxLines,
      decoration: InputDecoration(
        labelText: config.label,
        hintText: config.hint,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF18446B), width: 2.0),
        ),
      ),
      validator: config.isRequired
          ? (value) => value?.isEmpty ?? true ? 'This field is required' : null
          : null,
      onChanged: (value) => _formData[config.key] = value,
    );
  }

  Widget _buildNumberField(NumberFieldConfig config) {
    return TextFormField(
      controller: _controllers[config.key],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: config.label,
        hintText: config.hint,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF18446B), width: 2.0),
        ),
      ),
      validator: (value) {
        if (config.isRequired && (value?.isEmpty ?? true)) {
          return 'This field is required';
        }
        if (value != null && value.isNotEmpty) {
          final num? numValue = num.tryParse(value);
          if (numValue == null) return 'Please enter a valid number';
          if (config.min != null && numValue < config.min!) {
            return 'Value must be at least ${config.min}';
          }
          if (config.max != null && numValue > config.max!) {
            return 'Value must be at most ${config.max}';
          }
        }
        return null;
      },
      onChanged: (value) => _formData[config.key] = num.tryParse(value),
    );
  }

  Widget _buildDropdown(DropdownConfig config) {
    return DropdownButtonFormField<String>(
      value: _formData[config.key],
      decoration: InputDecoration(
        labelText: config.label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF18446B)),
        ),
      ),
      items: config.options.map((option) {
        return DropdownMenuItem<String>(
          value: option.value,
          child: Text(option.label),
        );
      }).toList(),
      validator: config.isRequired
          ? (value) => value == null ? 'Please select an option' : null
          : null,
      onChanged: (value) => setState(() => _formData[config.key] = value),
    );
  }

  Widget _buildCheckbox(CheckboxConfig config) {
    return CheckboxListTile(
      title: Text(config.label),
      subtitle: config.subtitle != null ? Text(config.subtitle!) : null,
      value: _formData[config.key] ?? false,
      activeColor: const Color(0xFF18446B),
      onChanged: (value) => setState(() => _formData[config.key] = value ?? false),
    );
  }

  Widget _buildCheckboxGroup(CheckboxGroupConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (config.label != null) ...[
          Text(config.label!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
        ],
        ...config.options.map((option) {
          final selectedOptions = List<String>.from(_formData[config.key] ?? []);
          return CheckboxListTile(
            title: Text(option.label),
            value: selectedOptions.contains(option.value),
            activeColor: const Color(0xFF18446B),
            onChanged: (checked) {
              setState(() {
                if (checked == true) {
                  selectedOptions.add(option.value);
                } else {
                  selectedOptions.remove(option.value);
                }
                _formData[config.key] = selectedOptions;
              });
            },
          );
        }),
      ],
    );
  }

  Widget _buildRadioGroup(RadioGroupConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (config.label != null) ...[
          Text(config.label!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
        ],
        ...config.options.map((option) {
          return RadioListTile<String>(
            title: Text(option.label),
            value: option.value,
            groupValue: _formData[config.key],
            activeColor: const Color(0xFF18446B),
            onChanged: (value) => setState(() => _formData[config.key] = value),
          );
        }),
      ],
    );
  }

  Widget _buildSwitch(SwitchConfig config) {
    return SwitchListTile(
      title: Text(config.label),
      subtitle: config.subtitle != null ? Text(config.subtitle!) : null,
      value: _formData[config.key] ?? false,
      activeColor: const Color(0xFF18446B),
      onChanged: (value) => setState(() => _formData[config.key] = value),
    );
  }

  Widget _buildDatePicker(DatePickerConfig config) {
    final selectedDate = _formData[config.key] as DateTime?;
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedDate == null
                ? config.label
                : '${config.label}: ${_formatDate(selectedDate)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: selectedDate == null ? FontWeight.normal : FontWeight.bold,
              color: selectedDate == null ? Colors.black54 : const Color(0xFF18446B),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _selectDate(config),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF18446B),
            padding: const EdgeInsets.all(8),
          ),
          child: const Icon(Icons.calendar_today, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTimePicker(TimePickerConfig config) {
    final selectedTime = _formData[config.key] as TimeOfDay?;
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => _selectTime(config),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF18446B),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(config.label, style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 20),
        Text(
          selectedTime == null
              ? "00:00"
              : "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildSlider(SliderConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${config.label}: ${(_formData[config.key] ?? config.initialValue ?? config.min).toStringAsFixed(config.divisions != null ? 0 : 1)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          value: (_formData[config.key] ?? config.initialValue ?? config.min).toDouble(),
          min: config.min,
          max: config.max,
          divisions: config.divisions,
          activeColor: const Color(0xFF18446B),
          onChanged: (value) => setState(() => _formData[config.key] = value),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(SectionHeaderConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (config.showDivider) const Divider(),
        Text(
          config.title,
          style: TextStyle(
            fontSize: config.fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF18446B),
          ),
        ),
        if (config.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            config.subtitle!,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ],
    );
  }

  Widget _buildSpacer(SpacerConfig config) {
    return SizedBox(height: config.height);
  }

  Future<void> _selectDate(DatePickerConfig config) async {
    final initialDate = _formData[config.key] as DateTime? ?? DateTime.now();
    final firstDate = config.enablePastDates ? DateTime(1900) : DateTime.now();
    final lastDate = config.enableFutureDates ? DateTime(2100) : DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() => _formData[config.key] = picked);
    }
  }

  Future<void> _selectTime(TimePickerConfig config) async {
    final initialTime = _formData[config.key] as TimeOfDay? ?? TimeOfDay.now();
    final picked = await showTimePicker(context: context, initialTime: initialTime);

    if (picked != null) {
      setState(() => _formData[config.key] = picked);
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call(_formData);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

// Base class for all form fields
abstract class FormField {
  final String key;
  final double? spacing;
  final dynamic initialValue;

  FormField({required this.key, this.spacing, this.initialValue});
}

// Text Field Configuration
class TextFieldConfig extends FormField {
  final String label;
  final String? hint;
  final bool isRequired;

  TextFieldConfig({
    required super.key,
    required this.label,
    this.hint,
    this.isRequired = false,
    super.spacing,
    super.initialValue,
  });
}

// Text Area Configuration
class TextAreaConfig extends FormField {
  final String label;
  final String? hint;
  final bool isRequired;
  final int maxLines;

  TextAreaConfig({
    required super.key,
    required this.label,
    this.hint,
    this.isRequired = false,
    this.maxLines = 4,
    super.spacing,
    super.initialValue,
  });
}

// Number Field Configuration
class NumberFieldConfig extends FormField {
  final String label;
  final String? hint;
  final bool isRequired;
  final num? min;
  final num? max;

  NumberFieldConfig({
    required super.key,
    required this.label,
    this.hint,
    this.isRequired = false,
    this.min,
    this.max,
    super.spacing,
    super.initialValue,
  });
}

// Dropdown Configuration
class DropdownConfig extends FormField {
  final String label;
  final List<OptionItem> options;
  final bool isRequired;

  DropdownConfig({
    required super.key,
    required this.label,
    required this.options,
    this.isRequired = false,
    super.spacing,
    super.initialValue,
  });
}

// Checkbox Configuration
class CheckboxConfig extends FormField {
  final String label;
  final String? subtitle;

  CheckboxConfig({
    required super.key,
    required this.label,
    this.subtitle,
    super.spacing,
    super.initialValue = false,
  });
}

// Checkbox Group Configuration
class CheckboxGroupConfig extends FormField {
  final String? label;
  final List<OptionItem> options;

  CheckboxGroupConfig({
    required super.key,
    this.label,
    required this.options,
    super.spacing,
    super.initialValue = const <String>[],
  });
}

// Radio Group Configuration
class RadioGroupConfig extends FormField {
  final String? label;
  final List<OptionItem> options;

  RadioGroupConfig({
    required super.key,
    this.label,
    required this.options,
    super.spacing,
    super.initialValue,
  });
}

// Switch Configuration
class SwitchConfig extends FormField {
  final String label;
  final String? subtitle;

  SwitchConfig({
    required super.key,
    required this.label,
    this.subtitle,
    super.spacing,
    super.initialValue = false,
  });
}

// Date Picker Configuration
class DatePickerConfig extends FormField {
  final String label;
  final bool enablePastDates;
  final bool enableFutureDates;

  DatePickerConfig({
    required super.key,
    required this.label,
    this.enablePastDates = true,
    this.enableFutureDates = true,
    super.spacing,
    super.initialValue,
  });
}

// Time Picker Configuration
class TimePickerConfig extends FormField {
  final String label;

  TimePickerConfig({
    required super.key,
    required this.label,
    super.spacing,
    super.initialValue,
  });
}

// Slider Configuration
class SliderConfig extends FormField {
  final String label;
  final double min;
  final double max;
  final int? divisions;

  SliderConfig({
    required super.key,
    required this.label,
    required this.min,
    required this.max,
    this.divisions,
    super.spacing,
    super.initialValue,
  });
}

// Section Header Configuration
class SectionHeaderConfig extends FormField {
  final String title;
  final String? subtitle;
  final double fontSize;
  final bool showDivider;

  SectionHeaderConfig({
    required super.key,
    required this.title,
    this.subtitle,
    this.fontSize = 18,
    this.showDivider = false,
    super.spacing,
  });
}

// Spacer Configuration
class SpacerConfig extends FormField {
  final double height;

  SpacerConfig({
    required super.key,
    this.height = 20,
  });
}

// Option Item for dropdowns, radio buttons, checkboxes
class OptionItem {
  final String label;
  final String value;

  OptionItem({required this.label, required this.value});
}

