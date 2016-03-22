package cn.uni.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.aspectj.weaver.bcel.AtAjAttributes;

import cn.uni.domain.TextInfo;
import cn.uni.domain.UserInfo;
import cn.uni.service.TextService;



public class FileToPath {

	
	public static String html(String content) {
		if (content == null)
		return "";
		String html = content;

		// html = html.replace( "'", "&apos;");
		html = html.replaceAll("&", "&amp;");
		html = html.replace("\"", "&quot;"); // "
		html = html.replace("\t", "&nbsp;&nbsp;");// 替换跳格
		html = html.replace(" ", "&nbsp;");// 替换空格
		html = html.replace("<", "&lt;");

		html = html.replaceAll(">", "&gt;");

		return html;
		}
	
	
	
	
	public  static  String  fileForPath(File[] uploadImages,HttpServletRequest request,TextService textService,String[] uploadImagesFileName,TextInfo textInfo,String bbsyes,String bbsname,String bbstype,String username) throws Exception {
		
		

		
		
		
		String UniContributeDate="";
		String path3="";
		UniContributeDate=UninewsTools.strNowtime().substring(0,10);
		int type=1;
		//一开始上传到tomcat路径下面
		//String tempFolder = PropertyManager.getProperty("pic_folder2");
		
		String tempFolder =ManagerPro.getString("pic_folder2");
		if (tempFolder==null || tempFolder.equals(""))
		{
			tempFolder = "d:/Unicontribution";
		}
		tempFolder+="/"+ UniContributeDate +"/";
		File dir = new File(tempFolder);
		if(!dir.exists())
		{
			//System.out.println("testMkdir");
			dir.mkdirs();
		}
		
		//String tempFolder1 = PropertyManager.getProperty("text_tempfolder");
		String tempFolder1 =ManagerPro.getString("text_tempfolder");

		if (tempFolder1==null || tempFolder1.equals(""))
		{
		              tempFolder1 = "d:/Unicontribution";
		}	
		String mytype = request.getParameter("mytype");
		
		if(mytype!=null)
		{
			 type = Integer.parseInt(mytype);

		}

		if(uploadImages!=null&&uploadImages.length>0)
		{
			if(type==2||(bbsyes!=null&&bbsyes.equals("pictype")))
			{
				tempFolder1 +="/docpic";
			}else if(type==3)
			{
				tempFolder1 +="/docvideo";
			}else if(type==4)
			{
				tempFolder1 +="/docaudio";
			}
		}
		else
		{
			type = 1;
			tempFolder1 +="/doc";
		}
			tempFolder1 +="/";
		
		
			UserInfo user = (UserInfo)request.getSession().getAttribute("user");
			String name_login="";
			String name_real="";
			String workcompany = "";
		if(user!=null)
		{
			 name_login =user.getName_Login();

			 name_real = user.getName_real();
			 
			 workcompany = user.getWorkcompany();
		}
		
		
		if(bbsyes!=null&&bbsyes.equals("pictype"))
		{
			name_login=username;
			
			

		}
		String path ="";
		String path2 ="";
		String filename="";
		int	myID=0;
		String k="1";
		int doIndex=0;
		int doIndex2=0;
		String attachInfo = "";
		String attachInfo2 = "";
		String picInfo = "";
		
		String remoteAddr = request.getRemoteAddr();
		textInfo.setAuthorIP(remoteAddr);
		textInfo.setAttachInfo(attachInfo);
		textInfo.setPicInfo(picInfo);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		String dd = dateFormat.format(new Date());
		textInfo.setContributeDate(dd);
if(uploadImages!=null&&bbsyes!=null&&bbsyes.equals("pictype"))
{
	textInfo.setRest2("2");
	}
else {
	textInfo.setRest2(mytype);

}
		if(bbsyes!=null&&bbsyes.equals("pictype"))
		{
			textInfo.setRest3("新闻app客户端投稿");
		}
		else {
			textInfo.setRest3("电脑投稿");

		}
		
		textInfo.setSender(name_login);
		String replaceAll = textInfo.getTextContent().replaceAll("！","！！");
		textInfo.setTextContent(replaceAll);
		textInfo.setAnonyFlag(0);
		textInfo.setIsUsed("是");
		textInfo.setStatus("待取");
		
		String replace = UUID.randomUUID().toString().replace("-", "");
		
		replace="yc"+replace;
		textInfo.setGlobalNewsId(replace);
		//TODO
		
				
				Object save = textService.save(textInfo);
				
				if(save!=null)
				{
					myID=Integer.parseInt(save.toString());	
				}
		
		//myID=textService.selectMax();

			
		
		if(uploadImages!=null&&uploadImages[0]!=null&&uploadImages.length>0)
		{
		
		int count = uploadImagesFileName.length;
		for(int x=0;x<count;x++)
		{
		
			
			
			
			
			
			
			filename=name_login+UniContributeDate+"_"+myID+"_"+x;
			doIndex=uploadImagesFileName[x].lastIndexOf(".");
            uploadImagesFileName[x] = uploadImagesFileName[x].replaceAll(";","");
            attachInfo += filename+uploadImagesFileName[x].substring(doIndex)+";";
            if(type==2){
            attachInfo2 += "[img]"+ManagerPro.getString("bbs_fujian")+"/Unicontribution/picAll"+"/"+ UniContributeDate +"/"+filename+uploadImagesFileName[x].substring(doIndex)+";[/img];";
            
            }
            
            else {
				
                attachInfo2 += "[url]"+ManagerPro.getString("bbs_fujian")+"/Unicontribution/picAll"+"/"+ UniContributeDate +"/"+filename+uploadImagesFileName[x].substring(doIndex)+";[/url]&lt;br&gt;";

			}
			picInfo += uploadImagesFileName[x].substring(0,doIndex)+";";

			path=tempFolder+filename+uploadImagesFileName[x].substring(doIndex);	
			path3+=path+";";
			File  newfile = new File(path);
			
			
			if(bbsyes!=null&&bbsyes.equals("pictype"))
			{
				fileCopy(uploadImages[x].getAbsolutePath(),path);
			}
			else {
				uploadImages[x].renameTo(newfile);

			}
			
			
			textService.update(attachInfo,picInfo,myID);
		}
		
		
	/*	//you附件
		HttpClient client = new HttpClient();
		 client.getParams().setContentCharset("UTF-8");
		 NameValuePair[] nameValuePair =null;
		 PostMethod method=null;
		 
		 if(bbsyes!=null&&bbsyes.equals("true")){
			 
		 
		 
		 
		 if(bbsname!=null&&bbsname.equals("帖子"))
		 {
			 method = new PostMethod(ManagerPro.getString("bbs_tiezi"));
			 
			 
			 nameValuePair=new NameValuePair[4];
				
				nameValuePair[0]= new NameValuePair("username",name_login);
				String textTitle = textInfo.getTextTitle();
				nameValuePair[1]= new NameValuePair("subject",textTitle);
				String textContent = textInfo.getTextContent();
				
				
				String html = html(textContent+attachInfo2);
				nameValuePair[2]= new NameValuePair("message",html);
				
				if(bbstype!=null&&bbstype.equals("2"))
				{
					nameValuePair[3]= new NameValuePair("fid","2");

				}
				
				else if(bbstype!=null&&bbstype.equals("1"))
				{
					nameValuePair[3]= new NameValuePair("fid","1");

				}
				else if(bbstype!=null&&bbstype.equals("3"))
				{
					nameValuePair[3]= new NameValuePair("fid","3");

				}
				else if(bbstype!=null&&bbstype.equals("4"))
				{
					nameValuePair[3]= new NameValuePair("fid","4");

				}
				else if(bbstype!=null&&bbstype.equals("5"))
				{
					nameValuePair[3]= new NameValuePair("fid","5");

				}
				else {
					nameValuePair[3]= new NameValuePair("fid","71");

				}
			 
			 
		 }
		 else {
			 method = new PostMethod(ManagerPro.getString("bbs_wenzhang"));
			 
			 
			 
			 nameValuePair = new NameValuePair[4];
				
				nameValuePair[0]= new NameValuePair("username",name_login);
				String textTitle = textInfo.getTextTitle();
				nameValuePair[1]= new NameValuePair("title",textTitle);
				String textContent = textInfo.getTextContent();
				
				
				String html = html(textContent+attachInfo2);
				nameValuePair[2]= new NameValuePair("content",html); 
				
				
				if(bbstype!=null&&bbstype.equals("1"))
				{
					nameValuePair[3]= new NameValuePair("catid","1");

				}
				if(bbstype!=null&&bbstype.equals("2"))
				{
					System.out.println("you..........");
					nameValuePair[3]= new NameValuePair("catid","2");

				}
				else if(bbstype!=null&&bbstype.equals("3"))
				{
					nameValuePair[3]= new NameValuePair("catid","3");

				}
				else if(bbstype!=null&&bbstype.equals("4"))
				{
					nameValuePair[3]= new NameValuePair("catid","4");

				}
				else if(bbstype!=null&&bbstype.equals("5"))
				{
					nameValuePair[3]= new NameValuePair("catid","5");

				}
				else {
					nameValuePair[3]= new NameValuePair("catid","6");

				}
		}
		method.addRequestHeader("Content","text/html,charset=utf-8"); 
		
		method.addParameters(nameValuePair);
		
		int executeMethod = client.executeMethod(method);
		method.releaseConnection();

		}*/
	
		
		
		
		
		//TODO加入有图片的话
		//TODO
	
		}

		
		TextInfo newtextInfo =textService.findById(myID);
		String attachStr = newtextInfo.getAttachInfo();
		textService.makeXML(newtextInfo,name_login,type,name_real,workcompany,attachStr,k,bbsyes);
		
		String[] files = attachStr.split(";");
		String[] split = path3.split(";");
		if(files!=null&&files[0]!=null&&files[0].length()>0)
		{
		int count2=files.length;
		
		for(int j=0;j<count2;j++)
		{	
			
			if(type==2)
			{
				
				textService.makeXML(newtextInfo,name_login,type,name_real,workcompany,"",k+"_"+j,bbsyes);
			}
			String tempFile="";
			if(uploadImages!=null&&uploadImages.length>0)
			{
		 tempFile = files[j];
		doIndex2 = tempFile.lastIndexOf('_');
		tempFile = tempFile.substring(0,doIndex2)+"_"+1+tempFile.substring(doIndex2);

			}
		
		
		path2=tempFolder1+tempFile;	

		fileCopy(split[j], path2);
		
		//split[j]=split[j].replace("/", "\\");
		split[j]=split[j].replace("\\\\\\\\", "\\\\");
		try {
			
			if(type==2)
			{
			toSmaillImg(split[j],split[j]);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		}
		
		}
		
		
			return path;
			
	}
	
	
	
	public static void fileCopy(String file1,String file2)
	{
		try //must try and catch,otherwise will compile error
		{
			//instance the File as file_in and file_out
			java.io.File file_in=new java.io.File(file1);
			java.io.File file_out=new java.io.File(file2);
			FileInputStream in1=new FileInputStream(file_in);
			FileOutputStream out1=new FileOutputStream(file_out);
			byte[] bytes=new byte[1024];
			int c=0;
			while((c=in1.read(bytes))!=-1)
				out1.write(bytes,0,c);
			in1.close();
			out1.close();
		}
		catch(Exception e)
		{
			System.out.println("Error!"+e);
		}
	}
	
	 public static void toSmaillImg(String filePath,String thumbPath) throws Exception{   
	        String newurl =thumbPath;   
	        java.awt.Image bigJpg = javax.imageio.ImageIO.read(new java.io.File(filePath));  
	        
	        String rate = ManagerPro.getString("rate");
	        
	        float tagsize =Float.parseFloat(rate);
	        //float tagsize = 100;   
	        int old_w = bigJpg.getWidth(null);   
	        int old_h = bigJpg.getHeight(null);      
	        int new_w = 0;   
	        int new_h = 0;   
	        float tempdouble;    
	        tempdouble = old_w > old_h ? old_w/tagsize : old_h/tagsize;   
	        new_w = Math.round(old_w/tempdouble);   
	        new_h = Math.round(old_h/tempdouble);   
	        java.awt.image.BufferedImage tag = new java.awt.image.BufferedImage(new_w,new_h,java.awt.image.BufferedImage.TYPE_INT_RGB);   
	        tag.getGraphics().drawImage(bigJpg,0,0,new_w,new_h,null);   
	        FileOutputStream newimage = new FileOutputStream(newurl);   
	        com.sun.image.codec.jpeg.JPEGImageEncoder encoder = com.sun.image.codec.jpeg.JPEGCodec.createJPEGEncoder(newimage);          
	        encoder.encode(tag);   
	        newimage.close();   
	    }   
	
	


}
