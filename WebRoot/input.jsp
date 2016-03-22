<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html;charset=GBK" %> 

<html>
 
    <head>
        <link rel="stylesheet" type="text/css" href="ErrorPageTemplate.css" >
 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Internet Explorer 无法显示该网页</title>
 
      
    </head>
 
    
 
        <table width="730" cellpadding="0" cellspacing="0" border="0">
 
        <!-- Error title -->
            <tr>
                <td id="infoIconAlign" width="60" align="left" valign="top" rowspan="2">
                    <img src="noConnect.png" id="infoIcon" alt="信息图标" width="48" height="48">
                </td>
                <td id="mainTitleAlign" valign="middle" align="left" width="*">
                    <h1 id="mainTitle">Internet Explorer 无法显示该页面</h1>
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
                    <h2 id="whatToTry">您可以尝试以下操作:</h2>
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
                                    <button onclick="javascript:diagnoseConnectionAndRefresh(); return false;" id="diagnose">诊断连接问题</button>
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
                                  <a href="#" onclick="javascript:expandCollapse('infoBlockID', true); return false;"><img src="down.png" id="infoBlockIDImage" border="0" class="actionIcon" alt="详细信息"></a>
                              </td>
                              <td valign="top">
                                  <span id="moreInfoContainer"></span>
                                  <noscript><ID id="moreInformation">更多信息</ID></noscript>
                              </td>
                          </tr>
                      </table>
                    </h4>
                    <div id="infoBlockID" class="infoBlock" style="display: none">
                        <p>
                            <ID id="errorExpl1">此问题可能是由下列各种问题导致的:</ID>
                            <ul>
                                <li id="errorExpl2">Internet 连接已丢失。</li>
                                <li id="errorExpl3">该网站暂时不可用。</li>
                                <li id="errorExpl4">无法连接到域名服务器(DNS)。</li>
                                <li id="errorExpl5">域名服务器(DNS)没有该网站的域的列表。</li>
                                <li id="errorExpl7">在地址中可能存在键入错误。</li> 
                                <li id="errorExpl6">如果这是 HTTPS (安全)地址，请单击“工具”菜单下的“Internet 选项”，再单击“高级”选项卡，然后请检查以确保“安全”部分下的 SSL 和 TLS 协议已启用。</li>
                            </ul>
                        </p>
                        <p id="offlineUsers">对于脱机用户<b></b></p>                                     
                        <p id="viewSubscribedFeeds1">
                           仍可查看已订阅的源和最近查看过的一些网页。<br/>
                           若要查看已订阅的源
                           <ol>
                               <li id="viewSubscribedFeeds2">单击“收藏夹中心”按钮<img src="favcenter.png" border="0">，单击“源”，然后单击希望查看的源。</li>
                           </ol>
                        </p>
                        <p id="viewRecentWebpages1">查看最近访问过的网页(不查看所有页面)
                           <ol>
                              <li id="viewRecentWebpages2">单击“工具”<img src="tools.png" border="0">，然后单击“脱机工作”。</li>
                              <li id="viewRecentWebpages3">单击“收藏夹中心”按钮，<img src="favcenter.png" border="0">，单击“历史记录”，然后单击希望查看的页面。</li>
                           </ol>
                        </p>
                    </div>
                </td>
            </tr>
 
        </table>
 
    </body>
</html>

