package cn.uni.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.uni.domain.PageBean;
import cn.uni.domain.StatusInfo;
import cn.uni.domain.TextInfo;


public interface TextService {

	Object save(TextInfo textInfo);
	int selectMax();
	TextInfo findById(int myID);
	void makeXML(TextInfo newtextInfo, String nameLogin, int type,
			String nameReal, String workcompany,String attachStr,String k,String bbs);
	boolean checkTitle(String textTitle, String attribute, String localeString);
	List<TextInfo> getAll();
	List<TextInfo> getByCondition(String startDate,String endDate,String author,String sender,String idcard,String workcompany);
	
	List ListTextAmountLimit(String contributeEsseFlag,String contributeEsse,String startDate,String endDate);
	List<StatusInfo> ListStatus(String substring, String substring2,
			String orderStr, String province,String city,String jianbao);
	void makeFile(HttpServletRequest request, HttpServletResponse response,
			String startDate, String endDate, String orderStr, String province);
	List<StatusInfo> ListStatusAuthor(String orderStr, String province);
	void makeFileAuthor(HttpServletRequest request,
			HttpServletResponse response, String orderStr, String province);

	void delete(Integer id);
	PageBean getAllFenYe(int pageNum, Class<TextInfo> class1);
	PageBean getAllFenYe(int pageNum, Class<TextInfo> class1, String parameter);
	PageBean getAllFenYeByName(int pageNum, TextInfo class1, String name);
	void update(String attachInfo, String picInfo, int myID);
	PageBean getNewAllFenYe(int pageNum, Class<TextInfo> class1,
			String parameter);
	PageBean getAllFenYeByAll(int pageNum, Class<TextInfo> class1,
			String startDate, String endDate, String author, String sender,
			String idcard, String workcompany);
	TextInfo getByTitle(String textTitle, Date todayPlus1,String name);
	int getAllAuthor();
	List<Object[]> findChartUser(String startDate, String endDate);
	List<Object[]> findChartByProvince(String province,String str,String str2,String city,String jianbao);
	List<StatusInfo> ListStatusByLogin(String startDate, String endDate,
			String orderStr);
	List<Object[]> findUsersByProvince(String province, String startDate,
			String endDate);
	List<StatusInfo> ListStatusByLogin2(String startDate, String endDate,
			String orderStr,String province);
	List findJspBaoBiao(String startDate, String endDate,String jianbao);
	List findByCounty(String startDate, String endDate,String jianbao);
	void createXML(int id,String name);

}
