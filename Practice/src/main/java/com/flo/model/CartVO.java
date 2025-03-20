package com.flo.model;

public class CartVO
{
    private int no;             // 장바구니 번호 (시퀀스)
    private String name;        // 상품 이름 (Products 테이블에서 참조하는 PK)
    private String price;       // 상품 가격
    private int usePeriod;      // 이용 기간
    private int totalPrice;     // 총 가격 (가격 * 이용기간)

    // Getter and Setter Methods
    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getUsePeriod() {
        return usePeriod;
    }

    public void setUsePeriod(int usePeriod) {
        this.usePeriod = usePeriod;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
}
