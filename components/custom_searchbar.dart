import 'package:flutter/material.dart';


/**
 * CUSTOM COMPONENT FOR CREATING SEARCHBAR
 */
class CustomSearchBox extends StatefulWidget {
  final Function onCancel;
  final Function onSearch;

  CustomSearchBox({
    @required this.onCancel,
    @required this.onSearch,
  });

  @override
  _CustomSearchBoxState createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.search,
                size: 32.0,
              ),
              onPressed: () {
                final data = _controller.value.text;
                widget.onSearch(data);
              },
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for a place or address',
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          if (_controller.value.text != '')
            FlatButton.icon(
              // color: Theme.of(context).primaryColor,
              color: Colors.transparent,
              textColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.close),
              label: const Text('Cancel'),
              onPressed: () {
                _controller.clear();
              },
            ),
        ],
      ),
    );
  }
}
