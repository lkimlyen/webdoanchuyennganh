using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using webanhnguyen.Models;
using System.IO;

namespace webanhnguyen.Controllers.Admin
{
    public class PromotionController : BaseAdminController
    {
        //GET: Product
        private List<tbl_Product> getItem(int count)
        {
            return getItem(count, "");
        }
        private List<tbl_Product> getAllItem()
        {
            return getItem(-1, "");
        }
        private List<tbl_Product> getItem(int count, String keyword)
        {

            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.tbl_Products.Where(a => a.TenSP.Contains(keyword)).OrderByDescending(a => a.NgayCapNhat);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.tbl_Products.OrderByDescending(a => a.NgayCapNhat);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }


        }
        public List<DataHelper.PromotionAddItemModel> getProduct()
        {
            List<DataHelper.PromotionAddItemModel> list = Session["PromotionAddItemModel"] as List<DataHelper.PromotionAddItemModel>;
            if (list == null)
            {
                //Neu gio hang chua ton tai thi khoi tao listGiohang
                list = new List<DataHelper.PromotionAddItemModel>();
                Session["PromotionAddItemModel"] = list;
            }
            return list;

        }
        public ActionResult PromotionAddItem(int Id, string strURL)
        {
            //Lay ra Session gio hang
            List<DataHelper.PromotionAddItemModel> list = getProduct();
            //Kiem tra sách này tồn tại trong Session["Giohang"] chưa?
            DataHelper.PromotionAddItemModel sanpham = list.Find(n => n.proid == Id);
                sanpham = new DataHelper.PromotionAddItemModel();
                list.Add(sanpham);
                return Redirect(strURL); 
        }

        // GET: Promotion
        public List<tbl_promotion_detail> getListPromotionDetailById(int id)
        {
            return data.tbl_promotion_details.OrderByDescending(a => a.Id).Where(n => n.Idkm == id).ToList();
        }

        private List<tbl_promotion> getPromotion(int count)
        {
            return getPromotion(count, null);
        }
        private List<tbl_promotion> getAllPromotion()
        {
            return getPromotion(-1, null);
        }
        private tbl_promotion getOnePromotion(int id)
        {
            var item = from ic in data.tbl_promotions
                       where ic.Id == id
                       select ic;
            if (item == null)
            {
                return new tbl_promotion();
            }
            return item.Single();
        }
        private tbl_promotion_detail getOnePromotionDetail(int id)
        {
            var item = from ic in data.tbl_promotion_details
                       where ic.Id == id
                       select ic;
            if (item == null)
            {
                return new tbl_promotion_detail();
            }
            return item.Single();
        }

