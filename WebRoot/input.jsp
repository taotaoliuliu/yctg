<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html;charset=GBK" %> 

<html>
 
    <head>
        <link rel="stylesheet" type="text/css" href="ErrorPageTemplate.css" >
 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Internet Explorer �޷���ʾ����ҳ</title>
 
      
    </head>
 
    
 
        <table width="730" cellpadding="0" cellspacing="0" border="0">
 
        <!-- Error title -->
            <tr>
                <td id="infoIconAlign" width="60" align="left" valign="top" rowspan="2">
                    <img src="noConnect.png" id="infoIcon" alt="��Ϣͼ��" width="48" height="48">
                </td>
                <td id="mainTitleAlign" valign="middle" align="left" width="*">
                    <h1 id="mainTitle">Internet Explorer �޷���ʾ��ҳ��</h1>
                </td>
            </tr>
 
            <tr>
                <!-- This row is for HTTP status code, as well as the divider-->
                <td id="errorCodeAlign" class="errorCodeAndDivider" align="right">&nbsp;
                    <div class="divider"></div>
                </td>
            </tr>
 
        <!-- What you can do -->
            <tr>
                <td>
                    &nbsp;
                </td>
                <td id="whatToTryAlign" valign="top" align="left">
                    <h2 id="whatToTry">�����Գ������²���:</h2>
                </td>
            </tr>
 
        <!-- Check Connection -->
            <tr>
                <td >
                    &nbsp;
                </td>
                <td id="checkConnectionAlign" align="left" valign="middle">
                    <h4>
                        <table>
                            <tr>
                                <td valign="top">
                                </td>
                                <td valign="middle">
                                    <button onclick="javascript:diagnoseConnectionAndRefresh(); return false;" id="diagnose">�����������</button>
                                </td>
                            </tr>
                        </table>
                    </h4>
                </td>
            </tr>
 
 
        <!-- InfoBlock -->
            <tr>
                <td id="infoBlockAlign" align="right" valign="top">
                    &nbsp;
                </td>
                <td id="moreInformationAlign" align="left" valign="middle">
                    <h4>
                      <table>
                          <tr>
                              <td valign="top">
                                  <a href="#" onclick="javascript:expandCollapse('infoBlockID', true); return false;"><img src="down.png" id="infoBlockIDImage" border="0" class="actionIcon" alt="��ϸ��Ϣ"></a>
                              </td>
                              <td valign="top">
                                  <span id="moreInfoContainer"></span>
                                  <noscript><ID id="moreInformation">������Ϣ</ID></noscript>
                              </td>
                          </tr>
                      </table>
                    </h4>
                    <div id="infoBlockID" class="infoBlock" style="display: none">
                        <p>
                            <ID id="errorExpl1">����������������и������⵼�µ�:</ID>
                            <ul>
                                <li id="errorExpl2">Internet �����Ѷ�ʧ��</li>
                                <li id="errorExpl3">����վ��ʱ�����á�</li>
                                <li id="errorExpl4">�޷����ӵ�����������(DNS)��</li>
                                <li id="errorExpl5">����������(DNS)û�и���վ������б�</li>
                                <li id="errorExpl7">�ڵ�ַ�п��ܴ��ڼ������</li> 
                                <li id="errorExpl6">������� HTTPS (��ȫ)��ַ���뵥�������ߡ��˵��µġ�Internet ѡ����ٵ������߼���ѡ���Ȼ��������ȷ������ȫ�������µ� SSL �� TLS Э�������á�</li>
                            </ul>
                        </p>
                        <p id="offlineUsers">�����ѻ��û�<b></b></p>                                     
                        <p id="viewSubscribedFeeds1">
                           �Կɲ鿴�Ѷ��ĵ�Դ������鿴����һЩ��ҳ��<br/>
                           ��Ҫ�鿴�Ѷ��ĵ�Դ
                           <ol>
                               <li id="viewSubscribedFeeds2">�������ղؼ����ġ���ť<img src="favcenter.png" border="0">��������Դ����Ȼ�󵥻�ϣ���鿴��Դ��</li>
                           </ol>
                        </p>
                        <p id="viewRecentWebpages1">�鿴������ʹ�����ҳ(���鿴����ҳ��)
                           <ol>
                              <li id="viewRecentWebpages2">���������ߡ�<img src="tools.png" border="0">��Ȼ�󵥻����ѻ���������</li>
                              <li id="viewRecentWebpages3">�������ղؼ����ġ���ť��<img src="favcenter.png" border="0">����������ʷ��¼����Ȼ�󵥻�ϣ���鿴��ҳ�档</li>
                           </ol>
                        </p>
                    </div>
                </td>
            </tr>
 
        </table>
 
    </body>
</html>

