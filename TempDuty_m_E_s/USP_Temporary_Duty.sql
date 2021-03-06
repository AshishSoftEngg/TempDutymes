USE [MES]
GO
/****** Object:  StoredProcedure [dbo].[USP_Temporary_Duty]    Script Date: 27-Jan-20 8:14:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[USP_Temporary_Duty] 
(
	@TableID int =Null, 
	@ECODE varchar (50)= NULL,
	@EMP_NAME varchar (150) = NULL,
	@EmpType char (5) = NULL,
	@GPS_NPS varchar (50) = NULL,
	@fin_year char (9) = NULL,
	@freeze_flage char(1)=NULL,
	@refrence_no varchar(50)=NULL,
	@ref_status varchar(50)=NULL,  
	--@DOB date = null,	
	@DoB datetime = Null,
	@DateTime_Of_Start datetime = Null,
	@Gpf_Pran_No numeric(10, 2) = Null,	
	@BasicPay numeric(10, 2) = Null,
	@Levels numeric(18, 2) = Null,
	@Cells numeric(18, 2) = Null,
	@Ranks varchar (50) = Null,
	@HeadqtrOffice varchar (200) = Null,	
	@OrderForMove_Duty varchar(50) = Null,
	@AuthorityRule_TR_SR varchar(50) = Null,
	@StationFrom_Journey_commenced varchar(50) = Null,

	@is_selected char(10)=NULL,

	@CREATEDBY varchar (120) = NULL,			   
    @xmlDoc XML = null,    
    @P_MSG  varchar(max) output  , 
	@sptype int
	
)
as 
BEGIN

if (@sptype=1)
begin	
if exists (select* from TemporaryDuty_Head WHERE ECODE=@ECODE and freeze_flage='N')

begin
	set @P_MSG='Please Freeze First Record Then Save Other Data';
end
else
begin
  INSERT
  INTO TemporaryDuty_Head
    (	
	ECODE ,
	EMP_NAME,
	DoB ,
	Gpf_Pran_No,	
	Ranks,
	HeadqtrOffice,
	BasicPay,
	OrderForMove_Duty,
	AuthorityRule_TR_SR,
	StationFrom_Journey_commenced,
	DateTime_Of_Start,		
		EmpType ,
		GPS_NPS,
		fin_year,
		freeze_flage,
		refrence_no,
		CREATEDBY ,
		CREATEDDATE,
		Levels,
		Cells
    )
    VALUES
    (     
	@ECODE ,
	@EMP_NAME ,		
	@DoB ,
	@Gpf_Pran_No ,		
	@Ranks ,
	@HeadqtrOffice ,
	@BasicPay ,
	@OrderForMove_Duty ,
	@AuthorityRule_TR_SR ,
	@StationFrom_Journey_commenced ,
	@DateTime_Of_Start ,
		@EmpType ,      
		@GPS_NPS,
		@fin_year ,
		@freeze_flage,
		@refrence_no,
		@CREATEDBY ,   
		GETDATE(),
		@Levels,
		@Cells
    )
	 SET @TableID = SCOPE_IDENTITY()

---Child data Truncate table TemporaryDuty_Child  select * from TemporaryDuty_Child

Insert into TemporaryDuty_Child(TAHEADID,NameOfPlace_Arrived_At,Arvl_Date,Arvl_Hrs,Distance_by_Road,ConveyMode,ConveyClass,Departure_Date,Departure_Hrs,NoOfDA,Rate_RMA_DA,Amount,Remark) 
		SELECT @TableID,
			ParamValues.Data.value('NameOfPlace_Arrived_At[1]','varchar(120)'),			
			convert(datetime,ParamValues.Data.value('Arvl_Date[1]','varchar(50)'),103),
			ParamValues.Data.value('Arvl_Hrs[1]','nvarchar(50)'),
			ParamValues.Data.value('Distance_by_Road[1]','numeric(18, 2)'),
			ParamValues.Data.value('ConveyMode[1]','varchar(50)'),
			ParamValues.Data.value('ConveyClass[1]','varchar(50)'),
			convert(datetime,ParamValues.Data.value('Departure_Date[1]','varchar(50)'),103),
			ParamValues.Data.value('Departure_Hrs[1]','nvarchar(50)'),
			ParamValues.Data.value('NoOfDA[1]','numeric(18, 2)'),
			ParamValues.Data.value('Rate_RMA_DA[1]','numeric(18, 2)'),
			ParamValues.Data.value('Amount[1]','numeric(18, 2)'),
			ParamValues.Data.value('Remark[1]','nvarchar(500)')

			from @xmlDoc.nodes('root/data') AS ParamValues (data)
			update Advance_Reimburse_Master
		set 
		   is_selected='Y'
		   where advance_refno=@refrence_no
	set @P_MSG='Record Save Successfully.';
    
  end
END;
if(@SpType=2)--Update Data into T_DRCActivities
begin	
if exists (select* from TemporaryDuty_Head WHERE refrence_no=@refrence_no and refrence_no!=@refrence_no)

begin
	set @P_MSG='Record Already Exist For '+ @refrence_no+'';
end
else
begin
update TemporaryDuty_Head
set 
ECODE=@ECODE,
EMP_NAME=@EMP_NAME ,		
	Levels=@Levels,
	Cells=@Cells,
	DoB = @DoB ,
	Gpf_Pran_No = @Gpf_Pran_No ,	
	Ranks = @Ranks ,
	HeadqtrOffice = @HeadqtrOffice ,
	BasicPay = @BasicPay ,
	OrderForMove_Duty = @OrderForMove_Duty ,
	AuthorityRule_TR_SR = @AuthorityRule_TR_SR ,
	StationFrom_Journey_commenced = @StationFrom_Journey_commenced ,
	DateTime_Of_Start = @DateTime_Of_Start ,		

EmpType=@EmpType ,      
GPS_NPS=@GPS_NPS,
fin_year=@fin_year ,
freeze_flage=@freeze_flage,
CREATEDBY=@CREATEDBY , 
refrence_no=@refrence_no,
UPDATEDDATE=getdate()
where TABID=@TableID
-----Child data
Delete from TemporaryDuty_Child where TAHEADID=@TableID	
Insert into TemporaryDuty_Child(taheadid,NameOfPlace_Arrived_At,Arvl_Date,Arvl_Hrs,Distance_by_Road,ConveyMode,ConveyClass,Departure_Date,Departure_Hrs,NoOfDA,Rate_RMA_DA,Amount,Remark) 
		SELECT @TableID,
			ParamValues.Data.value('NameOfPlace_Arrived_At[1]','varchar(120)'),			
			convert(datetime,ParamValues.Data.value('Arvl_Date[1]','varchar(50)'),103),
			ParamValues.Data.value('Arvl_Hrs[1]','nvarchar(50)'),
			ParamValues.Data.value('Distance_by_Road[1]','numeric(18, 2)'),
			ParamValues.Data.value('ConveyMode[1]','varchar(50)'),
			ParamValues.Data.value('ConveyClass[1]','varchar(50)'),
			convert(datetime,ParamValues.Data.value('Departure_Date[1]','varchar(50)'),103),
			ParamValues.Data.value('Departure_Hrs[1]','nvarchar(50)'),
			ParamValues.Data.value('NoOfDA[1]','numeric(18, 2)'),
			ParamValues.Data.value('Rate_RMA_DA[1]','numeric(18, 2)'),
			ParamValues.Data.value('Amount[1]','numeric(18, 2)'),
			ParamValues.Data.value('Remark[1]','nvarchar(500)')

			from @xmlDoc.nodes('root/data') AS ParamValues (data)
			 update Advance_Reimburse_Master
		set 
		    is_selected='Y'
		   where advance_refno=@refrence_no
			set @P_MSG='Record  Successfully Updated'
end
end
if(@SpType=3) --Bind Grid
begin
--Select M_TuitionFee_Head.*,des_type_name,freeze_flage from M_TuitionFee_Head
--inner join M_Designation_Type  on M_Designation_Type.DES_Type_Id=M_TuitionFee_Head.EmpType
Select * from TemporaryDuty_Head
left outer join M_Designation_Type  on M_Designation_Type.DES_Type_Id= TemporaryDuty_Head.EmpType
left outer join Advance_Reimburse_Master  on Advance_Reimburse_Master.Advance_refno= TemporaryDuty_Head.refrence_no
left outer join M_Department on M_Department.DepartmentCode=TemporaryDuty_Head.HeadqtrOffice
end
if(@SpType=5) --Select Record to update
begin    
Select TABID,ECODE,EMP_NAME,EmpType,GPS_NPS,fin_year,freeze_flage,refrence_no,CREATEDBY,DoB,Levels,Cells,Gpf_Pran_No,Ranks,HeadqtrOffice,BasicPay,OrderForMove_Duty,AuthorityRule_TR_SR,
	StationFrom_Journey_commenced,DateTime_Of_Start from TemporaryDuty_Head where TABID=@TableID
end     
if (@sptype=6)--edit Child table
		Begin
		Select NameOfPlace_Arrived_At,Arvl_Date,Arvl_Hrs,Distance_by_Road,ConveyMode,ConveyClass,Departure_Date,Departure_Hrs,NoOfDA,Rate_RMA_DA,Amount,Remark from TemporaryDuty_Child where  TAHEADID=@TableID
		end
		if (@sptype=7)--DELETE HEAD AND CHILD
		Begin
		DELETE FROM TemporaryDuty_Head WHERE TABID=@TableID
		delete from TemporaryDuty_Child where TAHEADID=@TableID
		set @P_MSG='Record Deleted Successfully!'	
		end

		if (@sptype=8)--Freeze HEAD AND CHILD
		Begin
		update  TemporaryDuty_Head 
		set
		    freeze_flage=@freeze_flage
			where TABID=@TableID
        update Advance_Reimburse_Master
		set 
		   ref_status=@ref_status
		   where advance_refno=@refrence_no
		set @P_MSG=' Record Successfully Frozen'
		end
		if(@SpType=9) --Bind Grid
begin
--Select M_TuitionFee_Head.*,des_type_name,freeze_flage from M_TuitionFee_Head
--inner join M_Designation_Type  on M_Designation_Type.DES_Type_Id=M_TuitionFee_Head.EmpType
select Convert(varchar,( advance_Date))+ +'/' + advance_refno as Refrenceno from Advance_Reimburse_Master
end
end
