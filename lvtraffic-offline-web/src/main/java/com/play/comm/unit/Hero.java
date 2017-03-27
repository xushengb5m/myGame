package com.play.comm.unit;

import java.util.Random;

public class Hero extends UnitBase{
	
	private Long strength;
	
	private Long speed;
	
	private Long intell;
	
	private Long luck;
	
	public static void main(String[] args) {
		Random rand = new Random();
		System.out.println(rand.nextInt(1000));
	}
	

}
