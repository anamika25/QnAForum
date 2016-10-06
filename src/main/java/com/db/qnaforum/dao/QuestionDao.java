package com.db.qnaforum.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import javax.swing.JOptionPane;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.db.qnaforum.entity.Question;

@Repository
public class QuestionDao {

	@Autowired
	private DataSource dataSource;

	@Autowired
	private UserDao userDao;

	@Autowired
	private CategoryDao categoryDao;

	@Autowired
	private AnswerDao answerDao;

	private int noOfRecords;

	public int getNoOfRecords() {
		return noOfRecords;
	}

	public Question findByQuestionId(int quesId) {
		String sql = "SELECT * FROM Questions WHERE question_id = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, quesId);
			Question ques = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				ques = new Question(rs.getInt("question_id"), rs.getString("title"), rs.getString("text"),
						rs.getInt("user_id"));
				ques.setUser(userDao.findByUserId(ques.getUserId()));
				ques.setCategories(categoryDao.findCategoriesByQuesId(quesId));
				ques.setAnswers(answerDao.findAnswersByQuesId(quesId));
			}
			rs.close();
			ps.close();
			return ques;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public List<Question> findQuestionsPaginated(int pageId) {
		String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM Questions ORDER BY question_id DESC LIMIT ? OFFSET ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, 20);
			ps.setInt(2, pageId * 20);
			List<Question> questions = new ArrayList<Question>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Question ques = new Question(rs.getInt("question_id"), rs.getString("title"), rs.getString("text"),
						rs.getInt("user_id"));
				ques.setUser(userDao.findByUserId(ques.getUserId()));
				questions.add(ques);
			}
			rs.close();

			rs = ps.executeQuery("SELECT FOUND_ROWS()");
			if (rs.next())
				this.noOfRecords = rs.getInt(1);
			ps.close();
			return questions;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	public Question addQuestion(String title, String text, int userid) {
		String sql = "INSERT INTO Questions (title,text,user_id) VALUES (?,?,?);";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, text);
			ps.setInt(3, userid);
			Question ques = null;
			int rs = ps.executeUpdate();
			if (rs==1) {
				JOptionPane.showMessageDialog(null, "Your Question has been submitted successfully");
			}
			//rs.close();
			ps.close();
			return ques;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	
}
