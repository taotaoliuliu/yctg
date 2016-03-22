package cn.uni.dao;

import java.util.List;

import cn.uni.base.BaseDao;
import cn.uni.domain.BulletinInfo;

public interface BullentinDao extends BaseDao<BulletinInfo>{

	void stop(int id);

	List<BulletinInfo> getAllByIfPut();

	void resume(int id);

}
