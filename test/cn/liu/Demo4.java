package cn.liu;

import java.text.ParseException;

import org.junit.Test;

public class Demo4 implements Runnable{


		public void tst(){
		Demo3 demo3 = new Demo3();
		try {
			
			
			
			demo3.start();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		}


public static void main(String[] args) {
		System.out.println("fsf");
		Demo4 demo4 = new Demo4();
		demo4.run();
}
public void run() {
	Demo3 demo3 = new Demo3();

	try {
		demo3.start();
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

}

}
