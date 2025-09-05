import 'package:flutter/material.dart';
import 'package:form_template/form_template.dart';

class Homepage extends StatefulWidget {
  final String title;

  const Homepage({super.key, required this.title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: FormBuilder(
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
      ),
    );
  }
}
