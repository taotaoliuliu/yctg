package cn.uni.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Paint;
import java.awt.PaintContext;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.geom.Rectangle2D;
import java.awt.image.ColorModel;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryAxis3D;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberAxis3D;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.xy.XYSeries;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


import cn.uni.dao.TextDao;
import cn.uni.domain.DisBean;
import cn.uni.domain.PageBean;
import cn.uni.domain.StatusInfo;
import cn.uni.domain.Text;
import cn.uni.domain.TextAmountInfo;
import cn.uni.domain.TextInfo;
import cn.uni.domain.UserInfo;
import cn.uni.service.TextService;
import cn.uni.service.UserService;
import cn.uni.util.FileToPath;
import cn.uni.util.I18n;
import cn.uni.util.ManagerPro;

import com.mysql.jdbc.EscapeTokenizer;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class TextAction extends ActionSupport implements ModelDriven<TextInfo>,ServletRequestAware,ServletResponseAware{
		public  HttpServletRequest request;
		public HttpServletResponse response;
		private TextInfo textInfo = new TextInfo();

	  private File[] uploadImages;//得到上传的文件
	  private String[] uploadImagesContentType;//得到文件的类型
	  private String[] uploadImagesFileName;//得到文件的名称
	  
	  
	  public int pageNum=1;

		public int getPageNum() {
			return pageNum;
		}

		public void setPageNum(int pageNum) {
			this.pageNum = pageNum;
		}
		
	  
	  public File[] getUploadImages() {
		return uploadImages;
	}

	public void setUploadImages(File[] uploadImages) {
		this.uploadImages = uploadImages;
	}
		
	public String[] getUploadImagesContentType() {
		return uploadImagesContentType;
	}

	public void setUploadImagesContentType(String[] uploadImagesContentType) {
		this.uploadImagesContentType = uploadImagesContentType;
	}

	public String[] getUploadImagesFileName() {
		return uploadImagesFileName;
	}

	public void setUploadImagesFileName(String[] uploadImagesFileName) {
		this.uploadImagesFileName = uploadImagesFileName;
	}


	
	
	
	
	@Resource
	 private TextService textService;
	
	@Resource
	 private UserService userService;
	@Resource
	private TextDao textDao;
	public String login()
	{
		
		return "index";
	}
	
	public String list()
	{	
		
//		List<TextInfo> list=textService.getAll();
//		ActionContext.getContext().put("listText", list);	
		
		
		
		
		PageBean pageBean =textService.getAllFenYe(pageNum,TextInfo.class);
		ActionContext.getContext().getValueStack().push(pageBean);
		return "list";
	}
	public String manyList()
	{
//		List<TextInfo> list=textService.getAll();
//		ActionContext.getContext().put("listText", list);
	
		
		
		
		String parameter = request.getParameter("limit");
		
		if(parameter!=null)
		{
			parameter=parameter.trim();
			parameter=parameter.substring(parameter.lastIndexOf(",")+1);

			PageBean pageBean =textService.getNewAllFenYe(pageNum,TextInfo.class,parameter);
			ActionContext.getContext().getValueStack().push(pageBean);

		}
		else{
		
		PageBean pageBean =textService.getAllFenYe(pageNum,TextInfo.class);
		ActionContext.getContext().getValueStack().push(pageBean);
		}
		return "manyList";
	}
	public String add()
	{	
		return "tolist";
	}
	public String addUI()
	{	
		return "addUI";
	}
	public String delete()
	{	
		
		
		
		String dele_list[] = request.getParameterValues("selCheck");
		
		
		
		for(int x=0;x<dele_list.length;x++)
		{
			
			int id=Integer.parseInt(dele_list[x]);
			textService.delete(id);
		}
		

		return "toManageText";
	}
	public String searchDelete()
	{	
		
		
		
		String dele_list[] = request.getParameterValues("selCheck");
		
		
		
		for(int x=0;x<dele_list.length;x++)
		{
			
			int id=Integer.parseInt(dele_list[x]);
			textService.delete(id);
		}
		
		
		
		
		
		
		return "toTextSearchRe";
	}
	
	
	public String editUI()
	{	
		return "editUI";
	}
	public String edit()
	{	
		return "tolist";
	}
	public String statPerson()
	{
		String nameRe = (String) request.getSession().getAttribute("name_real");
		ActionContext.getContext().put("name", nameRe);
		
		System.out.println(textInfo.getTextTitle());
		
		String name = (String) request.getSession().getAttribute("name_Login");
		name=name.trim();
		PageBean pageBean =textService.getAllFenYeByName(pageNum,textInfo,name);
		ActionContext.getContext().getValueStack().push(pageBean);
		return "statPerson" ;
	}
	public String textContribute()
	{
		String types=ManagerPro.getString("type");
		types=I18n.getGBText(types);
		String[] typess = types.split(",");
		ActionContext.getContext().put("types", typess);
		String txtplate=ManagerPro.getString("txtplate");
		txtplate=I18n.getGBText(txtplate);
		String[] txtplates = txtplate.split(",");
		ActionContext.getContext().put("txtplates", txtplates);
		
		//同步bbs类型
		List<Text> list = new ArrayList<Text>();

		String bbs=ManagerPro.getString("bbs_bbs");
		bbs=I18n.getGBText(bbs);
		String[] bbss = bbs.split(",");
		String[] bbss2= new String[bbss.length];
		String[] bbss3= new String[bbss.length];
		for(int x=0;x<bbss.length;x++)
		{
			bbss2[x]=bbss[x].substring(0, bbss[x].indexOf("("));
			bbss3[x]=bbss[x].substring(bbss[x].indexOf("(")+1,bbss[x].indexOf(")"));
			Text textInfo = new Text();
			
			textInfo.setName(bbss2[x]);
			textInfo.setId(bbss3[x]);
			list.add(textInfo);
		}
	
		ActionContext.getContext().put("bbss", list);
		
		UserInfo user=(UserInfo)request.getSession().getAttribute("user");
		String name =user.getName_real();
		ActionContext.getContext().put("name", name);
		
		return "textContribute";
	}
	public String textContribute2()
	{
		String types=ManagerPro.getString("type");
		types=I18n.getGBText(types);
		String[] typess = types.split(",");
		ActionContext.getContext().put("types", typess);
		String txtplate=ManagerPro.getString("txtplate");
		txtplate=I18n.getGBText(txtplate);
		String[] txtplates = txtplate.split(",");
		ActionContext.getContext().put("txtplates", txtplates);
		
		
		//同步bbs类型
		List<Text> list = new ArrayList<Text>();

		String bbs=ManagerPro.getString("bbs_bbs");
		bbs=I18n.getGBText(bbs);
		String[] bbss = bbs.split(",");
		String[] bbss2= new String[bbss.length];
		String[] bbss3= new String[bbss.length];
		for(int x=0;x<bbss.length;x++)
		{
			bbss2[x]=bbss[x].substring(0, bbss[x].indexOf("("));
			bbss3[x]=bbss[x].substring(bbss[x].indexOf("(")+1,bbss[x].indexOf(")"));
			Text textInfo = new Text();
			
			textInfo.setName(bbss2[x]);
			textInfo.setId(bbss3[x]);
			list.add(textInfo);
		}
	
		ActionContext.getContext().put("bbss", list);
		UserInfo user=(UserInfo)request.getSession().getAttribute("user");
		String name =user.getName_real();
		ActionContext.getContext().put("name", name);
		return "textContribute2";
	}
	public String textContribute3()
	{
		String types=ManagerPro.getString("type");
		types=I18n.getGBText(types);
		String[] typess = types.split(",");
		ActionContext.getContext().put("types", typess);
		String txtplate=ManagerPro.getString("txtplate");
		txtplate=I18n.getGBText(txtplate);
		String[] txtplates = txtplate.split(",");
		ActionContext.getContext().put("txtplates", txtplates);
		
		//同步bbs类型
		List<Text> list = new ArrayList<Text>();

		String bbs=ManagerPro.getString("bbs_bbs");
		bbs=I18n.getGBText(bbs);
		String[] bbss = bbs.split(",");
		String[] bbss2= new String[bbss.length];
		String[] bbss3= new String[bbss.length];
		for(int x=0;x<bbss.length;x++)
		{
			bbss2[x]=bbss[x].substring(0, bbss[x].indexOf("("));
			bbss3[x]=bbss[x].substring(bbss[x].indexOf("(")+1,bbss[x].indexOf(")"));
			Text textInfo = new Text();
			
			textInfo.setName(bbss2[x]);
			textInfo.setId(bbss3[x]);
			list.add(textInfo);
		}
	
		ActionContext.getContext().put("bbss", list);
		UserInfo user=(UserInfo)request.getSession().getAttribute("user");
		String name =user.getName_real();
		ActionContext.getContext().put("name", name);
		return "textContribute3";
	}
	
	public String manageText()
	{
		String txtplate=ManagerPro.getString("txtplate");
		txtplate=I18n.getGBText(txtplate);
		String[] txtplates = txtplate.split(",");
		ActionContext.getContext().put("txtplates", txtplates);	
		String cat = request.getParameter("plate");
		if(cat!=null){
		try {
			
				
			cat=URLDecoder.decode(cat, "utf-8");
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		}
		
		if(pageNum==1)
		{
			request.getSession().setAttribute("cat", cat);
			
		}
	String cat2=(String)request.getSession().getAttribute("cat");
		
		if(cat2!=null)
		{
			
			
			PageBean pageBean =textService.getAllFenYe(pageNum,TextInfo.class,(String)request.getSession().getAttribute("cat"));
			ActionContext.getContext().getValueStack().push(pageBean);
			
		}
		
		
		else
		{
			
			
		PageBean pageBean =textService.getAllFenYe(pageNum,TextInfo.class);
		ActionContext.getContext().getValueStack().push(pageBean);
		}
		
	
		
		return "manageText";
	}
	
	public String textStatusUI()
	{
		
		
		String LimitSetTime = request.getParameter("LimitSetTime");
		if("".equals(LimitSetTime)||LimitSetTime==null)
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		return "textStatusUI";
	}
	
	public String textStatusUI2()
	{
		
		
		String LimitSetTime = request.getParameter("LimitSetTime");
		if("".equals(LimitSetTime)||LimitSetTime==null)
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		
		
		String jianbao = request.getParameter("jianbao");
		if("".equals(jianbao)||jianbao==null)
		{
			request.setAttribute("jianbao", "0");
		}
		else{
		request.setAttribute("jianbao", jianbao);
		}
		return "textStatusUI2";
	}
	
	public String textStatus()
	{
		String LimitSetTime = request.getParameter("LimitSetTime");
		if("".equals(LimitSetTime)||LimitSetTime==null)
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		String orderStr = request.getParameter("orderStr");
		String province = request.getParameter("province");
		
		request.setAttribute("province", province);
		String strAction = request.getParameter("MyAction");
							String startDate = request.getParameter("StartDate");
							String endDate = request.getParameter("EndDate");
		
			if(strAction!=null&&strAction.equals("export"))
				{					
					textService.makeFile(request,response,startDate,endDate,orderStr,province);					
				}
		if(startDate!=null&&endDate!=null){
			startDate=startDate.substring(0,10);
			endDate=endDate.substring(0,10);
		}
		if("0".equals(LimitSetTime)||LimitSetTime==null)
		{
			startDate=null;
			endDate=null;
			
			
		}
			List<StatusInfo> list=textService.ListStatus(startDate,endDate,orderStr,province,null,null);	
			ActionContext.getContext().put("listStatus", list);
			
			
			
			

			ActionContext.getContext().put("listStatus", list);
			
//			List<Object[]> list2=textService.findChartByProvince(province,startDate,endDate);
//			
//			
//			//创建图形的数据结果集，使用list进行遍历
//			DefaultCategoryDataset dataset = new DefaultCategoryDataset();
//			if(list2!=null && list2.size()>0){
//				for(Object[] objects:list2){
//					//b.keyword,b.ddlName,COUNT(a.jctID)
//					dataset.addValue(Double.parseDouble(objects[1].toString()), "所属地区", objects[0].toString());
//				}
//			}
//			//使用JFreechart的核心对象创建图形
//			JFreeChart chart = ChartFactory.createBarChart3D("用户统计报表（所属市区）",   //图形的主标题
//					list.get(0).getSum2(),                  //X轴外的标签名称
//											            "稿件数量",                         //Y轴外的标签名称 
//											            dataset,                       //存放图形的数据集
//											            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
//											            true,          				   //是否显示子标题
//											            true,        				   //是否在图形上生成提示
//											            true          				   //在图形上是否生成url连接 
//											            );
//			//处理主标题乱码
//			chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
//			//处理子标题乱码
//			chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
//			//获取图表区域对象
//			CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
//			//获取X轴对象
//			CategoryAxis3D categoryAxis3D = (CategoryAxis3D) categoryPlot.getDomainAxis();
//			//获取Y轴对象
//			NumberAxis3D numberAxis3D = (NumberAxis3D) categoryPlot.getRangeAxis();
//
//
//			
//			//处理X轴上的乱码
//			categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,12));
//			
//
//			
//			//处理X轴外的乱码
//			categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
//			//处理Y轴上的乱码
//			numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
//			//处理Y轴外的乱码
//			numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
//			
//			//处理Y轴的刻度以1为单位，不使用默认
//			numberAxis3D.setAutoTickUnitSelection(false);
//			NumberTickUnit unit = new NumberTickUnit(100);
//			numberAxis3D.setTickUnit(unit);
//			
//			//获取绘图区域对象
//			BarRenderer3D renderer3D = (BarRenderer3D) categoryPlot.getRenderer();
//			//让图形变得苗条点
//			renderer3D.setMaximumBarWidth(0.06);
//			//让图形上显示数字
//			renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
//			renderer3D.setBaseItemLabelsVisible(true);
//			renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
//			
//			/*******使图片生成到项目chart的路径下，以图片的形式********/
//			//查找chart的路径
//			String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
//			String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
//			
//			File file = new File(path+"/"+filename);
//			try {
//				ChartUtilities.saveChartAsPNG(file, chart, 1000, 600);
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			
//			
//			request.setAttribute("filename", filename);
//			request.setAttribute("list2", list2);
			
			
			
			
			
		return "textStatus";
	}
	//省份统计稿件数量
	public String textStatusZZ() throws UnsupportedEncodingException{
		
		
		
		String LimitSetTime = request.getParameter("LimitSetTime");//没有时间限制0
		


		
		if("".equals(LimitSetTime)||LimitSetTime==null||"0".equals(LimitSetTime))
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		
		String orderStr = request.getParameter("orderStr");
		String province = request.getParameter("province");
		
		String city = request.getParameter("city");

		System.out.println(city+"city");
		
		request.setAttribute("province", province);
		request.setAttribute("city", city);

		String strAction = request.getParameter("MyAction");
							String startDate = request.getParameter("StartDate");
							String endDate = request.getParameter("EndDate");
		
			if(strAction!=null&&strAction.equals("export"))
				{					
					textService.makeFile(request,response,startDate,endDate,orderStr,province);					
				}
		if(startDate!=null&&endDate!=null){
			startDate=startDate.substring(0,10);
			endDate=endDate.substring(0,10);
		}
		if("0".equals(LimitSetTime)||LimitSetTime==null)
		{
			startDate=null;
			endDate=null;
			
			
		}
		
		if("请选择".equals(city)) city="";
		if("请选择".equals(province)) province="";
		List<StatusInfo> list=textService.ListStatus(startDate,endDate,orderStr,province,city,null);	
		ActionContext.getContext().put("listStatus", list);
		
		
		
		

		
		List<Object[]> list2=textService.findChartByProvince(province,startDate,endDate,city,null);
		
		
		//创建图形的数据结果集，使用list进行遍历
		
		if(!"".equals(province)&&province!=null)
		{
			DefaultCategoryDataset dataset = new DefaultCategoryDataset();
			if(list2!=null && list2.size()>0){
				for(Object[] objects:list2){
				if(objects[0]!=null&&objects[1]!=null)
				{
					dataset.addValue(Double.parseDouble(objects[1].toString()), "所属地区", objects[0].toString().trim());

				}
				}
			}
			String ss=null;
			if(!"".equals(province)&&province!=null)
			{ 
				ss=province;
				
			}
			//使用JFreechart的核心对象创建图形
			JFreeChart chart = ChartFactory.createBarChart("稿件统计报表",   //图形的主标题
					ss,                  //X轴外的标签名称
											            "稿件数量",                         //Y轴外的标签名称 
											            dataset,                       //存放图形的数据集
											            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
											            true,          				   //是否显示子标题
											            true,        				   //是否在图形上生成提示
											            true          				   //在图形上是否生成url连接 
											            );
			//处理主标题乱码
			chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
			//处理子标题乱码
			chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
			//获取图表区域对象
			CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
			//获取X轴对象
			CategoryAxis categoryAxis3D = (CategoryAxis) categoryPlot.getDomainAxis();
			//获取Y轴对象
			NumberAxis numberAxis3D = (NumberAxis) categoryPlot.getRangeAxis();


			
			//处理X轴上的乱码
			categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,12));
			

			
			//处理X轴外的乱码
			categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴上的乱码
			numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴外的乱码
			numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			
			//处理Y轴的刻度以1为单位，不使用默认
			numberAxis3D.setAutoTickUnitSelection(false);
			
			//TODO
			NumberTickUnit unit=null;
		
				
				
			if("北京".equals(province))
			{
				 unit = new NumberTickUnit(10000);

			}
			
			else{
			 unit = new NumberTickUnit(1000);
			}
			
		
			numberAxis3D.setTickUnit(unit);
			
			//获取绘图区域对象
			BarRenderer renderer3D = (BarRenderer) categoryPlot.getRenderer();
			
GradientPaint gp0 = new GradientPaint(0.0f, 0.0f,new Color(100,129,169),0.0f, 0.0f,new Color(100,129,169));
			
			renderer3D.setSeriesPaint(0, gp0); 
			//让图形变得苗条点
			renderer3D.setMaximumBarWidth(0.02);
			//让图形上显示数字
			renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			renderer3D.setBaseItemLabelsVisible(true);
			renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
			
			/*******使图片生成到项目chart的路径下，以图片的形式********/
			//查找chart的路径
			String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
			String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
			
			File file = new File(path+"/"+filename);
			try {
				ChartUtilities.saveChartAsPNG(file, chart, 1400, 600);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			request.setAttribute("filename", filename);
			request.setAttribute("list2", list2);
		}
		else
		{
			DefaultCategoryDataset dataset = new DefaultCategoryDataset();
			if(list2!=null && list2.size()>0){
				for(Object[] objects:list2){
					//b.keyword,b.ddlName,COUNT(a.jctID)
					
					if(!objects[0].toString().contains(" ")){
						dataset.addValue(Double.parseDouble(objects[1].toString()), "省份", objects[0].toString());
					}
					
				}
			}
			//使用JFreechart的核心对象创建图形
			JFreeChart chart = ChartFactory.createBarChart("稿件统计报表",   //图形的主标题
					"",                  //X轴外的标签名称
											            "稿件数量",                         //Y轴外的标签名称 
											            dataset,                       //存放图形的数据集
											            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
											            true,          				   //是否显示子标题
											            true,        				   //是否在图形上生成提示
											            true          				   //在图形上是否生成url连接 
											            );
			//处理主标题乱码
			chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
			//处理子标题乱码
			chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
			//获取图表区域对象
			CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
			//获取X轴对象
			CategoryAxis categoryAxis3D = (CategoryAxis) categoryPlot.getDomainAxis();
			//获取Y轴对象
			NumberAxis numberAxis3D = (NumberAxis) categoryPlot.getRangeAxis();


			
			//处理X轴上的乱码
			categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,10));
			
			
			
			//处理X轴外的乱码
			categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴上的乱码
			numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴外的乱码
			numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			
			//处理Y轴的刻度以1为单位，不使用默认
			numberAxis3D.setAutoTickUnitSelection(false);
			NumberTickUnit unit = new NumberTickUnit(10000);
			numberAxis3D.setTickUnit(unit);
			
			//获取绘图区域对象
			BarRenderer renderer3D = (BarRenderer) categoryPlot.getRenderer();
GradientPaint gp0 = new GradientPaint(0.0f, 0.0f,new Color(100,129,169),0.0f, 0.0f,new Color(100,129,169));
			
			renderer3D.setSeriesPaint(0, gp0); 
			//让图形变得苗条点
			renderer3D.setMaximumBarWidth(0.02);
			//让图形上显示数字
			renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			renderer3D.setBaseItemLabelsVisible(true);
			renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
			
			/*******使图片生成到项目chart的路径下，以图片的形式********/
			//查找chart的路径
			String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
			String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
			
			File file = new File(path+"/"+filename);
			try {
				//TODO
				ChartUtilities.saveChartAsPNG(file, chart, 2200, 600);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			request.setAttribute("filename", filename);
			request.setAttribute("list2", list2);
		}
		
		
		return "textStatus";
	}
	
	
	
	
	
	
	
	
	//Jianbao lsl 2014-6-27
	public String textStatusZZ2() throws UnsupportedEncodingException{
		
		
		
		String LimitSetTime = request.getParameter("LimitSetTime");//没有时间限制0
		

		String jianbao = request.getParameter("jianbao");
		
		if("".equals(LimitSetTime)||LimitSetTime==null||"0".equals(LimitSetTime))
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		
		if("".equals(jianbao)||jianbao==null||"CMA".equals(jianbao))
		{
			request.setAttribute("jianbao", "0");
		}
		else{
		request.setAttribute("jianbao", "1");
		}
		
		String orderStr = request.getParameter("orderStr");
		String province = request.getParameter("province");
		
		String city = request.getParameter("city");

		System.out.println(city+"city");
		
		request.setAttribute("province", province);
		request.setAttribute("city", city);

		String strAction = request.getParameter("MyAction");
							String startDate = request.getParameter("StartDate");
							String endDate = request.getParameter("EndDate");
		
			if(strAction!=null&&strAction.equals("export"))
				{					
					textService.makeFile(request,response,startDate,endDate,orderStr,province);					
				}
		if(startDate!=null&&endDate!=null){
			startDate=startDate.substring(0,10);
			endDate=endDate.substring(0,10);
		}
		if("0".equals(LimitSetTime)||LimitSetTime==null)
		{
			startDate=null;
			endDate=null;
			
			
		}
		
		if("请选择".equals(city)) city="";
		if("请选择".equals(province)) province="";
		List<StatusInfo> list=textService.ListStatus(startDate,endDate,orderStr,province,city,jianbao);	
		ActionContext.getContext().put("listStatus", list);
		
		
		
		

		
		List<Object[]> list2=textService.findChartByProvince(province,startDate,endDate,city,jianbao);
		
		
		//创建图形的数据结果集，使用list进行遍历
		
		if(!"".equals(province)&&province!=null)
		{
			DefaultCategoryDataset dataset = new DefaultCategoryDataset();
			if(list2!=null && list2.size()>0){
				for(Object[] objects:list2){
				if(objects[0]!=null&&objects[1]!=null)
				{
					dataset.addValue(Double.parseDouble(objects[1].toString()), "所属地区", objects[0].toString().trim());

				}
				}
			}
			String ss=null;
			if(!"".equals(province)&&province!=null)
			{ 
				ss=province;
				
			}
			//使用JFreechart的核心对象创建图形
			JFreeChart chart = ChartFactory.createBarChart("稿件统计报表",   //图形的主标题
					ss,                  //X轴外的标签名称
											            "稿件数量",                         //Y轴外的标签名称 
											            dataset,                       //存放图形的数据集
											            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
											            true,          				   //是否显示子标题
											            true,        				   //是否在图形上生成提示
											            true          				   //在图形上是否生成url连接 
											            );
			//处理主标题乱码
			chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
			//处理子标题乱码
			chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
			//获取图表区域对象
			CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
			//获取X轴对象
			CategoryAxis categoryAxis3D = (CategoryAxis) categoryPlot.getDomainAxis();
			//获取Y轴对象
			NumberAxis numberAxis3D = (NumberAxis) categoryPlot.getRangeAxis();


			
			//处理X轴上的乱码
			categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,12));
			

			
			//处理X轴外的乱码
			categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴上的乱码
			numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴外的乱码
			numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			
			//处理Y轴的刻度以1为单位，不使用默认
			numberAxis3D.setAutoTickUnitSelection(false);
			
			//TODO
			NumberTickUnit unit=null;
		
				
				
			if("北京".equals(province))
			{
				 unit = new NumberTickUnit(10000);

			}
			
			else{
			 unit = new NumberTickUnit(1000);
			}
			
		
			numberAxis3D.setTickUnit(unit);
			
			//获取绘图区域对象
			BarRenderer renderer3D = (BarRenderer) categoryPlot.getRenderer();
			
