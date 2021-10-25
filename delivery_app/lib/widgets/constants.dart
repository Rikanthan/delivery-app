import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        allowSorting: true,
        columnName: 'orderID',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Order ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'ownerName',
        width: 65,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Name',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'stockAddress',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Stock Address',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'deliveryAddress',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Delivery Address',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'ownerEmail',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Owner Email',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'ownerPhone',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Phone No',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'status',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Status',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'orderDate',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Order Date',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'description',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Description',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'actions',
        width: 170,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Actions',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      )
    ]
    );
    return columns;
  }