program DataTable;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Data,
  CNClrLib.Enums,
  CNClrLib.Host,
  CNClrLib.Core;

var
  DataSet: _DataSet;


  procedure MakeParentTable;
  var
    table: _DataTable;
    column: _DataColumn;
    row: _DataRow;
    primaryKeyColumns: _DataColumnArray;
    I: Integer;
  begin
    // Create a new DataTable.
    table := CoDataTable.CreateInstance('ParentTable');

    // Create new DataColumn, set DataType,
    // ColumnName and add to DataTable.
    column := CoDataColumn.CreateInstance;
    column.DataType := TClrAssembly.GetType('System.Int32');
    column.ColumnName := 'id';
    column.ReadOnly_ := true;
    column.Unique := true;
    // Add the Column to the DataColumnCollection.
    table.Columns.Add(column);

    // Create second column.
    column := CoDataColumn.CreateInstance;
    column.DataType := TClrAssembly.GetType('System.String');
    column.ColumnName := 'ParentItem';
    column.AutoIncrement := false;
    column.Caption := 'ParentItem';
    column.ReadOnly_ := false;
    column.Unique := false;
    // Add the column to the table.
    table.Columns.Add(column);

    // Make the ID column the primary key column.
    primaryKeyColumns := CoDataColumnArray.CreateInstance(1);
    primaryKeyColumns[0] := table.Columns.Item_1['id'];
    table.PrimaryKey := primaryKeyColumns;

    // Instantiate the DataSet variable.
    DataSet := CoDataSet.CreateInstance;
    // Add the new DataTable to the DataSet.
    DataSet.Tables.Add(table);

    // Create three new DataRow objects and add
    // them to the DataTable
    for I := 0 to 2 do
    begin
      row := table.NewRow;
      row.Item_1['id'] := i;
      row.Item_1['ParentItem'] := 'ParentItem ' + i.ToString;
      table.Rows.Add(row);
    end;
  end;

  procedure MakeChildTable;
  var
    table: _DataTable;
    column: _DataColumn;
    row: _DataRow;
    I: Integer;
  begin
    // Create a new DataTable.
    table := CoDataTable.CreateInstance('childTable');

    // Create first column and add to the DataTable.
    column := CoDataColumn.CreateInstance;
    column.DataType := TClrAssembly.GetType('System.Int32');
    column.ColumnName := 'ChildID';
    column.AutoIncrement := true;
    column.Caption := 'ID';
    column.ReadOnly_ := true;
    column.Unique := true;

    // Add the column to the DataColumnCollection.
    table.Columns.Add(column);

    // Create second column.
    column := CoDataColumn.CreateInstance;
    column.DataType := TClrAssembly.GetType('System.String');
    column.ColumnName := 'ChildItem';
    column.AutoIncrement := false;
    column.Caption := 'ChildItem';
    column.ReadOnly_ := false;
    column.Unique := false;
    table.Columns.Add(column);

    // Create third column.
    column := CoDataColumn.CreateInstance;
    column.DataType := TClrAssembly.GetType('System.Int32');
    column.ColumnName := 'ParentID';
    column.AutoIncrement := false;
    column.Caption := 'ParentID';
    column.ReadOnly_ := false;
    column.Unique := false;
    table.Columns.Add(column);

    DataSet.Tables.Add(table);

    // Create three sets of DataRow objects,
    // five rows each, and add to DataTable.
    for I := 0 to 4 do
    begin
      row := table.NewRow;
      row.Item_1['childID'] := i;
      row.Item_1['ChildItem'] := 'Item ' + i.ToString;
      row.Item_1['ParentID'] := 0;
      table.Rows.Add(row);
    end;

    for I := 0 to 4 do
    begin
      row := table.NewRow;
      row.Item_1['childID'] := i + 5;
      row.Item_1['ChildItem'] := 'Item ' + i.ToString;
      row.Item_1['ParentID'] := 1;
      table.Rows.Add(row);
    end;

    for I := 0 to 4 do
    begin
      row := table.NewRow;
      row.Item_1['childID'] := i + 10;
      row.Item_1['ChildItem'] := 'Item ' + i.ToString;
      row.Item_1['ParentID'] := 2;
      table.Rows.Add(row);
    end;
  end;

  procedure MakeDataRelation;
  var
    parentColumn,
    childColumn: _DataColumn;
    relation: _DataRelation;
  begin
    // DataRelation requires two DataColumn
    // (parent and child) and a name.
    parentColumn := DataSet.Tables.Item_1['ParentTable'].Columns.Item_1['id'];
    childColumn := DataSet.Tables.Item_1['ChildTable'].Columns.Item_1['ParentID'];
    relation := CoDataRelation.CreateInstance('parent2Child', parentColumn, childColumn);
    DataSet.Tables.Item_1['ChildTable'].ParentRelations.Add(relation);
  end;

  procedure MakeDataTables;
  begin
    // Run all of the functions.
    MakeParentTable;
    MakeChildTable;
    MakeDataRelation;
  end;

begin
  try
    MakeDataTables;
  except
    on E: Exception do
    begin
      Writeln(E.message);
    end;
  end;
end.
