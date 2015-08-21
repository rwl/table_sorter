import 'dart:html';
import 'package:test/test.dart';
import 'package:table_sorter/table_sorter.dart';

tableSorterTest() {
  group('TableSorter', () {
    test("select", () {
      var sorter = new TableSorter.select("#projectTable");
      expect(sorter, isNotNull);
    });
  });

  group("enable", () {
    test("add links to table headers", () {
      var sorter = new TableSorter.select("#projectTable");
      sorter.enable = true;
      var hasLinks = new RegExp(
          '<tr><th><a href="#">Name</a></th><th><a href="#">Age</a></th>');
      var result = sorter.table.outerHtml.contains(hasLinks);
      sorter.enable = false;
      expect(result, isTrue);
    });
    test("remove links", () {
      var noLinks = '<tr><th>Name</th><th>Age</th>';
      var hasLinks = new RegExp(
          '<tr><th><a href="#">Name</a></th><th><a href="#">Age</a></th>');
      var sorter = new TableSorter.select("#projectTable");
      sorter.table.tHead.innerHtml = noLinks;

      sorter.enable = true;
      sorter.enable = false;

      expect(sorter.table.outerHtml.contains(hasLinks), isFalse);
    });
  });

  group('table', () {
    test("select", () {
      var sorter = new TableSorter.select("#projectTable");
      var element = document.querySelector("#projectTable");
      expect(sorter.table, equals(element));
    });
  });
}

void main() => tableSorterTest();
