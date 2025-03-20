package com.flo.model;

import java.sql.Timestamp;

public class ProductsInsertVO
{
	private int productId;	// 상품 고유 ID (Primary Key)
	private String name;	// 상품명
	private String description;	// 상품 설명
	private double price;	// 가격
	// private int stockQuantity;	// 재고 수량
	// private String category;	// 상품 카테고리
	private String imageUrl;	// 상품 이미지 URL
	private Timestamp createdAt;	// 상품 등록일
	private Timestamp updatedAt;	// 상품 수정일
	
	public ProductsInsertVO()
	{
		super();
	}
	
	

	public ProductsInsertVO(int productId, String name, String description, double price, String imageUrl,
			Timestamp createdAt, Timestamp updatedAt) {
		super();
		this.productId = productId;
		this.name = name;
		this.description = description;
		this.price = price;
		this.imageUrl = imageUrl;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}



	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	
	
}