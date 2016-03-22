package cn.uni.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileInputStream;

import net.sf.json.JSONObject;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.validation.SkipValidation;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.uni.dao.TextDao;
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
public class TextAction2 extends ActionSupport implements ModelDriven<TextInfo>,ServletRequestAware,ServletResponseAware{
		public  HttpServletRequest request;
		public HttpServletResponse response;
		private TextInfo textInfo = new TextInfo();

	  private File[] uploadImages;//得到上传的文件
	  private String[] uploadImagesContentType;//得到文件的类型
	  private String[] uploadImagesFileName;//得到文件的名称
	  
	  
	  public int pageNum = 1;

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
	  private UserService userService;
	@Resource
	  private TextService textService;
	@Resource
	private TextDao textDao;

	
	
	@SkipValidation
	public String uploadFilePic()
	{
		//
		String bbsyes = request.getParameter("bbsyes");
		System.out.println(bbsyes+"22");
		//帖子还是文章
		String bbsname = request.getParameter("bbstype");
		//文章帖子的具体分块
		String bbstype = request.getParameter("bbstype2");
		
		String mytype = request.getParameter("mytype");
		
				String maxcheckday = ManagerPro.getString("maxcheckday");
				int days_i = Integer.parseInt(maxcheckday);
				Calendar c = Calendar.getInstance();  
				c.setTime(new java.util.Date());  
				java.util.Date today = c.getTime(); 
				c.add(Calendar.DAY_OF_YEAR, -(days_i));  
				java.util.Date today_plus1 = c.getTime(); 
	
				String textTitle = textInfo.getTextTitle();
					
				String textContent = textInfo.getTextContent();
				String name2 = (String) request.getSession().getAttribute("name_Login");
				
				
				if(textContent!=null&&textContent.length()>8000)
				{
					
					this.addFieldError("name", "稿件内容太长，请分段上传！");

					
					return "textContribute";

				}
				
				
				
				
				if(uploadImages!=null)
					{
						for(int x=0;x<uploadImages.length;x++)
						{
							long length = uploadImages[x].length();
							String length2 = ManagerPro.getString("maxsize");
							long length3=Long.parseLong(length2);
							if(length>length3)
							{
								this.addFieldError("name", "请上传10M以下的单个附件！");
								
								ActionContext.getContext().getValueStack().push(textInfo);

								String types=ManagerPro.getString("type");
								types=I18n.getGBText(types);
								String[] typess = types.split(",");
								ActionContext.getContext().put("types", typess);
								String txtplate=ManagerPro.getString("txtplate");
								txtplate=I18n.getGBText(txtplate);
								String[] txtplates = txtplate.split(",");
								ActionContext.getContext().put("txtplates", txtplates);
								UserInfo user=(UserInfo)request.getSession().getAttribute("user");
								String name =user.getName_real();
								ActionContext.getContext().put("name", name);
								
							//	ActionContext.getContext().
								
								//同步bbs类型
								List<Text> list = new ArrayList<Text>();

								String bbs=ManagerPro.getString("bbs_bbs");
								bbs=I18n.getGBText(bbs);
								String[] bbss = bbs.split(",");
								String[] bbss2= new String[bbss.length];
								String[] bbss3= new String[bbss.length];
								for(int y=0;y<bbss.length;y++)
								{
									bbss2[y]=bbss[y].substring(0, bbss[y].indexOf("("));
									bbss3[y]=bbss[y].substring(bbss[y].indexOf("(")+1,bbss[y].indexOf(")"));
									Text textInfo = new Text();
									
									textInfo.setName(bbss2[y]);
									textInfo.setId(bbss3[y]);
									list.add(textInfo);
								}
							
								ActionContext.getContext().put("bbss", list);
								
								
								
								if(mytype.equals("3"))
								{
									return "textContribute2";
								}
								else if(mytype.equals("4"))
								{
									return "textContribute3";

								}
								else {
									return "textContribute";

								}
							}
						}
					}
				
				
				
			try {
			//  FileToPath.fileForPath(this.uploadImages, this.request, this.textService, this.uploadImagesFileName, this.textInfo, bbsyes, bbsname, bbstype,username);

				FileToPath.fileForPath(uploadImages,request,textService,uploadImagesFileName,textInfo,bbsyes,bbsname,bbstype,null);
			} catch (Exception e) {
				e.printStackTrace();
			}
	
		
			return "uploadFilePic";
	}
	
	
	public String httpUpload()
	{
		  
		response.setContentType("application/json");  
		response.setCharacterEncoding("UTF-8");  
		
		

		
		

		
		
		try {
			
			String jsondata = request.getParameter("parameter");
			JSONObject json = JSONObject.fromObject(jsondata);

			String username = json.get("UserName").toString();
			
			
			
			
			String title = json.get("Title").toString();
			String content = json.get("Content").toString();
				
			String attachments = json.get("Attachments").toString();
			UserInfo byLoginName = userService.getByLoginName(username);
			
			String nameReal = byLoginName.getName_real();
			System.out.println(nameReal+"nameReal");
			
//			URL url = new URL(attachments); 
//			
//			HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
//			
//			//设置请求方式为"GET"  
//			conn.setRequestMethod("GET");  
//			//超时响应时间为5秒  
//			conn.setConnectTimeout(5 * 1000);
//			
//			//通过输入流获取图片数据  
//			InputStream inStream = conn.getInputStream();
			//方案一：在写一次fileForPath比较麻烦,重复代码较多（还是使用这个）
			
			//方案二：使用局域网拷贝文件到固定的目录下面（重复拷贝次数过多）
			uploadImages=new File[1];
			uploadImagesFileName=new String[1];
			if(attachments!=null&&attachments.length()>0)
			{
				
			
//			String host = ManagerPro.getString("host");//远程服务器的地址
//	        String username2 = ManagerPro.getString("hostname");//用户名
//	        String password = ManagerPro.getString("hostpassword");//密码
//	        String path = ManagerPro.getString("hostdir");//远程服务器共享文件夹名称
//	        String output_path = ManagerPro.getString("tohostdir")+attachments;//本地存放路径
//	        
//	        String full_path = "smb://" + username2 + ":" + password + "@" + host + path;
//
//			SmbFile file = new SmbFile(full_path+attachments);
//			
//			
//			
//			SmbFileInputStream in = new SmbFileInputStream(file);
//
//			FileOutputStream fileOutputStream = new FileOutputStream(output_path);
//			
//			byte[] bytes=new byte[1024];
//			int c=0;
//			while((c=in.read(bytes))!=-1)
//			{
//				fileOutputStream.write(bytes,0,c);
//
//			}
//			fileOutputStream.close();
//			
//			in.close();
				//appnewsuri
				
				
				String appnewsuri = ManagerPro.getString("appnewsuri");
				String tohostdir = ManagerPro.getString("tohostdir");
				String urlString=appnewsuri+attachments;
				attachments = attachments.substring(attachments.lastIndexOf("/")+1);

				System.out.println(urlString+"urlString");
				URL url = new URL(urlString);   
		        // 打开连接   
		        URLConnection con = url.openConnection();   
		        //设置请求超时为5s   
		        con.setConnectTimeout(5*1000);   
		        // 输入流   
		        InputStream is = con.getInputStream();   
		       
		        // 1K的数据缓冲   
		        byte[] bs = new byte[1024];   
		        // 读取到的数据长度   
		        int len;   
		        // 输出的文件流   
		        
				System.out.println(urlString+"urlString");

		       File sf=new File(tohostdir);   
		       if(!sf.exists()){   
		           sf.mkdirs();   
		       }   
		       
				System.out.println(sf.getPath()+attachments+"sf.getPath()+attachments");

		       OutputStream os = new FileOutputStream(sf.getPath()+"/"+attachments);   
		        // 开始读取   
		        while ((len = is.read(bs)) != -1) {   
		          os.write(bs, 0, len);   
		        }   
		        // 完毕，关闭所有链接   
		        os.close();   
		        is.close();   

			
		       			

			uploadImages[0]= new File(tohostdir+attachments);
		
			uploadImagesFileName[0]=attachments;
			}
			
			textInfo.setAuthor(nameReal);
			textInfo.setTextContent(content);
			textInfo.setTextTitle(title);
			String fileForPath="";
			if(uploadImages[0]!=null&&uploadImagesFileName[0]!=null)
			{
				System.out.println("1111111111");
				 fileForPath = FileToPath.fileForPath(uploadImages,request,textService,uploadImagesFileName,textInfo,"pictype",null,null,username);

			}
			else {
				System.out.println("2222222222");
			fileForPath = FileToPath.fileForPath(uploadImages,request,textService,uploadImagesFileName,textInfo,"pictype",null,null,username);

				
			}

	        
		
			if(fileForPath!=null)
			{
				JSONObject jObject = new JSONObject();

				jObject.put("Ret", 1);
				jObject.put("Msg", "保存成功");
				try {
					PrintWriter writer = response.getWriter();
					
					
					writer.println(jObject);
					writer.flush();
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
			else {
				
				
				JSONObject jObject = new JSONObject();

				jObject.put("Ret", 0);
				jObject.put("Msg", "失败");
				try {
					PrintWriter writer = response.getWriter();
					writer.println(jObject);
					writer.flush();
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}	
				
				
			}
			
			
			
			
	
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}   
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		
		return null;
		
	}
	
	public String getTitle()
	{
		
		
		
        try {
        	
        	String title = request.getParameter("title");
        	
			String maxcheckday = ManagerPro.getString("maxcheckday");

        	int days_i = Integer.parseInt(maxcheckday);
			Calendar c = Calendar.getInstance();  
			c.setTime(new java.util.Date());  
			java.util.Date today = c.getTime(); 
			c.add(Calendar.DAY_OF_YEAR, -(days_i));  
			java.util.Date today_plus1 = c.getTime(); 

			String name2 = (String) request.getSession().getAttribute("name_Login");
        	
        	TextInfo info=textService.getByTitle(title,today_plus1,name2);
			JSONObject obj = new JSONObject();

        	if(info!=null)
        	{
        		obj.put("flag", 1);
        	}
        	else {
        		obj.put("flag", 0);
			}
			
        	PrintWriter writer = response.getWriter();

			writer.println(obj);
			writer.flush();
			writer.close();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		
		
		return null;
	}
	
	
	
	
	
	
	
	public TextInfo getModel() {
		return textInfo;
	}

	public void setServletRequest(HttpServletRequest req) {
		this.request=req;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response=response;
	}
	

	
	
	
	

	
	
}
