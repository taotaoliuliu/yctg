/*     */ package cn.uni.dao.impl;
/*     */ 
/*     */ import cn.uni.base.BaseDaoImpl;
/*     */ import cn.uni.dao.UserDao;
/*     */ import cn.uni.domain.PageBean;
/*     */ import cn.uni.domain.UserInfo;
/*     */ import cn.uni.util.ManagerPro;
/*     */ import cn.uni.util.UninewsTools;
/*     */ import java.util.List;
/*     */ import org.apache.commons.lang3.StringUtils;
/*     */ import org.hibernate.Query;
/*     */ import org.hibernate.Session;
/*     */ import org.springframework.stereotype.Repository;
/*     */ 
/*     */ @Repository
/*     */ public class UserDaoImpl extends BaseDaoImpl<UserInfo>
/*     */   implements UserDao
/*     */ {
/*     */   public List<UserInfo> getAll()
/*     */   {
/*  24 */     List list = getSession().createQuery("from UserInfo u where u.auditingFlag=1")
/*  25 */       .list();
/*  26 */     return list;
/*     */   }
/*     */ 
/*     */   public UserInfo getByLoginName(String loginName)
/*     */   {
/*  33 */     Query query = getSession().createQuery("from UserInfo u where u.name_Login=?");
/*  34 */     query.setParameter(0, loginName);
/*  35 */     List list = query.list();
/*  36 */     UserInfo info = null;
/*  37 */     if ((list != null) && (list.size() > 0))
/*     */     {
/*  39 */       info = (UserInfo)list.get(0);
/*     */     }
/*     */ 
/*  42 */     return info;
/*     */   }
/*     */ 
/*     */   public void deleteByLoginName(String string) {
/*  46 */     Query query = getSession().createQuery("delete from UserInfo u where u.name_Login=?");
/*  47 */     query.setParameter(0, string);
/*  48 */     query.executeUpdate();
/*     */   }
/*     */ 
/*     */   public List<UserInfo> getAllByAuditing()
/*     */   {
/*  53 */     List list = getSession().createQuery("from UserInfo u where u.auditingFlag=0 order by u.createtime desc")
/*  54 */       .list();
/*  55 */     return list;
/*     */   }
/*     */ 
/*     */   public UserInfo getByLoginNameAndAuditing(String loginName)
/*     */   {
/*  60 */     Query query = getSession().createQuery("from UserInfo u where u.name_Login=? and u.auditingFlag=?");
/*  61 */     query.setParameter(0, loginName).setParameter(1, Integer.valueOf(0));
/*  62 */     List list = query.list();
/*  63 */     UserInfo info = null;
/*  64 */     if ((list != null) && (list.size() > 0))
/*     */     {
/*  66 */       info = (UserInfo)list.get(0);
/*     */     }
/*  68 */     return info;
/*     */   }
/*     */ 
/*     */   public void auditing(String string) {
/*  72 */     Query query = getSession().createQuery("update UserInfo u set u.auditingFlag=1 where u.name_Login=?");
/*  73 */     query.setParameter(0, string);
/*  74 */     query.executeUpdate();
/*     */   }
/*     */ 
/*     */   public void pauseUser(String string) {
/*  78 */     Query query = getSession().createQuery("update UserInfo u set u.auditingFlag=0 where u.name_Login=?");
/*  79 */     query.setParameter(0, string);
/*  80 */     query.executeUpdate();
/*     */   }
/*     */ 
/*     */   public void setPassword(String password, String username) {
/*  84 */     password = UninewsTools.encryptPassword(password);
/*  85 */     Query query = getSession().createQuery("update UserInfo u set u.password=? where u.name_Login=?");
/*  86 */     query.setParameter(0, password).setParameter(1, username);
/*  87 */     query.executeUpdate();
/*     */   }
/*     */ 
/*     */   public List<UserInfo> getListByCondition(String searchString, String properties)
/*     */   {
/*  92 */     searchString = searchString.trim();
/*     */ 
/*  94 */     String condition = "";
/*  95 */     if (StringUtils.isNotBlank(searchString))
/*     */     {
/*  98 */       if (StringUtils.isNotBlank(properties))
/*     */       {
/* 100 */         if (properties.equals("name_Login"))
/*     */         {
/* 103 */           condition = condition + " and u.name_Login like '%" + searchString + "%'";
/*     */         }
/* 106 */         else if (properties.equals("name_real"))
/* 107 */           condition = condition + " and u.name_real like '%" + searchString + "%'";
/* 108 */         else if (properties.equals("role")) {
/* 109 */           condition = condition + " and u.role like '%" + searchString + "%'";
/*     */         }
/* 111 */         else if (properties.equals("province"))
/* 112 */           condition = condition + " and u.province like '%" + searchString + "%'";
/* 113 */         else if (properties.equals("city"))
/* 114 */           condition = condition + " and u.city like '%" + searchString + "%'";
/* 115 */         else if (properties.equals("workcompany"))
/* 116 */           condition = condition + " and u.workcompany like '%" + searchString + "%'";
/* 117 */         else if (properties.equals("idcard")) {
/* 118 */           condition = condition + " and u.idcard like '%" + searchString + "%'";
/*     */         }
/*     */       }
/*     */     }
/* 122 */     String hql = " from UserInfo u where 1=1  " + condition + " and u.auditingFlag=1 order by u.name_real";
/*     */ 
/* 124 */     Query query = getSession().createQuery(hql);
/* 125 */     List list = query.list();
/*     */ 
/* 127 */     return list;
/*     */   }
/*     */ 
/*     */   public UserInfo getUserBynameLoginAndPassword(String nameLogin, String password)
/*     */   {
/* 132 */     Query query = getSession().createQuery("from UserInfo u where u.name_Login=? and u.password=? and u.auditingFlag=1");
/* 133 */     query.setParameter(0, nameLogin).setParameter(1, password);
/* 134 */     UserInfo info = (UserInfo)query.uniqueResult();
/*     */ 
/* 136 */     return info;
/*     */   }
/*     */ 
/*     */   public PageBean getAllFenYe(int pageNum, Class<UserInfo> class1)
/*     */   {
/* 142 */     String page = ManagerPro.getString("PageSize");
/*     */ 
/* 144 */     int pageSize = Integer.parseInt(page);
/*     */ 
/* 147 */     Query countQuery = getSession().createQuery("SELECT COUNT(*) from  UserInfo u where u.auditingFlag=1");
/*     */ 
/* 149 */     int recordCount = ((Long)countQuery.uniqueResult()).intValue();
/*     */ 
/* 152 */     Query listQuery = getSession().createQuery("from UserInfo u where u.auditingFlag=1 order by u.userID desc");
/*     */ 
/* 154 */     listQuery.setFirstResult((pageNum - 1) * pageSize);
/* 155 */     listQuery.setMaxResults(pageSize);
/* 156 */     List recordList = listQuery.list();
/*     */ 
/* 158 */     return new PageBean(pageNum, pageSize, recordCount, recordList);
/*     */   }
/*     */ 
/*     */   public UserInfo findUser(UserInfo userInfo)
/*     */   {
/* 165 */     String nameLogin = userInfo.getName_Login();
/* 166 */     String nameReal = userInfo.getName_real();
/* 167 */     String idcard = userInfo.getIdcard();
/*     */ 
/* 169 */     Query query = getSession().createQuery("from UserInfo u where u.name_Login=? and u.name_real=? and u.idcard=?")
/* 170 */       .setParameter(0, nameLogin).setParameter(1, nameReal).setParameter(2, idcard);
/*     */ 
/* 172 */     UserInfo user = (UserInfo)query.uniqueResult();
/*     */ 
/* 174 */     return user;
/*     */   }
/*     */ 
/*     */   public UserInfo getByLoginIdcard(String idcard)
/*     */   {
/* 179 */     Query query = getSession().createQuery("from UserInfo u where u.idcard=?");
/* 180 */     query.setParameter(0, idcard);
/* 181 */     List list = query.list();
/* 182 */     UserInfo info = null;
/* 183 */     if ((list != null) && (list.size() > 0))
/*     */     {
/* 185 */       info = (UserInfo)list.get(0);
/*     */     }
/*     */ 
/* 188 */     return info;
/*     */   }
/*     */ }

