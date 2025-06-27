import 'package:flutter/material.dart';
import '../components.dart';

class SearchByWidget extends StatefulWidget {
  final bool withCategory;
  final List<String> listOfCategories;
  final String? initialCategoryValue;
  final void Function(String catg, String searchText) onChanged;

  //final String searchText;
  const SearchByWidget({
    super.key,
    this.withCategory = false,
    required this.listOfCategories,
    required this.onChanged,

    /// required this.searchText,
    this.initialCategoryValue,
  });

  @override
  State<SearchByWidget> createState() => _SearchByWidgetState();
}

class _SearchByWidgetState extends State<SearchByWidget> {
  String searchText = '';
  String? selectedCategory;
  @override
  void initState() {
    /// load the initial value
    if (widget.initialCategoryValue != null) {
      selectedCategory = widget.initialCategoryValue;
    } else if (widget.listOfCategories.isNotEmpty) {
      selectedCategory = widget.listOfCategories[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          (widget.withCategory)
              ? SizedBox(
                  width: 160,
                  //  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),

                    /// a dropdown button with a list of categories
                    child: DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'By',
                      ),
                      dropdownColor: Colors.white.withOpacity(0.8),
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 18,
                      elevation: 8,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                        widget.onChanged.call(newValue!, searchText);
                      },
                      items: widget.listOfCategories
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                          .toList(),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (fillterText) {
                  setState(() {
                    searchText = fillterText;
                  });
                  widget.onChanged(selectedCategory!, fillterText);
                },
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                decoration: InputDecoration(
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: null,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      //  color: null,
                      //color: null,
                    ),
                  ),
                  suffixIcon: const Icon(Icons.search_outlined, size: 18),
                  hintText: 'Search',
                  contentPadding: const EdgeInsets.fromLTRB(
                    20.0,
                    15.0,
                    20.0,
                    15.0,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: null,
                    ),
                  ),
                  filled: true,
                  fillColor: AppConstants.whiteOpacity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
