﻿using System;
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
        public Double dDongia { set; get; }
        public int iSoluong { set; get; }
        public string salias { set; get; }
        public double giakhuyenmai { set; get;}
        public int khuyemai { set; get; }
        public string gift { set; get; }
        public Double dThanhtien
        {
            get { return iSoluong * dDongia; }

        }
        //Khoi tao gio hàng theo Masp duoc truyen vao voi Soluong mac dinh la 1
        public ShoppingCart(int Masp)
        {
            iMasp = Masp;
            tbl_promotion_detail spkm = db.tbl_promotion_details.Single(n => n.Idsp == iMasp);
            tbl_Product sp = db.tbl_Products.Single(n => n.ID == iMasp);
            sTensp = sp.TenSP;
            sAnhbia = sp.UrlHinh;
            khuyemai = spkm.KhuyenMai.Value;
            if (khuyemai > 0)
            {
                dDongia = double.Parse(spkm.Giakhuyenmai.ToString());

            }
            else
            {
                dDongia = double.Parse(sp.GiaHienTai.ToString());
            }
            gift = spkm.Gift;
            iSoluong = 1;
            salias = sp.alias;
        }
    }
}