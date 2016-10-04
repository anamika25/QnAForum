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

import com.db.qnaforum.entity.Category;

@Repository
public class CategoryDao {

	@Autowired
	private DataSource dataSource;

	public List<Category> findCategoriesByQuesId(int quesId) {
		String sql = "SELECT category_id FROM Question_Category_mapping WHERE question_id = ?";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, quesId);
			List<Integer> categoryIds = new ArrayList<Integer>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int categoryId = rs.getInt("category_id");
				categoryIds.add(categoryId);
			}
			List<Category> categories = findCategoriesByIdList(categoryIds);
			rs.close();
			ps.close();
			return categories;
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

	public List<Category> findCategoriesByIdList(List<Integer> categoryIds) {
		String sql = "SELECT * FROM Category WHERE category_id in ";
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			StringBuilder builder = new StringBuilder();
			for (int i = 0; i < categoryIds.size(); i++) {
				builder.append("?,");
			}
			PreparedStatement ps = conn
					.prepareStatement(sql + "(" + builder.deleteCharAt(builder.length() - 1).toString() + ")");
			int index = 1;
			for (int id : categoryIds) {
				ps.setObject(index++, id);
			}
			List<Category> categories = new ArrayList<Category>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Category cat = new Category(rs.getInt("category_id"), rs.getString("name"));
				categories.add(cat);
			}
			rs.close();
			ps.close();
			return categories;
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
