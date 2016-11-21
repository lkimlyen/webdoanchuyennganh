using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webanhnguyen.Models;

namespace webanhnguyen.Controllers
{
    public class ShoppingCartController : BaseController
    {
        // GET: ShoppingCart
        public ActionResult Index()
        {
            return View();
        }
        public List<ShoppingCart> Laygiohang()
        {
            
            List<ShoppingCart> lstGiohang = Session["ShoppingCart"] as List<ShoppingCart>;
            if (lstGiohang == null)
            {
                //Neu gio hang chua ton tai thi khoi tao listGiohang
                lstGiohang = new List<ShoppingCart>();
                Session["ShoppingCart"] = lstGiohang;
            }
            return lstGiohang;
        }
        //Them hang vao gio
        public ActionResult ThemGiohang(int iMasp, string strURL)
        {
            //Lay ra Session gio hang
            List<ShoppingCart> lstGiohang = Laygiohang();
            //Kiem tra sách này tồn tại trong Session["Giohang"] chưa?
            ShoppingCart sanpham = lstGiohang.Find(n => n.iMasp == iMasp);
            if (sanpham == null)
            {
                sanpham = new ShoppingCart(iMasp);
                lstGiohang.Add(sanpham);
                return Redirect(strURL);
            }
            else
            {
                sanpham.iSoluong++;
                return Redirect(strURL);
            }
        }

