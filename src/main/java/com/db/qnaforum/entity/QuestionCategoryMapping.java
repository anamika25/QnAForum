package com.db.qnaforum.entity;

public class QuestionCategoryMapping {

	private int qcId;
	private int questionId;
	private int categoryId;

	public QuestionCategoryMapping(int qcId, int questionId, int categoryId) {
		this.qcId = qcId;
		this.questionId = questionId;
		this.categoryId = categoryId;
	}

	public int getQcId() {
		return qcId;
	}

	public void setQcId(int qcId) {
		this.qcId = qcId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

}
