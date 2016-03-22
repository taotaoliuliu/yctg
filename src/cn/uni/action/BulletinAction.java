package cn.uni.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.uni.domain.BulletinInfo;
import cn.uni.service.BullentinService;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class BulletinAction extends ActionSupport implements ModelDriven<BulletinInfo>,ServletRequestAware{
	public  HttpServletRequest request;
	
	BulletinInfo bullentinInfo = new BulletinInfo();
	@Resource	
	private BullentinService bullentinService;
	public String home()
	{
		List<BulletinInfo> list = bullentinService.getAll();
		//ActionContext.getContext().put("listBulletin", list);
		request.setAttribute("listBulletin", list);
		return "home";
	}
	
	
	public String list()
	{	
		return "list";
	}
	public String add()
	{	
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		String dd = dateFormat.format(new Date());
		bullentinInfo.setCreatTime(dd);
		bullentinInfo.setIfPut(1);
		bullentinService.save(bullentinInfo);
		return "tolist";
	}
	public String addUI()
	{	
		return "addUI";
	}
	public String delete()
	{	
		bullentinService.delete(bullentinInfo.getBulletinID());
		return "tolist";
	}
	public String editUI()
	{	
		BulletinInfo newBulletin = bullentinService.getById(bullentinInfo.getBulletinID());
		ActionContext.getContext().getValueStack().push(newBulletin);
		
		return "editUI";
	}
	public String edit()
	
	{	
		BulletinInfo newBulletin = bullentinService.getById(bullentinInfo.getBulletinID());
		
		
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String dd = dateFormat.format(new Date());
		bullentinInfo.setCreatTime(dd);
		bullentinInfo.setIfPut(newBulletin.getIfPut());
		bullentinService.update(bullentinInfo);
		return "tolist";
	}
	public String stop()
	
	{	
		String bulletinID = request.getParameter("bulletinID");
		int id=	Integer.parseInt(bulletinID);
		bullentinService.stop(id);
		return "tolist";
	}
	public String resume()
	
	{	
		String bulletinID = request.getParameter("bulletinID");
		int id=	Integer.parseInt(bulletinID);
		bullentinService.resume(id);
		return "tolist";
	}
	public String show()
	{
		List<BulletinInfo> list=bullentinService.getAllByIfPut();
		BulletinInfo info = list.get(0);
		ActionContext.getContext().getValueStack().push(info);
		return "show";
	}
	
	public String showOne()
	{
		BulletinInfo byId = bullentinService.getById(bullentinInfo.getBulletinID());
		
		ActionContext.getContext().getValueStack().push(byId);
		
		return "showOne";
	}
	public BulletinInfo getModel() {
		return bullentinInfo;
	}


	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
}
