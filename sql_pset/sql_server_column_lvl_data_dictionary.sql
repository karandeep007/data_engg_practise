SELECT
	schemas.name AS SchemaName,
	tables.name AS TableName,
	columns.name AS ColumnName,
	types.name AS DataTypeName,
	columns.max_length,
	columns.precision,
	columns.scale,
	columns.is_nullable
FROM sys.tables
INNER JOIN sys.columns
ON tables.object_id = columns.object_id
INNER JOIN sys.types
ON types.user_type_id = columns.user_type_id
INNER JOIN sys.schemas
ON schemas.schema_id = tables.schema_id
WHERE tables.is_ms_shipped = 0
and columns.name like '%password%'