#table_sorter

A [Dart][] package which adds links to an HTML table that enable sorting
rows according to column values without the use of CSS.

All cells in the table header are transformed into "sorting anchors". By
clicking a "sorting anchor" once, all the table's rows are ordered ascending
according to the "sorting anchor" corresponding column. By clicking the same
"sorting anchor" a second time, the table's rows are ordered descending
according to the "sorting anchor" corresponding column.

## Usage

```html
<table border="1" id="userTable">
  <thead>
    <tr><th>Name</th><th>Age</th></tr>
  </thead>
  <tbody>
    <tr><td>John</td><td>20</td></tr>
    <tr><td>Jim</td><td>51</td></tr>
    <tr><td>Amy</td><td>40</td></tr>
    <tr><td>Malcolm</td><td>60</td></tr> 
  </tbody>
</table>
```

```dart
import "dart:html";
import "package:table_sorter/table_sorter.dart";

void main() {
  var sorter = new TableSorter.select("#userTable")
    ..enable = true;     
}
```

[Dart]: https://www.dartlang.org/
