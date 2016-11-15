using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webanhnguyen.Models;
using PagedList.Mvc;
using PagedList;


namespace webanhnguyen.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }
        #region lấy sản phẩm show lên trang chủ
        public ActionResult Laysanpham()
        {
            var sp = from n in db.tbl_Products 
                     where n.Status == true && n.Sanphambanchay == false
                     select n;
            return PartialView(sp);
        }
        #endregion
        #region sản phẩm bán chạy
        [ChildActionOnly]
        public ActionResult Topbanchay()
        {
            var SP_hot = (from sp in db.tbl_Products
                          where sp.Status == true && sp.Sanphambanchay == true
                          select sp).Take(6).ToList();
            return PartialView(SP_hot);
        }
        #endregion
        
        #region chi tiết sản phẩm
        public ActionResult Details(string id)
        {
            tbl_header hea = db.tbl_headers.SingleOrDefault(n => n.id == 1);
            Session["title"] = ViewBag.shoptitle;
         
            Session["icon"] = hea.shortcuticon;
            var CT_SP = (db.tbl_Products.First(sp => sp.alias == id));
            int loai = int.Parse(CT_SP.IDLoaiSP.ToString());
            ViewBag.TenLoai = (from s in db.tbl_Products
                               from l in db.tbl_product_types
                               where s.alias == id && s.IDLoaiSP == l.ID && s.Status == true
                               select l);
            ViewBag.SP_cungloai = (from s in db.tbl_Products
                                   where s.alias != id && s.IDLoaiSP == loai && s.Status == true
                                   select s).Skip(0).Take(4).ToList();
            ViewBag.SP_khac = (from s in db.tbl_Products
                               where s.alias != id && s.IDLoaiSP != loai && s.Status == true
                               select s).Skip(0).Take(4).ToList();
            //CT_SP.LuotXem += 1;
            //UpdateModel(CT_SP);
            //db.SubmitChanges();
            ViewBag.Title = CT_SP.title;
            ViewBag.keyword = CT_SP.keyword;
            ViewBag.description = CT_SP.description;

            return View(CT_SP);
        }
        #endregion
        #region sản phẩm theo loại
        public ActionResult ProductType(string id, int? page, string sorting)
        {
            tbl_header hea = db.tbl_headers.SingleOrDefault(n => n.id == 1);
            Session["title"] = ViewBag.shoptitle;
            
            Session["icon"] = hea.shortcuticon;

            int pageSize = 20;
            int pageNum = (page ?? 1);

            var laysp = from g in db.tbl_Products
                        from h in db.tbl_product_types
                        where h.alias == id && g.IDLoaiSP == h.ID && g.Status == true && h.Status == true
                        select g;
            Session["loai"] = id;
            tbl_product_type loai = db.tbl_product_types.SingleOrDefault(n => n.alias == id);
            Session["tenloai"] = loai.TenLoaiSP;
            ViewBag.TenLoai = (from l in db.tbl_product_types
                               where l.alias == id
                               select l);
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";
            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(laysp.OrderByDescending(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(laysp.OrderBy(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(laysp.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(laysp.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(laysp.OrderBy(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }
            return View(laysp.ToPagedList(pageNum, pageSize));
        }
        public ActionResult hienthi2(string id, int? page, string sorting)
        {
            tbl_header hea = db.tbl_headers.SingleOrDefault(n => n.id == 1);
            Session["title"] = ViewBag.shoptitle;
            Session["icon"] = hea.shortcuticon;

            int pageSize = 20;
            int pageNum = (page ?? 1);
            var laysp = from g in db.tbl_Products
                        from h in db.tbl_product_types
                        where h.alias == id && g.IDLoaiSP == h.ID && g.Status == true && h.Status == true
                        select g;
            ViewBag.TenLoai = (from l in db.tbl_product_types
                               where l.alias == id
                               select l);
            Session["loai"] = id;
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";

            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(laysp.OrderByDescending(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(laysp.OrderBy(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(laysp.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(laysp.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(laysp.OrderBy(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }
            return View(laysp.ToPagedList(pageNum, pageSize));
        }
        public ActionResult hienthi3(string id, int? page, string sorting)
        {
            tbl_header hea = db.tbl_headers.SingleOrDefault(n => n.id == 1);
            Session["title"] = ViewBag.shoptitle;
            
            Session["icon"] = hea.shortcuticon;

            int pageSize = 20;
            int pageNum = (page ?? 1);
            var laysp = from g in db.tbl_Products
                        from h in db.tbl_product_types
                        where h.alias == id && g.IDLoaiSP == h.ID && g.Status == true && h.Status == true
                        select g;
            ViewBag.TenLoai = (from l in db.tbl_product_types
                               where l.alias == id
                               select l);
            Session["loai"] = id;
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";
            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(laysp.OrderByDescending(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(laysp.OrderBy(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(laysp.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(laysp.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(laysp.OrderBy(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }

            return View(laysp.ToPagedList(pageNum, pageSize));
        }
        #endregion

        #region sản phẩm theo loại
        #endregion
        #region Sản phẩm tìm kiếm (Search)
        [HttpGet]
        public ActionResult Search(string txttimkiem, string sorting, int? page)
        {
            tbl_header hea = db.tbl_headers.SingleOrDefault(n => n.id == 1);
            Session["icon"] = hea.shortcuticon;

            int pageNum = (page ?? 1);
            int pageSize = 20;
            string tukhoa = txttimkiem;
            if (String.IsNullOrEmpty(tukhoa))
                tukhoa = "";
            ViewBag.tukhoa = tukhoa;
            Session["timkiem"] = txttimkiem;
            List<tbl_Product> sp = db.tbl_Products.Where(n => n.TenSP.Contains(tukhoa)).ToList();
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";
            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(sp.OrderByDescending(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(sp.OrderBy(n => n.TenSP).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(sp.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNum, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(sp.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(sp.OrderBy(n => n.GiaHienTai).ToPagedList(pageNum, pageSize));
            }
            return View(sp.OrderBy(n => n.TenSP).ToPagedList(pageNum, pageSize));
        }
        #endregion
       
        #region khuyenmai
        public ActionResult khuyenmai(int? page, string sorting)
        {
           
            int pageNume = (page ?? 1);
            int pageSize = 20;
            var km = (from k in db.tbl_Products
                      where k.Status == true && k.KhuyenMai > 0

                      select k);
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";
            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(km.OrderByDescending(n => n.TenSP).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(km.OrderBy(n => n.TenSP).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(km.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(km.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNume, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(km.OrderBy(n => n.GiaHienTai).ToPagedList(pageNume, pageSize));
            }

            return View(km.ToPagedList(pageNume, pageSize));
        }
        public ActionResult khuyenmai1(int? page, string sorting)
        {
            
            int pageNume = (page ?? 1);
            int pageSize = 20;
            var km = (from k in db.tbl_Products
                      where k.Status == true && k.KhuyenMai > 0

                      select k);
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";
            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(km.OrderByDescending(n => n.TenSP).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(km.OrderBy(n => n.TenSP).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(km.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(km.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNume, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(km.OrderBy(n => n.GiaHienTai).ToPagedList(pageNume, pageSize));
            }

            return View(km.ToPagedList(pageNume, pageSize));
        }
        public ActionResult khuyenmai2(int? page, string sorting)
        {
            
            int pageNume = (page ?? 1);
            int pageSize = 20;
            var km = (from k in db.tbl_Products
                      where k.Status == true && k.KhuyenMai > 0
                      select k);
            ViewBag.TenSapXep = "Sắp xếp: A đến Z";
            ViewBag.NameSortParm = "Name_desc";
            ViewBag.NameSortParmasc = "Name_asc";
            ViewBag.DateSortParm = "Date_desc";
            ViewBag.PriceSortParm = "Price_desc";
            ViewBag.PriceSortPasc = "Price";
            if (sorting == "Name_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp: Z đến A";
                return View(km.OrderByDescending(n => n.TenSP).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Name_asc")
            {
                ViewBag.TenSapXep = "Sắp xếp: A đến Z";
                return View(km.OrderBy(n => n.TenSP).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Date_desc")
            {
                ViewBag.TenSapXep = "Sản phẩm mới";
                return View(km.OrderByDescending(n => n.NgayCapNhat).ToPagedList(pageNume, pageSize));
            }
            if (sorting == "Price_desc")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Cao Đến Thấp";
                return View(km.OrderByDescending(n => n.GiaHienTai).ToPagedList(pageNume, pageSize));
            }

            if (sorting == "Price")
            {
                ViewBag.TenSapXep = "Sắp xếp Giá: Thấp đến Cao";
                return View(km.OrderBy(n => n.GiaHienTai).ToPagedList(pageNume, pageSize));
            }

            return View(km.ToPagedList(pageNume, pageSize));
        }
        #endregion
        #region footer
        [ChildActionOnly]
        public ActionResult footer()
        {
            var footer = from mn in db.tbl_shops
                         where mn.id == 1
                         select mn;
            return PartialView(footer.Single());
        }

        #endregion

        #region header
        [ChildActionOnly]//Gọi từ View sang Controll
        public ActionResult header()
        {
            //Lấy ra danh sách Menu
            var header = (from mn in db.tbl_headers
                          where mn.id == 1
                          select mn);

            return PartialView(header.Single());
        }
        #endregion
        #region information
        public ActionResult infomation(string id)
        {
            tbl_information inf = db.tbl_informations.SingleOrDefault(n => n.alias == id && n.Status == true);
            Session["tenmuinfo"] = inf.TenTT;
            return View(inf);
        }
        public ActionResult menuinfo()
        {
            var info = from i in db.tbl_informations
                       where i.Status == true
                       select i;
            return PartialView(info);
        }
        #endregion
        #region tintuc
        public ActionResult tintuc(int? page)
        {
            int pageNume = (page ?? 1);
            int pageSize = 20;
            var tintuc = (from tt in db.tbl_news
                          where tt.status == true
                          orderby tt.NgayCapNhat descending
                          select tt);

            return View(tintuc.ToPagedList(pageNume, pageSize));
        }
        #endregion
        #region tincongnghe
        public ActionResult tincongnghe()
        {
            var tin = from m in db.tbl_news
                      where m.status == true
                      orderby m.NgayCapNhat descending
                      select m;
            return PartialView(tin.Take(5).ToList());
        }
        #endregion
        #region Chi tiết tin (Reader)
        public ActionResult Reader(string id)
        {

            //Lấy ra tin tức từ mã tin truyền vào
            var CT_Tin = (db.tbl_news.First(tt => tt.alias.Equals(id)));

            //Lấy ra 10 tin khác (10 tin trong đó không có tin đang đọc)

            //Bộ đếm lượt xem cho Tin tức
            //if (CT_Tin.LuotXem == null)
            //{
            //    CT_Tin.LuotXem = 0;
            //}
            //else
            //    CT_Tin.LuotXem += 1;
            //UpdateModel(CT_Tin);
            //db.SubmitChanges();
            ViewBag.Title = CT_Tin.title;
            ViewBag.keyword = CT_Tin.keyword;
            ViewBag.description = CT_Tin.description;

            return View(CT_Tin);
        }

        #endregion

    }
}