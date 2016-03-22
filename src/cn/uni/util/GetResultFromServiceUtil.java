package cn.uni.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;



/**
 * @author 孙辽东
 * @E-mail:sld880311@126.com
 * @qq:767768553
 * @version :1.0.0
 * 创建时间：2013-4-28上午10:30:43
 * 简单说明:Java模仿页面请求工具类
 * 1.可以实现接口信息调用
 * 2.恶性工具服务器
 */
public class GetResultFromServiceUtil {
	/**
	 * 使用Java中的包进行处理
	 * @param url
	 * @param endcoding
	 * @return
	 */
	public static String getHtmlFromWebSite(String url, String endcoding) {
		String result = "";
		try {
			String sCurrentLine = "";
			String sTotalString = "";
			URL l_url = new URL(url);
			HttpURLConnection l_connection = (HttpURLConnection) l_url.openConnection();
			l_connection.setConnectTimeout(3000);
			l_connection.setReadTimeout(10000); 
			l_connection.setDoInput(true);
			l_connection.setDoOutput(true);
			l_connection.setRequestMethod("POST");
			
//			 /**   
//	         * 最后，为了得到OutputStream，简单起见，把它约束在Writer并且放入POST信息中，例如： ...   
//	         */    
//	        OutputStreamWriter out = new OutputStreamWriter(l_connection.getOutputStream(), "8859_1");     
//	        out.write("username=kevin&password=*********"); //向页面传递数据。post的关键所在！      
//	        // remember to clean up      
//	        out.flush();     
//	        out.close();     
			if(l_connection.getResponseCode()==200){
				l_connection.connect();
				InputStream l_urlStream = l_connection.getInputStream();
				BufferedReader l_reader = null;
				if (endcoding == null || "".equals(endcoding.trim())) {
					l_reader = new BufferedReader(
							new InputStreamReader(l_urlStream));
				} else {
					l_reader = new BufferedReader(
							new InputStreamReader(l_urlStream, endcoding));
				}
				while ((sCurrentLine = l_reader.readLine()) != null) {
					sTotalString += sCurrentLine;
				}
				result = sTotalString;
			}else{
				System.out.println("失败："+url);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	/**
	 * 使用第三方的包commons-httpclient-3.1.jar
	 * 根据url获取远程接口中的数据
	 * @param url请求路径,data请求时的参数
	 */
	public static String getResultFromWeb(String url,String data){
		StringBuffer result = new StringBuffer();
		HttpClient client = new HttpClient();
		HttpConnectionManagerParams params =  client.getHttpConnectionManager().getParams();
//		params.setConnectionTimeout(30000); 
//		params.setSoTimeout(30000); 
		client.getParams().setBooleanParameter("http.protocol.expect-continue", false); 
		PostMethod post = new PostMethod(url); //以post的方式提交请求
		post.addRequestHeader("Connection", "close");
		try {
			post.setRequestEntity(new StringRequestEntity(data, "text/xml", "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		InputStream is = null;
		try{
			int statusCode = client.executeMethod(post);
			if (statusCode != HttpStatus.SC_OK) 
			{
				System.out.println("Http Method failed: "+ post.getStatusLine());
			}
			is = post.getResponseBodyAsStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			int ch = -1;
			while ((ch = reader.read()) != -1) 
			{
				result.append((char) ch);
			}
			reader.close();	
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(is!=null){
				try {
					
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return result.toString();
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String url = "http://127.0.0.1:8080/uniContribute_qxb/userAction_add?name=aaa";
//		String data = "43432";
//		GetResultFromServiceUtil.getResultFromWeb(url, data);
		
	//	String url = "http://www.baidu.com/s?word=Oracle+OCJP&tn=sitehao123&ie=utf-8";
//		String url = "http://127.0.0.1:8888/sda/main.html";
//		String res = GetResultFromServiceUtil.getHtmlFromWebSite(url, "UTF-8");
		String res = GetResultFromServiceUtil.getResultFromWeb(url, "111");
		System.out.println(res);
	}
}
