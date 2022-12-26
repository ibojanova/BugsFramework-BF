--create schema bf authorization dbo;
--go

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
drop table bf.[ref.finalErrorValue];
drop table bf.[ref.finalError];
drop table bf.[ref.bugValue];
drop table bf.[ref.bug];
drop table bf.[ref.operandErrorValue];
drop table bf.[ref.operandError];
drop table bf.[ref.operandAttributeValue];
drop table bf.[ref.operandAttribute];
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
	Name nvarchar(64),
		primary key (Attribute, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.operand] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);
create table bf.[ref.operandAttribute] (
	Operand nvarchar(64) references bf.[ref.operand](Name) on update cascade,
	Name nvarchar(64),
		primary key (Operand, Name),
	Definition nvarchar(256) 
);
create table bf.[ref.operandAttributeValue] (
	Operand nvarchar(64),
	Attribute nvarchar(64),
		foreign key (Operand, Attribute) references bf.[ref.operandAttribute](Operand, Name) on update cascade,
	Name nvarchar(64) 
		primary key (Operand, Attribute, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.operandError] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.operandErrorValue] (
	OperandError nvarchar(64) not null references bf.[ref.operandError](Name) on update cascade,
	Name nvarchar(64),
		primary key (OperandError, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.bug] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.bugValue] (
	Bug nvarchar(64) not null references bf.[ref.bug](Name) on update cascade,
	Name nvarchar(64),
		primary key (Bug, Name),
	Definition nvarchar(256) 
);

create table bf.[ref.finalError] (
	Name nvarchar(64) primary key,
	Definition nvarchar(256) 
);

create table bf.[ref.finalErrorValue] (
	FinalError nvarchar(64) not null references bf.[ref.finalError](Name) on update cascade,
	Name nvarchar(64),
		primary key (FinalError, Name),
	Definition nvarchar(256) 
);


-----------------

create table bf.cluster (
	Name nvarchar(64) primary key,
	Title nvarchar(64),
	Type nvarchar(16) references bf.[ref.clusterType](Name) on update cascade,
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
		foreign key (Attribute, Name) references bf.[ref.operationAttributeValue](Attribute, Name) on update cascade,
	primary key (Class, Attribute, Name)
);

create table bf.operand (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Name nvarchar(64) references bf.[ref.operand](Name) on update cascade,
	primary key (Class, Name)
);
create table bf.operandAttribute (
	Class nvarchar(64),
	Operand nvarchar(64),
		foreign key (Class, Operand) references bf.operand (Class, Name) on update cascade,
	Attribute nvarchar(64), 
	Name nvarchar(64),
		foreign key (Operand, Attribute, Name) references bf.[ref.operandAttributeValue] (Operand, Attribute, Name),
	primary key (Class, Operand, Attribute, Name)
);

create table bf.bug (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	Bug nvarchar(64),
	Name nvarchar(64),
		foreign key (Bug, Name) references bf.[ref.bugValue] (Bug, Name) on update cascade,
	primary key (Class, Bug, Name)
);

create table bf.causeOperandError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	OperandError nvarchar(64),
	Name nvarchar(64),
		foreign key (OperandError, Name) references bf.[ref.operandErrorValue] (OperandError, Name) on update cascade,
	primary key (Class, OperandError, Name)
);
create table bf.consequenceOperandError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	OperandError nvarchar(64),
	Name nvarchar(64),
		foreign key (OperandError, Name) references bf.[ref.operandErrorValue] (OperandError, Name) on update cascade,
	primary key (Class, OperandError, Name)
);

create table bf.fanalError (
	Class nvarchar(64) references bf.class(Name) on update cascade,
	FinalError nvarchar(64),
	Name nvarchar(64),
		foreign key (FinalError, Name) references bf.[ref.finalErrorValue] (FinalError, Name) on update cascade,
	primary key (Class, FinalError, Name)
);




