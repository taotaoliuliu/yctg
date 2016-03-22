package cn.uni.servcie.impl;

import cn.uni.dao.TextDao;
import cn.uni.domain.PageBean;
import cn.uni.domain.StatusInfo;
import cn.uni.domain.TextInfo;
import cn.uni.service.TextService;
import java.io.PrintStream;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TextServiceImpl
  implements TextService
{

  @Resource
  private TextDao textDao;

  public Object save(TextInfo textInfo)
  {
   return  this.textDao.save(textInfo);
  }

  public int selectMax() {
    return this.textDao.selectMax();
  }

  public TextInfo findById(int myID)
  {
    TextInfo byId = (TextInfo)this.textDao.getById(Integer.valueOf(myID));

    return byId;
  }

  public void makeXML(TextInfo newtextInfo, String nameLogin, int type, String nameReal, String workcompany, String attachStr, String k, String bbs)
  {
    this.textDao.makeXML(newtextInfo, nameLogin, type, nameReal, workcompany, attachStr, k, bbs);
  }

  public boolean checkTitle(String textTitle, String attribute, String localeString)
  {
    return this.textDao.checkTitle(textTitle, attribute, localeString);
  }

  public List<TextInfo> getAll()
  {
    List list = this.textDao.getAll();
    return list;
  }

  public List<TextInfo> getByCondition(String startDate, String endDate, String author, String sender, String idcard, String workcompany)
  {
    if ((idcard == null) && (workcompany == null) && (author == null) && (sender == null))
    {
      return this.textDao.getAll();
    }
    return this.textDao.getByCondition(startDate, endDate, author, sender, idcard, workcompany);
  }

  public List ListTextAmountLimit(String contributeEsseFlag, String contributeEsse, String startDate, String endDate)
  {
    return this.textDao.ListTextAmountLimit(contributeEsseFlag, contributeEsse, startDate, endDate);
  }

  public List<StatusInfo> ListStatus(String startTime, String endTime, String orderStr, String province, String city, String jianbao)
  {
    return this.textDao.ListStatus(startTime, endTime, orderStr, province, city, jianbao);
  }

  public void makeFile(HttpServletRequest request, HttpServletResponse response, String startDate, String endDate, String orderStr, String province)
  {
    List result = ListStatus(startDate, endDate, orderStr, province, null, null);
    try
    {
      String content = "<table border=1>";

      content = content + "<tr>";
      content = content + "<td align=\"center\">作者姓名</td>";
      content = content + "<td align=\"center\">作者登录名</td>";
      content = content + "<td align=\"center\">来稿篇数</td>";
      content = content + "<td align=\"center\">上稿篇数</td>";
      content = content + "<td align=\"center\">报纸用稿数</td>";
      content = content + "<td align=\"center\">网站用稿数</td>";
      content = content + "</tr>";
      if (result.size() > 0)
      {
        for (int i = 0; i < result.size(); i++)
        {
          StatusInfo si = (StatusInfo)result.get(i);
          content = content + "<tr>";
          content = content + "<td align=\"center\">";
          content = content + si.name_real;
          content = content + "</td>";
          content = content + "<td align=\"center\">";
          content = content + si.name_Login;
          content = content + "</td>";
          content = content + "<td align=\"center\">";
          content = content + si.sum;
          content = content + "</td>";
          content = content + "<td align=\"center\">";
          content = content + si.sum2;
          content = content + "</td>";
          content = content + "<td align=\"center\">";
          content = content + si.sum3;
          content = content + "</td>";
          content = content + "<td align=\"center\">";
          content = content + si.sum4;
          content = content + "</td>";
          content = content + "</tr>";
        }
        content = content + "</table>";
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/octet-stream;charset=utf-8");
        String displayfilename = "source" + startDate + "_" + endDate + ".xls";
        response.setHeader("Content-Disposition", "attachment;filename=" + displayfilename);
        ServletOutputStream out = response.getOutputStream();

        out.write(content.getBytes("GBK"));
        out.flush();
      }
    }
    catch (Exception e)
    {
      System.out.println(e);
    }
  }

  public List<StatusInfo> ListStatusAuthor(String orderStr, String province)
  {
    return this.textDao.ListStatusAuthor(orderStr, province);
  }

  public void makeFileAuthor(HttpServletRequest request, HttpServletResponse response, String orderStr, String province)
  {
    List result = ListStatusAuthor(orderStr, province);
    try
    {
      String content = "<table border=1>";

      content = content + "<tr>";
      content = content + "<td align=\"center\">作者姓名</td>";
      content = content + "<td align=\"center\">作者登录名</td>";

      content = content + "</tr>";
      if (result.size() > 0)
      {
        for (int i = 0; i < result.size(); i++)
        {
          StatusInfo si = (StatusInfo)result.get(i);
          content = content + "<tr>";
          content = content + "<td align=\"center\">";
          content = content + si.name_real;
          content = content + "</td>";
          content = content + "<td align=\"center\">";
          content = content + si.name_Login;
          content = content + "</td>";

          content = content + "</tr>";
        }
        content = content + "</table>";
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/octet-stream;charset=utf-8");
        String displayfilename = "source" + new Date() + ".xls";
        response.setHeader("Content-Disposition", "attachment;filename=" + displayfilename);
        ServletOutputStream out = response.getOutputStream();

        out.write(content.getBytes("GBK"));
        out.flush();
      }
    }
    catch (Exception e)
    {
      System.out.println("error:" + e);
    }
  }

  public void delete(Integer id)
  {
    this.textDao.delete(id);
  }

  public PageBean getAllFenYe(int pageNum, Class<TextInfo> class1)
  {
    return this.textDao.getAllFenYe(pageNum, class1);
  }

  public PageBean getAllFenYe(int pageNum, Class<TextInfo> class1, String parameter)
  {
    return this.textDao.getAllFenYe(pageNum, class1, parameter);
  }

  public PageBean getAllFenYeByName(int pageNum, TextInfo class1, String name)
  {
    return this.textDao.getAllFenYeByName(pageNum, class1, name);
  }

  public void update(String attachInfo, String picInfo, int myID) {
    TextInfo byId = (TextInfo)this.textDao.getById(Integer.valueOf(myID));
    byId.setAttachInfo(attachInfo);
    byId.setPicInfo(picInfo);

    this.textDao.update(byId);
  }

  public PageBean getNewAllFenYe(int pageNum, Class<TextInfo> class1, String parameter)
  {
    return this.textDao.getAllFenYeBySender(pageNum, class1, parameter);
  }

  public PageBean getAllFenYeByAll(int pageNum, Class<TextInfo> class1, String startDate, String endDate, String author, String sender, String idcard, String workcompany)
  {
    return this.textDao.getAllFenYeByAll(pageNum, class1, startDate, endDate, author, sender, idcard, workcompany);
  }

  public TextInfo getByTitle(String textTitle, Date todayPlus1, String name)
  {
    return this.textDao.getByTitle(textTitle, todayPlus1, name);
  }

  public int getAllAuthor()
  {
    return this.textDao.getAllAuthor();
  }

  public List<Object[]> findChartUser(String startDate, String endDate)
  {
    return this.textDao.findChartUser(startDate, endDate);
  }

  public List<Object[]> findChartByProvince(String province, String str, String str2, String city, String jianbao)
  {
    return this.textDao.findChartByProvince(province, str, str2, city, jianbao);
  }

  public List<StatusInfo> ListStatusByLogin(String startDate, String endDate, String name)
  {
    return this.textDao.ListStatusByLogin(startDate, endDate, name);
  }

  public List<Object[]> findUsersByProvince(String province, String startDate, String endDate)
  {
    return this.textDao.findUsersByProvince(province, startDate, endDate);
  }

  public List<StatusInfo> ListStatusByLogin2(String startDate, String endDate, String orderStr, String province)
  {
    return this.textDao.ListStatusByLogin2(startDate, endDate, orderStr, province);
  }

  public List findJspBaoBiao(String startDate, String endDate, String jianbao) {
    return this.textDao.findJspBaoBiao(startDate, endDate, jianbao);
  }

  public List findByCounty(String startDate, String endDate, String jianbao) {
    return this.textDao.findByCounty(startDate, endDate, jianbao);
  }

public void createXML(int id,String name) {
	 this.textDao.createXML(id,name);
}
}