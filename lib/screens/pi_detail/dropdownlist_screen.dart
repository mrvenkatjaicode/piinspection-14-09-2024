import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../utils/constant.dart';
import '../../utils/widgets/custom_bottom_clipper.dart';

class DropDownListScreen extends StatelessWidget {
  final List<Tuple2<String?, String?>?> datalist;
  final String listtype;
  const DropDownListScreen({
    super.key,
    required this.datalist,
    required this.listtype,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          title: Text("Select $listtype"),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: height,
            width: width,
            color: greycolor.shade300,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CurvedBottomClipper(),
                  child: Container(
                    height: height / 4,
                    width: width,
                    color: const Color(kAppTheme),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 150,
                            child: TextFormField(
                              // controller:
                              //     Provider.of<DropDownListNotifier>(context)
                              //         .searchcontroller,
                              cursorHeight: 20,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                // Provider.of<DropDownListNotifier>(context,
                                //         listen: false)
                                //     .filterSearchResults(
                                //         value, widget.datalist);
                              },
                              decoration: InputDecoration(
                                hintText: "Search $listtype",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(kAppTheme),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      Icons.filter_list_rounded,
                                      color: whitecolor,
                                    ),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Provider.of<DropDownListNotifier>(context,
                                      //         listen: false)
                                      //     .filterSearchResults(
                                      //         Provider.of<DropDownListNotifier>(
                                      //                 context,
                                      //                 listen: false)
                                      //             .searchcontroller
                                      //             .text,
                                      //         widget.datalist);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(kAppTheme),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.search,
                                        color: whitecolor,
                                      ),
                                    ),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: whitecolor,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: whitecolor,
                                    width: 1,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: whitecolor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height / 8,
                  child: SizedBox(
                    height: height / 1.33,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: /*  Provider.of<DropDownListNotifier>(context,
                                            listen: false)
                                        .filteredItems
                                        .isEmpty
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/dataempty.png"),
                                          const Center(
                                            child: Text("No Record(s) Found"),
                                          ),
                                        ],
                                      )
                                    : */
                              ListView.builder(
                            shrinkWrap: true,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: datalist
                                .length /* Provider.of<DropDownListNotifier>(
                                                context,
                                                listen: false)
                                            .filteredItems
                                            .length */
                            ,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Text(datalist[index]!
                                            .item2
                                            .toString() /* Provider.of<
                                                                    DropDownListNotifier>(
                                                                context,
                                                                listen: false)
                                                            .filteredItems[index]!
                                                            .item2
                                                            .toString() */
                                        ),
                                    onTap: () {
                                      if (listtype == "Product") {}
                                      Navigator.pop(context, {
                                        'value': datalist[index]!.item2 ?? "",
                                        'code': datalist[index]!.item1 ?? ""
                                      });
                                      debugPrint(
                                          datalist[index]!.item2.toString());
                                      debugPrint(
                                          datalist[index]!.item1.toString());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
