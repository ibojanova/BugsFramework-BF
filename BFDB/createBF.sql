--create schema bf authorization dbo;
--go
/*
drop table bf.fanalError;
drop table bf.consequence;
drop table bf.cause;
drop table bf.bug;
drop table bf.operandAttribute;
drop table bf.operand;
drop table bf.operationAttribute;
drop table bf.operation;
drop table bf.class;
drop table bf.cluster;
drop table bf.[ref.finalErrorValue];
drop table bf.[ref.finalError];
drop table bf.[ref.bug];
drop table bf.[ref.improperOperandValue];
drop table bf.[ref.improperOperand];
drop table bf.[ref.operandAttributeValue];
drop table bf.[ref.operandAttribute];
drop table bf.[ref.operand];
drop table bf.[ref.operationAttributeValue];
drop table bf.[ref.operationAttribute];
drop table bf.[ref.clusterType];
*/

create table bf.[ref.clusterType] (
	Name sysname primary key,
);

create table bf.[ref.operationAttribute] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.operationAttributeValue] (
	Attribute sysname references bf.[ref.operationAttribute](Name) on update cascade,
	Name sysname,
		primary key (Attribute, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.operand] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.operandAttribute] (
	Operand sysname references bf.[ref.operand](Name) on update cascade,
	Name sysname,
		primary key (Operand, Name),
	Definition nvarchar(256) 
);
create table bf.[ref.operandAttributeValue] (
	Operand sysname,
	Attribute sysname,
		foreign key (Operand, Attribute) references bf.[ref.operandAttribute](Operand, Name) on update cascade,
	Name sysname 
		primary key (Operand, Attribute, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.improperOperand] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.improperOperandValue] (
	ImproperOperand sysname not null references bf.[ref.improperOperand](Name) on update cascade,
	Name sysname,
		primary key (ImproperOperand, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.bug] (
	Name sysname primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.finalError] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.finalErrorValue] (
	FinalError sysname not null references bf.[ref.finalError](Name) on update cascade,
	Name sysname,
		primary key (FinalError, Name),
	Definition nvarchar(256) 
);


-----------------

create table bf.cluster (
	Name sysname primary key,
	Type sysname references bf.[ref.clusterType](Name) on update cascade,
	Definition nvarchar(256) 
);

create table bf.class (
	Cluster sysname references bf.cluster(Name) on update cascade,
	Name sysname primary key,
	Title sysname,
	Definition nvarchar(256) null
);

create table bf.operation (
	Class sysname references bf.class(Name) on update cascade,
	Name sysname,
	primary key (Class, Name),
	Definition nvarchar(256) null
);

create table bf.operationAttribute (
	Class sysname references bf.class(Name) on update cascade,
	Attribute sysname,
	Name sysname,
		foreign key (Attribute, Name) references bf.[ref.operationAttributeValue](Attribute, Name) on update cascade,
	primary key (Class, Attribute, Name)
);

create table bf.operand (
	Class sysname references bf.class(Name) on update cascade,
	Name sysname references bf.[ref.operand](Name) on update cascade,
	primary key (Class, Name)
);
create table bf.operandAttribute (
	Class sysname,
	Operand sysname,
		foreign key (Class, Operand) references bf.operand (Class, Name) on update cascade,
	Attribute sysname, 
	Name sysname,
		foreign key (Operand, Attribute, Name) references bf.[ref.operandAttributeValue] (Operand, Attribute, Name),
	primary key (Class, Operand, Attribute, Name)
);

create table bf.bug (
	Class sysname references bf.class(Name) on update cascade,
	Name sysname references bf.[ref.bug] (Name) on update cascade,
	primary key (Class, Name)
);

create table bf.cause (
	Class sysname references bf.class(Name) on update cascade,
	ImproperOperand sysname,
	Name sysname,
		foreign key (ImproperOperand, Name) references bf.[ref.improperOperandValue] (ImproperOperand, Name) on update cascade,
	primary key (Class, ImproperOperand, Name)
);
create table bf.consequence (
	Class sysname references bf.class(Name) on update cascade,
	ImproperOperand sysname,
	Name sysname,
		foreign key (ImproperOperand, Name) references bf.[ref.improperOperandValue] (ImproperOperand, Name) on update cascade,
	primary key (Class, ImproperOperand, Name)
);

create table bf.fanalError (
	Class sysname references bf.class(Name) on update cascade,
	FinalError sysname,
	Name sysname,
		foreign key (FinalError, Name) references bf.[ref.finalErrorValue] (FinalError, Name) on update cascade,
	primary key (Class, FinalError, Name)
);




