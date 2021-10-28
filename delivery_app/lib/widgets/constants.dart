import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<String> deliveryColumnName = ["ownerName","stockAddress","deliveryAddress",
"ownerEmail","ownerPhoneNumber","status","orderDate","description"];

List<String> deliveryHeaders = ["Name","Stock Address","Delivery Address","Email",
"Phone No","Status","Order Date","Description"];

List<String> removalColumnName = ["ownerName","stockAddress","deliveryAddress",
"ownerEmail","ownerPhoneNumber","serviceType","status","orderDate","description"];

List<String> removalHeaders = ["Name","Stock Address","Delivery Address","Email",
"Phone No","Removal Type","status","Order Date","Description"];

List<String> transportColumnName = ["name","email","phone","address",
"description","frightTo","frightfrom","orderDate","status"];

List<String> transportHeaders = ["Name","Email","Phone","Address",
"Description","Fright To","Freight From","Order Date","Status"];

List<String> cleaningColumnName = ["name","email","phone","address",
"description","orderDate","status"];

List<String> cleaningHeaders = ["Name","Email","Phone","Address",
"Description","Order Date","Status"];

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
        width: i == 0 ? 65 
        : columnName[i].contains("description") ? 170 :
         columnName[i].contains("status") ? 120 : 100,
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
    cleaning,
    feedback    
  }