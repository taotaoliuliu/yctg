package cn.uni.service;

import cn.uni.domain.PageBean;
import cn.uni.domain.UserInfo;
import java.util.List;

public abstract interface UserService
{
  public abstract void save(UserInfo paramUserInfo);

  public abstract void delete(Integer paramInteger);

  public abstract void update(UserInfo paramUserInfo);

  public abstract List<UserInfo> getAll();

  public abstract UserInfo getById(Integer paramInteger);

  public abstract UserInfo getByLoginName(String paramString);

  public abstract void deleteByLoginName(String paramString);

  public abstract List<UserInfo> getAllByAuditing();

  public abstract UserInfo getByLoginNameAndAuditing(String paramString);

  public abstract void auditing(String paramString);

  public abstract void pauseUser(String paramString);

  public abstract void setPassword(String paramString1, String paramString2);

  public abstract List<UserInfo> getListByCondition(String paramString1, String paramString2);

  public abstract UserInfo getUserBynameLoginAndPassword(String paramString1, String paramString2);

  public abstract PageBean getAllFenYe(int paramInt, Class<UserInfo> paramClass);

  public abstract UserInfo findUser(UserInfo paramUserInfo);

  public abstract UserInfo getByLoginIdcard(String paramString);
}