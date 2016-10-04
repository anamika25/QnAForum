package com.db.qnaforum.entity;

public class Answer {

	private int answerId;
	private int questionId;
	private int userId;
	private String text;
	private User user;

	public Answer(int answerId, int questionId, int userId, String text) {
		this.answerId = answerId;
		this.questionId = questionId;
		this.userId = userId;
		this.text = text;
	}

	public int getAnswerId() {
		return answerId;
	}

	public void setAnswerId(int answerId) {
		this.answerId = answerId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Answer [answerId=");
		builder.append(answerId);
		builder.append(", questionId=");
		builder.append(questionId);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", text=");
		builder.append(text);
		builder.append(", user=");
		builder.append(user);
		builder.append("]");
		return builder.toString();
	}

}
