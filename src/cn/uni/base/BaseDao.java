package cn.uni.base;


import java.util.List;

public interface BaseDao<T> {
	Object save(T entity);
	void delete(Integer id);
	void update(T entity);
	
	T getById(Integer id);
	List<T> getByIds(Integer[] ids);
	List<T> getAll();
}
