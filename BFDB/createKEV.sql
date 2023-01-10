
--@author Irena Bojanova(ivb)
--@date - 12/9/2022
 
--create schema kev authorization dbo;
--

create table kev.cve (
	cve varchar(16) primary key,
	vendorProject varchar(16), 
	product varchar(16), 
	vulnerabilityName nvarchar(128), 
	dateAdded  date, 
	shortDescription nvarchar(256)
);
go

create or alter proc kev.loadCve (@data nvarchar(max)) as
begin
	delete from kev.cve where cve in (select cve from openjson(@data) with (cve varchar(16)));
	insert into kev.cve (cve, vendorProject, product, vulnerabilityName, dateAdded, shortDescription) 
		select cve, vendorProject, product, vulnerabilityName, dateAdded, shortDescription 
		from openjson(@data) with (cve varchar(16), vendorProject varchar(16), product varchar(16), vulnerabilityName nvarchar(128), dateAdded  date, shortDescription nvarchar(256));
end;