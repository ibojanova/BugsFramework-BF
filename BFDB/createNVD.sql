--@author Irena Bojanova(ivb)
--@date - 12/9/2022

--create schema nvd authorization dbo;
--go

drop table nvd.mapCveCwe;
drop table nvd.cve;

create table nvd.cve (
	cve varchar(16) primary key,
	description nvarchar(256) null,
	score decimal(4,1)
);

create table nvd.mapCveCwe (
	cve varchar(16) references nvd.cve(cve) on delete cascade on update cascade,
	cwe varchar(16),
		primary key (cve, cwe)
);
go

create or alter proc nvd.loadCve (@data nvarchar(max)) as
begin
	delete from nvd.cve where cve in (select cve from openjson(@data) with (cve varchar(16)));
	insert into nvd.cve (cve, description, score) 
		select cve, description, score 
		from openjson(@data) with (cve varchar(16), description nvarchar(256), score decimal(4,1));

	insert into nvd.mapCveCwe (cve, cwe) 
		select cve, w.cwe from openjson(@data) with (cve varchar(16), cwe nvarchar(max) as json) cross apply openjson(cwe) with (cwe varchar(16) '$') w;
end;