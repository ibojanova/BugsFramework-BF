--@author Irena Bojanova(ivb)
--@date - 12/9/2022
 
 create or alter proc bf.clusters as
	select Name, Title, Type, Definition 
	from bf.cluster
	order by [Order];
go

create or alter proc bf.classes as
	select Cluster, c.Name, c.Title, c.Definition 
	from bf.class c inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order];
go

create or alter proc bf.operations as
	select Class, o.Name, o.Definition 
	from bf.operation o inner join bf.class c on o.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], o.[Order];
go

create or alter proc bf.operationAttributes as
	select a.Class, a.Attribute, a.Name
	from bf.operationAttribute a 
		inner join bf.class c on a.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], a.Attribute, a.[Order];
go

create or alter proc bf.operands as
	select Class, o.Name 
	from bf.operand o inner join bf.class c on o.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], o.[Order];
go

create or alter proc bf.operandAttributes as
	select a.Class, a.Operand, a.Attribute, a.Name 
	from bf.operandAttribute a 
		inner join bf.operand o on a.Operand = o.Name and a.Class = o.Class
		inner join bf.class c on o.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], o.[Order], a.Attribute, a.[Order];
go

create or alter proc bf.bugs as
	select b.Class, b.Bug, b.Name 
	from bf.bug b inner join bf.class c on b.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], b.Bug, b.[Order];
go

create or alter proc bf.causeOperandErrors as
	select o.Class, o.OperandError, o.Name 
	from bf.causeOperandError o inner join bf.class c on o.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], o.OperandError, o.[Order];
go

create or alter proc bf.consequenceOperandErrors as
	select o.Class, o.OperandError, o.Name 
	from bf.consequenceOperandError o inner join bf.class c on o.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], o.OperandError, o.[Order];
go

create or alter proc bf.fanalErrors as
	select o.Class, o.FinalError, o.Name 
	from bf.fanalError o inner join bf.class c on o.Class = c.Name
		inner join bf.cluster cl on c.Cluster = cl.Name
	order by cl.[Order], c.[Order], o.FinalError, o.[Order];
go

-- usage:		
exec bf.clusters
exec bf.classes
exec bf.operations
exec bf.operationAttributes
exec bf.operands
exec bf.operandAttributes
exec bf.bugs
exec bf.causeOperandErrors
exec bf.consequenceOperandErrors
exec bf.fanalErrors