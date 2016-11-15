using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webanhnguyen.Models;
using PagedList;

namespace webanhnguyen.Controllers.Admin
{
    public class ProducerController : BaseAdminController
    {
        // GET: Producer
        private List<tbl_producer> getProducer(int count)
        {
            return getProducer(count, "");
        }
        private List<tbl_producer> getAllProducer()
        {
            return getProducer(-1, "");
        }
        private List<tbl_producer> getProducer(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.tbl_producers.Where(a => a.Tenhangsx.Contains(keyword));
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.tbl_producers;
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }
        private tbl_producer getOneProducer(int id)
        {
            var producer = from ic in data.tbl_producers
                               where ic.Id == id
                               select ic;
            if (producer == null)
            {
                return new tbl_producer();
            }
            return producer.Single();
        }

        public ActionResult ProducerSetStatusEnable(int id)
        {
            tbl_producer tic = getOneProducer(id);
            tic.status = !tic.status;
            UpdateModel(tic);
            data.SubmitChanges();
            return RedirectToAction("producerView");
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return producerView(1);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult producerView(int? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listProducer = getProducer(10);
            return View(URLHelper.URL_ADMIN_PRODUCER, listProducer.ToPagedList(pageNum, pageSize));
        }
        [HttpPost]
        public ActionResult producerView(FormCollection form, String btnDel, int? page)
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
                            data.tbl_producers.DeleteOnSubmit(getOneProducer(Int32.Parse(arrayStringCheckedList[i])));
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
            var listProducer = getProducer(10, keyword);
            return View(URLHelper.URL_ADMIN_PRODUCER, listProducer.ToPagedList(pageNum, pageSize));
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult producerCreate()
        {
            return View(URLHelper.URL_ADMIN_PRODUCER_M, new tbl_producer());
        }
        [HttpPost]
        public ActionResult producerCreate(FormCollection form, HttpPostedFileBase fileUpload)
        {
            tbl_producer tic = new tbl_producer();
            var name = form["name"];
            bool err = false;
            if (String.IsNullOrEmpty(name))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
            }
            tic.Tenhangsx = name;
            tic.alias = DataHelper.GeneralHelper.getInstance().getAliasFromProducerName(data, name);
            if (err == false)
            {
                data.tbl_producers.InsertOnSubmit(tic);
                data.SubmitChanges();
                return RedirectToAction("producerView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_PRODUCER_M, tic);
            }
        }
        /*
         *
         *
         * 
         */
        [HttpGet]
        public ActionResult producerEdit(String id)
        {
            return View(URLHelper.URL_ADMIN_PRODUCER_M, getOneProducer(Int32.Parse(id)));
        }
        [HttpPost]
        public ActionResult producerEdit(FormCollection form, HttpPostedFileBase fileUpload)
        {
            var id = form["id"];
            if (id == null)
            {
                return producerCreate(form, fileUpload);
            }
            else
            {
                tbl_producer tic = getOneProducer(Int32.Parse(id));
                var name = form["name"];
                bool err = false;
                if (String.IsNullOrEmpty(name))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
                }
                if (!tic.Tenhangsx.Equals(name))
                    tic.alias = DataHelper.GeneralHelper.getInstance().getAliasFromProducerName(data, name);

                tic.Tenhangsx = name;
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SubmitChanges();
                    return RedirectToAction("producerView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_PRODUCER_M, tic);
                }
            }
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult producerDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.tbl_producers.DeleteOnSubmit(getOneProducer(Int32.Parse(id)));
                    data.SubmitChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return producerView(1);
        }
    }
}