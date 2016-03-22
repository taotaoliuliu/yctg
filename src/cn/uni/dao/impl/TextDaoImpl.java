 package cn.uni.dao.impl;
 
 import cn.uni.base.BaseDaoImpl;
 import cn.uni.dao.TextDao;
 import cn.uni.domain.PageBean;
 import cn.uni.domain.StatusInfo;
 import cn.uni.domain.TextAmountInfo;
 import cn.uni.domain.TextInfo;
 import cn.uni.domain.UserInfo;
 import cn.uni.util.I18n;
 import cn.uni.util.ManagerPro;
 import java.io.File;
 import java.io.FileOutputStream;
 import java.io.PrintWriter;
 import java.io.UnsupportedEncodingException;
 import java.net.URLDecoder;
 import java.text.SimpleDateFormat;
 import java.util.ArrayList;
 import java.util.Date;
 import java.util.List;
 import org.apache.commons.lang3.StringUtils;
 import org.hibernate.Query;
 import org.hibernate.SQLQuery;
 import org.hibernate.Session;
import org.springframework.stereotype.Repository;
 
 @Repository
 public class TextDaoImpl extends BaseDaoImpl<TextInfo>
   implements TextDao
 {
   public int selectMax()
   {
     Object uniqueResult = getSession().createSQLQuery("select max(textID) from textInfo ")
       .uniqueResult();
 
     int qcount = ((Integer)uniqueResult).intValue();
     return qcount;
   }
 
   public void makeXML(TextInfo newtextInfo, String nameLogin, int type, String nameReal, String workcompany, String attachStr, String k, String bbs)
   {
     PrintWriter outs = null;
 
     Query query = getSession().createQuery("from UserInfo u where u.name_Login=?")
       .setParameter(0, nameLogin);
     UserInfo userInfo = (UserInfo)query.uniqueResult();
 
     String idcard = userInfo.getIdcard();
     String address = userInfo.getDepartment();
     String email = userInfo.getEmail();
     String postalcode = userInfo.getPostalcode();
     String phone = userInfo.getPhone();
     String role = userInfo.getRole();
     String mobilePhone = userInfo.getMobilePhone();
     String province = userInfo.getProvince();
 
     String city = userInfo.getCity();
 
     String county = userInfo.getCounty();
     String mcontent = newtextInfo.getTextContent();
 
     mcontent = mcontent.replaceAll("<", "＜");
     mcontent = mcontent.replaceAll(">", "＞");
 
     String UniContributeDate = newtextInfo.getContributeDate();
     UniContributeDate = UniContributeDate.substring(0, 10);
     String author = newtextInfo.getAuthor();
     String picInfo = newtextInfo.getPicInfo();
     String rest1 = newtextInfo.getRest1();
     String cat = newtextInfo.getCat();
     String title = newtextInfo.getTextTitle();
 
     String globalNewsId = newtextInfo.getGlobalNewsId();
 
     int textId = newtextInfo.getTextID().intValue();
 
     String tempFolder = ManagerPro.getString("text_tempfolder");
     if ((tempFolder == null) || (tempFolder.equals("")))
     {
       tempFolder = "d:/Unicontribution";
     }
 
     if ((type == 2) || ((bbs != null) && (bbs.equals("pictype")))) {
       tempFolder = tempFolder + "/docpic/";
     }
     else if (type == 1)
       tempFolder = tempFolder + "/doc/";
     else if (type == 3)
       tempFolder = tempFolder + "/docvideo/";
     else if (type == 4) {
       tempFolder = tempFolder + "/docaudio/";
     }
 
     File file = new File(tempFolder);
 
     if (!file.exists())
     {
       file.mkdirs();
     }
 
     String filename = nameLogin + UniContributeDate + "_" + textId;
     filename = filename + "_" + k;
 
     if ((type == 2) && (!attachStr.equals("")))
     {
       filename = filename + "_t";
     }
     int dashIndex = 0;
     String attachStr2 = "";
     if ((attachStr != null) && (!attachStr.equals("")))
     {
       String[] attachInfoStrs = attachStr.split(";");
       for (int m = 0; m < attachInfoStrs.length; m++)
       {
         if ((attachInfoStrs[m] != null) && (!attachInfoStrs[m].equals("")))
         {
           dashIndex = attachInfoStrs[m].lastIndexOf('_');
           attachStr2 = attachStr2 + attachInfoStrs[m].substring(0, dashIndex) + "_" + 1 + attachInfoStrs[m].substring(dashIndex) + ";";
         }
       }
     }
 
     String pReturn = "\r\n";
     String pString = "";
     String txtfile = "";
     txtfile = tempFolder + filename + ".XML";
     pString = pString + "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + pReturn;
     pString = pString + "<News>" + pReturn;
     pString = pString + "<ID>" + textId + "</ID>" + pReturn;
     pString = pString + "<Author>" + author + "</Author>" + pReturn;
     pString = pString + "<Province>" + province + "</Province>" + pReturn;
     pString = pString + "<City>" + city + "</City>" + pReturn;
 
     pString = pString + "<County>" + county + "</County>" + pReturn;
     pString = pString + "<GlobalNewsId>" + globalNewsId + "</GlobalNewsId>" + pReturn;
 
     pString = pString + "<ccode>" + role + "</ccode>" + pReturn;
     pString = pString + "<Sender>" + nameReal + "</Sender>" + pReturn;
     pString = pString + "<IDCard>" + idcard + "</IDCard>" + pReturn;
     pString = pString + "<address>" + address + "</address>" + pReturn;
     pString = pString + "<postCode>" + postalcode + "</postCode>" + pReturn;
     pString = pString + "<bankcard>" + userInfo.getBankcard() + "</bankcard>" + pReturn;
     pString = pString + "<bankaddress>" + userInfo.getBankaddress() + "</bankaddress>" + pReturn;
     pString = pString + "<banklinkcard>" + userInfo.getBanklinkcard() + "</banklinkcard>" + pReturn;

     pString = pString + "<Type>" + rest1 + "</Type>" + pReturn;
     pString = pString + "<Cat>" + cat + "</Cat>" + pReturn;
     pString = pString + "<WorkCompany>" + workcompany + "</WorkCompany>" + pReturn;
     pString = pString + "<Time>" + UniContributeDate + "</Time>" + pReturn;
     pString = pString + "<Phone>" + phone + "," + mobilePhone + "</Phone>" + pReturn;
     pString = pString + "<Email>" + email + "</Email>" + pReturn;
     pString = pString + "<Title>" + title + "</Title>" + pReturn;
 
     if ((attachStr == null) || (attachStr.equals(""))) {
       if (type == 2)
       {
         pString = pString + "<Body></Body>" + pReturn;
       }
       else
         pString = pString + "<Body>" + title + pReturn + mcontent + "</Body>" + pReturn;
     }
     else
     {
       pString = pString + "<Body>" + title + pReturn + mcontent + "</Body>" + pReturn;
       pString = pString + "<Pics>" + attachStr2 + "</Pics>" + pReturn;
     }
     pString = pString + "</News>" + pReturn;
     File f_txt = new File(txtfile);
     if (!f_txt.exists())
     {
       try {
         outs = new PrintWriter(new FileOutputStream(txtfile, true));
       } catch (Exception e) {
         e.printStackTrace();
       }
       outs.println(pString);
       outs.flush();
       outs.close();
     }
   }
 
   public boolean checkTitle(String textTitle, String attribute, String localeString)
   {
     boolean haveTitle = false;
     String strsql = "select * from textInfo where textTitle = '" + textTitle + "' and sender='" + attribute + "' and ContributeDate >'" + localeString + "'";
 
     SQLQuery createSQLQuery = getSession().createSQLQuery(strsql);
     if (createSQLQuery.uniqueResult() != null)
     {
       haveTitle = true;
     }
 
     return haveTitle;
   }
 
	public List<TextInfo> getByCondition(String startDate, String endDate, String author, String sender, String idcard, String workcompany) {
     String condition = " select t.* from textInfo t,userInfo u where t.sender=u.name_login ";
 
     if (StringUtils.isNotBlank(author))
     {
       condition = condition + " and t.author ='" + author + "'";
     }
     if (StringUtils.isNotBlank(sender))
     {
       condition = condition + " and t.sender ='" + sender + "'";
     }
     if (StringUtils.isNotBlank(idcard))
     {
       condition = condition + " and u.IDCard like '%" + idcard + "%'";
     }
     if (StringUtils.isNotBlank(workcompany))
     {
       condition = condition + " and u.workcompany ='" + workcompany + "'";
     }
     if ((StringUtils.isNotBlank(startDate)) && (StringUtils.isNotBlank(endDate)))
     {
       condition = condition + " and t.ContributeDate >= '" + startDate + "' and  t.ContributeDate <'" + endDate + "'";
     }
     SQLQuery query = getSession().createSQLQuery(condition);
     List list = query.list();
 
     List listText = new ArrayList();
 
     TextInfo textInfo2 = null;
     for (int x = 0; x < list.size(); x++)
     {
       textInfo2 = new TextInfo();
       textInfo2.setTextID(Integer.valueOf(Integer.parseInt(((Object[])list.get(x))[0].toString())));
       textInfo2.setTextTitle(((Object[])list.get(x))[1].toString());
       if (((Object[])list.get(x))[7] != null)
       {
         textInfo2.setRest1(((Object[])list.get(x))[7].toString());
       }
       textInfo2.setSender(((Object[])list.get(x))[4].toString());
       textInfo2.setAuthor(((Object[])list.get(x))[3].toString());
       textInfo2.setContributeDate(((Object[])list.get(x))[5].toString());
       if (((Object[])list.get(x))[12] != null)
       {
         textInfo2.setCat(((Object[])list.get(x))[12].toString());
       }
       textInfo2.setRest3(((Object[])list.get(x))[9].toString());
       textInfo2.setIsUsed(((Object[])list.get(x))[13].toString());
       if (((Object[])list.get(x))[11] != null)
       {
         textInfo2.setStatus(((Object[])list.get(x))[11].toString());
       }
       listText.add(textInfo2);
     }
 
     return listText;
   }
 
   public List<TextAmountInfo> ListTextAmountLimit(String contributeEsseFlag, String contributeEsse, String startDate, String endDate)
   {
     String strsql = "";
     try
     {
       if (contributeEsse != null)
       {
         contributeEsse = URLDecoder.decode(contributeEsse, "utf-8");
       }
     } catch (UnsupportedEncodingException e) {
       e.printStackTrace();
     }
     if ("province".equals(contributeEsseFlag))
     {
       if ((!"".equals(startDate)) && (startDate != null) && (!"".equals(endDate)) && (endDate != null))
       {
         if (("".equals(contributeEsse)) || (contributeEsse == null))
         {
           strsql = "select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.ContributeDate>='" + startDate + "' and textInfo.ContributeDate<'" + endDate + "' Group by userInfo.province order by sumText desc";
         }
         else {
           I18n.getGBText(contributeEsse);
           strsql = "select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.province='" + contributeEsse + "' and textInfo.ContributeDate>='" + startDate + "' and textInfo.ContributeDate<'" + endDate + "' Group by userInfo.province order by sumText desc";
         }
 
       }
       else if (("".equals(contributeEsse)) || (contributeEsse == null))
       {
         strsql = "select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender Group by userInfo.province order by sumText desc";
       }
       else {
         strsql = "select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.province='" + contributeEsse + "' Group by userInfo.province order by sumText desc";
       }
     }
     else if ("city".equals(contributeEsseFlag))
     {
       if ((!"".equals(startDate)) && (startDate != null) && (!"".equals(endDate)) && (endDate != null))
/*      */       {
/*  315 */         if (("".equals(contributeEsse)) || (contributeEsse == null))
/*      */         {
/*  317 */           strsql = "select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.ContributeDate>='" + startDate + "' and textInfo.ContributeDate<'" + endDate + "' Group by userInfo.city order by sumText desc";
/*      */         }
/*      */         else {
/*  320 */           strsql = "select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.city='" + contributeEsse + "' and textInfo.ContributeDate>='" + startDate + "' and textInfo.ContributeDate<'" + endDate + "' Group by userInfo.city order by sumText desc";
/*      */         }
/*      */ 
/*      */       }
/*  324 */       else if (("".equals(contributeEsse)) || (contributeEsse == null))
/*      */       {
/*  326 */         strsql = "select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender Group by userInfo.city order by sumText desc";
/*      */       }
/*      */       else {
/*  329 */         strsql = "select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.city='" + contributeEsse + "' Group by userInfo.city order by sumText desc";
/*      */       }
/*      */ 
/*      */     }
/*  334 */     else if ((!"".equals(startDate)) && (startDate != null) && (!"".equals(endDate)) && (endDate != null))
/*      */     {
/*  336 */       if (("".equals(contributeEsse)) || (contributeEsse == null))
/*      */       {
/*  338 */         strsql = "select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.ContributeDate>='" + startDate + "' and textInfo.ContributeDate<'" + endDate + "' Group by textInfo.sender order by sumText desc";
/*      */       }
/*      */       else {
/*  341 */         strsql = "select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.author='" + contributeEsse + "' and textInfo.ContributeDate>='" + startDate + "' and textInfo.ContributeDate<'" + endDate + "' Group by textInfo.sender order by sumText desc";
/*      */       }
/*      */ 
/*      */     }
/*  345 */     else if (("".equals(contributeEsse)) || (contributeEsse == null))
/*      */     {
/*  347 */       strsql = "select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender Group by textInfo.sender order by sumText desc";
/*      */     }
/*      */     else {
/*  350 */       strsql = "select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.author='" + contributeEsse + "' Group by textInfo.sender order by sumText desc";
/*      */     }
/*      */ 
/*  356 */     List vt = new ArrayList();
/*      */ 
/*  361 */     SQLQuery query = getSession().createSQLQuery(strsql);
/*      */ 
/*  363 */     List list = query.list();
/*      */ 
/*  366 */     for (int x = 0; x < list.size(); x++)
/*      */     {
/*  368 */       String author = ((Object[])list.get(x))[0].toString();
/*      */ 
/*  370 */       int sumtext = Integer.parseInt(((Object[])list.get(x))[1].toString());
/*  371 */       TextAmountInfo textAmountInfo = new TextAmountInfo(author, sumtext);
/*  372 */       vt.add(textAmountInfo);
/*      */     }
/*      */ 
/*  375 */     return vt;
/*      */   }
/*      */ 
/*      */   public List<StatusInfo> ListStatus(String startDate, String endDate, String orderStr, String province, String city, String jianbao)
/*      */   {
/*  384 */     String sql = "";
/*      */ 
/*  387 */     if ((!"".equals(province)) && (!"".equals(city)))
/*      */     {
/*  389 */       sql = sql + "select county,count(*) as coun from userInfo u,textInfo t ";
/*      */     }
/*      */ 
/*  392 */     if ((!"".equals(province)) && ("".equals(city)))
/*      */     {
/*  394 */       sql = sql + "select city,count(*) as coun from userInfo u,textInfo t ";
/*      */     }
/*      */ 
/*  397 */     if (("".equals(city)) && ("".equals(province)))
/*      */     {
/*  399 */       sql = sql + "select province,count(*) as coun from userInfo u,textInfo t ";
/*      */     }
/*      */ 
/*  405 */     sql = sql + " where u.name_Login=t.sender  ";
/*      */ 
/*  410 */     if ((!"".equals(jianbao)) && ("CMA".equals(jianbao)))
/*      */     {
/*  412 */       sql = sql + " AND  STATUS!='待取'  AND t.`status` LIKE '%CMA网站:见%'";
/*      */     }
/*      */ 
/*  415 */     if ((!"".equals(jianbao)) && ("ZGQXB".equals(jianbao)))
/*      */     {
/*  417 */       sql = sql + " AND  STATUS!='待取'  AND t.`status` LIKE '%中国气象报:见%'";
/*      */     }
/*      */ 
/*  422 */     if ((startDate != null) && (endDate != null)) {
/*  423 */       sql = sql + " and ContributeDate >='";
/*  424 */       sql = sql + startDate + " 00:00:00' and  ContributeDate <='" + endDate + " 23:59:59' and anonyFlag = 0 ";
/*      */     }
/*      */ 
/*  427 */     if ((!"".equals(province)) && (!"".equals(city)))
/*      */     {
/*  429 */       sql = sql + " and city ='" + city + "' GROUP BY county order by coun desc";
/*      */     }
/*      */ 
/*  432 */     if ((!"".equals(province)) && ("".equals(city)))
/*      */     {
/*  434 */       sql = sql + " and province ='" + province + "' GROUP BY city order by coun desc";
/*      */     }
/*      */ 
/*  439 */     if (("".equals(city)) && ("".equals(province)))
/*      */     {
/*  441 */       sql = sql + "  GROUP BY province order by coun desc";
/*      */     }
/*      */ 
/*  446 */     List list = getSession().createSQLQuery(sql)
/*  447 */       .list();
/*      */ 
/*  451 */     List listStatus = new ArrayList();
/*      */     try
/*      */     {
/*  454 */       if ((list != null) && (list.size() > 0))
/*      */       {
/*  458 */         for (int x = 0; x < list.size(); x++)
/*      */         {
/*  460 */           StatusInfo statusInfo = new StatusInfo();
/*      */ 
/*  462 */           Object object = ((Object[])list.get(x))[1];
/*  463 */           Object object2 = ((Object[])list.get(x))[0];
/*      */ 
/*  465 */           if ((object != null) && (object2 != null)) {
/*  466 */             statusInfo.setSum(object.toString());
/*      */           }
/*  468 */           if ((object2 != null) && (object != null)) {
/*  469 */             statusInfo.setSum2(object2.toString());
/*      */           }
/*  471 */           listStatus.add(statusInfo);
/*      */         }
/*      */       }
/*      */     }
/*      */     catch (Exception e)
/*      */     {
/*  477 */       e.printStackTrace();
/*      */     }
/*      */ 
/*  480 */     return listStatus;
/*      */   }
/*      */ 
/*      */   public List<StatusInfo> ListStatusAuthor(String orderStr, String province)
/*      */   {
/*  486 */     String strsql = "SELECT userInfo.name_Login,userInfo.name_real";
/*  487 */     strsql = strsql + " FROM textInfo inner JOIN userInfo ON textInfo.sender = userInfo.name_Login ";
/*      */ 
/*  489 */     strsql = strsql + " and userInfo.province = '" + province + "' and role!='管理员'";
/*  490 */     strsql = strsql + "  GROUP BY name_Login,name_real order by " + orderStr + " desc";
/*      */ 
/*  492 */     List list = getSession().createSQLQuery(strsql).list();
/*      */ 
/*  495 */     List listStatus = new ArrayList();
/*  496 */     for (int x = 0; x < list.size(); x++)
/*      */     {
/*  499 */       StatusInfo statusInfo = new StatusInfo();
/*  500 */       statusInfo.setName_Login(((Object[])list.get(x))[0].toString());
/*  501 */       statusInfo.setName_real(((Object[])list.get(x))[1].toString());
/*      */ 
/*  503 */       listStatus.add(statusInfo);
/*      */     }
/*      */ 
/*  512 */     return listStatus;
/*      */   }
/*      */ 
/*      */   public PageBean getAllFenYe(int pageNum, Class<TextInfo> class1)
/*      */   {
/*  518 */     String page = ManagerPro.getString("PageSize");
/*      */ 
/*  520 */     int pageSize = Integer.parseInt(page);
/*      */ 
/*  523 */     Query countQuery = getSession().createQuery("SELECT COUNT(*) from  TextInfo");
/*      */ 
/*  525 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*      */ 
/*  529 */     List recordList = getSession().createQuery("from TextInfo t order by t.textID desc")
/*  530 */       .setFirstResult((pageNum - 1) * pageSize)
/*  531 */       .setMaxResults(pageSize)
/*  532 */       .list();
/*      */ 
/*  539 */     return new PageBean(pageNum, pageSize, recordCount, recordList);
/*      */   }
/*      */ 
/*      */   public PageBean getAllFenYe(int pageNum, Class<TextInfo> class1, String parameter)
/*      */   {
/*  545 */     String page = ManagerPro.getString("PageSize");
/*      */ 
/*  547 */     int pageSize = Integer.parseInt(page);
/*      */ 
/*  550 */     Query countQuery = getSession().createQuery("SELECT COUNT(*) from  TextInfo t where t.Cat=?").setParameter(0, parameter);
/*      */ 
/*  552 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*      */ 
/*  555 */     Query listQuery = getSession().createQuery("from TextInfo t where t.Cat=? order by t.textID desc").setParameter(0, parameter);
/*      */ 
/*  557 */     listQuery.setFirstResult((pageNum - 1) * pageSize);
/*  558 */     listQuery.setMaxResults(pageSize);
/*  559 */     List recordList = listQuery.list();
/*      */ 
/*  561 */     return new PageBean(pageNum, pageSize, recordCount, recordList);
/*      */   }
/*      */ 
/*      */   public PageBean getAllFenYeByName(int pageNum, TextInfo tn, String name)
/*      */   {
	
				String textTitle = tn.getTextTitle();
	
/*  569 */     String page = ManagerPro.getString("PageSize");
/*      */ 
/*  571 */     int pageSize = Integer.parseInt(page);


				String counthql="";
				
				String hql="";
				if(textTitle!=null&&textTitle!="")
				{
					
					counthql=	"SELECT COUNT(*) from  TextInfo t,UserInfo u where t.sender=u.name_Login and t.textTitle like '%"+textTitle+"%'  and u.name_Login=?";
					hql="select t.* from textInfo t ,userInfo u where t.sender=u.name_Login and t.textTitle like '%"+textTitle+"%' and u.name_Login=? order by t.textID desc";
				}
				else {
					counthql= "SELECT COUNT(*) from  TextInfo t,UserInfo u where t.sender=u.name_Login and u.name_Login=?";
					hql="select t.* from textInfo t ,userInfo u where t.sender=u.name_Login and u.name_Login=? order by t.textID desc";
				}


/*      */ 
/*  574 */     Query countQuery = getSession().createQuery(counthql).setParameter(0, name);
/*      */ 
/*  576 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*      */ 
/*  579 */     Query listQuery = getSession().createSQLQuery(hql).setParameter(0, name);
/*      */ 
/*  581 */     listQuery.setFirstResult((pageNum - 1) * pageSize);
/*  582 */     listQuery.setMaxResults(pageSize);
/*  583 */     List record = listQuery.list();
/*      */ 
/*  585 */     List recordList = new ArrayList();
/*  586 */     TextInfo textInfo = null;
/*  587 */     if ((record != null) && (record.size() > 0))
/*      */     {
/*  589 */       for (int x = 0; x < record.size(); x++) {
/*  590 */         int id = Integer.parseInt(((Object[])record.get(x))[0].toString());
/*  591 */         textInfo = new TextInfo();
/*  592 */         textInfo.setTextID(Integer.valueOf(id));
/*  593 */         if (((Object[])record.get(x))[1] != null)
/*      */         {
/*  595 */           textInfo.setTextTitle(((Object[])record.get(x))[1].toString());
/*      */         }
/*  597 */         if (((Object[])record.get(x))[7] != null)
/*      */         {
/*  600 */           textInfo.setRest1(((Object[])record.get(x))[7].toString());
/*      */         }
/*  602 */         if (((Object[])record.get(x))[3] != null)
/*      */         {
/*  604 */           textInfo.setAuthor(((Object[])record.get(x))[3].toString());
/*      */         }
/*  606 */         if (((Object[])record.get(x))[5] != null)
/*      */         {
/*  609 */           textInfo.setContributeDate(((Object[])record.get(x))[5].toString());
/*      */         }
/*  611 */         if (((Object[])record.get(x))[12] != null)
/*      */         {
/*  614 */           textInfo.setCat(((Object[])record.get(x))[12].toString());
/*      */         }
/*  616 */         if (((Object[])record.get(x))[9] != null)
/*      */         {
/*  619 */           textInfo.setRest3(((Object[])record.get(x))[9].toString());
/*      */         }
/*  621 */         if (((Object[])record.get(x))[13] != null)
/*      */         {
/*  624 */           textInfo.setIsUsed(((Object[])record.get(x))[13].toString());
/*      */         }
/*  626 */         if (((Object[])record.get(x))[11] != null)
/*      */         {
/*  628 */           textInfo.setStatus(((Object[])record.get(x))[11].toString());
/*      */         }
/*  630 */         recordList.add(textInfo);
/*      */       }
/*      */     }
/*      */ 
/*  634 */     return new PageBean(pageNum, pageSize, recordCount, recordList);
/*      */   }
/*      */ 
/*      */   public PageBean getAllFenYeBySender(int pageNum, Class<TextInfo> class1, String parameter)
/*      */   {
/*  645 */     String page = ManagerPro.getString("PageSize");
/*      */ 
/*  647 */     int pageSize = Integer.parseInt(page);
/*      */ 
/*  650 */     Query countQuery = getSession().createQuery("SELECT COUNT(*) from  TextInfo t where t.sender=?").setParameter(0, parameter);
/*      */ 
/*  652 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*      */ 
/*  655 */     Query listQuery = getSession().createQuery("from TextInfo t where t.sender=? order by t.textID desc").setParameter(0, parameter);
/*      */ 
/*  657 */     listQuery.setFirstResult((pageNum - 1) * pageSize);
/*  658 */     listQuery.setMaxResults(pageSize);
/*  659 */     List recordList = listQuery.list();
/*      */ 
/*  661 */     return new PageBean(pageNum, pageSize, recordCount, recordList);
/*      */   }
/*      */ 
/*      */   public PageBean getAllFenYeByAll(int pageNum, Class<TextInfo> class1, String startDate, String endDate, String author, String sender, String idcard, String workcompany)
/*      */   {
/*  676 */     String page = ManagerPro.getString("PageSize");
/*      */ 
/*  678 */     int pageSize = Integer.parseInt(page);
/*      */ 
/*  681 */     String condition1 = " select t.* from textInfo t, userInfo u where t.sender=u.name_login ";
/*  682 */     String condition = "";
/*  683 */     String condition2 = " select count(*) from TextInfo t,UserInfo u where t.sender=u.name_Login";
/*  684 */     if (StringUtils.isNotBlank(author))
/*      */     {
/*  686 */       condition = condition + " and t.author ='" + author + "'";
/*      */     }
/*  688 */     if (StringUtils.isNotBlank(sender))
/*      */     {
/*  690 */       condition = condition + " and t.sender ='" + sender + "'";
/*      */     }
/*  692 */     if (StringUtils.isNotBlank(idcard))
/*      */     {
/*  694 */       condition = condition + " and u.idcard like '%" + idcard + "%'";
/*      */     }
/*  696 */     if (StringUtils.isNotBlank(workcompany))
/*      */     {
/*  698 */       condition = condition + " and u.workcompany ='" + workcompany + "'";
/*      */     }
/*  700 */     if ((StringUtils.isNotBlank(startDate)) && (StringUtils.isNotBlank(endDate)))
/*      */     {
/*  702 */       condition = condition + " and t.ContributeDate >= '" + startDate + "' and  t.ContributeDate <='" + endDate + "'";
/*      */     }
/*      */ 
/*  707 */     Query countQuery = getSession().createQuery(condition2 + condition);
/*      */ 
/*  709 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*      */ 
/*  712 */     String order = " order by t.ContributeDate desc";
/*  713 */     Query listQuery = getSession().createSQLQuery(condition1 + condition + order);
/*      */ 
/*  715 */     listQuery.setFirstResult((pageNum - 1) * pageSize);
/*  716 */     listQuery.setMaxResults(pageSize);
/*  717 */     List list = listQuery.list();
/*      */ 
/*  719 */     List listText = new ArrayList();
/*      */ 
/*  721 */     TextInfo textInfo2 = null;
/*  722 */     for (int x = 0; x < list.size(); x++)
/*      */     {
/*  726 */       textInfo2 = new TextInfo();
/*      */ 
/*  728 */       textInfo2.setTextTitle(((Object[])list.get(x))[1].toString());
/*      */ 
/*  730 */       textInfo2.setTextID(Integer.valueOf(Integer.parseInt(((Object[])list.get(x))[0].toString())));
/*  731 */       if (((Object[])list.get(x))[7] != null)
/*      */       {
/*  733 */         textInfo2.setRest1(((Object[])list.get(x))[7].toString());
/*      */       }
/*  735 */       textInfo2.setSender(((Object[])list.get(x))[4].toString());
/*  736 */       textInfo2.setAuthor(((Object[])list.get(x))[3].toString());
/*  737 */       textInfo2.setContributeDate(((Object[])list.get(x))[5].toString());
/*  738 */       if (((Object[])list.get(x))[12] != null)
/*      */       {
/*  740 */         textInfo2.setCat(((Object[])list.get(x))[12].toString());
/*      */       }
/*  742 */       if (((Object[])list.get(x))[10] != null)
/*      */       {
/*  744 */         textInfo2.setAuthorIP(((Object[])list.get(x))[10].toString());
/*      */       }
/*  746 */       textInfo2.setRest3(((Object[])list.get(x))[9].toString());
/*  747 */       textInfo2.setIsUsed(((Object[])list.get(x))[13].toString());
/*  748 */       if (((Object[])list.get(x))[11] != null)
/*      */       {
/*  750 */         textInfo2.setStatus(((Object[])list.get(x))[11].toString());
/*      */       }
/*  752 */       listText.add(textInfo2);
/*      */     }
/*      */ 
/*  757 */     return new PageBean(pageNum, pageSize, recordCount, listText);
/*      */   }
/*      */ 
/*      */   public TextInfo getByTitle(String textTitle, Date todayPlus1, String name)
/*      */   {
/*  765 */     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
/*      */ 
/*  767 */     String format = sdf.format(todayPlus1);
/*  768 */     Query query = getSession().createQuery("from TextInfo t where t.textTitle=? and t.ContributeDate > ? and t.sender=?").setParameter(0, textTitle)
/*  769 */       .setParameter(1, format).setParameter(2, name);
/*      */ 
/*  772 */     List list = query.list();
/*  773 */     TextInfo textInfo = null;
/*  774 */     if ((list != null) && (list.size() > 0))
/*      */     {
/*  776 */       textInfo = (TextInfo)list.get(0);
/*      */     }
/*  778 */     return textInfo;
/*      */   }
/*      */ 
/*      */   public int getAllAuthor()
/*      */   {
/*  783 */     Query countQuery = getSession().createQuery("select count(DISTINCT author) from TextInfo");
/*      */ 
/*  785 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*      */ 
/*  787 */     return recordCount;
/*      */   }
/*      */ 
/*      */   public List<Object[]> findChartUser(String startDate, String endDate)
/*      */   {
/*  795 */     String sql = "select distinct province, count(*) as coun from userInfo where province is not null ";
/*      */ 
/*  797 */     if ((startDate != null) && (endDate != null))
/*      */     {
/*  801 */       sql = sql + " and createtime > '" + startDate + "' and createtime<'" + endDate + "'";
/*      */     }
/*  803 */     sql = sql + " GROUP BY province order by coun desc";
/*      */ 
/*  805 */     List list = getSession().createSQLQuery(sql)
/*  806 */       .list();
/*  807 */     return list;
/*      */   }
/*      */ 
/*      */   public List<Object[]> findChartByProvince(String province, String startDate, String endDate, String city, String jianbao) {
/*  811 */     String sql = "";
/*  812 */     if ((!"".equals(city)) && (!"".equals(province)))
/*      */     {
/*  814 */       sql = sql + "select county,count(*) as coun from userInfo u,textInfo t ";
/*      */     }
/*      */ 
/*  817 */     if (("".equals(city)) && (!"".equals(province)))
/*      */     {
/*  819 */       sql = sql + "select city,count(*) as coun from userInfo u,textInfo t ";
/*      */     }
/*      */ 
/*  822 */     if (("".equals(city)) && ("".equals(province)))
/*      */     {
/*  824 */       sql = sql + "select province,count(*) as coun from userInfo u,textInfo t ";
/*      */     }
/*      */ 
/*  829 */     sql = sql + " where u.name_Login=t.sender  ";
/*      */ 
/*  832 */     if ((!"".equals(jianbao)) && ("CMA".equals(jianbao)))
/*      */     {
/*  834 */       sql = sql + " AND  STATUS!='待取'  AND t.`status` LIKE '%CMA网站:见%'";
/*      */     }
/*      */ 
/*  837 */     if ((!"".equals(jianbao)) && ("ZGQXB".equals(jianbao)))
/*      */     {
/*  839 */       sql = sql + " AND  STATUS!='待取'  AND t.`status` LIKE '%中国气象报:见%'";
/*      */     }
/*      */ 
/*  845 */     if ((startDate != null) && (endDate != null)) {
/*  846 */       sql = sql + " and ContributeDate >='";
/*  847 */       sql = sql + startDate + " 00:00:00' and  ContributeDate <='" + endDate + " 23:59:59' and anonyFlag = 0 ";
/*      */     }
/*      */ 
/*  850 */     if ((!"".equals(city)) && (!"".equals(province)))
/*      */     {
/*  852 */       sql = sql + " and city ='" + city + "' GROUP BY county order by coun desc";
/*      */     }
/*      */ 
/*  856 */     if (("".equals(city)) && (!"".equals(province)))
/*      */     {
/*  858 */       sql = sql + " and province ='" + province + "' GROUP BY city order by coun desc";
/*      */     }
/*      */ 
/*  862 */     if (("".equals(city)) && ("".equals(province)))
/*      */     {
/*  864 */       sql = sql + "  GROUP BY province order by coun desc";
/*      */     }
/*      */ 
/*  868 */     List list = getSession().createSQLQuery(sql)
/*  869 */       .list();
/*      */ 
/*  873 */     return list;
/*      */   }
/*      */ 
/*      */   public List<StatusInfo> ListStatusByLogin(String startDate, String endDate, String name)
/*      */   {
/*  880 */     String strsql = "SELECT province, COUNT(*) AS sum ";
/*      */ 
/*  896 */     strsql = strsql + " FROM  userInfo where 1=1 ";
/*  897 */     if ((startDate != null) && (endDate != null))
/*      */     {
/*  899 */       strsql = strsql + " and createtime >='" + startDate + " 00:00:00' and  createtime <='" + endDate + " 23:59:59'  ";
/*      */     }
/*      */ 
/*  903 */     strsql = strsql + " GROUP BY province ORDER BY sum DESC";
/*      */ 
/*  906 */     List list = getSession().createSQLQuery(strsql)
/*  909 */       .list();
/*      */ 
/*  914 */     List listStatus = new ArrayList();
/*  915 */     for (int x = 0; x < list.size(); x++)
/*      */     {
/*  917 */       StatusInfo statusInfo = new StatusInfo();
/*  918 */       statusInfo.setSum(((Object[])list.get(x))[1].toString());
/*      */ 
/*  920 */       statusInfo.setSum2(((Object[])list.get(x))[0].toString());
/*  921 */       listStatus.add(statusInfo);
/*      */     }
/*      */ 
/*  928 */     return listStatus;
/*      */   }
/*      */ 
/*      */   public List<StatusInfo> ListStatusByLogin2(String startDate, String endDate, String name, String province)
/*      */   {
/*  941 */     String sql = "";
/*  942 */     if ((!"".equals(province)) && (province != null))
/*      */     {
/*  944 */       sql = sql + "select city,count(*) as coun from userInfo u ";
/*      */     }
/*      */     else {
/*  947 */       sql = sql + "select province,count(*) as coun from userInfo u ";
/*      */     }
/*      */ 
/*  951 */     sql = sql + " where 1=1  ";
/*      */ 
/*  955 */     if ((startDate != null) && (endDate != null)) {
/*  956 */       sql = sql + " and createtime >='";
/*  957 */       sql = sql + startDate + "' and  createtime <='" + endDate + "' and AuditingFlag = 1 ";
/*      */     }
/*      */ 
/*  960 */     if ((!"".equals(province)) && (province != null))
/*      */     {
/*  962 */       sql = sql + " and province ='" + province + "' GROUP BY city order by coun desc";
/*      */     }
/*      */     else
/*      */     {
/*  966 */       sql = sql + " GROUP BY province order by coun desc";
/*      */     }
/*  968 */     List list = getSession().createSQLQuery(sql)
/*  969 */       .list();
/*      */ 
/*  973 */     List listStatus = new ArrayList();
/*  974 */     for (int x = 0; x < list.size(); x++)
/*      */     {
/*  976 */       StatusInfo statusInfo = new StatusInfo();
/*  977 */       statusInfo.setSum(((Object[])list.get(x))[1].toString());
/*      */ 
/*  981 */       statusInfo.setSum2(((Object[])list.get(x))[0].toString());
/*      */ 
/*  983 */       listStatus.add(statusInfo);
/*      */     }
/*      */ 
/*  988 */     return listStatus;
/*      */   }
/*      */ 
/*      */   public List<Object[]> findUsersByProvince(String province, String startDate, String endDate)
/*      */   {
/*  999 */     String sql = "";
/* 1000 */     if ((!"".equals(province)) && (province != null))
/*      */     {
/* 1002 */       sql = sql + "select city,count(*) as coun from userInfo u ";
/*      */     }
/*      */     else {
/* 1005 */       sql = sql + "select province,count(*) as coun from userInfo u ";
/*      */     }
/*      */ 
/* 1009 */     sql = sql + " where 1=1  ";
/*      */ 
/* 1013 */     if ((startDate != null) && (endDate != null)) {
/* 1014 */       sql = sql + " and createtime >='";
/* 1015 */       sql = sql + startDate + "' and  createtime <='" + endDate + "' and AuditingFlag = 1 ";
/*      */     }
/*      */ 
/* 1018 */     if ((!"".equals(province)) && (province != null))
/*      */     {
/* 1020 */       sql = sql + " and province ='" + province + "' GROUP BY city order by coun desc";
/*      */     }
/*      */     else
/*      */     {
/* 1024 */       sql = sql + " GROUP BY province order by coun desc";
/*      */     }
/* 1026 */     List list = getSession().createSQLQuery(sql)
/* 1027 */       .list();
/*      */ 
/* 1031 */     return list;
/*      */   }
/*      */ 
/*      */   public List findJspBaoBiao(String startDate, String endDate, String jianbao)
/*      */   {
/* 1036 */     List listall = new ArrayList();
/*      */ 
/* 1048 */     String sql = "select province,count(*) as count from userInfo u,textInfo t  where u.name_Login=t.sender ";
/*      */ 
/* 1051 */     if ((startDate != null) && (endDate != null))
/*      */     {
/* 1053 */       startDate = startDate + " 00:00:00";
/* 1054 */       endDate = endDate + " 23:59:59";
/* 1055 */       sql = sql + "and t.ContributeDate >='" + startDate + "' and  t.ContributeDate <='" + endDate + "' ";
/*      */     }
/* 1057 */     if ((jianbao != null) && ("CMA".equals(jianbao)))
/*      */     {
/* 1059 */       sql = sql + "   AND t.`status` LIKE '%CMA网站:见%'";
/*      */     }
/*      */ 
/* 1062 */     if ((jianbao != null) && ("ZGQXB".equals(jianbao)))
/*      */     {
/* 1064 */       sql = sql + "   AND t.`status` LIKE '%中国气象报:见%'";
/*      */     }
/* 1066 */     sql = sql + " GROUP BY province ORDER BY coun DESC ";
/*      */ 
/* 1069 */     List listp = getSession().createSQLQuery(sql).list();
/*      */ 
/* 1072 */     for (int x = 0; x < listp.size(); x++)
/*      */     {
/* 1074 */       String province = ((Object[])listp.get(x))[0].toString() + "_" + ((Object[])listp.get(x))[1].toString();
/*      */ 
/* 1079 */       String sql4 = "select city,count(*) as coun from userInfo u,textInfo t  where u.name_Login=t.sender ";
/*      */ 
/* 1083 */       if ((startDate != null) && (endDate != null))
/*      */       {
/* 1086 */         sql4 = sql4 + "and ContributeDate >='" + startDate + "' and  ContributeDate <='" + endDate + "' ";
/*      */       }
/* 1088 */       if ((jianbao != null) && ("CMA".equals(jianbao)))
/*      */       {
/* 1090 */         sql4 = sql4 + "   AND t.`status` LIKE '%CMA网站:见%'";
/*      */       }
/*      */ 
/* 1093 */       if ((jianbao != null) && ("ZGQXB".equals(jianbao)))
/*      */       {
/* 1095 */         sql4 = sql4 + "   AND t.`status` LIKE '%中国气象报:见%'";
/*      */       }
/*      */ 
/* 1098 */       sql4 = sql4 + " and province ='" + ((Object[])listp.get(x))[0].toString() + "' GROUP BY city";
/*      */ 
/* 1101 */       List listci = getSession().createSQLQuery(sql4).list();
/*      */ 
/* 1104 */       for (int y = 0; y < listci.size(); y++)
/*      */       {
/* 1108 */         String city = ((Object[])listci.get(y))[0].toString() + "_" + ((Object[])listci.get(y))[1].toString();
/*      */ 
/* 1115 */         String sql5 = "select county,count(*) as coun from userInfo u,textInfo t  where u.name_Login=t.sender ";
/*      */ 
/* 1117 */         if ((startDate != null) && (endDate != null))
/*      */         {
/* 1120 */           sql5 = sql5 + "and t.ContributeDate >='" + startDate + "' and  t.ContributeDate <='" + endDate + "' ";
/*      */         }
/*      */ 
/* 1123 */         if ((jianbao != null) && ("CMA".equals(jianbao)))
/*      */         {
/* 1125 */           sql5 = sql5 + "   AND t.`status` LIKE '%CMA网站:见%'";
/*      */         }
/*      */ 
/* 1128 */         if ((jianbao != null) && ("ZGQXB".equals(jianbao)))
/*      */         {
/* 1130 */           sql5 = sql5 + "   AND t.`status` LIKE '%中国气象报:见%'";
/*      */         }
/*      */ 
/* 1133 */         sql5 = sql5 + " and city ='" + ((Object[])listci.get(y))[0].toString() + "' GROUP BY county order by coun desc";
/*      */ 
/* 1135 */         List listco = getSession().createSQLQuery(sql5).list();
/*      */ 
/* 1139 */         for (int z = 0; z < listco.size(); z++)
/*      */         {
/* 1143 */           Object o = ((Object[])listco.get(z))[0];
/* 1144 */           Object o2 = ((Object[])listco.get(z))[1];
/* 1145 */           String county = "";
/* 1146 */           String county2 = "";
/*      */ 
/* 1158 */           if (o != null)
/*      */           {
/* 1160 */             county = o.toString();
/*      */           }
/*      */           else {
/* 1163 */             county = "县未知";
/*      */           }
/*      */ 
/* 1166 */           if (o2 != null)
/*      */           {
/* 1168 */             county2 = o2.toString();
/*      */           }
/*      */           else {
/* 1171 */             county2 = "0";
/*      */           }
/*      */ 
/* 1174 */           StatusInfo info = new StatusInfo();
/*      */ 
/* 1176 */           info.setName_Login(((Object[])listp.get(x))[0].toString());
/* 1177 */           info.setName_real(((Object[])listp.get(x))[1].toString());
/* 1178 */           info.setSum(((Object[])listci.get(y))[0].toString());
/* 1179 */           info.setSum2(((Object[])listci.get(y))[1].toString());
/* 1180 */           info.setSum3(county);
/* 1181 */           info.setSum4(county2);
/*      */ 
/* 1183 */           listall.add(info);
/*      */         }
/*      */ 
/*      */       }
/*      */ 
/*      */     }
/*      */ 
/* 1234 */     return listall;
/*      */   }
/*      */ 
/*      */   public List findByCounty(String startDate, String endDate, String jianbao) {
/* 1238 */     List listall = new ArrayList();
/*      */ 
/* 1241 */     String sql5 = "select county,count(*) as coun from userInfo u,textInfo t  where u.name_Login=t.sender ";
/*      */ 
/* 1246 */     if ((startDate != null) && (endDate != null))
/*      */     {
/* 1249 */       sql5 = sql5 + "and t.ContributeDate >='" + startDate + "' and  t.ContributeDate <='" + endDate + "' ";
/*      */     }
/*      */ 
/* 1252 */     if ((jianbao != null) && ("CMA".equals(jianbao)))
/*      */     {
/* 1254 */       sql5 = sql5 + "   AND t.`status` LIKE '%CMA网站:见%'";
/*      */     }
/*      */ 
/* 1257 */     if ((jianbao != null) && ("ZGQXB".equals(jianbao)))
/*      */     {
/* 1259 */       sql5 = sql5 + "   AND t.`status` LIKE '%中国气象报:见%'";
/*      */     }
/*      */ 
/* 1264 */     sql5 = sql5 + " GROUP BY county ORDER BY coun DESC ";
/*      */ 
/* 1268 */     List listco = getSession().createSQLQuery(sql5).list();
/*      */ 
/* 1274 */     for (int z = 0; z < listco.size(); z++)
/*      */     {
/* 1278 */       Object o = ((Object[])listco.get(z))[0];
/* 1279 */       Object o2 = ((Object[])listco.get(z))[1];
/* 1280 */       String county = "";
/* 1281 */       String county2 = "";
/*      */ 
/* 1284 */       if ((o != null) && (o2 != null))
/*      */       {
/* 1288 */         county = o.toString();
/* 1289 */         county2 = o2.toString();
/*      */ 
/* 1292 */         StatusInfo info = new StatusInfo();
/*      */ 
/* 1294 */         info.setSum(county);
/* 1295 */         info.setSum2(county2);
/*      */ 
/* 1297 */         listall.add(info);
/*      */       }
/*      */ 
/*      */     }
/*      */ 
/* 1309 */     return listall;
/*      */   }
/*      */

public void createXML(int id,String name) {
	
	
	 PrintWriter outs = null;
	 
     Query query = getSession().createQuery("from UserInfo u where u.name_Login=?")
       .setParameter(0, name);
     UserInfo userInfo = (UserInfo)query.uniqueResult();
     
     String workcompany = userInfo.getWorkcompany();
     
 TextInfo text = getById(id);
 
     String idcard = userInfo.getIdcard();
     String address = userInfo.getDepartment();
     String email = userInfo.getEmail();
     String postalcode = userInfo.getPostalcode();
     String phone = userInfo.getPhone();
     String role = userInfo.getRole();
     String mobilePhone = userInfo.getMobilePhone();
     String province = userInfo.getProvince();
 
     String city = userInfo.getCity();
 
     String county = userInfo.getCounty();
     String mcontent = text.getTextContent();
 
     mcontent = mcontent.replaceAll("<", "＜");
     mcontent = mcontent.replaceAll(">", "＞");
 
     String UniContributeDate = text.getContributeDate();
     UniContributeDate = UniContributeDate.substring(0, 10);
     String author = text.getAuthor();
     String picInfo = text.getPicInfo();
     String rest1 = text.getRest1();
     String cat = text.getCat();
     String title = text.getTextTitle();
 
     String globalNewsId = text.getGlobalNewsId();
 
     int textId = text.getTextID().intValue();
     
    
 
     String tempFolder = ManagerPro.getString("text_tempfolder");
     if ((tempFolder == null) || (tempFolder.equals("")))
     {
       tempFolder = "d:/Unicontribution";
     }
     
  if(picInfo!=null&&picInfo.length()>0)
  {
      tempFolder = tempFolder + "/docpic/";

  }
  else {
	
      tempFolder = tempFolder + "/doc/";

}
     
     
     
 
     File file = new File(tempFolder);
 
     if (!file.exists())
     {
       file.mkdirs();
     }
 
     String filename = name + UniContributeDate + "_" + textId;
     filename = filename + "_";
     
     String attachStr = text.getAttachInfo();
 
     if(picInfo!=null&&picInfo.length()>0)
     {
       filename = filename + "_t";
     }
     int dashIndex = 0;
     String attachStr2 = "";
     if ((attachStr != null) && (!attachStr.equals("")))
     {
       String[] attachInfoStrs = attachStr.split(";");
       for (int m = 0; m < attachInfoStrs.length; m++)
       {
         if ((attachInfoStrs[m] != null) && (!attachInfoStrs[m].equals("")))
         {
           dashIndex = attachInfoStrs[m].lastIndexOf('_');
           attachStr2 = attachStr2 + attachInfoStrs[m].substring(0, dashIndex) + "_" + 1 + attachInfoStrs[m].substring(dashIndex) + ";";
         }
       }
     }
 
     String pReturn = "\r\n";
     String pString = "";
     String txtfile = "";
     txtfile = tempFolder + filename + ".XML";
     pString = pString + "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + pReturn;
     pString = pString + "<News>" + pReturn;
     pString = pString + "<ID>" + textId + "</ID>" + pReturn;
     pString = pString + "<Author>" + author + "</Author>" + pReturn;
     pString = pString + "<Province>" + province + "</Province>" + pReturn;
     pString = pString + "<City>" + city + "</City>" + pReturn;
 
     pString = pString + "<County>" + county + "</County>" + pReturn;
     pString = pString + "<GlobalNewsId>" + globalNewsId + "</GlobalNewsId>" + pReturn;
 
     pString = pString + "<ccode>" + role + "</ccode>" + pReturn;
     pString = pString + "<Sender>" + name + "</Sender>" + pReturn;
     pString = pString + "<IDCard>" + idcard + "</IDCard>" + pReturn;
     pString = pString + "<address>" + address + "</address>" + pReturn;
     pString = pString + "<postCode>" + postalcode + "</postCode>" + pReturn;
     pString = pString + "<Type>" + rest1 + "</Type>" + pReturn;
     pString = pString + "<Cat>" + cat + "</Cat>" + pReturn;
     pString = pString + "<WorkCompany>" + workcompany + "</WorkCompany>" + pReturn;
     pString = pString + "<Time>" + UniContributeDate + "</Time>" + pReturn;
     pString = pString + "<Phone>" + phone + "," + mobilePhone + "</Phone>" + pReturn;
     pString = pString + "<Email>" + email + "</Email>" + pReturn;
     pString = pString + "<Title>" + title + "</Title>" + pReturn;
 
     if ((attachStr == null) || (attachStr.equals(""))) {
    	 if(picInfo!=null&&picInfo.length()>0)
    	  {
         pString = pString + "<Body></Body>" + pReturn;
       }
       else
         pString = pString + "<Body>" + title + pReturn + mcontent + "</Body>" + pReturn;
     }
     else
     {
       pString = pString + "<Body>" + title + pReturn + mcontent + "</Body>" + pReturn;
       pString = pString + "<Pics>" + attachStr2 + "</Pics>" + pReturn;
     }
     pString = pString + "</News>" + pReturn;
     File f_txt = new File(txtfile);
     if (!f_txt.exists())
     {
       try {
         outs = new PrintWriter(new FileOutputStream(txtfile, true));
       } catch (Exception e) {
         e.printStackTrace();
       }
       outs.println(pString);
       outs.flush();
       outs.close();
     }
	
	
	
} }

