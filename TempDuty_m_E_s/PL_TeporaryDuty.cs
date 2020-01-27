using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PL_TeporaryDuty
/// </summary>
public class PL_TeporaryDuty
{
    public PL_TeporaryDuty()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public int sptype { get; set; }
    public int TableID { get; set; }
    public string ECODE { get; set; }

    public string Levels { get; set; }
	public string Cells { get; set; }
    public DateTime DoB { get; set; }
    public DateTime DateTime_Of_Start { get; set; }
    public decimal Gpf_Pran_No { get; set; }
    public decimal BasicPay { get; set; }
    public string Ranks { get; set; }
    public string HeadqtrOffice { get; set; }    
    public string OrderForMove_Duty { get; set; }
    public string AuthorityRule_TR_SR { get; set; }
    public string StationFrom_Journey_commenced { get; set; }
   


    public string EMP_NAME { get; set; }
    public string EmpType { get; set; }
    public string GPS_NPS { get; set; }
    public string fin_year { get; set; }
    public string CreatedBy { get; set; }
    public string UpdatedBy { get; set; }
    public int TABLEID { get; set; }
    public string xml { get; set; }
    public string MSG { get; set; }
    public string freeze_flage { get; set; }
    public string refrence_no { get; set; }
    public string ref_status { get; set; }

}
public class PL_Tempdutychild
{

    public string NameOfPlace_Arrived_At { get; set; }
    public DateTime Arvl_Date { get; set; }
    public string Arvl_Hrs { get; set; }
    public string Departure_Hrs { get; set; }
    public string Distance_by_Road { get; set; }
    public string ConveyMode { get; set; }
    public string ConveyClass { get; set; }
    public DateTime Departure_Date { get; set; }    
    public decimal NoOfDA { get; set; }
    public string Rate_RMA_DA { get; set; }
    public decimal Amount { get; set; }
    public string Remark { get; set; }



}