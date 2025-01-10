import 'package:flutter/material.dart';
import 'package:flutter_vertical_tab_bar/flutter_vertical_tab_bar.dart';

class FilterDialog extends StatefulWidget {
  final List<Map<String, String>> highlights;
  final Function(String) updateSearchQuery;

  const FilterDialog(
      {required this.highlights, required this.updateSearchQuery, Key? key})
      : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog>
    with SingleTickerProviderStateMixin {
  late List<Map<String, String>> filteredHighlights;
  late TabController _tabController;
  List<String> selectedLocations = [];
  List<String> selectedTrainingName = [];
  List<String> selectedTrainer = [];

  @override
  void initState() {
    super.initState();
    filteredHighlights = widget.highlights;
    _tabController = TabController(length: 3, vsync: this);
  }

  void updateSearchQuery(String query) {
    setState(() {
      filteredHighlights = widget.highlights
          .where((highlight) =>
              highlight['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locations =
        widget.highlights.map((e) => e['location']!).toSet().toList();
    final trainingName =
        widget.highlights.map((e) => e['speakerTitle']!).toSet().toList();
    final trainer =
        widget.highlights.map((e) => e['speaker']!).toSet().toList();

    List<String> titles = ["Locations", "Training Name", "Trainer"];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 600,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sort and Filters',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Filter Options
              Container(
                margin: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 340,
                      height: 400,
                      color: Colors.white,
                      child: VerticalTabs(
                        backgroundColor: Colors.white,
                        tabBackgroundColor: Colors.white,
                        selectedTabTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        unSelectedTabTextStyle: TextStyle(color: Colors.black),
                        indicatorColor: Colors.red,
                        tabsWidth: 100,
                        direction: TextDirection.ltr,
                        indicatorSide: IndicatorSide.start,
                        contentScrollAxis: Axis.vertical,
                        changePageDuration: const Duration(milliseconds: 500),
                        tabs: titles,
                        contents: <Widget>[
                          _buildVerticalFilterTab(locations, selectedLocations),
                          _buildVerticalFilterTab(trainingName, selectedTrainingName),
                          _buildVerticalFilterTab(trainer, selectedTrainer),
                        ],
                      ),
                    ),
                    // Container(
                    //         height: 60,
                    //         width: 240,
                    //    child:   TabBarView(
                    //         controller: _tabController,
                    //         children: [
                    //           // Location Filter
                    //           _buildVerticalFilterTab(locations, selectedLocations),
                    //           // Speaker Title Filter
                    //           _buildVerticalFilterTab(speakerTitles, selectedTrainingName),
                    //           // Speaker Filter
                    //           _buildVerticalFilterTab(speakers, selectedTrainer),
                    //         ],
                    //
                    //     ),)
                    // Column(
                    //   children: [
                    //     Container(
                    //       height: 60,
                    //       width: 240,
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: TextField(
                    //         onChanged: updateSearchQuery,
                    //         decoration: InputDecoration(
                    //           prefixIcon: Icon(
                    //             Icons.search,
                    //             color: Colors.grey,
                    //           ),
                    //           hintText: 'Search...',
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(8.0),
                    //             borderSide: BorderSide(color: Colors.grey),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 240,
                    //       child: ListView.builder(
                    //         shrinkWrap: true,
                    //         itemCount: filteredHighlights.length,
                    //         itemBuilder: (context, index) {
                    //           final highlight = filteredHighlights[index];
                    //           return ListTile(
                    //             title: Text(highlight['title']!),
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Build the filter tab with checkboxes
  Widget _buildVerticalFilterTab(
      List<String> items, List<String> selectedItems) {
    return
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 10),
            ...items.map((item) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(item,style: TextStyle(fontSize: 12),),
                value: selectedItems.contains(item,),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedItems.add(item);
                    } else {
                      selectedItems.remove(item);
                    }
                  });
                },
              );
            }).toList(),
          ],
        );

  }
}
