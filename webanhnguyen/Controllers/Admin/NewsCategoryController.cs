using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webanhnguyen.Models;
using System.IO;
using PagedList;

namespace webanhnguyen.Controllers.Admin
{
    public class NewsCategoryController : BaseAdminController
    {
        // GET: NewsCategory
       
        private List<tbl_new_type> getNewsCategory(int count)
        {
            return getNewsCategory(count, "");
        }
        private List<tbl_new_type> getAllNewsCategory()
        {
            return getNewsCategory(-1, "");
        }
        private List<tbl_new_type> getNewsCategory(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.tbl_new_types.Where(a => a.TenLoaiTT.Contains(keyword));
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.tbl_new_types;
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }
        private tbl_new_type getOneNewsCategory(int id)
        {
            var newsCategory = from ic in data.tbl_new_types
                               where ic.Id == id
                               select ic;
            if (newsCategory == null)
            {
                return new tbl_new_type();
            }
            return newsCategory.Single();
        }

        public ActionResult NewsCategorySetStatusEnable(int id)
        {
            tbl_new_type tic = getOneNewsCategory(id);
            tic.status = !tic.status;
            UpdateModel(tic);
            data.SubmitChanges();
            return RedirectToAction("newsCategoryView");
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return newsCategoryView(1);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult newsCategoryView(int? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listItemCategory = getNewsCategory(10);
            return View(URLHelper.URL_ADMIN_NEWS_CATEGORY, listItemCategory.ToPagedList(pageNum, pageSize));
        }
        [HttpPost]
        public ActionResult newsCategoryView(FormCollection form, String btnDel, int? page)
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
                            data.tbl_new_types.DeleteOnSubmit(getOneNewsCategory(Int32.Parse(arrayStringCheckedList[i])));
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
            var listItemCategory = getNewsCategory(10, keyword);
            return View(URLHelper.URL_ADMIN_NEWS_CATEGORY, listItemCategory.ToPagedList(pageNum, pageSize));
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult newsCategoryCreate()
        {
            return View(URLHelper.URL_ADMIN_NEWS_CATEGORY_M, new tbl_new_type());
        }
        [HttpPost]
        public ActionResult newsCategoryCreate(FormCollection form, HttpPostedFileBase fileUpload)
        {
            tbl_new_type tic = new tbl_new_type();
            var name = form["name"];
            bool err = false;
            if (String.IsNullOrEmpty(name))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
            }
            tic.TenLoaiTT = name;
            tic.alias = DataHelper.GeneralHelper.getInstance().getAliasFromNewTypeName(data, name);
            if (err == false)
            {
                data.tbl_new_types.InsertOnSubmit(tic);
                data.SubmitChanges();
                return RedirectToAction("NewsCategoryView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_NEWS_CATEGORY_M, tic);
            }
        }
        /*
         *
         *
         * 
         */
        [HttpGet]
        public ActionResult newsCategoryEdit(String id)
        {
            return View(URLHelper.URL_ADMIN_NEWS_CATEGORY_M, getOneNewsCategory(Int32.Parse(id)));
        }
        [HttpPost]
        public ActionResult newsCategoryEdit(FormCollection form, HttpPostedFileBase fileUpload)
        {
            var id = form["id"];
            if (id == null)
            {
                return newsCategoryCreate(form, fileUpload);
            }
            else
            {
                tbl_new_type tic = getOneNewsCategory(Int32.Parse(id));
                var name = form["name"];
                bool err = false;
                if (String.IsNullOrEmpty(name))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
                }
                if (!tic.TenLoaiTT.Equals(name))
                    tic.alias = DataHelper.GeneralHelper.getInstance().getAliasFromNewTypeName(data, name);

                tic.TenLoaiTT = name;
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SubmitChanges();
                    return RedirectToAction("newsCategoryView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_NEWS_CATEGORY_M, tic);
                }
            }
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult newsCategoryDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.tbl_new_types.DeleteOnSubmit(getOneNewsCategory(Int32.Parse(id)));
                    data.SubmitChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return newsCategoryView(1);
        }
    }
}