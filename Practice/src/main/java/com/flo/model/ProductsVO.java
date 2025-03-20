package com.flo.model;

public class ProductsVO
{
	private int no;
	private String name;
	private String price;
	private int usePeriod;
	
	public ProductsVO()
	{
	}

	public ProductsVO(int no, String name, String price, int usePeriod)
	{
		super();
		this.no = no;
		this.name = name;
		this.price = price;
		this.usePeriod = usePeriod;
	}

	public int getNo()
	{
		return no;
	}

	public void setNo(int no)
	{
		this.no = no;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getPrice()
	{
		return price;
	}

	public void setPrice(String price)
	{
		this.price = price;
	}

	public int getUsePeriod()
	{
		return usePeriod;
	}

	public void setUsePeriod(int usePeriod)
	{
		this.usePeriod = usePeriod;
	}

	@Override
	public String toString()
	{
		return "\nNO. \t" + "상품명\t" + "가격\t" + "이용기간\n" + 
				+ no + "\t" + name + "\t" + price + "\t" + usePeriod;
	}
}