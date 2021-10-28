
import 'package:flutter/material.dart';
import 'package:flutter_eatit/state/place_order_state.dart';
import 'package:flutter_eatit/strings/place_order_strings.dart';
import 'package:flutter_eatit/utils/const.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderScreen extends StatelessWidget {
  var placeOrderState = Get.put(PlaceOrderController());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final commentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(placeOrderText),
      ),
      body: Form(
        key: formKey,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: firstNameController,
                            validator: ValidationBuilder(
                                    requiredMessage:
                                        '$firstNameText $isRequiredText')
                                .required()
                                .build(),
                            decoration: InputDecoration(
                                hintText: firstNameText,
                                label: Text(firstNameText),
                                border: OutlineInputBorder()))),
                    SizedBox(width: 8),
                    Expanded(
                        child: TextFormField(
                            controller: lastNameController,
                            validator: ValidationBuilder(
                                    requiredMessage:
                                        '$lastNameText $isRequiredText')
                                .required()
                                .build(),
                            decoration: InputDecoration(
                                hintText: lastNameText,
                                label: Text(lastNameText),
                                border: OutlineInputBorder())))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: addressController,
                        validator: ValidationBuilder(
                                requiredMessage: '$addressText $isRequiredText')
                            .required()
                            .build(),
                        decoration: InputDecoration(
                            hintText: addressText,
                            label: Text(addressText),
                            border: OutlineInputBorder()))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentText,
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        RadioListTile<String>(
                            title: const Text(codText),
                            value: COD_VAL,
                            groupValue: placeOrderState.paymentSelected.value,
                            onChanged: (String? v) {
                              placeOrderState.paymentSelected.value = v!;
                            }),
                        RadioListTile<String>(
                            title: const Text(brainTreeText),
                            value: BRAINTREE_VAL,
                            groupValue: placeOrderState.paymentSelected.value,
                            onChanged: (String? v) {
                              placeOrderState.paymentSelected.value = v!;
                            })
                      ],
                    )),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: commentController,
                        validator: ValidationBuilder(
                                requiredMessage: '$commentText $isRequiredText')
                            .required()
                            .build(),
                        decoration: InputDecoration(
                            hintText: commentText,
                            label: Text(commentText),
                            border: OutlineInputBorder()))
                  ],
                ),
                Spacer(),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text(placeOrderText),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('OK');
                          }
                        }))
              ],
            )),
      ),
    ));
  }
}