        public ActionResult PromotionSetStatusEnable(int id)
        {
            tbl_promotion tic = getOnePromotion(id);
            tic.status = !tic.status;
            UpdateModel(tic);
            data.SubmitChanges();
            return RedirectToAction("PromotionView");
        }
        private List<tbl_promotion> getPromotion(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.tbl_promotions.Where(a => a.Tenkhuyenmai.Contains(keyword)).OrderByDescending(a => a.ngaytao);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.tbl_promotions.OrderByDescending(a => a.ngaytao);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return PromotionView(1);
        }
        [HttpGet]
        public ActionResult promotionCreate(int ? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;


            
            var promotion = new tbl_promotion();

            return View(URLHelper.URL_ADMIN_PROMOTION_M, new Tuple<tbl_promotion,List<tbl_Product>>(promotion,getAllItem()));
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult promotionCreate(FormCollection form, String btnAdd, HttpPostedFileBase fileUpload, int ? page)
        {
            if (btnAdd != null)
            {
                //Delete checked items
                string checkedList = form["chk[]"];
                if (!String.IsNullOrEmpty(checkedList))
                {
                    string[] arrayStringCheckedList = checkedList.Split(new char[] { ',' });
                    for (int i = 0; i < arrayStringCheckedList.Length; i++)
                    {
                        try
                        {
                            data.tbl_Products.DeleteOnSubmit(getOneItem(Int32.Parse(arrayStringCheckedList[i])));
                            data.SubmitChanges();
                            ViewBag.AlertSuccess = "Xoá thành công!";
                        }
                        catch (Exception e)
                        {
                            ViewBag.AlertError = "Không xoá được";
                        }
                    }
                }
            }
            int pageNum = (page ?? 1);
            int pageSize = 20;


            var keyword = form["keyword"];
            var listItem = getItem(10, keyword).ToPagedList(pageNum, pageSize);
            

            tbl_promotion tic = new tbl_promotion();
            var name = form["name"];
            var price = form["price"];
            var price2 = form["price2"];
            var detail = form["detail"];
            var sold_amount = form["soldamount"];
     
tic.alias = DataHelper.GeneralHelper.getInstance().getAliasFromPromotionName(data, name);
            List<DataHelper.PromotionAddItemModel> list = getProduct();

            bool err = false;
            if (String.IsNullOrEmpty(name))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập tên khuyến mãi!\n";
            }
            
            tic.Tenkhuyenmai = name;
            tic.status = true;
            tic.ngaytao = DateTime.Now;
            tic.ngaykhuyenmai = Convert.ToDateTime(price);
            tic.ngayketthuc = Convert.ToDateTime(price2);
            tic.Noidung = detail;
            if (form["chkClearImg"] != null)
            {
                tic.AnhBia = "";
            }
            else if (fileUpload != null)
            {
                var fileName = Path.GetFileName(DateTime.Now.Millisecond + fileUpload.FileName);
                var path = Path.Combine(Server.MapPath(URLHelper.URL_IMAGE_PATH), fileName);
                if (!System.IO.File.Exists(path))
                {
                    fileUpload.SaveAs(path);
                }
                tic.AnhBia = fileName;
            }
            if (err == false)
            {
                data.tbl_promotions.InsertOnSubmit(tic);
                data.SubmitChanges();
                foreach (var item in list)
                {

                    tbl_promotion_detail ctkm = new tbl_promotion_detail();
                    ctkm.Idkm = item.modelid;
                    ctkm.Idsp = item.proid;
                    ctkm.quantity = item.quantity;
                    ctkm.Giaban = (decimal)item.price;
                    ctkm.Giakhuyenmai = (decimal)item.pricepd;
                    ctkm.Gift = item.gift;
                    
                    data.tbl_promotion_details.InsertOnSubmit(ctkm);
                }

                return RedirectToAction("promotionView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_PROMOTION_M, new Tuple<tbl_promotion, List<tbl_Product>>(tic, listItem));
            }
        }

        [HttpGet]
        public ActionResult PromotionDetail(int id)
        {
            var listPromotionDetail = getListPromotionDetailById(id);

            tbl_promotion tic = getOnePromotion(id);
            ViewBag.id = tic.Id;
            ViewBag.name = tic.Tenkhuyenmai;
            ViewBag.ngaykhuyenmai = tic.ngaykhuyenmai;
            ViewBag.ngayketthuc = tic.ngayketthuc;
            return View(URLHelper.URL_ADMIN_PROMOTION_M, listPromotionDetail);
        }

        //[HttpPost, ValidateInput(false)]
        //public ActionResult OrderDetail(FormCollection form)
        //{
        //    var id = form["id"];
        //    if (id == null)
        //    {
        //        ViewData["Error"] += "Có lỗi xảy ra";
        //        return RedirectToAction("Index");
        //    }
        //    else
        //    {
        //        Order tic = getOneOrder(Int32.Parse(id));
        //        var name = form["TenNguoiNhan"];
        //        var phone = form["soDT"];
        //        var address = form["DiaChi"];
        //        var email = form["yahoo"];
        //        bool err = false;
        //        if (String.IsNullOrEmpty(name))
        //        {
        //            err = true;
        //            ViewData["Error"] += "Vui lòng nhập tên người nhận hàng!\n";
        //        }
        //        tic.tennguoinhan = name;
        //        tic.phonenumber = phone;
        //        tic.diachi = address;
        //        tic.gmail = email;
        //        if (err == false)
        //        {
        //            UpdateModel(tic);
        //            data.SubmitChanges();
        //            return RedirectToAction("OrderView");
        //        }
        //        else
        //        {
        //            ViewBag.id = id;
        //            ViewBag.name = tic.tennguoinhan;
        //            ViewBag.phone = tic.phonenumber;
        //            ViewBag.address = tic.diachi;
        //            ViewBag.email = tic.gmail;
        //            var listOrderDetail = getListOrderDetailById(Int32.Parse(id));
        //            List<DataHelper.ShoppingCardItemModel> listShoppingCardModels = DataHelper.ShoppingCardHelper.getInstance().getListShoppingCardItemModelFromListOrderDetails(data, listOrderDetail);
        //            long totalPrice = 0;
        //            foreach (DataHelper.ShoppingCardItemModel model in listShoppingCardModels)
        //            {
        //                totalPrice += (long)model.total;
        //            }
        //            ViewBag.TotalPrice = totalPrice;
        //            return View(URLHelper.URL_ADMIN_ORDER_DETAIL, listShoppingCardModels);

        //        }
        //    }
        //}

        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult PromotionView(int? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listPromotion = getPromotion(10);
            return View(URLHelper.URL_ADMIN_PROMOTION, listPromotion.ToPagedList(pageNum, pageSize));
        }
        [HttpPost]
        public ActionResult PromtionView(FormCollection form, String btnDel, int? page)
        {
            if (btnDel != null)
            {
                //Delete checked items
                string checkedList = form["chk[]"];
                if (!String.IsNullOrEmpty(checkedList))
                {
                    string[] arrayStringCheckedList = checkedList.Split(new char[] { ',' });
                    for (int i = 0; i < arrayStringCheckedList.Length; i++)
                    {
                        try
                        {
                            data.tbl_promotions.DeleteOnSubmit(getOnePromotion(Int32.Parse(arrayStringCheckedList[i])));
                            data.SubmitChanges();
                            ViewBag.AlertSuccess = "Xoá thành công!";
                        }
                        catch (Exception e)
                        {
                            ViewBag.AlertError = "Không xoá được";
                        }
                    }
                }
            }
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var keyword = form["keyword"];
            var listPromotion = getPromotion(10, keyword);
            return View(URLHelper.URL_ADMIN_PROMOTION, listPromotion.ToPagedList(pageNum, pageSize));
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult PromotionDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.tbl_promotions.DeleteOnSubmit(getOnePromotion(Int32.Parse(id)));
                    data.SubmitChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return PromotionView(1);
        }

        public ActionResult PromotionDetailDelete(String id, int idorder)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.tbl_promotion_details.DeleteOnSubmit(getOnePromotionDetail(Int32.Parse(id)));
                    data.SubmitChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return PromotionDetail(idorder);
        }
    }
}