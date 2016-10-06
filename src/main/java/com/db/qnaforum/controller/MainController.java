package com.db.qnaforum.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.db.qnaforum.dao.AnswerDao;
import com.db.qnaforum.dao.QuestionDao;
import com.db.qnaforum.dao.UserDao;
import com.db.qnaforum.entity.Answer;
import com.db.qnaforum.entity.Question;
import com.db.qnaforum.entity.User;

@Controller
public class MainController {

	@Autowired
	private QuestionDao quesDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private AnswerDao ansDao;

	@RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)
	public ModelAndView defaultPage(Principal principal,
			@RequestParam(value = "pageNum", required = false) Integer pageNum) {

		ModelAndView model = new ModelAndView();
		if (principal == null) {
			model.setViewName("redirect:/login");
			return model;
		}
		pageNum = pageNum == null ? 0 : pageNum;
		List<Question> questions = quesDao.findQuestionsPaginated(pageNum);
		model.addObject("questions", questions);
		int noOfRecords = quesDao.getNoOfRecords();
		int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / 20);
		model.addObject("noOfPages", noOfPages);
		model.addObject("currentPage", pageNum);
		model.setViewName("hello");
		return model;

	}

	@RequestMapping(value = { "/Add_Question" }, method = RequestMethod.GET)
	public ModelAndView QuestionPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title", "Spring Security Login Form - Database Authentication");
		model.addObject("message", "This is default page!");
		model.setViewName("Question");
		return model;
	}

	/*
	 * @RequestMapping(value = "/admin**", method = RequestMethod.GET) public
	 * ModelAndView adminPage() { ModelAndView model = new ModelAndView();
	 * model.addObject("title",
	 * "Spring Security Login Form - Database Authentication");
	 * model.addObject("message", "This page is for ROLE_ADMIN only!");
	 * model.setViewName("admin");
	 * 
	 * return model;
	 * 
	 * }
	 */

	@RequestMapping(value = "/quesDetail", method = RequestMethod.GET)
	public ModelAndView questionDetails(@RequestParam(value = "quesId", required = true) Integer quesId,
			@RequestParam(value = "error", required = false) String error) {
		ModelAndView model = new ModelAndView();
		Question quesDetails = quesDao.findByQuestionId(quesId);
		quesDetails.setText(quesDetails.getText().replaceFirst("\\n", "").replace("\n", "<br/>").replace(" ", "&nbsp;")
				.replace("\"", "'"));
		for (Answer answer : quesDetails.getAnswers()) {
			answer.setText(answer.getText().replaceFirst("\\n", "").replace("\n", "<br/>").replace(" ", "&nbsp;")
					.replace("\"", "'"));
		}
		model.addObject("question", quesDetails);
		model.addObject("error", error);
		model.setViewName("questionDetails");
		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}
		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");
		return model;
	}

	// for 403 access denied page
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();
		// check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);
			model.addObject("username", userDetail.getUsername());
		}
		model.setViewName("403");
		return model;
	}

	@RequestMapping(value = "/updateAnswer", method = RequestMethod.POST)
	public ModelAndView addAnswer(Principal principal, @RequestParam(value = "quesId", required = false) Integer quesId,
			@RequestParam(value = "answer", required = true) String answer,
			@RequestParam(value = "ansId", required = false) Integer ansId) {
		ModelAndView model = new ModelAndView();
		User user = userDao.findByUsername(principal.getName());
		boolean success = false;
		if (ansId == null)
			success = ansDao.addAnswer(quesId, user.getId(), answer);
		else
			success = ansDao.updateAnswer(ansId, answer);

		if (!success) {
			model.setViewName("redirect:/quesDetail?quesId=" + quesId + "&error=Could%20not%20add%20answer");
		} else
			model.setViewName("redirect:/quesDetail?quesId=" + quesId);
		return model;
	}

	@RequestMapping(value = "/deleteAnswer", method = RequestMethod.POST)
	public ModelAndView deleteAnswer(@RequestParam(value = "quesId", required = true) Integer quesId,
			@RequestParam(value = "ansId", required = true) Integer ansId) {
		ModelAndView model = new ModelAndView();
		boolean success = ansDao.deleteAnswer(ansId);
		if (!success) {
			model.setViewName("redirect:/quesDetail?quesId=" + quesId + "&error=Could%20not%20delete%20answer");
		} else
			model.setViewName("redirect:/quesDetail?quesId=" + quesId);
		return model;
	}

	@RequestMapping(value = "/createUser", method = RequestMethod.POST)
	public ModelAndView signUp(@RequestParam(value = "fullname", required = true) String fullname,
			@RequestParam(value = "username", required = true) String username,
			@RequestParam(value = "password", required = true) String password) {
		ModelAndView model = new ModelAndView();
		boolean success = userDao.createUser(fullname, username, password);
		if (!success) {
			model.addObject("error", "Could%20not%20create%20account.");
		} else
			model.addObject("msg", "Sign%20up%20successful");
		model.setViewName("login");
		return model;
	}

}