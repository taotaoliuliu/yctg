package cn.uni.base;



import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;


@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> implements BaseDao<T>{
	@Resource
	private SessionFactory sessionFactory;
	private Class<T> clazz;
	public BaseDaoImpl() {
		ParameterizedType pt = (ParameterizedType) this.getClass().getGenericSuperclass();
		this.clazz = (Class<T>) pt.getActualTypeArguments()[0];

		System.out.println("clazz = " + clazz);
	}

	public void delete(Integer id) {
		Object obj = getSession().get(clazz, id);
		getSession().delete(obj);

	}

	public List<T> getAll() {
		return getSession().createQuery
		("from "+clazz.getSimpleName()).list();
	}

	public T getById(Integer id) {
		return (T)getSession().get(clazz, id);
		
		
			}

	
	public List<T> getByIds(Integer[] ids) {
		if (ids == null || ids.length == 0) {
			return Collections.EMPTY_LIST;
		}
		else{
		String hql="from "+clazz.getSimpleName()+" where id in (:ids)";
		
		return getSession().createQuery(hql)
		.setParameterList("ids", ids).list();
		}
	}

	public Object save(T entity) {
		Serializable save = getSession().save(entity);
		
		return save;
		
		
		
	}

	public void update(T entity) {
		getSession().update(entity);

		
	}
	
//	public PageBean getPageBean(int pageNum,HQLHelper hqlHelper)
//	{
//		int pageSize = Configuration.getPageSize();
//
//		List<Object> parameters = hqlHelper.getParameters();
//		
//		//查询总记录数
//		Query countQuery = getSession().createQuery(hqlHelper.getCountHQL());
//		for(int i=0;i<parameters.size();i++)
//		{
//			countQuery.setParameter(i, parameters.get(i));
//		}
//		int recordCount =((Long)countQuery.uniqueResult()).intValue();
//		
//		//查询本页数据
//		Query listQuery = getSession().createQuery(hqlHelper.getListHQL());
//		
//		for(int i = 0; i < parameters.size(); i++)
//		{
//			listQuery.setParameter(i, parameters.get(i));
//		}
//		listQuery.setFirstResult((pageNum - 1) * pageSize);
//		listQuery.setMaxResults(pageSize);
//		List recordList = listQuery.list(); // 执行查询
//
//		return new PageBean(pageNum, pageSize, recordCount, recordList);
//	}
//	
	protected Session getSession()
	{
		return sessionFactory.getCurrentSession();
	}

}