GradientPaint gp0 = new GradientPaint(0.0f, 0.0f,new Color(100,129,169),0.0f, 0.0f,new Color(100,129,169));
			
			renderer3D.setSeriesPaint(0, gp0); 
			//让图形变得苗条点
			renderer3D.setMaximumBarWidth(0.02);
			//让图形上显示数字
			renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			renderer3D.setBaseItemLabelsVisible(true);
			renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
			
			/*******使图片生成到项目chart的路径下，以图片的形式********/
			//查找chart的路径
			String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
			String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
			
			File file = new File(path+"/"+filename);
			try {
				ChartUtilities.saveChartAsPNG(file, chart, 1400, 600);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			request.setAttribute("filename", filename);
			request.setAttribute("list2", list2);
		}
		else
		{
			DefaultCategoryDataset dataset = new DefaultCategoryDataset();
			if(list2!=null && list2.size()>0){
				for(Object[] objects:list2){
					//b.keyword,b.ddlName,COUNT(a.jctID)
					
					if(!objects[0].toString().contains(" ")){
						dataset.addValue(Double.parseDouble(objects[1].toString()), "省份", objects[0].toString());
					}
					
				}
			}
			//使用JFreechart的核心对象创建图形
			JFreeChart chart = ChartFactory.createBarChart("稿件统计报表",   //图形的主标题
					"",                  //X轴外的标签名称
											            "稿件数量",                         //Y轴外的标签名称 
											            dataset,                       //存放图形的数据集
											            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
											            true,          				   //是否显示子标题
											            true,        				   //是否在图形上生成提示
											            true          				   //在图形上是否生成url连接 
											            );
			//处理主标题乱码
			chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
			//处理子标题乱码
			chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
			//获取图表区域对象
			CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
			//获取X轴对象
			CategoryAxis categoryAxis3D = (CategoryAxis) categoryPlot.getDomainAxis();
			//获取Y轴对象
			NumberAxis numberAxis3D = (NumberAxis) categoryPlot.getRangeAxis();


			
			//处理X轴上的乱码
			categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,10));
			
			
			
			//处理X轴外的乱码
			categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴上的乱码
			numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
			//处理Y轴外的乱码
			numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
			
			//处理Y轴的刻度以1为单位，不使用默认
			numberAxis3D.setAutoTickUnitSelection(false);
			NumberTickUnit unit = new NumberTickUnit(10000);
			numberAxis3D.setTickUnit(unit);
			
			//获取绘图区域对象
			BarRenderer renderer3D = (BarRenderer) categoryPlot.getRenderer();
