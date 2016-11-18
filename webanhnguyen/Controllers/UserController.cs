using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webanhnguyen.Models;
using PagedList;
using System.IO;

namespace webanhnguyen.Controllers
{
    public class UserController : BaseController
    {
        // GET: User

        public ActionResult Index()
        {
            return View();
        }
        #region Tài khoản (Login - SuccessLogin - Logout - Account - ChangePassword - Register - SuccessRegister)
        #region Đăng nhập (Login)
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
       
        public ActionResult Login(FormCollection collection)
        {
                try
                {
                    //Lấy giá trị ở Form Login
                    var _Email = collection["email"];
                    var _Password = collection["password"];
                Customer kh = db.Customers.SingleOrDefault(n => n.email == _Email && n.password == _Password);
                //Tạo biến _UserLogin để kiểm tra tài khoản đăng nhập có trong CSDL không
               // var _UserLogin = db.Customers.SingleOrDefault(k => k.email == _Email && k.password == _Password);
                    if (ModelState.IsValid && kh != null)
                    {
                    if (kh.status == true)//không bị lock tài khoản
                    {
                        Session["ID"] = kh.id;
                        //Lưu các thông tin vào Session
                        Session["Email"] = kh;
                        Session["emailstring"] = kh.email;
                        if (Session["Giohang"] == null)
                        {//Chuyển đến trang thông báo Login thành công (Ở đây không dùng được RedirectToAction vì [ChildActionOnly])
                            return Content("<script>alert('Đăng nhập thành công!');window.location='/Home/Index';</script>");
                        }
                        else
                            return Content("<script>alert('Đăng nhập thành công!');window.location='/ShoppingCart/GioHang';</script>");
                    }
                    
                        else
                            return Content("<script>alert('Tài khoản của bạn đã bị khóa. Vui lòng liên hệ ban quản trị!');window.location='/User/Login';</script>");
                    }
                    else
                        return Content("<script>alert('Tên đăng nhập hoặc mật khẩu không đúng!');window.location='/User/Login';</script>");
                }
                catch
                {
                    return Content("<script>alert('Đăng nhập thất bại!');window.location='/User/Login';</script>");
                }
        }

        #endregion
     

        #region Đăng xuất (Logout)
        public ActionResult Logout()
        {
            Session.RemoveAll();
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }
        #endregion

        public ActionResult Profile()
        {
            if (Session["Email"] == null)
                return RedirectToAction("Index");
            int _MaKH = int.Parse(Session["ID"].ToString());
            var kh = db.Customers.SingleOrDefault(k => k.id == _MaKH);
            return View(kh);
        }
        #region Thay đổi thông tin cá nhân (ProfileUpdate)
        public ActionResult ProfileUpdate()
        {
           
            if (Session["Email"] == null)
                return RedirectToAction("Index");
            int _MaKH = int.Parse(Session["ID"].ToString());
            var kh = db.Customers.SingleOrDefault(k => k.id == _MaKH);
            return View(kh);
        }

        [HttpPost]
        public ActionResult ProfileUpdate(FormCollection collection)
        {
            
            try
            {
                  
                //Lấy giá trị ở Form ChangePassword
                var _Email = collection["email"];
                var _PassNew = collection["password1"];
                var _RePassNew = collection["password2"];
                var _Name = collection["name"];
                var _SDT = collection["phone"];
                var _Address = collection["address"];
                int _MaKH = int.Parse(Session["ID"].ToString());
                var kh = db.Customers.SingleOrDefault(k => k.id == _MaKH);
                    kh.name = _Name;
                    kh.moblie = _SDT;
                    kh.address = _Address;
        
                    kh.password = _PassNew;
                //Khai báo _FileUpload ở <input type="file" id="_FileUpload" name="_FileUpload" /> trên Form Account
                HttpPostedFileBase _FileUpload = Request.Files["fileupload"];
                if (_FileUpload != null && _FileUpload.ContentLength > 0)//Kiểm tra đã chọn 1 file Upload để thực hiện tiếp
                {
                    //khai báo biến _FileName là tên File
                    string _FileName = Path.GetFileName(_FileUpload.FileName);

                    //Khai báo biến _Path là đường dẫn Upload File
                    string _Path = Path.Combine(Server.MapPath("~/cdn.fptshop.com.vn/Uploads/Thumbs/"), _FileName);

                    //Kiểm tra chỉ cho Upload File có kính thước < 1 MB
                    if (_FileUpload.ContentLength > 1 * 1024 * 1024)
                    {
                        return Content("<script>alert('Kích thước của tập tin không được vượt quá 1 MB!');window.location='/User/ProfileUpdate';</script>");
                    }

                    //Ngoài hạn chế dung lượng File Upload lên Server thì quan trọng nhất là chỉ cho phép User Upload được dạng File ảnh lên
                    //Vì nếu cho Upload được tất cả các File thì User có thể Upload File Backdoor, Shell lên Server dẫn đến Site bị hacker tấn công

                    //Khai báo mảng chứa các đuôi file hợp lệ cho Upload
                    var _DuoiFile = new[] { "jpg", "jpeg", "png", "gif" };

                    //Khai báo biến _FileExt: trong đó GetExtension là lấy phần mở rộng (đuôi File), Substring(1): lấy từ vị trí thứ nhất => Tức sẽ lấy ra đuôi File
                    var _FileExt = Path.GetExtension(_FileUpload.FileName).Substring(1);

                    //Kiểm tra trong mảng _DuoiFile KHÔNG chứa phần đuôi file của tập tin User upload lên
                    if (!_DuoiFile.Contains(_FileExt))
                    {
                        return Content("<script>alert('Chỉ được Upload tập tin hình ảnh dạng (.jpg, .jpeg, .png, .gif)!');window.location='/User/ProfileUpdate';</script>");
                    }

                    //Thực thi Upload tập tin lên Server
                    _FileUpload.SaveAs(_Path);

                    //Gán giá trị Avatar là đường dẫn của tập tin vừa Upload để Update trong Database
                    kh.image = _FileName;
                }

                UpdateModel(kh);
                db.SubmitChanges();
                return Content("<script>alert('Cập nhật thành công!');window.location='/User/Profile';</script>");
            }
            catch
            {
                return Content("<script>alert('Thao tác đổi mật khẩu thất bại!');window.location='/User/ProfileUpdate';</script>");
            }
        }
        #endregion

