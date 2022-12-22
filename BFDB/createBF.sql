--create schema bf authorization dbo;
--go
/*
drop table bf.fanalError;
drop table bf.consequenceOperandError;
drop table bf.causeOperandError;
drop table bf.bug;
drop table bf.operandAttribute;
drop table bf.operand;
drop table bf.operationAttribute;
drop table bf.operation;
drop table bf.class;
drop table bf.cluster;
drop table bf.[def.finalErrorValue];
drop table bf.[def.finalError];
drop table bf.[def.bugValue];
drop table bf.[def.bug];
drop table bf.[def.operandErrorValue];
drop table bf.[def.operandError];
drop table bf.[def.operandAttributeValue];
drop table bf.[def.operandAttribute];
drop table bf.[def.operand];
drop table bf.[def.operationAttributeValue];
drop table bf.[def.operationAttribute];
drop table bf.[def.clusterType];
*/

create table bf.[def.clusterType] (
	Name nvarchar(16) primary key,
);

create table bf.[def.operationAttribute] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);
create table bf.[def.operationAttributeValue] (
	Attribute nvarchar(64) references bf.[def.operationAttribute](Name) on update cascade,
	Name nvarchar(64),
		primary key (Attribute, Name),
	Definition nvarchar(256) 
);

create table bf.[def.operand] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);
create table bf.[def.operandAttribute] (
	Operand nvarchar(64) references bf.[def.operand](Name) on update cascade,
	Name nvarchar(64),
		primary key (Operand, Name),
	Definition nvarchar(256) 
);
create table bf.[def.operandAttributeValue] (
	Operand nvarchar(64),
	Attribute nvarchar(64),
		foreign key (Operand, Attribute) references bf.[def.operandAttribute](Operand, Name) on update cascade,
	Name nvarchar(64) 
		primary key (Operand, Attribute, Name),
	Definition nvarchar(256) 
);

create table bf.[def.operandError] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[def.operandErrorValue] (
	OperandError nvarchar(64) not null references bf.[def.operandError](Name) on update cascade,
	Name nvarchar(64),
		primary key (OperandError, Name),
	Definition nvarchar(256) 
);

create table bf.[def.bug] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[def.bugValue] (
	Bug nvarchar(64) not null references bf.[def.bug](Name) on update cascade,
	Name nvarchar(64),
		primary key (Bug, Name),
	Definition nvarchar(256) 
);

create table bf.[def.finalError] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[def.finalErrorValue] (
	FinalError nvarchar(64) not null references bf.[def.finalError](Name) on update cascade,
	Name nvarchar(64),
		primary key (FinalError, Name),
	Definition nvarchar(256) 
);


-----------------

create table bf.cluster (
	Name nvarchar(64) primary key,
	Title nvarchar(64),
	Type nvarchar(16) references bf.[def.clusterType](Name) on update cascade,
	Definition nvarchar(256) 
);

create table bf.class (
	Cluster nvarchar(64) references bf.cluster(Name) on update cascade,
	Name nvarchar(64) primary key,
	Title nvarchar(64),
	Definition nvarchar(256) null
);

create table bf.operation (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Name nvarchar(64),
	primary key (Class, Name),
	Definition nvarchar(256) null
);

create table bf.operationAttribute (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Attribute nvarchar(64),
	Name nvarchar(64),
		foreign key (Attribute, Name) references bf.[def.operationAttributeValue](Attribute, Name) on update cascade,
	primary key (Class, Attribute, Name)
);

create table bf.operand (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Name nvarchar(64) references bf.[def.operand](Name) on update cascade,
	primary key (Class, Name)
);
create table bf.operandAttribute (
	Class nvarchar(64),
	Operand nvarchar(64),
		foreign key (Class, Operand) references bf.operand (Class, Name) on update cascade,
	Attribute nvarchar(64), 
	Name nvarchar(64),
		foreign key (Operand, Attribute, Name) references bf.[def.operandAttributeValue] (Operand, Attribute, Name),
	primary key (Class, Operand, Attribute, Name)
);

create table bf.bug (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Bug nvarchar(64),
	Name nvarchar(64),
		foreign key (Bug, Name) references bf.[def.bugValue] (Bug, Name) on update cascade,
	primary key (Class, Bug, Name)
);

create table bf.causeOperandError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	OperandError nvarchar(64),
	Name nvarchar(64),
		foreign key (OperandError, Name) references bf.[def.operandErrorValue] (OperandError, Name) on update cascade,
	primary key (Class, OperandError, Name)
);
create table bf.consequenceOperandError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	OperandError nvarchar(64),
	Name nvarchar(64),
		foreign key (OperandError, Name) references bf.[def.operandErrorValue] (OperandError, Name) on update cascade,
	primary key (Class, OperandError, Name)
);

create table bf.fanalError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	FinalError nvarchar(64),
	Name nvarchar(64),
		foreign key (FinalError, Name) references bf.[def.finalErrorValue] (FinalError, Name) on update cascade,
	primary key (Class, FinalError, Name)
);




