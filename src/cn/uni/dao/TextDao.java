package cn.uni.dao;

import cn.uni.base.BaseDao;
import cn.uni.domain.PageBean;
import cn.uni.domain.StatusInfo;
import cn.uni.domain.TextInfo;
import java.util.Date;
import java.util.List;

public abstract interface TextDao extends BaseDao<TextInfo>
{
  public abstract int selectMax();

  public abstract void makeXML(TextInfo paramTextInfo, String paramString1, int paramInt, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6);

  public abstract boolean checkTitle(String paramString1, String paramString2, String paramString3);

  public abstract List<TextInfo> getByCondition(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6);

  public abstract List ListTextAmountLimit(String paramString1, String paramString2, String paramString3, String paramString4);

  public abstract List<StatusInfo> ListStatus(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6);

  public abstract List<StatusInfo> ListStatusAuthor(String paramString1, String paramString2);

  public abstract PageBean getAllFenYe(int paramInt, Class<TextInfo> paramClass);

  public abstract PageBean getAllFenYe(int paramInt, Class<TextInfo> paramClass, String paramString);

  public abstract PageBean getAllFenYeByName(int paramInt, TextInfo textInfo, String paramString);

  public abstract PageBean getAllFenYeBySender(int paramInt, Class<TextInfo> paramClass, String paramString);

  public abstract PageBean getAllFenYeByAll(int paramInt, Class<TextInfo> paramClass, String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6);

  public abstract TextInfo getByTitle(String paramString1, Date paramDate, String paramString2);

  public abstract int getAllAuthor();

  public abstract List<Object[]> findChartUser(String paramString1, String paramString2);

  public abstract List<Object[]> findChartByProvince(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5);

  public abstract List<StatusInfo> ListStatusByLogin(String paramString1, String paramString2, String paramString3);

  public abstract List<Object[]> findUsersByProvince(String paramString1, String paramString2, String paramString3);

  public abstract List<StatusInfo> ListStatusByLogin2(String paramString1, String paramString2, String paramString3, String paramString4);

  public abstract List findJspBaoBiao(String paramString1, String paramString2, String paramString3);

  public abstract List findByCounty(String paramString1, String paramString2, String paramString3);

public abstract void createXML(int id,String name);
}