        #region Đăng ký (Register)
        public ActionResult Register()
        {
          //Đã Đăng Nhập thì không cho vào Form Đăng Ký
            if (Session["Email"] != null)
                return RedirectToAction("Index");
            return View();
        }

        [HttpPost]
        public ActionResult Register(FormCollection collection, Customer kh)
        {

            try
            {
                //Lấy giá trị ở Form Register    
                var _Password = collection["password1"];
                var _RePassword = collection["password2"];
                string _Email = collection["email1"];
                var name = collection["name"];
                if(String.IsNullOrEmpty(_Email))
                {
                    return View();
                }
                //Kiểm tra xem tài khoản đã có người sử dụng chưa?
                var _CheckUser = db.Customers.FirstOrDefault(k => k.email == _Email);
                if (_CheckUser != null)
                    return Content("<script>alert('Email đã có người sử dụng!');window.location='/User/Register';</script>");
                else
                    kh.email = _Email;

                //Kiểm tra Mật khẩu nhập lại có giống Mật khẩu đăng ký không?
                    kh.password = _Password;
                kh.date_added = DateTime.Now;
                //Khai báo _FileUpload ở <input type="file" id="_FileUpload" name="_FileUpload" /> trên Form Register
                kh.status = true;//Mặc định cho tài khoản là Hiện
                kh.name = name;
                //Thực hiện thêm mới
                db.Customers.InsertOnSubmit(kh);
                db.SubmitChanges();
		kh = db.Customers.SingleOrDefault(n => n.email == _Email && n.password == _Password);
                //Lưu thông tin khách hàng vừa đăng ký vào Session để tự động đăng nhập
                Session["ID"] = kh.id;
                        //Lưu các thông tin vào Session
                        Session["Email"] = kh;
                        Session["emailstring"] = kh.email;
                return RedirectToAction("SuccessRegister");
            }
            catch
            {
                return Content("<script>alert('Đăng ký thất bại!');window.location='/User/Register';</script>");
            }
        }
        #endregion

        #region Đăng ký thành công (SuccessRegister)
        public ActionResult SuccessRegister()
        {
            //Ở đây khi đăng ký thành công thì sẽ lưu thông tin tài khoản vào Session => chưa có thì về trang chủ
            if (Session["Email"] == null)
                return RedirectToAction("Index");

            return View();
        }
        #endregion
        #region quên mật khẩu (RecoverPassword)
        public ActionResult RecoverPassword()
        {
            //Ở đây khi đăng ký thành công thì sẽ lưu thông tin tài khoản vào Session => chưa có thì về trang chủ
            if (Session["Email"] == null)
                return RedirectToAction("Index");
            return View();
        }
        #endregion
        #region Đơn hàng
        public ActionResult Order(int ? page, string sorting)
        {
           
            int pageNum = (page ?? 1);
            int pageSize = 20;
            if (Session["Email"] == null)
                return RedirectToAction("Login");
            int _MaKH = int.Parse(Session["ID"].ToString());
            var donhang = from d in db.Orders
                           where d.idkh == _MaKH
                           select d;
            ViewBag.DateSortParm = "Date_desc";
            if(sorting == "Date_desc")
            {
                return View(donhang.OrderByDescending(n => n.thoidiemdathang).ToPagedList(pageNum, pageSize));
            }
            
            return View(donhang.ToPagedList(pageNum, pageSize));
        }
        #endregion
       
        #region chi tiết đơn hàng
        public ActionResult OrderDetail(int id)
        {
              if (Session["Email"] == null)
                return RedirectToAction("Login");
            List<OrderDetail> CT_SP = (from n in db.OrderDetails
                                       from s in db.tbl_Products
                                       where n.iddh == id && n.idsp == s.ID
                                       select n).ToList();

            Order order = db.Orders.SingleOrDefault(n => n.id == id );

            List<DataHelper.ShoppingCardItemModel> CT_SP_CO_LUON_TEN_SP = new List<DataHelper.ShoppingCardItemModel>();
            foreach(OrderDetail orderDetail in CT_SP)
            {
                DataHelper.ShoppingCardItemModel model = new DataHelper.ShoppingCardItemModel();
                model.name = DataHelper.ProductHelper.getInstance().getProductById(db, orderDetail.idsp.Value).TenSP;
                model.price = orderDetail.dongia.Value;
                model.id = orderDetail.idsp.Value;
                model.quantity = orderDetail.soluong.Value;
                model.total = orderDetail.thanhtien.Value;
                model.alias = DataHelper.ProductHelper.getInstance().getProductById(db, orderDetail.idsp.Value).alias;
                CT_SP_CO_LUON_TEN_SP.Add(model);
            }
          

            ViewBag.order = (from c in db.Orders where c.id == id select c).ToList();
            ViewBag.Tongtien = order.price;
            ViewBag.kh = (from c in db.Customers where c.id == order.idkh  select c).ToList();
            return View(CT_SP_CO_LUON_TEN_SP);
        }
        #endregion
        #endregion

    }
}