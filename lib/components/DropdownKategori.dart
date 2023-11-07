import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:nutricare/theme.dart';

class DropdownKategori extends StatefulWidget {
  final List<dynamic> categories;
  const DropdownKategori({super.key, required this.categories});

  @override
  State<DropdownKategori> createState() => _DropdownKategoriState();
}

class _DropdownKategoriState extends State<DropdownKategori> {
 
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    List<dynamic> categories = widget.categories;

    return Container(
      width: 280,
      height: 40,
      child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Kategori Status Gizi',
                      style: inclusiveSans.copyWith(fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items:categories
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              item,
                              style: inclusiveSans.copyWith(fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: selectedValue != null ? Colors.white : Colors.black,),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: selectedValue != null ? 0 : 5 ,
                            ),
                            Divider(
                              thickness: selectedValue != null ? 0 : 1,
                              color: selectedValue != null ? biruungu : Colors.grey[200],
                            )
                          ],
                        ),
                      )).toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                  
                });
              },
              buttonStyleData: ButtonStyleData(
                height: 50,
                width: 160,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: biruungu,
                ),
                elevation: 2,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconSize: 20,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                offset: const Offset(0, -4),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all<double>(6),
                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 45,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
    );
  }
}