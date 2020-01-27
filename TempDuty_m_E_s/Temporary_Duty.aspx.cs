using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Payroll_Master_Temporary_Duty : System.Web.UI.Page
{
    CommonCode cc = new CommonCode();
    PL_TeporaryDuty pl = new PL_TeporaryDuty();
    BL_TemporaryDuty bl = new BL_TemporaryDuty();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           


             DataTable dt = new DataTable();
            dt.Columns.Add("NameOfPlace_Arrived_At");
            dt.Columns.Add("Arvl_Date");
            dt.Columns.Add("Arvl_Hrs");
            dt.Columns.Add("Distance_by_Road");
            dt.Columns.Add("ConveyMode");
            dt.Columns.Add("ConveyClass");
            dt.Columns.Add("Departure_Date");
            dt.Columns.Add("Departure_Hrs");
            dt.Columns.Add("NoOfDA");
            dt.Columns.Add("Rate_RMA_DA");
            dt.Columns.Add("Amount");
            dt.Columns.Add("Remark");

            ViewState["dt"] = dt;

            bind_FinancialYear();
            binddesig_type();
            bindchildgrd();
            bindgrdData();

            cc.FillDDL(ref ddlHdtrOffice, "---Select Department---", "DepartmentName", "DepartmentCode", "M_Department");
            ddlHdtrOffice.SelectedIndex = 1;

        }
    }

    protected void bind_FinancialYear()
    {
        try
        {
            CultureInfo Cult = new CultureInfo("hi-IN");
            int previousyear = Convert.ToDateTime(DateTime.Now, Cult).Year - 1;
            int currentyear = Convert.ToDateTime(DateTime.Now, Cult).Year;
            string str = "select * from [M_Financial_Year] order by year_id asc";
            DataTable dt = SQL_DBCS.ExecuteDataTable(str);


            if (dt.Rows.Count > 0)
            {
                ddlFinancial.DataTextField = "fin_year";
                ddlFinancial.DataValueField = "fin_year";
                ddlFinancial.DataSource = dt;
                ddlFinancial.DataBind();

                ddlFinancial.Items.Insert(0, "--Select--");
            }
            int year = Convert.ToDateTime(DateTime.Now).Year;
            year = Convert.ToDateTime(DateTime.Now).Year;
            if (year == 2019)
            {
                ddlFinancial.SelectedValue = "2019-2020";
            }
            else if (year == 2020)
            {
                ddlFinancial.SelectedValue = "2020-2021";
            }
            else if (year == 2021)
            {
                ddlFinancial.SelectedValue = "2021-2022";
            }
            else if (year == 2022)
            {
                ddlFinancial.SelectedValue = "2022-2023";
            }


        }
        catch (Exception ex)
        {
            Messagebox.Show(ex.Message);
        }
    }
    public void binddesig_type()
    {
        string str = "select DES_Type_Name, DES_Type_Id from M_Designation_Type";
        //DataTable dt = cc.EQ(str);
        DataTable dt = SQL_DBCS.ExecuteDataTable(str);
        if (dt.Rows.Count > 0)
        {
            ddlEmpType.DataSource = dt;
            ddlEmpType.DataTextField = "DES_Type_Name";
            ddlEmpType.DataValueField = "DES_Type_Id";
            ddlEmpType.DataBind();
            ddlEmpType.Items.Insert(0, new ListItem("--Select--", "0"));

        }
    }

    protected void ddlEmpType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_emp();
    }

    private void bind_emp()
    {
        string str = "";
        if (ddlEmpType.SelectedIndex > 0)
        {
            str = " select NAME+' ('+CODE+')' NAME, CODE from V_paybill where DESG_TYPE='" + ddlEmpType.SelectedValue.ToString().Trim() + "' and GPF_TYPE='" + ddlGpsMps.SelectedItem.Text + "' order by NAME";
        }
        else
        {
            str = " select NAME+' ('+CODE+')' NAME, CODE from V_paybill  order by NAME";

        }
        DataTable dt = cc.EQ(str);
        if (dt.Rows.Count > 0)
        {
            ddl_emp.DataTextField = "NAME";
            ddl_emp.DataValueField = "CODE";
            ddl_emp.DataSource = dt;
            ddl_emp.DataBind();
            ddl_emp.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        else
        {
            ddl_emp.Items.Clear();
        }
    }



    protected void Add_Click(object sender, EventArgs e)
    {
        if (txtNameOfArrived.Text.Trim() != "" && txtArrivalDate.Text != "" && txtArrivalHrs.Text.Trim() != "" && txtDistanceRoad.Text.Trim() != "" && txtConveyMode.Text.Trim() != "" && txtConveyClass.Text.Trim() != "" && txtDepartureDate.Text.Trim() != "" && txtDepartureHrs.Text.Trim() != "" && txtNoDA.Text.Trim() != "" && txtRateofRMADA.Text.Trim() != "" && txtAmount.Text.Trim() != "" && txtRemark.Text.Trim() != "")
        {
            DataTable dt = ViewState["dt"] as DataTable;
            dt.Rows.Add(txtNameOfArrived.Text.Trim(), txtArrivalDate.Text, txtArrivalHrs.Text.Trim(), txtDistanceRoad.Text.Trim(), txtConveyMode.Text.Trim(), txtConveyClass.Text.Trim(), txtDepartureDate.Text.Trim(), txtDepartureHrs.Text.Trim(), txtNoDA.Text.Trim(), txtRateofRMADA.Text.Trim(), txtAmount.Text.Trim(), txtRemark.Text.Trim());
            ViewState["dt"] = dt;
            bindchildgrd();

            txtNameOfArrived.Text = string.Empty;
            txtArrivalDate.Text = string.Empty;
            txtArrivalHrs.Text = string.Empty;
            txtDistanceRoad.Text = string.Empty;
            txtConveyMode.Text = string.Empty;
            txtConveyClass.Text = string.Empty;
            txtDepartureDate.Text = string.Empty;
            txtDepartureHrs.Text = string.Empty;
            txtNoDA.Text = string.Empty;
            txtRateofRMADA.Text = string.Empty;
            txtAmount.Text = string.Empty;
            txtRemark.Text = string.Empty;
        }
        else
        {
            Messagebox.Show("Please Fill All Fields Mandatory (*) Fields!");
        }
    }
    public void bindchildgrd()
    {
        Grd.DataSource = ViewState["dt"] as DataTable;
        Grd.DataBind();
    }



    protected void grd_data_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grd_data.PageIndex = e.NewPageIndex;
            // BindEditGrid();
        }
        catch (Exception ex)
        {

            Messagebox.Show(ex.Message);
        }
    }

    public bool validate()
    {
      


        if (ddlFinancial.SelectedIndex == 0)
        {
            Messagebox.Show("Please Select Financial Year No.");
            return false;
        }
        if (ddlEmpType.SelectedIndex == 0)
        {
            Messagebox.Show("Please Select Designation Type.");
            return false;
        }
        if (ddl_emp.SelectedIndex == 0)
        {
            Messagebox.Show("Please Select Employee Name.");
            return false;
        }
        if (ddlGpsMps.SelectedIndex == 0)
        {
            Messagebox.Show("Please Select Gpf/Nps.");
            return false;
        }
        if (ddlHdtrOffice.SelectedIndex == 0)
        {
            Messagebox.Show("Please Select Headquarters/Office.");
            return false;
        }        
        if (txtOfMDuty.Text == "")
        {
            Messagebox.Show("Please Enter Order for Move/Duty.");
            return false;
        }
        if (txtAuthRole.Text == "")
        {
            Messagebox.Show("Please Enter Autherity(Role in TR/SL).");
            return false;
        }
        if (txtDateTimeStrt.Text == "")
        {
            Messagebox.Show("Please Enter 	Date and Time of Start.");
            return false;
        }
        if (txtStationfrmjnycom.Text == "")
        {
            Messagebox.Show("Please Enter Station from where Journey Commenced.");
            return false;
        }

        
        return true;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (validate() == true)
            {

                Save();
            }

        }
        catch (Exception ex)
        {
            Messagebox.Show(ex.ToString());

        }
    }
    void BindGridDisplay()
    {
        DataSet ds = new DataSet();

        if (ds.Tables.Count > 0)
        {
            grd_data.DataSource = ds.Tables[0];
            grd_data.DataBind();
        }
        else
        {
            grd_data.EmptyDataText = "No Record Available";
            grd_data.DataSource = null;
            grd_data.DataBind();
        }
    }
    private void Save()
    {

      //  string format = "d";
        CultureInfo cult = new CultureInfo("hi-IN");
        string ref_no = "";
        if (Ddl_advancerefNo.SelectedIndex > 0)
        {
            ref_no = Ddl_advancerefNo.SelectedItem.Text;
        }
        else
        {
            ref_no = "";
        }
        pl.fin_year = ddlFinancial.SelectedValue;
        pl.EmpType = ddlEmpType.SelectedValue;
        pl.ECODE = ddl_emp.SelectedValue;
        pl.EMP_NAME = ddl_emp.SelectedItem.Text;

        pl.GPS_NPS = ddlGpsMps.SelectedValue;
        pl.refrence_no = ref_no;
        pl.freeze_flage = "N";

         pl.DoB = Convert.ToDateTime(lblDoB.Text);
         pl.DateTime_Of_Start = Convert.ToDateTime(txtDateTimeStrt.Text);
        pl.Ranks = lblRank.Text.ToString();
        pl.Gpf_Pran_No = Convert.ToDecimal(lblGPFNo.Text.Trim());
        pl.BasicPay = Convert.ToDecimal(lblBasicPay.Text.Trim());
        pl.HeadqtrOffice = ddlHdtrOffice.SelectedValue.ToString();
        pl.OrderForMove_Duty = txtOfMDuty.Text.Trim();
        pl.AuthorityRule_TR_SR = txtAuthRole.Text.Trim();      
        pl.StationFrom_Journey_commenced = txtStationfrmjnycom.Text.Trim();
        pl.Levels = lblLevel.Text.Trim();
        pl.Cells = lblCell.Text.Trim();

        if (btnSave.Text == "Save")
        {
            pl.sptype = 1;
            pl.CreatedBy = Session["USERID"].ToString();

        }


        else
        {
            pl.UpdatedBy = Session["UserID"].ToString();
            pl.TableID = Convert.ToInt32(lblRecordID.Text);
            pl.sptype = 2;
        }

        List<PL_Tempdutychild> objlist = new List<PL_Tempdutychild>();
        for (int row = 0; row < Grd.Rows.Count; row++)

        {
            PL_Tempdutychild pd = new PL_Tempdutychild();

            pd.NameOfPlace_Arrived_At = Grd.Rows[row].Cells[0].Text;
            pd.Arvl_Date = Convert.ToDateTime(Grd.Rows[row].Cells[1].Text, cult);
            pd.Arvl_Hrs = Grd.Rows[row].Cells[2].Text;
            pd.Distance_by_Road = Grd.Rows[row].Cells[3].Text;
            pd.ConveyMode = Grd.Rows[row].Cells[4].Text;
            pd.ConveyClass = Grd.Rows[row].Cells[5].Text;
            pd.Departure_Date = Convert.ToDateTime(Grd.Rows[row].Cells[6].Text, cult);
            pd.Departure_Hrs = Grd.Rows[row].Cells[7].Text;
            pd.NoOfDA = Convert.ToDecimal(Grd.Rows[row].Cells[8].Text);
            pd.Rate_RMA_DA = Grd.Rows[row].Cells[9].Text;
            pd.Amount = Convert.ToDecimal(Grd.Rows[row].Cells[10].Text);
            pd.Remark = Grd.Rows[row].Cells[11].Text;

            objlist.Add(pd);
        }
        string xmlDoc = CommonCode.ConvertToXMLFormat<PL_Tempdutychild>(ref objlist);

        int result = bl.Insert(pl, xmlDoc);
        if (result > 0)
        {
            Reset();
            bindgrdData();

            Messagebox.Show(pl.MSG);



        }
        else
        {

            Messagebox.Show(pl.MSG);

        }
    }

    private void bindgrdData()
    {
        pl.sptype = 3;
        DataTable dt = new DataTable();
        dt = bl.bindData(pl);
        if (dt.Rows.Count > 0)
        {
            grd_data.DataSource = dt;
            grd_data.DataBind();

        }
        else
        {
            grd_data.DataSource = null;
            grd_data.DataBind();

        }
        //if (dt.Rows[0]["freeze_flage"].ToString() == "N")
        //{

        //    lblShowName.Text = dt.Rows[0]["EMP_NAME"].ToString() + "You Are Freezed ";
        //    //lblShowName.Text =dt.Rows[0]["EMP_NAME"].ToString() +  "You Are Freezed " ;
        //    grd_data.Columns[6].Visible = false;
        //}

        //else
        //{
        //    grd_data.Columns[6].Visible = true;
        //}

    }

    private void Reset()
    {
        ddlEmpType.SelectedIndex = 0;
        //ddlFinancial.SelectedIndex = 0;
        ddlGpsMps.SelectedIndex = 0;
        //ddl_emp.SelectedIndex = 0;
        //lblShowName.Text = "";
        Ddl_advancerefNo.Items.Clear();
        lblamonut.Text = "";
        //ChildField
        txtNameOfArrived.Text = "";
        txtArrivalDate.Text = "";
        txtArrivalHrs.Text = "";
        txtDistanceRoad.Text = "";
        txtConveyMode.Text = "";
        txtConveyClass.Text = "";
        txtDepartureDate.Text = "";
        txtDepartureHrs.Text = "";
        txtNoDA.Text = "";
        txtRateofRMADA.Text = "";
        txtAmount.Text = "";
        txtRemark.Text = "";

        lblCell.Text = "";
        lblLevel.Text = "";
        lblRank.Text = "";
        lblDoB.Text = "";
        lblGPFNo.Text = "";
        lblBasicPay.Text = "";
        lblShowName.Text = "";
        txtAuthRole.Text = "";
        txtOfMDuty.Text = "";
        txtDateTimeStrt.Text = "";
        txtStationfrmjnycom.Text = "";


        btnSave.Text = "Save";
        btnSave.Visible = true;
        DataTable dt = new DataTable();
        dt.Columns.Add("NameOfPlace_Arrived_At");
        dt.Columns.Add("Arvl_Date");
        dt.Columns.Add("Arvl_Hrs");
        dt.Columns.Add("Distance_by_Road");
        dt.Columns.Add("ConveyMode");
        dt.Columns.Add("ConveyClass");
        dt.Columns.Add("Departure_Date");
        dt.Columns.Add("Departure_Hrs");
        dt.Columns.Add("NoOfDA");
        dt.Columns.Add("Rate_RMA_DA");
        dt.Columns.Add("Amount");
        dt.Columns.Add("Remark");        

        ViewState["dt"] = dt;

        bindchildgrd();
        // Response.Redirect("M_TutionFee.aspx");
    }



    protected void lnk_Click(object sender, EventArgs e)
    {
        
        GridViewRow gvr = (GridViewRow)((LinkButton)sender).NamingContainer;
        gvr.ForeColor = System.Drawing.Color.Red;
        int index = gvr.RowIndex;
        Label lbltabid = (Label)grd_data.Rows[index].FindControl("lbltabid");
        Label lbl = (Label)grd_data.Rows[index].FindControl("lblflag");
        Label refrenceno = (Label)grd_data.Rows[index].FindControl("lblrefrenceno");
        Label advance_amt = (Label)grd_data.Rows[index].FindControl("lbladvanceamt");
        HiddenField Departmentcode = (HiddenField)grd_data.Rows[index].FindControl("hdndepartmentcode");
        pl.TABLEID = Convert.ToInt16(lbltabid.Text);
        pl.sptype = 5;

        DataTable dt = bl.getData(pl);
        if (dt.Rows.Count > 0)
        {

            ddlGpsMps.SelectedValue = dt.Rows[0]["GPS_NPS"].ToString();
            ddlFinancial.SelectedValue = dt.Rows[0]["fin_year"].ToString();
            string st = dt.Rows[0]["EmpType"].ToString();
            ddlEmpType.SelectedValue = st.Trim();
            bind_emp();
            ddl_emp.SelectedValue = dt.Rows[0]["ECODE"].ToString();
            //lblShowName.Text = dt.Rows[0]["EMP_NAME"].ToString();
            BindRefrenceno();
            lblflage.Text = dt.Rows[0]["freeze_flage"].ToString();
            lblRecordID.Text = dt.Rows[0]["TABID"].ToString();
            BindGridForEdit(Convert.ToInt32(lblRecordID.Text));
            if (Ddl_advancerefNo.Items.Count > 0 && refrenceno.Text != "")
            {
                Ddl_advancerefNo.SelectedValue = dt.Rows[0]["refrence_no"].ToString();
                Ddl_advancerefNo.SelectedValue = refrenceno.Text;

            }
            lblrefno.Text = "";
            if (Ddl_advancerefNo.Items.Count <= 0)
            {
                //Ddl_advancerefNo.Visible = false;
                lblrefno.Visible = true;
                lblrefno.Text = refrenceno.Text;
            }
            if (advance_amt.Text != "")
            {
                lblamonut.Text = advance_amt.Text;
            }

            ddlEmpType.Enabled = false;
            ddlGpsMps.Enabled = false;
            ddl_emp.Enabled = false;
            if (lblflage.Text == "Y")
            {
                Ddl_advancerefNo.Visible = false;
                reimburse.Visible = true;
                //BindRefrenceno();
                btnSave.Visible = false;
                Ddl_advancerefNo.Enabled = true;
            }
            else
            {
                Ddl_advancerefNo.Visible = true;
                // reimburse.Visible = false;
                btnSave.Visible = true;
            }
            //ParentTblselect
            ddlHdtrOffice.SelectedValue = Departmentcode.Value;
            lblRank.Text = dt.Rows[0]["Ranks"].ToString();
            lblDoB.Text = dt.Rows[0]["DoB"].ToString();
            lblLevel.Text = dt.Rows[0]["Levels"].ToString();
            lblCell.Text = dt.Rows[0]["Cells"].ToString();
            lblGPFNo.Text = dt.Rows[0]["Gpf_Pran_No"].ToString();
            lblBasicPay.Text = dt.Rows[0]["BasicPay"].ToString();
            lblShowName.Text = dt.Rows[0]["EMP_NAME"].ToString();
            txtAuthRole.Text = dt.Rows[0]["AuthorityRule_TR_SR"].ToString();
            txtOfMDuty.Text = dt.Rows[0]["OrderForMove_Duty"].ToString();
            txtDateTimeStrt.Text = dt.Rows[0]["DateTime_Of_Start"].ToString();
            txtStationfrmjnycom.Text = dt.Rows[0]["StationFrom_Journey_commenced"].ToString();






            btnSave.Text = "Update";
        }
    }
    protected void BindGridForEdit(int Rowid)
    {
        pl.sptype = 6;
        pl.TABLEID = Rowid;
        DataTable dtSaveRecord = new DataTable();
        dtSaveRecord = bl.bindData(pl);
        if (dtSaveRecord.Rows.Count > 0)
        {
            ViewState["dt"] = dtSaveRecord;

        }
        else
        {

        }

        bindchildgrd();
    }

    protected void lnkdelete_Click(object sender, EventArgs e)
    {
        GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
        DataTable dt = ViewState["dt"] as DataTable;
        dt.Rows.RemoveAt(row.RowIndex);
        ViewState["dt"] = dt;
        bindchildgrd();
    }
    protected void masterdelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnk = (LinkButton)sender;
            GridViewRow grdRow = (GridViewRow)lnk.Parent.Parent;
            int rowIndex = grdRow.RowIndex;

            Label lbltabid = (Label)grd_data.Rows[rowIndex].FindControl("TABID");
            lbltabid.Text = lbltabid.Text;
            pl.TABLEID = Convert.ToInt32(lbltabid.Text);
            pl.sptype = 7;
            bl.Delete(pl);
            Messagebox.Show(pl.MSG);
            bindgrdData();
            Reset();
        }
        catch (Exception ex)
        {
            Messagebox.Show(ex.ToString());
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
        Response.Redirect("Temporary_Duty.aspx");
    }

    protected void btn_freeze_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnk = (LinkButton)sender;
            GridViewRow grdRow = (GridViewRow)lnk.Parent.Parent;
            int rowIndex = grdRow.RowIndex;
            Label lbltabid = (Label)grd_data.Rows[rowIndex].FindControl("lbltabid");
            Label refrenceno = (Label)grd_data.Rows[rowIndex].FindControl("lblrefrenceno");
            lbltabid.Text = lbltabid.Text;
            pl.TABLEID = Convert.ToInt32(lbltabid.Text);
            pl.refrence_no = refrenceno.Text;
            pl.ref_status = "Settled";
            pl.sptype = 8;
            pl.freeze_flage = "Y";

            bl.Freeze(pl);
            Messagebox.Show(pl.MSG);
            bindgrdData();
            Reset();

        }
        catch (Exception ex)
        {
            Messagebox.Show(ex.ToString());
        }
    }

    protected void Grd_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void grd_data_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        foreach (GridViewRow row in grd_data.Rows)
        {
            Label lbl = (Label)row.Cells[5].FindControl("lblflag");
            Label lblmsg = (Label)row.Cells[5].FindControl("lblfreeze");
            var linkButton = (LinkButton)row.Cells[5].FindControl("btn_freeze");
            //var lnk = (LinkButton)row.Cells[0].FindControl("lnkbtn");
            if (lbl.Text == "Y")
            {
                lblmsg.Visible = true;
                lblmsg.Text = "FREEZED";
                linkButton.Visible = false;
                //lnk.Visible = false;
            }
            else
            {
                lblmsg.Visible = false;
                linkButton.Visible = true;
                lbl.Text = "Freeze";

            }
        }
    }

    protected void ddl_emp_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        string str = "";
        str = "select ESS.ECODE,ESS.BASIC,ESS.PAY_BAND,ESS.CUR_PAY_GRADE,ESS.IT_Amount,MEM.Emp_Name,MEM.DATE_OF_BIRTH,ESS.GPF_ACCT_NO from  M_Emp_mast MEM inner join EMP_SALARY_STRUCTURE ESS ON MEM.ECODE=ESS.ECODE Where  ESS.ECODE='" + ddl_emp.SelectedValue + "'";

        // str = "select EMP_NAME,ECODE from M_Emp_mast where ECODE='" + ddl_emp.SelectedValue + "'";
        DataTable dt = SQL_DBCS.ExecuteDataTable(str);

        if (dt.Rows.Count > 0)
        {
            lblShowName.Text = dt.Rows[0]["EMP_NAME"].ToString();
            lblLevel.Text = dt.Rows[0]["CUR_PAY_GRADE"].ToString();
            lblCell.Text = dt.Rows[0]["PAY_BAND"].ToString();
            lblBasicPay.Text = dt.Rows[0]["BASIC"].ToString();
            lblDoB.Text = dt.Rows[0]["DATE_OF_BIRTH"].ToString();
            lblGPFNo.Text = dt.Rows[0]["GPF_ACCT_NO"].ToString();
            lblRank.Text = ddlEmpType.SelectedItem.ToString();

            BindRefrenceno();
        }
        else
        {
            lblShowName.Visible = false;
        }
        
    }
    public void BindRefrenceno()
    {
        try
        {
            string str = "";
            str = "select * from Advance_Reimburse_Master where emp_pk='" + ddl_emp.SelectedValue + "' and ref_status='Pending' and Freeze_flag='Y' and reimburse_type= '2' and is_selected='N'";
            DataTable dt = cc.EQ(str);
            if (dt.Rows.Count > 0)
            {
                Ddl_advancerefNo.DataTextField = "advance_refno";
                Ddl_advancerefNo.DataValueField = "advance_refno";
                Ddl_advancerefNo.DataSource = dt;
                Ddl_advancerefNo.DataBind();
                Ddl_advancerefNo.Items.Insert(0, "---Select ---");
            }
            else
            {
                //Messagebox.Show("Record Not Available.");
                Ddl_advancerefNo.Items.Clear();
            }
        }
        catch (Exception ex)
        {
            Messagebox.Show(ex.Message);
        }
    }

    protected void Ddl_advancerefNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        string str = "";
        str = "select * from Advance_Reimburse_Master where advance_refno='" + Ddl_advancerefNo.SelectedValue + "' and ref_status='Pending' and Freeze_flag='Y'";
        DataTable dt = cc.EQ(str);
        if (dt.Rows.Count > 0)
        {
            lblamonut.Text = dt.Rows[0]["advance_amt"].ToString();
        }
    }

    protected void ddlGpsMps_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlEmpType.SelectedIndex = 0;
        ddl_emp.Items.Clear();
    }
}