        [HttpGet]
        //Xay dung trang Gio hang
        public ActionResult GioHang()
        {
            
            List<ShoppingCart> lstGiohang = Laygiohang();
            if (lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return View(lstGiohang);
        }
        [HttpPost]
        public ActionResult GioHang(FormCollection collection)
        {
            if (Session["Email"] == null || Session["Email"].ToString() == "")
            {
                return RedirectToAction("Login", "User");
            }
            if (Session["ShoppingCart"] == null)
            {
                return RedirectToAction("Index", "Home");
            }

            //Them Don hang
            Order ddh = new Order();
            Customer kh = (Customer)Session["Email"];
            List<ShoppingCart> gh = Laygiohang();
            ddh.idkh = kh.id;
            ddh.thoidiemdathang = DateTime.Now;

            ddh.tinhtrangthanhtoan = false;

            ddh.tennguoinhan = collection["name"];
            ddh.diachi = collection["address"];
            ddh.phonenumber = collection["phone"];
            ddh.gmail = collection["email"];

            db.Orders.InsertOnSubmit(ddh);
            db.SubmitChanges();

            decimal tong = 0;
            //Them chi tiet don hang            
            foreach (var item in gh)
            {

                OrderDetail ctdh = new OrderDetail();
                ctdh.iddh = ddh.id;
                ctdh.idsp = item.iMasp;
                ctdh.soluong = item.iSoluong;
                ctdh.dongia = (decimal)item.dDongia;
                ctdh.thanhtien = ctdh.soluong * ctdh.dongia;
                tong += (decimal)ctdh.thanhtien;
                db.OrderDetails.InsertOnSubmit(ctdh);
            }
            ddh.price = tong;
            UpdateModel(ddh);
            db.SubmitChanges();
            Session["ShoppingCart"] = null;
            return RedirectToAction("Xacnhandonhang", "ShoppingCart");
        }

        //Tong so luong
        private int TongSoLuong()
        {
            int iTongSoLuong = 0;
            List<ShoppingCart> lstGiohang = Session["ShoppingCart"] as List<ShoppingCart>;
            if (lstGiohang != null)
            {
                iTongSoLuong = lstGiohang.Sum(n => n.iSoluong);
            }
            return iTongSoLuong;
        }
        //Tinh tong tien
        private double TongTien()
        {
            double iTongTien = 0;
            List<ShoppingCart> lstGiohang = Session["ShoppingCart"] as List<ShoppingCart>;
            if (lstGiohang != null)
            {
                iTongTien = lstGiohang.Sum(n => n.dThanhtien);
            }
            return iTongTien;
        }
        //Tao Partial view de hien thi thong tin gio hang
        public ActionResult GiohangPartial()
        {
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return PartialView();
        }
        //Cap nhat Giỏ hàng
        [HttpPost]
        public ActionResult CapnhatGiohang(FormCollection f, int iMaSP)
        {

            //Lay gio hang tu Session
            List<ShoppingCart> lstGiohang = Laygiohang();
            //Kiem tra sach da co trong Session["Giohang"]
            ShoppingCart sanpham = lstGiohang.SingleOrDefault(n => n.iMasp == iMaSP);
            //Neu ton tai thi cho sua Soluong
            if (sanpham != null)
            {
                sanpham.iSoluong = int.Parse(f["txtSoluong"].ToString());
            }
            return RedirectToAction("GioHang");
        }
        //Xoa Giohang
        public ActionResult XoaGiohang(int iMaSP)
        {
            //Lay gio hang tu Session
            List<ShoppingCart> lstGiohang = Laygiohang();
            //Kiem tra sach da co trong Session["Giohang"]
            ShoppingCart sanpham = lstGiohang.SingleOrDefault(n => n.iMasp == iMaSP);
            //Neu ton tai thi cho sua Soluong
            if (sanpham != null)
            {
                lstGiohang.RemoveAll(n => n.iMasp == iMaSP);
                return RedirectToAction("GioHang");

            }
            return RedirectToAction("Index", "Home");
        }
        //Xoa tat ca thong tin trong Gio hang
        public ActionResult XoaTatcaGiohang()
        {
            //Lay gio hang tu Session
            List<ShoppingCart> lstGiohang = Laygiohang();
            lstGiohang.Clear();
            return RedirectToAction("Index", "Home");
        }

        //Hien thi View DatHang de cap nhat cac thong tin cho Don hang
        [HttpGet]
        public ActionResult DatHang()
        {  //Kiem tra dang nhap
            if (Session["Email"] == null || Session["Email"].ToString() == "")
            {
                return RedirectToAction("Login", "User");
            }
            if (Session["ShoppingCart"] == null)
            {
                return RedirectToAction("Index", "Home");
            }

            //Lay gio hang tu Session
            List<ShoppingCart> lstGiohang = Laygiohang();
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return View(lstGiohang);
        }

        //Xay dung chuc nang Dathang
        [HttpPost]
        public ActionResult DatHang(FormCollection collection)
        {
            //Them Don hang
            Order ddh = new Order();
            Customer kh = (Customer)Session["Email"];
            List<ShoppingCart> gh = Laygiohang();
            ddh.idkh = kh.id;
            ddh.thoidiemdathang = DateTime.Now;

            ddh.tinhtrangthanhtoan = false;

            ddh.tennguoinhan = collection["name"];
            ddh.diachi = collection["address"];
            ddh.phonenumber = collection["phonenumber"];
            ddh.gmail = collection["email"];
           
            db.Orders.InsertOnSubmit(ddh);
            db.SubmitChanges();

            decimal tong = 0;
            //Them chi tiet don hang            
            foreach (var item in gh)
            {

                OrderDetail ctdh = new OrderDetail();
                ctdh.iddh = ddh.id;
                ctdh.idsp = item.iMasp;
                ctdh.soluong = item.iSoluong;
                ctdh.dongia = (decimal)item.dDongia;
                ctdh.thanhtien = ctdh.soluong * ctdh.dongia;
                tong += (decimal)ctdh.thanhtien;
                db.OrderDetails.InsertOnSubmit(ctdh);
            }
            ddh.price = tong;
            UpdateModel(ddh); 
            db.SubmitChanges();
            Session["ShoppingCart"] = null;
            return RedirectToAction("Xacnhandonhang", "ShoppingCart");
        }
        public ActionResult Xacnhandonhang()
        {
            if(Session["Email"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
           
            return View();
        }


    }
}