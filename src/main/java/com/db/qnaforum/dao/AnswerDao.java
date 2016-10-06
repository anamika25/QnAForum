package com.db.qnaforum.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.db.qnaforum.entity.Answer;
import com.mysql.jdbc.Statement;

@Repository
public class AnswerDao {

	@Autowired
	private DataSource dataSource;

	@Autowired
	UserDao userDao;

	public List<Answer> findAnswersByQuesId(int quesId) {
		String sql = "SELECT * FROM Answers WHERE question_id = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, quesId);
			List<Answer> answers = new ArrayList<Answer>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Answer ans = new Answer(rs.getInt("answer_id"), rs.getInt("question_id"), rs.getInt("user_id"),
						rs.getString("text"));
				ans.setUser(userDao.findByUserId(ans.getUserId()));
				answers.add(ans);
			}
			rs.close();
			ps.close();
			return answers;
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

	public boolean addAnswer(int quesId, int userId, String answer) {
		String sql = "INSERT INTO Answers (question_id, user_id, text) VALUES (?, ?, ?)";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, quesId);
			ps.setInt(2, userId);
			ps.setString(3, answer);
			int key = ps.executeUpdate();
			if (key != 0) {
				return true;
			}
			ps.close();
			return false;
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

	public boolean deleteAnswer(int ansId) {
		String sql = "DELETE FROM Answers WHERE answer_id = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, ansId);
			int key = ps.executeUpdate();
			if (key != 0) {
				return true;
			}
			ps.close();
			return false;
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

	public boolean updateAnswer(Integer ansId, String answer) {
		String sql = "UPDATE Answers SET text = ? WHERE answer_id = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, answer);
			ps.setInt(2, ansId);
			int key = ps.executeUpdate();
			if (key != 0) {
				return true;
			}
			ps.close();
			return false;
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
