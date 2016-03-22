package cn.uni.service;

import java.util.List;

import cn.uni.domain.BulletinInfo;

public interface BullentinService {

	void save(BulletinInfo bullentinInfo);
	void delete(Integer id);
	void update(BulletinInfo entity);
	List<BulletinInfo> getAll();
	BulletinInfo getById(Integer id);
	void stop(int id);
	List<BulletinInfo> getAllByIfPut();
	void resume(int id);

}
