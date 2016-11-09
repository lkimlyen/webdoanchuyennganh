using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace webanhnguyen.Models
{
    public class ShoppingCart
    {
        databaseDataContext db = new databaseDataContext();
        public int iMasp { set; get; }
        public string sTensp { set; get; }
        public string sAnhbia { set; get; }
        public double dGiaban { set; get; }
        public int iKhuyenmai { set; get; }
        public Double dDongia { set; get; }
        public int iSoluong { set; get; }
        public string salias { set; get; }
        public Double dThanhtien
        {
            get { return iSoluong * dDongia; }

        }
        //Khoi tao gio hàng theo Masp duoc truyen vao voi Soluong mac dinh la 1
        public ShoppingCart(int Masp)
        {
            iMasp = Masp;
            tbl_Product sp = db.tbl_Products.Single(n => n.ID == iMasp);
            sTensp = sp.TenSP;
            sAnhbia = sp.UrlHinh;
            dGiaban = double.Parse(sp.GiaCu.ToString());
            iKhuyenmai = int.Parse(sp.KhuyenMai.ToString());
            dDongia = double.Parse(sp.GiaHienTai.ToString());
            iSoluong = 1;
            salias = sp.alias;
        }
    }
}