# 🧱 FormBuilder

`FormBuilder` is a simple and extensible Flutter package that allows you to build dynamic, customizable forms with minimal code. It supports a wide range of input field types like text, dropdown, checkbox, date picker, time picker, and more — all defined using simple configuration objects.

---

## ✨ Features

- ✅ Easily create forms with different field types
- 🧩 Modular field configuration (TextField, Dropdown, Checkbox, DatePicker, etc.)
- 📅 Date and time pickers included
- 🔄 Custom `onSubmit` callback with all form data
- 📐 Responsive and accessible form layout
- 🛠️ Easily extendable for custom fields

---

## 🚀 Getting Started

Add the package to your `pubspec.yaml`:

---
## 📦 Usage

```dart
FormBuilder(
        fields: [
          TextFieldConfig(
            key: "name",
            label: "FULL NAME*",
            isRequired: true,
          ),
          TextFieldConfig(
            key: "email",
            label: "EMAIL*",
            isRequired: true,
          ),
          DropdownConfig(
            key: "department",
            label: "DEPARTMENT",
            options: [
              OptionItem(label: "IT", value: "it"),
              OptionItem(label: "ADMIN", value: "admin"),
              OptionItem(label: "HR", value: "hr"),
            ],
          ),
          CheckboxConfig(
            key: "eligible",
            label: "ELIGIBLE?",
          ),
          DatePickerConfig(
            key: "birthdate",
            label: "DATE OF BIRTH",
            enableFutureDates: false,
          ),
          TimePickerConfig(
            key: "preferred_time",
            label: "MEETING TIME",
          ),
          TextAreaConfig(
            key: "message",
            label: "MESSAGE",
            maxLines: 5,
          ),
        ],
        onSubmit: (formData) {
          print("Form submitted: $formData");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Form submitted successfully!"),
              backgroundColor: Colors.green,
            ),
          );
       },
      )

