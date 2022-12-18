--create schema bf authorization dbo;
--go

create table bf.[ref.clusterType] (
	Name sysname primary key,
);

create table bf.[ref.operationAttributeType] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.operationAttribute] (
	Type sysname references bf.[ref.operationAttributeType](Name) on update cascade,
	Name sysname,
		primary key (Type, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.operand] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.operandAttributeType] (
	Operand sysname references bf.[ref.operand](Name) on update cascade,
	Name sysname,
		primary key (Operand, Name),
	Definition nvarchar(256) 
);
create table bf.[ref.operandAttribute] (
	Operand sysname,
	Type sysname,
		foreign key (Operand, Type) references bf.[ref.operandAttributeType](Operand, Name) on update cascade,
	Name sysname 
		primary key (Operand, Type, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.improperOperandType] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.improperOperand] (
	Type sysname not null references bf.[ref.improperOperandType](Name) on update cascade,
	Name sysname,
		primary key (Type, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.bug] (
	Name sysname primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.finalErrorType] (
	Name sysname primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.finalError] (
	Type sysname not null references bf.[ref.finalErrorType](Name) on update cascade,
	Name sysname,
		primary key (Type, Name),
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
	Type sysname,
	Name sysname,
		foreign key (Type, Name) references bf.[ref.operationAttribute](Type, Name) on update cascade,
	primary key (Class, Type, Name)
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
	Type sysname, 
	Name sysname,
		foreign key (Operand, Type, Name) references bf.[ref.operandAttribute] (Operand, Type, Name),
	primary key (Class, Operand, Type, Name)
);

create table bf.theBug (
	Class sysname references bf.class(Name) on update cascade,
	Name sysname references bf.[ref.bug] (Name) on update cascade,
	primary key (Class, Name)
);

create table bf.cause (
	Class sysname references bf.class(Name) on update cascade,
	Type sysname,
	Name sysname,
		foreign key (Type, Name) references bf.[ref.improperOperand] (Type, Name) on update cascade,
	primary key (Class, Type, Name)
);
create table bf.consequence (
	Class sysname references bf.class(Name) on update cascade,
	Type sysname,
	Name sysname,
		foreign key (Type, Name) references bf.[ref.improperOperand] (Type, Name) on update cascade,
	primary key (Class, Type, Name)
);

create table bf.fanalError (
	Class sysname references bf.class(Name) on update cascade,
	Type sysname,
	Name sysname,
		foreign key (Type, Name) references bf.[ref.finalError] (Type, Name) on update cascade,
	primary key (Class, Type, Name)
);




