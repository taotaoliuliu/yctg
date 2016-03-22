package cn.uni.servcie.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.uni.dao.BullentinDao;
import cn.uni.domain.BulletinInfo;
import cn.uni.service.BullentinService;

@Service
@Transactional
public class BullentinServiceImpl implements BullentinService{

	@Resource
	private BullentinDao bullentinDao;
	
	



	public void save(BulletinInfo bullentinInfo) {
		bullentinDao.save(bullentinInfo);
	}





	public void delete(Integer id) {
		bullentinDao.delete(id);
	}





	public List<BulletinInfo> getAll() {
		List<BulletinInfo> list = bullentinDao.getAll();
		return list;
	}





	public void update(BulletinInfo entity) {
		bullentinDao.update(entity);
	}





	public BulletinInfo getById(Integer id) {
		BulletinInfo byId = bullentinDao.getById(id);
		return byId;
	}





	public void stop(int id) {
		bullentinDao.stop(id);
	}





	public List<BulletinInfo> getAllByIfPut() {
		
		return bullentinDao.getAllByIfPut();
	}





	public void resume(int id) {
		bullentinDao.resume(id);

	}
	
}
