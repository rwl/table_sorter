/// Copyright (C) 2013 Bogdan Taranu
///
/// Permission is hereby granted, free of charge, to any person obtaining a
/// copy of this software and associated documentation files (the "Software"),
/// to deal in the Software without restriction, including without limitation
/// the rights to use, copy, modify, merge, publish, distribute, sublicense,
/// and/or sell copies of the Software, and to permit persons to whom the
/// Software is furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
library table_sorter;

import "dart:html";
import "src/utils.dart";

/// A basic tablesorter.
class TableSorter {
  final TableElement _table;

  /// The original `<th>` (without links).
  String _originalHeaders;

  /// Used for selecting.
  int _sortingKeyCellId;

  /// Associates the [TableSorter] with an HTML table found with the
  /// given [selectors].
  factory TableSorter.select(String selectors) {
    var table = document.querySelector(selectors);
    if (table == null) {
      throw new ArgumentError.value(selectors, 'selectors');
    }
    return new TableSorter(table);
  }

  TableSorter(this._table) {
    _originalHeaders = _table.tHead.innerHtml;
    _sortingKeyCellId = 0;
  }

  /// Returns the selected table.
  TableElement get table => _table;

  /// Enables/Disables sorting for the selected table.
  void set enable(bool isEnabled) {
    if (isEnabled) {
      _table.tHead.rows[0].cells.forEach(_addLink);
    } else {
      _table.tHead.innerHtml = _originalHeaders;
    }
  }

  /// Adds a link for `<th>` cells.
  void _addLink(TableCellElement cell) {
    var anchor = new AnchorElement()
      ..href = "#"
      ..text = cell.text
      ..onClick.listen(_sortTable);
    cell.children.clear();
    cell.append(anchor);
  }

  /// Sort the table according to the selected cell key.
  void _sortTable(Event e) {
    _sortingKeyCellId =
        ((e.target as Element).parent as TableCellElement).cellIndex;
    List<TableRowElement> rowsList;
    if (!_isAlreadySorted(_table.tBodies[0].rows)) {
      rowsList = _table.tBodies[0].rows.toList(growable: false);
      rowsList.sort(_compareRows);
    } else {
      rowsList = _table.tBodies[0].rows.reversed.toList(growable: false);
    }
    _table.tBodies[0].innerHtml = "";
    _table.tBodies[0].innerHtml = _getRowsNewHtml(rowsList);
  }

  /// Used for comparing two table rows.
  int _compareRows(TableRowElement firstRow, TableRowElement secondRow) {
    int result = 0;
    var firstCell = firstRow.cells[_sortingKeyCellId].text;
    var secondCell = secondRow.cells[_sortingKeyCellId].text;
    var firstInt = tryParseInt(firstCell);
    var secondInt = tryParseInt(secondCell);
    if (firstInt == null || secondInt == null) {
      var firstDouble = tryParseDouble(firstCell);
      var secondDouble = tryParseDouble(secondCell);
      if (firstDouble == null || secondDouble == null) {
        result = firstCell.compareTo(secondCell);
      } else {
        result = firstDouble.compareTo(secondDouble);
      }
    } else {
      result = firstInt.compareTo(secondInt);
    }
    return result;
  }

  /// Verifies if a list is already sorted.
  bool _isAlreadySorted(List<TableRowElement> rows) {
    for (int i = 1; i < rows.length; i++) {
      if (_compareRows(rows[i - 1], rows[i]) > 0) {
        return false;
      }
    }
    return true;
  }

  /// Transforms a list of [TableRowElement] into HTML.
  String _getRowsNewHtml(List<TableRowElement> rows) {
    var html = new StringBuffer();
    for (var row in rows) {
      html.write(row.outerHtml);
    }
    return html.toString();
  }
}
