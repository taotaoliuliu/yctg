
package cn.uni.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

public class I18n
{

    public I18n()
    {
    }

    public static String getText(HttpServletRequest request, String paramName)
    {
        if(paramName == null)
            return null;
        String value = request.getParameter(paramName);
        if(value == null)
            return null;
        try
        {
            value = new String(value.getBytes(), request.getCharacterEncoding());
        }
        catch(UnsupportedEncodingException ex)
        {
            System.err.println(ex);
        }
        catch(NullPointerException nex)
        {
            System.err.println(nex);
        }
        return value;
    }
    public static String getGBText(String paramName)
    {
    	String value =null;
    	if(paramName == null)
            return null;
        try
        {
            value = new String(paramName.getBytes("ISO8859-1"), "GBK");
        }
        catch(UnsupportedEncodingException ex)
        {
            System.err.println(ex);
        }
        catch(NullPointerException nex)
        {
            System.err.println(nex);
        }
        return value;
    }
    public static String getUNGBText(String paramName)
    {
    	String value =null;
    	if(paramName == null)
            return null;
        try
        {
            value = new String(paramName.getBytes("GBK"), "ISO8859-1");
        }
        catch(UnsupportedEncodingException ex)
        {
            System.err.println(ex);
        }
        catch(NullPointerException nex)
        {
            System.err.println(nex);
        }
        return value;
    }
    
}