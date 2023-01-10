--@author Irena Bojanova(ivb)
--@date - 12/9/2022
 
 --create schema bf authorization dbo;
--go

--operandError --> faultType
--consequenceOperandError --> error
--causeOperandError --> Fault
--operandAttribute --> faultAttribute
--operationAttribute --> operationAttribute
--NO -- operationAttribute --> bugAttribute

drop table bf.finalError;
--drop table bf.error;
drop table bf.fault;
drop table bf.bug;
drop table bf.faultAttribute;
drop table bf.operand;
drop table bf.operationAttribute;
drop table bf.operation;
drop table bf.class;
drop table bf.cluster;
drop table bf.[ref.finalErrorValue];
drop table bf.[ref.finalError];
drop table bf.[ref.bugValue];
drop table bf.[ref.bug];
drop table bf.[ref.faultTypeValue];
drop table bf.[ref.faultType];
drop table bf.[ref.faultAttributeValue];
drop table bf.[ref.faultAttribute];
drop table bf.[ref.operand];
drop table bf.[ref.operationAttributeValue];
drop table bf.[ref.operationAttribute];
drop table bf.[ref.clusterType];


create table bf.[ref.clusterType] (
	Name nvarchar(16) primary key,
);

create table bf.[ref.operationAttribute] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.operationAttributeValue] (
	Attribute nvarchar(64) references bf.[ref.operationAttribute](Name) on update cascade,
	Value nvarchar(64),
		primary key (Attribute, Value),
	Definition nvarchar(256) 
);

create table bf.[ref.operand] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.faultAttribute] (
	Operand nvarchar(64) references bf.[ref.operand](Name) on update cascade,
	Name nvarchar(64),
		primary key (Operand, Name),
	Definition nvarchar(256) 
);
create table bf.[ref.faultAttributeValue] (
	Operand nvarchar(64),
	Attribute nvarchar(64),
		foreign key (Operand, Attribute) references bf.[ref.faultAttribute](Operand, Name) on update cascade,
	Value nvarchar(64) 
		primary key (Operand, Attribute, Value),
	Definition nvarchar(256) 
);

create table bf.[ref.faultType] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.faultTypeValue] (
	Fault nvarchar(64) not null references bf.[ref.faultType](Name) on update cascade,
	Value nvarchar(64),
		primary key (Fault, Value),
	Definition nvarchar(256) 
);

create table bf.[ref.bug] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.bugValue] (
	Bug nvarchar(64) not null references bf.[ref.bug](Name) on update cascade,
	Value nvarchar(64),
		primary key (Bug, Value),
	Definition nvarchar(256) 
);

create table bf.[ref.finalError] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.finalErrorValue] (
	FinalError nvarchar(64) not null references bf.[ref.finalError](Name) on update cascade,
	Value nvarchar(64),
		primary key (FinalError, Value),
	Definition nvarchar(256) 
);


-----------------

create table bf.cluster (
	Name nvarchar(64) primary key,
	Title nvarchar(64),
	Type nvarchar(16) references bf.[ref.clusterType](Name) on update cascade,
	Definition nvarchar(256),
	[Order] int not null unique
);

create table bf.class (
	Cluster nvarchar(64) references bf.cluster(Name) on update cascade,
	Name nvarchar(64) primary key,
	Title nvarchar(64),
	Definition nvarchar(256) null,
	[Order] int not null,
	unique (Cluster, [Order])
);

create table bf.operation (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Name nvarchar(64),
	primary key (Class, Name),
	Definition nvarchar(256) null,
	[Order] int not null,
	unique (Class, [Order])
);

create table bf.operationAttribute (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Attribute nvarchar(64),
	Name nvarchar(64),
		foreign key (Attribute, Name) references bf.[ref.operationAttributeValue](Attribute, Name) on update cascade,
	primary key (Class, Attribute, Name),
	[Order] int not null,
	unique (Class, Attribute, [Order])
);

create table bf.operand (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Name nvarchar(64) references bf.[ref.operand](Name) on update cascade,
	primary key (Class, Name),
	[Order] int not null,
	unique (Class, [Order])
);
create table bf.faultAttribute (
	Class nvarchar(64),
	Operand nvarchar(64),
		foreign key (Class, Operand) references bf.operand (Class, Name) on update cascade,
	Attribute nvarchar(64), 
	Name nvarchar(64),
		foreign key (Operand, Attribute, Name) references bf.[ref.faultAttributeValue] (Operand, Attribute, Value),
	primary key (Class, Operand, Attribute, Name),
	[Order] int not null,
	unique (Class, Operand, Attribute, [Order])
);

create table bf.bug (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Bug nvarchar(64),
	Name nvarchar(64),
		foreign key (Bug, Name) references bf.[ref.bugValue] (Bug, Value) on update cascade,
	primary key (Class, Bug, Name),
	[Order] int not null,
	unique (Class, Bug, [Order])
);

create table bf.fault (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Fault nvarchar(64),
	Name nvarchar(64),
		foreign key (Fault, Name) references bf.[ref.faultTypeValue] (Fault, Value) on update cascade,
	primary key (Class, Fault, Name),
	[Order] int not null,
	unique (Class, Fault, [Order])
);

--create table bf.error (
--	Class nvarchar(64) references bf.class(Name) on update cascade,
--	Error nvarchar(64),
--	Name nvarchar(64),
--		foreign key (Error, Name) references bf.[ref.faultTypeValue] (Error, Name) on update cascade,
--	primary key (Class, Error, Name),
--	[Order] int not null,
--	unique (Class, Error, [Order])
--);

create table bf.finalError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	FinalError nvarchar(64),
	Name nvarchar(64),
		foreign key (FinalError, Name) references bf.[ref.finalErrorValue] (FinalError, Value) on update cascade,
	primary key (Class, FinalError, Name),
	[Order] int not null,
	unique (Class, FinalError, [Order])
);
