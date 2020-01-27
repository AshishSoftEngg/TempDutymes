using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BL_TemporaryDuty
/// </summary>
public class BL_TemporaryDuty
{
    public BL_TemporaryDuty()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public int Insert(PL_TeporaryDuty pl, string xmlDoc)
    {
        DL_TemporaryDuty obj = new DL_TemporaryDuty();
        return obj.Insert(pl, xmlDoc);
    }

    public DataTable bindData(PL_TeporaryDuty pl)
    {
        DL_TemporaryDuty obj = new DL_TemporaryDuty();
        return obj.bindData(pl);
    }

    public DataTable getData(PL_TeporaryDuty pl)
    {
        DL_TemporaryDuty obj = new DL_TemporaryDuty();
        return obj.getData(pl);
    }
    public virtual int Delete(PL_TeporaryDuty pl)
    {
        DL_TemporaryDuty objDAL = new DL_TemporaryDuty();
        return objDAL.Delete(pl);
    }

    public virtual int Freeze(PL_TeporaryDuty pl)
    {
        DL_TemporaryDuty objDAL = new DL_TemporaryDuty();
        return objDAL.Freeze(pl);
    }
}