package cn.uni.servcie.impl;

import cn.uni.dao.UserDao;
import cn.uni.domain.PageBean;
import cn.uni.domain.UserInfo;
import cn.uni.service.UserService;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserServiceImpl
  implements UserService
{

  @Resource
  private UserDao userDao;

  public void save(UserInfo userInfo)
  {
  
  Object save = userDao.save(userInfo);
  
  System.out.println(save+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  }

  public void delete(Integer id) {
userDao.delete(id);
  }

  public List<UserInfo> getAll() {
    List list = this.userDao.getAll();
    return list;
  }

  public UserInfo getById(Integer id)
  {
    UserInfo byId = (UserInfo)this.userDao.getById(id);

    return byId;
  }

  public void update(UserInfo entity) {
    this.userDao.update(entity);
  }

  public UserInfo getByLoginName(String loginName) {
    return this.userDao.getByLoginName(loginName);
  }

  public void deleteByLoginName(String string)
  {
    this.userDao.deleteByLoginName(string);
  }

  public List<UserInfo> getAllByAuditing() {
    List list = this.userDao.getAllByAuditing();
    return list;
  }

  public UserInfo getByLoginNameAndAuditing(String loginName) {
    return this.userDao.getByLoginNameAndAuditing(loginName);
  }

  public void auditing(String string) {
    this.userDao.auditing(string);
  }

  public void pauseUser(String string) {
    this.userDao.pauseUser(string);
  }

  public void setPassword(String password, String username) {
    this.userDao.setPassword(password, username);
  }

  public List<UserInfo> getListByCondition(String searchString, String properties)
  {
    return this.userDao.getListByCondition(searchString, properties);
  }

  public UserInfo getUserBynameLoginAndPassword(String nameLogin, String password)
  {
    UserInfo userInfo = this.userDao.getUserBynameLoginAndPassword(nameLogin, password);

    return userInfo;
  }

  public PageBean getAllFenYe(int pageNum, Class<UserInfo> class1)
  {
    return this.userDao.getAllFenYe(pageNum, class1);
  }

  public UserInfo findUser(UserInfo userInfo) {
    return this.userDao.findUser(userInfo);
  }

  public UserInfo getByLoginIdcard(String idcard) {
    return this.userDao.getByLoginIdcard(idcard);
  }
}