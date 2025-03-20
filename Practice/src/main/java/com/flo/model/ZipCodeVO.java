package com.flo.model;

public class ZipCodeVO
{
    private String zipCode;
    private String sido;
    private String gugun;
    private String dong;
    private String bunji;
	
    public ZipCodeVO() {
		super();
	}
	public ZipCodeVO(String zipCode, String sido, String gugun, String dong, String bunji) {
		super();
		this.zipCode = zipCode;
		this.sido = sido;
		this.gugun = gugun;
		this.dong = dong;
		this.bunji = bunji;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	
	@Override
	public String toString() {
		return "[우편번호 " + zipCode + ", 시/도 " + sido + ", 구/군 " + gugun + ", 동 " + dong + ", 번지 "
				+ bunji + "]";
	}
}