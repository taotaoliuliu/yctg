package cn.uni.util;

import java.util.*;


import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;



import cn.uni.base.BaseDaoImpl;
import cn.uni.dao.IManageText;
import cn.uni.domain.TextAmountInfo;


@Repository
public class ManageText extends BaseDaoImpl<Object> implements IManageText
{
	private static ManageText mObject = null;

	
	public static ManageText getInstance()
	{
		if (mObject == null)
			mObject = new ManageText();
		return mObject;
	}

	
	
	@SuppressWarnings("unchecked")
	public List<TextAmountInfo> ListTextAmountLimit(String contributeEsseFlag,String contributeEsse,String startDate,String endDate)
	{
		String strsql="";
		if (contributeEsseFlag.equals("province"))
		{
			if (!(startDate.equals("")||endDate.equals("")))
			{
				if (contributeEsse.equals(""))
				{
					strsql="select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.ContributeDate>='"+startDate+"' and textInfo.ContributeDate<'"+endDate+"' Group by userInfo.province order by sumText desc";
				}else
				{
					strsql="select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.province='"+contributeEsse+"' and textInfo.ContributeDate>='"+startDate+"' and textInfo.ContributeDate<'"+endDate+"' Group by userInfo.province order by sumText desc";
				}
			}else
			{
				if (contributeEsse.equals(""))
				{
					strsql="select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender Group by userInfo.province order by sumText desc";
				}else
				{
					strsql="select author=userInfo.province,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.province='"+contributeEsse+"' Group by userInfo.province order by sumText desc";
				}
			}
		}else if(contributeEsseFlag.equals("city"))
		{
			if (!(startDate.equals("")||endDate.equals("")))
			{
				if (contributeEsse.equals(""))
				{
					strsql="select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.ContributeDate>='"+startDate+"' and textInfo.ContributeDate<'"+endDate+"' Group by userInfo.city order by sumText desc";
				}else
				{
					strsql="select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.city='"+contributeEsse+"' and textInfo.ContributeDate>='"+startDate+"' and textInfo.ContributeDate<'"+endDate+"' Group by userInfo.city order by sumText desc";
				}
			}else
			{
				if (contributeEsse.equals(""))
				{
					strsql="select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender Group by userInfo.city order by sumText desc";
				}else
				{
					strsql="select author=userInfo.city,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.city='"+contributeEsse+"' Group by userInfo.city order by sumText desc";
				}
			}
		}else
		{
			if (!(startDate.equals("")||endDate.equals("")))
			{
				if (contributeEsse.equals(""))
				{
					strsql="select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and textInfo.ContributeDate>='"+startDate+"' and textInfo.ContributeDate<'"+endDate+"' Group by textInfo.sender order by sumText desc";
				}else
				{
					strsql="select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender and userInfo.author='"+contributeEsse+"' and textInfo.ContributeDate>='"+startDate+"' and textInfo.ContributeDate<'"+endDate+"' Group by textInfo.sender order by sumText desc";
				}
			}else
			{
				if (contributeEsse.equals(""))
				{
					strsql="select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfo where userInfo.name_login=textInfo.sender Group by textInfo.sender order by sumText desc";
				}else
				{
					strsql="select max(author)+','+max(idcard)+','+sender as author,sumText=count(*) from userInfo,textInfowhere userInfo.name_login=textInfo.sender and userInfo.author='"+contributeEsse+"' Group by textInfo.sender order by sumText desc";
				}

			}
		}

		List<TextAmountInfo> vt = new ArrayList<TextAmountInfo>();
	    
	    	//System.out.println(strsql);
	    	
	    	
	    	SQLQuery query = getSession().createSQLQuery(strsql);
	    	
	    	List<Object[]> list = query.list();
	    	
	    	
	    	for(int x=0;x<list.size();x++)
	    	{
	    		String author = list.get(x)[0].toString();
	    	
	    		int sumtext =Integer.parseInt(list.get(x)[1].toString());
	    		TextAmountInfo textAmountInfo = new TextAmountInfo(author,sumtext);
	    		vt.add(textAmountInfo);
	    	}
	    	
		return vt;
	    
	}
}

