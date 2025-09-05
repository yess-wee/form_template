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

EasyFormBuilder(
    title: "Contact Form",
    fields: [
        TextFieldConfig(
            key: "name",
            label: "Full Name*",
            isRequired: true,
        ),
        TextFieldConfig(
            key: "email",
            label: "Email Address*",
            isRequired: true,
        ),
        DropdownConfig(
            key: "country",
            label: "Country",
            options: []
                OptionItem(label: "USA", value: "us"),
                OptionItem(label: "Canada", value: "ca"),
                OptionItem(label: "UK", value: "uk"),
                ,
        ),
        CheckboxConfig(
            key: "newsletter",
            label: "Subscribe to newsletter",
        ),
        DatePickerConfig(
            key: "birthdate",
            label: "Birth Date",
            enableFutureDates: false,
        ),
        TimePickerConfig(
            key: "preferred_time",
            label: "SELECT TIME",
        ),
        TextAreaConfig(
            key: "message",
            label: "Message",
            maxLines: 5,
        ),
    ],
    onSubmit: (data) {
    print("Form submitted: $data");
    },
)