GradientPaint gp0 = new GradientPaint(0.0f, 0.0f,new Color(100,129,169),0.0f, 0.0f,new Color(100,129,169));
			
			renderer3D.setSeriesPaint(0, gp0); 
			//让图形变得苗条点
			renderer3D.setMaximumBarWidth(0.02);
			//让图形上显示数字
			renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			renderer3D.setBaseItemLabelsVisible(true);
			renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
			
			/*******使图片生成到项目chart的路径下，以图片的形式********/
			//查找chart的路径
			String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
			String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
			
			File file = new File(path+"/"+filename);
			try {
				//TODO
				ChartUtilities.saveChartAsPNG(file, chart, 2200, 600);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			request.setAttribute("filename", filename);
			request.setAttribute("list2", list2);
		}
		
		
		return "textStatus2";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public String authorStatusUI(){
		
		String LimitSetTime = request.getParameter("LimitSetTime");
		if("".equals(LimitSetTime)||LimitSetTime==null)
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		return "authorStatusUI";
	}
	
	public String authorStatus()
	{
		
	String LimitSetTime = request.getParameter("LimitSetTime");//没有时间限制0
		


		
		if("".equals(LimitSetTime)||LimitSetTime==null||"0".equals(LimitSetTime))
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		
		String orderStr = request.getParameter("orderStr");
		String province = request.getParameter("province");
		
		String city = request.getParameter("city");

		
		request.setAttribute("province", province);
		request.setAttribute("city", city);

		String strAction = request.getParameter("MyAction");
							String startDate = request.getParameter("StartDate");
							String endDate = request.getParameter("EndDate");
		
			if(strAction!=null&&strAction.equals("export"))
				{					
					textService.makeFile(request,response,startDate,endDate,orderStr,province);					
				}
		if(startDate!=null&&endDate!=null){
			startDate=startDate.substring(0,10);
			endDate=endDate.substring(0,10);
		}
		if("0".equals(LimitSetTime)||LimitSetTime==null)
		{
			startDate=null;
			endDate=null;
			
			
		}
		
		List<StatusInfo> list2=textService.ListStatusByLogin(startDate,endDate,orderStr);	
		ActionContext.getContext().put("listStatus", list2);
		
		
		
		
		//TODO
		List<Object[]> list=textService.findChartUser(startDate,endDate);
		
		//创建图形的数据结果集，使用list进行遍历dataset.addValue(13, "所属单位", "北京");
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		if(list!=null && list.size()>0){
			for(Object[] objects:list){
				//b.keyword,b.ddlName,COUNT(a.jctID)
				
				
				
				dataset.addValue(Double.parseDouble(objects[1].toString()), "省份", objects[0].toString());
			}
		}
		//使用JFreechart的核心对象创建图形
		JFreeChart chart = ChartFactory.createBarChart("用户报表",   //图形的主标题
										            "",                  //X轴外的标签名称
										            "记者通讯员数量",                         //Y轴外的标签名称 
										            dataset,                       //存放图形的数据集
										            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
										            true,          				   //是否显示子标题
										            true,        				   //是否在图形上生成提示
										            true          				   //在图形上是否生成url连接 
										            );
		//处理主标题乱码
		chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
		//处理子标题乱码
		chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
		//获取图表区域对象
		CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
		//获取X轴对象
		//CategoryAxis
		CategoryAxis	 categoryAxis3D = (CategoryAxis) categoryPlot.getDomainAxis();
		//获取Y轴对象
		NumberAxis numberAxis3D = (NumberAxis) categoryPlot.getRangeAxis();

		categoryAxis3D.setCategoryMargin(0.00001);//横轴标签之间的距离20%
		
		//处理X轴上的乱码
		categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,10));
		
	
		
		//处理X轴外的乱码
		categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
		//处理Y轴上的乱码
		numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
		//处理Y轴外的乱码
		numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
		
		//处理Y轴的刻度以1为单位，不使用默认
		numberAxis3D.setAutoTickUnitSelection(false);
		NumberTickUnit unit = new NumberTickUnit(100);
		numberAxis3D.setTickUnit(unit);
		
		//获取绘图区域对象
		BarRenderer renderer3D = (BarRenderer) categoryPlot.getRenderer();
		//让图形变得苗条点
		renderer3D.setMaximumBarWidth(0.015);
		
		GradientPaint gp0 = new GradientPaint(0.0f, 0.0f,new Color(100,129,169),0.0f, 0.0f,new Color(100,129,169));
		
		renderer3D.setSeriesPaint(0, gp0); 
		//让图形上显示数字
		renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		renderer3D.setBaseItemLabelsVisible(true);
		renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
		
		/*******使图片生成到项目chart的路径下，以图片的形式********/
		//查找chart的路径
		String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
		String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
		
		File file = new File(path+"/"+filename);
		try {
			ChartUtilities.saveChartAsPNG(file, chart, 2200, 600);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		request.setAttribute("filename", filename);
		
		request.setAttribute("list2", list);

		return "authorStatus";
	}
	
	
	public String authorStatusZZ()
	
	{
		
		
		String LimitSetTime = request.getParameter("LimitSetTime");//没有时间限制0

		
		if("".equals(LimitSetTime)||LimitSetTime==null||"0".equals(LimitSetTime))
		{
			request.setAttribute("LimitSetTime", "0");
		}
		else{
		request.setAttribute("LimitSetTime", LimitSetTime);
		}
		
		String orderStr = request.getParameter("orderStr");
		String province = request.getParameter("province");
		
		String city = request.getParameter("city");

		
		request.setAttribute("province", province);
		request.setAttribute("city", city);

		String strAction = request.getParameter("MyAction");
							String startDate = request.getParameter("StartDate");
							String endDate = request.getParameter("EndDate");
		
			if(strAction!=null&&strAction.equals("export"))
				{					
					textService.makeFile(request,response,startDate,endDate,orderStr,province);					
				}
		if(startDate!=null&&endDate!=null){
			startDate=startDate.substring(0,10);
			endDate=endDate.substring(0,10);
		}
		if("0".equals(LimitSetTime)||LimitSetTime==null)
		{
			startDate=null;
			endDate=null;
			
			
		}
		
		
		
		
		//TODO
		List<Object[]> list=textService.findChartUser(startDate,endDate);
		
		//创建图形的数据结果集，使用list进行遍历dataset.addValue(13, "所属单位", "北京");
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		if(list!=null && list.size()>0){
			for(Object[] objects:list){
				//b.keyword,b.ddlName,COUNT(a.jctID)
				
				
				
				dataset.addValue(Double.parseDouble(objects[1].toString()), "省份", objects[0].toString());
			}
		}
		//使用JFreechart的核心对象创建图形
		JFreeChart chart = ChartFactory.createBarChart("用户报表",   //图形的主标题
										            "",                  //X轴外的标签名称
										            "记者通讯员数量",                         //Y轴外的标签名称 
										            dataset,                       //存放图形的数据集
										            PlotOrientation.VERTICAL,      //图形的显示形式（水平或垂直）
										            true,          				   //是否显示子标题
										            true,        				   //是否在图形上生成提示
										            true          				   //在图形上是否生成url连接 
										            );
		//处理主标题乱码
		chart.getTitle().setFont(new Font("宋体",Font.BOLD,18));
		//处理子标题乱码
		chart.getLegend().setItemFont(new Font("宋体",Font.BOLD,15));
		//获取图表区域对象
		CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();
		//获取X轴对象
		//CategoryAxis
		CategoryAxis	 categoryAxis3D = (CategoryAxis) categoryPlot.getDomainAxis();
		//获取Y轴对象
		NumberAxis numberAxis3D = (NumberAxis) categoryPlot.getRangeAxis();

		categoryAxis3D.setCategoryMargin(0.00001);//横轴标签之间的距离20%
		
		//处理X轴上的乱码
		categoryAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,10));
		
	
		
		//处理X轴外的乱码
		categoryAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
		//处理Y轴上的乱码
		numberAxis3D.setTickLabelFont(new Font("宋体",Font.BOLD,15));
		//处理Y轴外的乱码
		numberAxis3D.setLabelFont(new Font("宋体",Font.BOLD,15));
		
		//处理Y轴的刻度以1为单位，不使用默认
		numberAxis3D.setAutoTickUnitSelection(false);
		NumberTickUnit unit = new NumberTickUnit(100);
		numberAxis3D.setTickUnit(unit);
		
		//获取绘图区域对象
		BarRenderer renderer3D = (BarRenderer) categoryPlot.getRenderer();
		//让图形变得苗条点
		renderer3D.setMaximumBarWidth(0.015);
		
		GradientPaint gp0 = new GradientPaint(0.0f, 0.0f,new Color(100,129,169),0.0f, 0.0f,new Color(100,129,169));
		
		renderer3D.setSeriesPaint(0, gp0); 
		//让图形上显示数字
		renderer3D.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		renderer3D.setBaseItemLabelsVisible(true);
		renderer3D.setBaseItemLabelFont(new Font("宋体",Font.BOLD,15));
		
		/*******使图片生成到项目chart的路径下，以图片的形式********/
		//查找chart的路径
		String path = ServletActionContext.getServletContext().getRealPath("/Unicontribution");
		String filename = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+".png";
		
		File file = new File(path+"/"+filename);
		try {
			ChartUtilities.saveChartAsPNG(file, chart, 2200, 600);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		request.setAttribute("filename", filename);
		
		request.setAttribute("list2", list);
		return "authorStatus";
		
	}
	
	public String textShow()
	{
		return "textShow";
	}
