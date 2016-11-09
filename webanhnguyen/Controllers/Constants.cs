﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace webanhnguyen.Controllers
{
    public class Constants
    {
        public const String NEWS_CATEGORY_NAME_NEWS = "CategoryNews";
        public const String NEWS_CATEGORY_NAME_POLICY = "CategoryPolicy";

        public const String KEY_VIEWDATA_SHOPPING_CARD_ALL_ITEMS_COST = "keyviewdatashoppingcardallitemscost";
        public const String KEY_VIEWDATA_SHOPPING_CARD_ITEMS_AMOUNT = "keyviewdatashoppingcarditemsamount";
        public const String KEY_VIEWDATA_LIST_SLIDE_IMAGES = "keyviewdatalistslideimages";
        public const String KEY_VIEWDATA_LIST_MODULE = "keyviewdatalistmodule";
        public const String KEY_VIEWDATA_LIST_MODULE_INDEX_PAGE = "keyviewdatalistmoduleindexpage";
        public const String KEY_VIEWDATA_IS_LOGIN = "ismemberlogin";
        public const String KEY_VIEWDATA_CURENCY = "keycurrency";
        public const String KEY_VIEWDATA_MEMBER_ACCOUNT = "keymemberaccount";

        public const String KEY_SESSION_SHOPPING_CARD = "keysessionshoppingcard";
        public const String KEY_SESSION_ADMIN_USERNAME = "keyadminusername";
        public const String KEY_SESSION_MEMBER_USERNAME = "keymemberusername";

        public enum Gender
        {
            MALE, FEMALE, BOTH
        }

        public enum AccountStatus
        {
            INACTIVE, ACTIVE
        }
        
        public enum OrderStatus
        {
            PAID, UNPAID
        }

        public enum ItemStatus
        {
            NORMAL, HOT 
        }
    }
}