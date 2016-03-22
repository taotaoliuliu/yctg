 package cn.uni.dao.impl;
 
 import cn.uni.base.BaseDaoImpl;
 import cn.uni.dao.BullentinDao;
 import cn.uni.domain.BulletinInfo;
 import java.util.List;
 import org.hibernate.Query;
 import org.hibernate.Session;
 import org.springframework.stereotype.Repository;
 
 @Repository
 public class BullentinDaoImpl extends BaseDaoImpl<BulletinInfo>
   implements BullentinDao
 {
   public void stop(int id)
   {
     Query query = getSession().createQuery("update BulletinInfo b set b.ifPut=0 where b.bulletinID=?")
       .setParameter(0, Integer.valueOf(id));
     query.executeUpdate();
   }
 
   public List<BulletinInfo> getAllByIfPut()
   {
     List list = getSession().createQuery("from BulletinInfo b where b.ifPut=1 order by b.CreatTime desc").list();
     return list;
   }
 
   public void resume(int id)
   {
     Query query = getSession().createQuery("update BulletinInfo b set b.ifPut=1 where b.bulletinID=?")
       .setParameter(0, Integer.valueOf(id));
     query.executeUpdate();
   }
 }

