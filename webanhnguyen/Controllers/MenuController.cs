using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace webanhnguyen.Controllers
{
    public class MenuController : BaseController
    {
        // GET: Menu
        public ActionResult Index()
        {
            return View();
        }
        #region menutop
        [ChildActionOnly]//Gọi từ View sang Controll
        public ActionResult MenuTop()
        {
            //Lấy ra danh sách Menu
            var MenuTop = (from mn in db.tbl_product_types
                           where mn.Status == true
                           select mn).ToList();
           
            return PartialView(MenuTop);
        }
        #endregion
        #region menubottom
        [ChildActionOnly]//Gọi từ View sang Controll
        public ActionResult MenuBottom()
        {
            //Lấy ra danh sách Menu
            var menu = (from mn in db.tbl_informations
                        where mn.Status == true

                        select mn).ToList();
            return PartialView(menu);
        }
        #endregion


    }
}