//	@Override
//	public String execute()
//	{
//		
//		System.out.println("5555555");
//		if(uploadImages!=null)
//		{
//			for(int x=0;x<uploadImages.length;x++)
//			{
//				long length = uploadImages[x].length();
//				String length2 = ManagerPro.getString("maxsize");
//				long length3=Long.parseLong(length2);
//				if(length>length3)
//				{
//					this.addFieldError("name", "请上传20M一下的附件！");
//					return "textContribute";
//				}
//			}
//		}
//		return SUCCESS;
//	}
	

	public String uploadFilePic()
	{
		
				
				String maxcheckday = ManagerPro.getString("maxcheckday");
				int days_i = Integer.parseInt(maxcheckday);
				Calendar c = Calendar.getInstance();  
				c.setTime(new java.util.Date());  
				java.util.Date today = c.getTime(); 
				c.add(Calendar.DAY_OF_YEAR, -(days_i));  
				java.util.Date today_plus1 = c.getTime(); 
	
				String textTitle = textInfo.getTextTitle();
				String name2 = (String) request.getSession().getAttribute("name_Login");
				TextInfo info=textService.getByTitle(textTitle,today_plus1,name2);
				if(info!=null)
				{
					this.addFieldError("name", "请不要重复发送稿件！！");
					
					
					String types=ManagerPro.getString("type");
					types=I18n.getGBText(types);
					String[] typess = types.split(",");
					ActionContext.getContext().put("types", typess);
					String txtplate=ManagerPro.getString("txtplate");
					txtplate=I18n.getGBText(txtplate);
					String[] txtplates = txtplate.split(",");
					ActionContext.getContext().put("txtplates", txtplates);
					String name = (String) request.getSession().getAttribute("name_real");
					ActionContext.getContext().put("name", name);
					return "textContribute";
				}
				
				
			try {
				FileToPath.fileForPath(uploadImages,request,textService,uploadImagesFileName,textInfo,null,null,null,null);
			} catch (Exception e) {
				e.printStackTrace();
			}
	
		
			return "uploadFilePic";
	}
	
	
	public String textSearch()
	{
		return "textSearch";
	}
	public String textSearchRe()
	{
	String author= textInfo.getAuthor();
	String sender= textInfo.getSender();
	
	String startDate = request.getParameter("StartDate");
	String endDate = request.getParameter("EndDate");
	String value = request.getParameter("LimitSetTime");
	String page = this.request.getParameter("pageNum");
    int num = 0;
    if ((page == null) || ("".equals(page)))
    {
      page = "0";
      num = Integer.parseInt(page);
    }
    else
    {
      num = Integer.parseInt(page);
    }
    if (num == 0)
    {
      this.request.getSession().setAttribute("value", value);
    }
	
	startDate+=" 00:00:00";
	endDate+=" 23:59:59";
	if("0".equals((String)request.getSession().getAttribute("value")))
	{
		startDate=null;
		endDate=null;
	}
	
	if(StringUtils.isNotBlank(author))
	{
	author=author.trim();
	}
	if(StringUtils.isNotBlank(sender))
	{
		sender=sender.trim();
	}
	if(org.apache.commons.lang3.StringUtils.isNotBlank(idcard))
	{
		idcard=idcard.trim();

	}
	if(StringUtils.isNotBlank(workcompany))
	{
		workcompany=workcompany.trim();
		
	}
	

//		List<TextInfo> listText=textService.getByCondition(startDate,endDate,author,sender,idcard,workcompany);
//		ActionContext.getContext().put("listText", listText);
	
	if(num==0)
	{
		if("null 00:00:00".equals(startDate))
		{
			request.getSession().setAttribute("startDate", null);
		}
		else
		{
			request.getSession().setAttribute("startDate", startDate);

		}
		if("null 23:59:59".equals(endDate))
		{
			request.getSession().setAttribute("endDate", null);
		}
		else
		{
			request.getSession().setAttribute("endDate", endDate);
			
		}
	request.getSession().setAttribute("author", author);
	request.getSession().setAttribute("sender", sender);
	request.getSession().setAttribute("idcard", idcard);
	request.getSession().setAttribute("workcompany", workcompany);
	}
	
	PageBean pageBean =textService.getAllFenYeByAll(pageNum,TextInfo.class,
			(String)request.getSession().getAttribute("startDate"),
			(String)request.getSession().getAttribute("endDate"),

			(String)request.getSession().getAttribute("author"),

			(String)request.getSession().getAttribute("sender"),

			(String)request.getSession().getAttribute("idcard"),

			(String)request.getSession().getAttribute("workcompany"));
		ActionContext.getContext().getValueStack().push(pageBean);
		
		return "textSearchRe";
	}
	
	public String textAmount()
	{
		
		String startTime="";
		startTime = request.getParameter("startTime");

		
		String endTime="";
		endTime = request.getParameter("endTime");
		
		String searchtextflag="";

		searchtextflag = request.getParameter("searchtextflag");
		
		String searchtext="";
		searchtext = request.getParameter("searchtext");
		
		String query="";

		List<TextAmountInfo> result = new ArrayList<TextAmountInfo>();
		if(StringUtils.isNotBlank(searchtextflag))
		{
			searchtextflag=searchtextflag.trim();

		}
		if(StringUtils.isNotBlank(searchtext))
		{
			searchtext=searchtext.trim();
			
		}
		
		result = textService.ListTextAmountLimit(searchtextflag,searchtext,startTime,endTime);
		
		ActionContext.getContext().put("result", result);
		
		return "textAmount";
	}
	
	public String textStatSearch()
	{
		return "textStatSearch";
	}
	
	public String showText() throws ParseException
	{
		
		
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		String StrtextID=request.getParameter("textID");
		int textID=Integer.parseInt(StrtextID);
		TextInfo text=textService.findById(textID);
		
		ActionContext.getContext().getValueStack().push(text);		
		String dateStr = text.getContributeDate();
		
		
		String dateStr2=dateStr.substring(0,dateStr.lastIndexOf("."));
		Date oldtime = dateFormat.parse(dateStr2);
		Date newtime= new Date();
		 Long mils =	(newtime.getTime()-oldtime.getTime())/86400000;
	
		
		
		
		int tempindex = dateStr.indexOf(" ");
		dateStr = dateStr.substring(0,tempindex);
		
		String attachInfo = text.getAttachInfo();

		if(attachInfo != null&&attachInfo.length()>0)
		{
			String[] pics = attachInfo.split(";");
			//String filepath=ManagerPro.getString("pic_folder3");
		
		String filepath = "";
		for(int i=0;i<pics.length;i++)
		{
			filepath =filepath+ManagerPro.getString("pic_folder3")+ "/"+dateStr+"/"+pics[i];
			if(i!=pics.length-1)
			{
				filepath=filepath+";";
			}
		}
		text.setFilepath(filepath);
		
		request.setAttribute("mils", mils);

		request.setAttribute("text", text);
		ActionContext.getContext().put("filepath", filepath);
		}
		
		
		//TODO关于图片在页面上的显示。。在textshow页面里面。。
		return "showText";
	}
	


	
	public String getBBSByName()
	{
		
		try {
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();

			String parameter = request.getParameter("bbsname");
			List<Text> list = new ArrayList<Text>();

			if(parameter!=null&&parameter.equals("文章"))
			{
	//同步bbs类型
				
				String bbs=ManagerPro.getString("bbs_article");
				bbs=I18n.getGBText(bbs);
				String[] bbss = bbs.split(",");
				String[] bbss2= new String[bbss.length];
				String[] bbss3= new String[bbss.length];
				for(int x=0;x<bbss.length;x++)
				{
					bbss2[x]=bbss[x].substring(0, bbss[x].indexOf("("));
					bbss3[x]=bbss[x].substring(bbss[x].indexOf("(")+1,bbss[x].indexOf(")"));
					Text textInfo = new Text();
					textInfo.setName(bbss2[x]);
					textInfo.setId(bbss3[x]);
					list.add(textInfo);
				}
				
				
				
				
			}
			else {
				
				
				
				
	//同步bbs类型
				
				String bbs=ManagerPro.getString("bbs_bbs");
				bbs=I18n.getGBText(bbs);
				String[] bbss = bbs.split(",");
				String[] bbss2= new String[bbss.length];
				String[] bbss3= new String[bbss.length];
				for(int x=0;x<bbss.length;x++)
				{
					bbss2[x]=bbss[x].substring(0, bbss[x].indexOf("("));
					bbss3[x]=bbss[x].substring(bbss[x].indexOf("(")+1,bbss[x].indexOf(")"));
					Text textInfo = new Text();
					
					textInfo.setName(bbss2[x]);
					textInfo.setId(bbss3[x]);
					list.add(textInfo);
				}
			}
			JSONArray jsonArray = JSONArray.fromObject(list);
			System.out.println(jsonArray);

			out.println(jsonArray.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return null;
		}
	
	
	
	public String textStatusBaoBiao()
	{
		String value = request.getParameter("LimitSetTime");

		String startDate = request.getParameter("StartDate");
		String endDate = request.getParameter("EndDate");
		
		String jianbao = request.getParameter("jianbao");

		request.setAttribute("jianbao", jianbao);
		if("0".equals(value))
		{
			startDate=null;
			endDate=null;
		}

		List list=textService.findJspBaoBiao(startDate,endDate,jianbao);//
		
		
		ActionContext.getContext().put("listStatus", list);


		return "baobiao";
	}
	
	public String textStatusByCounty()
	{
		
		String value = request.getParameter("LimitSetTime");

		String startDate = request.getParameter("StartDate");
		String endDate = request.getParameter("EndDate");
		
		String jianbao = request.getParameter("jianbao");
		
		request.setAttribute("jianbao", jianbao);

		
		if("0".equals(value))
		{
			startDate=null;
			endDate=null;
		}
		
		List list=textService.findByCounty(startDate,endDate,jianbao);
		ActionContext.getContext().put("listStatus", list);

		return "county";

		
		
	}
	
	
	public String createXML()
	{	
		
		
		
		String dele_list[] = request.getParameterValues("selCheck");
		
		String nameRe = (String) request.getSession().getAttribute("name_real");

		
		for(int x=0;x<dele_list.length;x++)
		{
			
			int id=Integer.parseInt(dele_list[x]);
			textService.createXML(id,nameRe);
		}
		

		return "toManageText";
	}
	
	
	
	
	public TextInfo getModel() {
		return textInfo;
	}

	public void setServletRequest(HttpServletRequest req) {
		this.request=req;
	}
	

	
	
	private String idcard;
	private String workcompany;
	private String author;
	private String sender;
	
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getWorkcompany() {
		return workcompany;
	}

	public void setWorkcompany(String workcompany) {
		this.workcompany = workcompany;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response=response;
	}
	

	
	
}
