package com.db.qnaforum.entity;

import java.util.List;

public class Question {

	private int questionId;
	private String title;
	private String text;
	private int userId;
	private User user;
	private List<Answer> answers;
	private List<Category> categories;

	public Question(int questionId, String title, String text, int userId) {
		this.questionId = questionId;
		this.title = title;
		this.text = text;
		this.userId = userId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Answer> getAnswers() {
		return answers;
	}

	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Question [questionId=");
		builder.append(questionId);
		builder.append(", title=");
		builder.append(title);
		builder.append(", text=");
		builder.append(text);
		builder.append(", user=");
		builder.append(user);
		builder.append(", answers=");
		builder.append(answers);
		builder.append(", categories=");
		builder.append(categories);
		builder.append("]");
		return builder.toString();
	}

}
