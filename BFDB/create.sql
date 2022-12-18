--NVD
--create schema nvd authorization dbo;
--go

--create table nvd.cve (
--	cve varchar(16) primary key,
--	score decimal(4,1)
--);

--create table nvd.mapCveCwe (
--	cve varchar(16) references nvd.cve(cve) on delete cascade on update cascade,
--	cwe varchar(16),
--		primary key (cve, cwe)
--);
--go

--create proc nvd.loadCve (@data nvarchar(max)) as
--begin
--	delete from nvd.cve where cve in (select cve from openjson(@data) with (cve varchar(16)));
--	insert into nvd.cve (cve, score) 
--		select cve, score from openjson(@data) with (cve varchar(16), score decimal(4,1));
--	insert into nvd.mapCveCwe (cve, cwe) 
--		select cve, w.cwe from openjson(@data) with (cve varchar(16), cwe nvarchar(max) as json) cross apply openjson(cwe) with (cwe varchar(16) '$') w;
--end;


--KEV
create schema kev authorization dbo;
go

create table kev.cve (
	cve varchar(16) primary key,
	vendorProject varchar(16), 
	product varchar(16), 
	vulnerabilityName nvarchar(128), 
	dateAdded  date, 
	shortDescription nvarchar(256)
);
go

create proc kev.loadCve (@data nvarchar(max)) as
begin
	delete from kev.cve where cve in (select cve from openjson(@data) with (cve varchar(16)));
	insert into kev.cve (cve, vendorProject, product, vulnerabilityName, dateAdded, shortDescription) 
		select cve, vendorProject, product, vulnerabilityName, dateAdded, shortDescription from openjson(@data) with (cve varchar(16), vendorProject varchar(16), product varchar(16), vulnerabilityName nvarchar(128), dateAdded  date, shortDescription nvarchar(256));
end;