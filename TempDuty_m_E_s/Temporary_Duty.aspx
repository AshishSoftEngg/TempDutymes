<%@ Page Title="Temporary Duty" Language="C#" MasterPageFile="~/BSEBMainMasterPage.master" AutoEventWireup="true" CodeFile="Temporary_Duty.aspx.cs" Inherits="Payroll_Master_Temporary_Duty" %>

<%@ Register Src="~/usercontrols/Messagebox.ascx" TagName="Messagebox" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%--<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="cc1" %>--%>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function PrintPanel() {
            var panel = document.getElementById("<%=pan_rpt.ClientID%>");
            var printWindow = window.open('', '', 'height=400,width=800');
            printWindow.document.write('<html><head><title>Monthly  Report</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function () {
                printWindow.print();
            }, 500);
            return false;
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 107px;
        }

        .auto-style2 {
            width: 90px;
        }

        .auto-style3 {
            width: 117px;
        }

        .auto-style8 {
            width: 156px;
        }

        .auto-style9 {
            width: 81px;
        }

        .auto-style10 {
            width: 94px;
        }

        .auto-style11 {
            width: 275px;
        }

        .auto-style12 {
            width: 229px;
        }

        .auto-style13 {
            width: 117px;
            height: 28px;
        }

        .auto-style14 {
            width: 90px;
            height: 28px;
        }

        .auto-style15 {
            width: 107px;
            height: 28px;
        }

        .auto-style16 {
            width: 229px;
            height: 28px;
        }

        .auto-style17 {
            width: 275px;
            height: 28px;
        }

        .auto-style18 {
            width: 156px;
            height: 28px;
        }

        .grid_scroll {
            overflow: auto;
            border: solid 1px #666633;
            height: 200px;
            width: 1048px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div>
        <fieldset>
            <table cellpadding="0" cellspacing="0" style="width: 100%; border-style: solid; border-width: 1px 1px 1px 1px;">
                <tr class="PageHeaddingBox">
                    <td colspan="4" style="text-align: center; border-bottom: solid 1px #666633">
                        <b>Temporary Duty Claim </b>
                    </td>
                    <uc1:Messagebox runat="server" ID="Messagebox" />
                </tr>
                <tr style="height: 10px">
                    <td>
                        <asp:Label ID="lblflage" runat="server" Visible="false"></asp:Label>

                    </td>
                </tr>
                <tr>

                    <td>Financial Year:<asp:Label ID="FinYear" runat="server" ForeColor="Red" Text="*"></asp:Label>&nbsp;&nbsp;&nbsp;
                          <asp:Label ID="lblRecordID" runat="server" Visible="false"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlFinancial" runat="server" AutoPostBack="true" Enabled="false"></asp:DropDownList>
                    </td>
                    <td>GPF/NPS: <span style="color: Red;">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlGpsMps" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlGpsMps_SelectedIndexChanged">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="1">GPF</asp:ListItem>
                            <asp:ListItem Value="2">NPS</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>

                <tr>
                    <td>Designation Type: <span style="color: Red;">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlEmpType" runat="server" OnSelectedIndexChanged="ddlEmpType_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                    </td>
                    <td>Employee Name: <span style="color: Red;">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddl_emp" AutoPostBack="true" OnSelectedIndexChanged="ddl_emp_SelectedIndexChanged" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>
                <tr>
                    <td runat="server" id="reimburse">
                        <label>
                            Advance Ref No.<span style="color: red"></span>
                        </label>
                    </td>
                    <td>
                        <asp:DropDownList ID="Ddl_advancerefNo" AutoPostBack="true" runat="server" OnSelectedIndexChanged="Ddl_advancerefNo_SelectedIndexChanged"></asp:DropDownList>

                   <asp:Label ID="lblrefno" runat="server" Visible="false"></asp:Label>

                    </td>
                    <td>Advance Amount:<span style="color: red"></span>&nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:Label ID="lblamonut" runat="server" Visible="true"></asp:Label>
                    </td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>
            </table>
        </fieldset>
    </div>
    <div>
        <fieldset>
            <table cellpadding="0" cellspacing="0" style="width: 100%; border-style: solid; border-width: 1px 1px 1px 1px;">

                <tr style="height: 10px">
                    <td>
                        <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td>Name, Rank :  &nbsp;&nbsp;&nbsp;
                          
                    </td>

                    <td>
                        <asp:Label ID="lblShowName" runat="server" Visible="true"></asp:Label>
                        &nbsp;&nbsp;&nbsp;<asp:Label ID="lblRank" runat="server" Visible="true"></asp:Label>
                    </td>
                    <td>Level:</td>
                    <td>
                        <asp:Label ID="lblLevel" runat="server" Visible="true"></asp:Label>

                    </td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>

                <tr>
                    <td>Cell :  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:Label ID="lblCell" runat="server" Visible="true"></asp:Label>
                    </td>
                    <td>DoB :  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:Label ID="lblDoB" runat="server" Visible="true"></asp:Label>
                    </td>


                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>
                <tr>
                    <td>GPF/PRAN No :  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:Label ID="lblGPFNo" runat="server" Visible="true"></asp:Label>
                    </td>
                    <td>BasicPay :  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:Label ID="lblBasicPay" runat="server" Visible="true"></asp:Label>
                    </td>
                    <td runat="server" id="Td1" visible="false">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>
            </table>
        </fieldset>


    </div>
    <br />
    <div>
        <fieldset>
            <table cellpadding="0" cellspacing="0" style="width: 100%; border-style: solid; border-width: 1px 1px 1px 1px;">

                <tr style="height: 10px">
                    <td>
                        <asp:Label ID="Label2" runat="server" Visible="false"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td>Headquarters/Office :<span style="color: red">*</span>  &nbsp;&nbsp;&nbsp;
                          
                    </td>

                    <td>
                        <asp:dropdownlist ID="ddlHdtrOffice" runat="server"  Width="150px"></asp:dropdownlist>

                        &nbsp;&nbsp;&nbsp;
                    </td>
                    <td>Order for Move/Duty:<span style="color: red">*</span></td>
                    <td>
                        <asp:TextBox ID="txtOfMDuty" runat="server" MaxLength="150" Width="150px"></asp:TextBox>

                    </td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>

                <tr>
                    <td>Autherity(Role in TR/SL) :<span style="color: red">*</span>  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtAuthRole" runat="server" MaxLength="20" Width="150px"></asp:TextBox>
                    </td>

                    <td>Date and Time of Start :<span style="color: red">*</span>  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtDateTimeStrt" runat="server" MaxLength="20" Width="150px"></asp:TextBox>
                       <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateTimeStrt" Format="dd/MM/yyyy">
                                        </cc1:CalendarExtender>
                       <%-- <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" Enabled="True"
                            TargetControlID="txtDateTimeStrt" ValidChars="1234567890: /" FilterMode="ValidChars">
                        </cc1:FilteredTextBoxExtender>--%>
                    </td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>
                <tr>
                    <td>Station from where Journey Commenced :<span style="color: red">*</span>  &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtStationfrmjnycom" runat="server" Width="150px"></asp:TextBox>
                    </td>
                    <td runat="server" id="Td2" visible="false">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height: 10px">
                    <td></td>
                </tr>
            </table>
        </fieldset>
    </div>
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <div class="col-sm-12 grid_scroll">
                        <fieldset>
                            <legend><b><u>Travel Details</u></b></legend>
                            <table width="100%" style="border-collapse: collapse;">

                                <tr style="color: #2D2D2D; text-align: justify; background-color: #08a595; font-size: 12px; font-weight: bold; height: 30px; text-align: center; vertical-align: Bottom">
                                    <th style="text-align: left" class="auto-style8">Name Of the Place Arrived at:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style8">Arrival Date:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style8">Arrival Hrs:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style8">Distance by Road in Kms:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style7">Conveyance Mode:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style5">Conveyance Class:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style2">Departure Date:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style9">Departure Hrs:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style9">No of DA:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style12">Rate RMA/DA:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style12">Amount:<span style="color: red">*</span>
                                    </th>
                                    <th style="text-align: left" class="auto-style11">Remark.<span style="color: red">*</span>
                                    </th>

                                    <th class="auto-style8"></th>
                                </tr>
                                <tr style="background: #3f96e3;">
                                    <td class="auto-style8">
                                        <asp:TextBox ID="txtNameOfArrived" MaxLength="30" runat="server" Height="16px" Width="126px" />

                                    </td>
                                    <td class="auto-style8">
                                        <asp:TextBox ID="txtArrivalDate" onkeypress="return false;" onkeydown="return false;" MaxLength="20" runat="server" Height="16px" Width="126px" />
                                        <cc1:CalendarExtender ID="CEArrivalDate" runat="server" TargetControlID="txtArrivalDate" Format="dd/MM/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td class="auto-style8">
                                        <asp:TextBox ID="txtArrivalHrs" MaxLength="8" Text="12:59:59" runat="server" Height="16px" Width="126px" />         
                                        <%--<cc1:TimeSelector ID="TimeSelector1" runat="server">
                                        </cc1:TimeSelector>--%>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" Enabled="True"
                                            TargetControlID="txtArrivalHrs" ValidChars="1234567890:" FilterMode="ValidChars">
                                        </cc1:FilteredTextBoxExtender>

                                    </td>
                                    <td class="auto-style8">
                                        <asp:TextBox ID="txtDistanceRoad" MaxLength="10" runat="server" Height="16px" Width="126px" />
                                         <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" Enabled="True"
                                            TargetControlID="txtDistanceRoad" ValidChars="1234567890." FilterMode="ValidChars">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td class="auto-style7">
                                        <asp:TextBox ID="txtConveyMode" MaxLength="15" runat="server" Height="16px" Width="138px" />

                                    </td>
                                    <td class="auto-style5">
                                        <asp:TextBox ID="txtConveyClass" MaxLength="15" runat="server" Height="16px" Width="143px" />

                                    </td>
                                    <td class="auto-style2">
                                        <asp:TextBox ID="txtDepartureDate" onkeypress="return false;" onkeydown="return false;" MaxLength="15" runat="server" Height="16px" Width="132px" />
                                        <cc1:CalendarExtender ID="CaltxtDepartureDate" runat="server" TargetControlID="txtDepartureDate" Format="dd/MM/yyyy">
                                        </cc1:CalendarExtender>
                                    </td>
                                    <td class="auto-style9">
                                        <asp:TextBox ID="txtDepartureHrs" MaxLength="8" Text="12:59:59" runat="server" Width="108px" Height="16px" />
                                         <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" Enabled="True"
                                            TargetControlID="txtDepartureHrs" ValidChars="1234567890:" FilterMode="ValidChars">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td class="auto-style16">
                                        <asp:TextBox ID="txtNoDA" MaxLength="10" runat="server" Width="122px" Height="16px" Style="margin-left: 0px; margin-bottom: 0px" />
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" Enabled="True"
                                            TargetControlID="txtNoDA" ValidChars="1234567890." FilterMode="ValidChars">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td class="auto-style17">
                                        <asp:TextBox ID="txtRateofRMADA" MaxLength="500" runat="server" Style="margin-left: 0px" />
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" Enabled="True"
                                            TargetControlID="txtRateofRMADA" ValidChars="1234567890." FilterMode="ValidChars">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td class="auto-style16">
                                        <asp:TextBox ID="txtAmount" MaxLength="10" runat="server" Width="122px" Height="16px" Style="margin-left: 0px; margin-bottom: 0px" />
                                    </td>
                                    <td class="auto-style17">
                                        <asp:TextBox ID="txtRemark" MaxLength="500" runat="server" Style="margin-left: 0px" />
                                    </td>
                                    <td class="auto-style18">
                                        <asp:Button Text="Add" runat="server" ID="Add" OnClick="Add_Click" Style="margin-left: 0px" />
                                    </td>
                                </tr>
                            </table>
                            <div class="col-sm-12">
                                <asp:GridView ID="Grd" runat="server" Width="100%" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="NameOfPlace_Arrived_At" HeaderText="Name Of Arrived" />
                                        <asp:BoundField DataField="Arvl_Date" HeaderText="Arrival Date" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="Arvl_Hrs" HeaderText="Arrival Hrs" />
                                        <asp:BoundField DataField="Distance_by_Road" HeaderText="Distance by Road in Kms" />
                                        <asp:BoundField DataField="ConveyMode" HeaderText="Conveyance Mode" />
                                        <asp:BoundField DataField="ConveyClass" HeaderText="Conveyance Class" />
                                        <asp:BoundField DataField="Departure_Date" HeaderText="Departure Date" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="Departure_Hrs" HeaderText="Departure Hrs" />
                                        <asp:BoundField DataField="NoOfDA" HeaderText="No of DA" />
                                        <asp:BoundField DataField="Rate_RMA_DA" HeaderText="Rate RMA/DA" />
                                        <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                        <asp:BoundField DataField="Remark" HeaderText="Remark" />
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkdelete" runat="server" OnClick="lnkdelete_Click">
                                                    <asp:Image ID="imgDelete" runat="server" ImageUrl="~/App_Themes/BasicTheme/Images/delete.png" Height="20px"
                                                        Width="20px" OnClientClick="return confirm('Are You Sure To Delete?');" ToolTip="Delete" />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </fieldset>
                    </div>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" TabIndex="6"
                        ValidationGroup="btnProcess" />
                    &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" TabIndex="7" /></td>
            </tr>
        </table>
    </div>

    <br />
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:GridView ID="grd_data" runat="server" AutoGenerateColumns="False"
                        Width="100%" TabIndex="9" AllowPaging="true" OnPageIndexChanging="grd_data_PageIndexChanging" OnRowDataBound="grd_data_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>

                                    <asp:LinkButton ID="lnkbtn" runat="server" OnClick="lnk_Click">
                                        <asp:Image ID="imgedit" runat="server" ToolTip="Edit" ImageUrl="~/App_Themes/BasicTheme/Images/edit.png"
                                            Height="20px" Width="20px" />
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Employee Name">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_EmployeeName" runat="server" Text='<%# Bind("Emp_Name") %>'></asp:Label>
                                    <asp:Label ID="lbltabid" runat="server" Visible="false" Text='<%# Bind("TABID") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Designation Type">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_EmployeeTypeid" Visible="false" runat="server" Text='<%# Bind("EmpType") %>'></asp:Label>
                                    <asp:Label ID="lbl_designame" Visible="true" runat="server" Text='<%# Bind("des_type_name") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="GPS/NPS Type">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_EmployeeType" runat="server" Text='<%# Bind("EmpType") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Adv. Refrence No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblrefrenceno" runat="server" Text='<%# Bind("refrence_no") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Advance Amt.">
                                <ItemTemplate>
                                    <asp:Label ID="lbladvanceamt" runat="server" Text='<%# Bind("advance_amt") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Financial Year">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_fin_year" runat="server" Text='<%# Bind("fin_year") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Headquarters/Office">
                                <ItemTemplate>
                                     <asp:HiddenField ID="hdndepartmentcode" runat="server" Value='<%# Bind("HeadqtrOffice") %>' />
                                    <asp:Label ID="lbl_HeadquartersOffice" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order for Move/Duty:">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_OrderforMoveDuty" runat="server" Text='<%# Bind("OrderForMove_Duty") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Delete" Visible="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="masterdelete" runat="server" OnClick="masterdelete_Click" ImageUrl="~/App_Themes/BasicTheme/Images/delete.png" Height="20px"
                                        Width="20px" OnClientClick="return confirm('Are You Sure To Delete?');" ToolTip="Delete">                                       
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Freeze">

                                <ItemTemplate>
                                    <asp:Label ID="lblfreeze" runat="server" Visible="false"></asp:Label>
                                    <asp:LinkButton ID="btn_freeze" runat="server" OnClick="btn_freeze_Click"
                                        OnClientClick="return confirm('Are You Sure To Freeze this record.?');" Visible="true" ToolTip="Freeze">
                                        <asp:Label ID="lblflag" runat="server" Text='<%#Bind("freeze_flage") %>'></asp:Label>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <asp:Panel ID="pan_rpt" runat="server" Style="display: none">
        </asp:Panel>
    </div>
</asp:Content>

