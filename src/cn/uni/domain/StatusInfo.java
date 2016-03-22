package cn.uni.domain;

public class StatusInfo
{
	public String name_real;
	public String name_Login;
	public String sum;
	public String sum2;
	public String sum3;
	public String sum4;

	
	
	public String getSum() {
		return sum;
	}

	public void setSum(String sum) {
		this.sum = sum;
	}

	public String getSum2() {
		return sum2;
	}

	public void setSum2(String sum2) {
		this.sum2 = sum2;
	}

	public String getSum3() {
		return sum3;
	}

	public void setSum3(String sum3) {
		this.sum3 = sum3;
	}

	public String getSum4() {
		return sum4;
	}

	public void setSum4(String sum4) {
		this.sum4 = sum4;
	}

	public StatusInfo() {
		
	}

	public StatusInfo(String name_Login,String name_real,String sum,String sum2,String sum3,String sum4)
	{
		this.name_real = name_real;
		this.name_Login = name_Login;
		this.sum = sum;
		this.sum2 = sum2;
		this.sum3 = sum3;
		this.sum4 = sum4;
	}

	public String getName_real() {
		return name_real;
	}

	public void setName_real(String nameReal) {
		name_real = nameReal;
	}

	public String getName_Login() {
		return name_Login;
	}

	public void setName_Login(String nameLogin) {
		name_Login = nameLogin;
	}
	

}