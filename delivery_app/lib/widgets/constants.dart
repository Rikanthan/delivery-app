import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<String> deliveryColumnName = ["ownerName","stockAddress","deliveryAddress",
"ownerEmail","ownerPhoneNumber","status","orderDate","description","action"];

List<String> deliveryHeaders = ["Name","Stock Address","Delivery Address","Email",
"Phone No","Status","Order Date","Description","Action"];

List<String> removalColumnName = ["ownerName","stockAddress","deliveryAddress",
"ownerEmail","ownerPhoneNumber","serviceType","status","orderDate","description","action"];

List<String> removalHeaders = ["Name","Stock Address","Delivery Address","Email",
"Phone No","Removal Type","status","Order Date","Description","Action"];

List<String> transportColumnName = ["name","email","phone","address",
"description","frightTo","frightfrom","orderDate","status","action"];

List<String> transportHeaders = ["Name","Email","Phone","Address",
"Description","Fright To","Freight From","Order Date","Status","Action"];

List<String> cleaningColumnName = ["name","email","phone","address",
"description","orderDate","status","action"];

List<String> cleaningHeaders = ["Name","Email","Phone","Address",
"Description","Order Date","Status","Action"];

List<GridColumn> getColumns(List<String> columnName, List<String> headers) {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        allowSorting: true,
        columnName: 'orderId',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Delivery ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      for(int i = 0 ; i < columnName.length ; i++) 
          GridColumn(
        allowSorting: true,
        columnName: columnName[i],
        width: i == 0 ? 65 : i == columnName.length - 1 ? 170 : 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            headers[i],
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
    ]
    );
    return columns;
  }

  enum ServicesClicked
  {
    delivery,
    removal,
    transport,
    cleaning    
  }