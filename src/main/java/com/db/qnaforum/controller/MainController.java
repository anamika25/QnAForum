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
import com.db.qnaforum.dao.CategoryDao;
import com.db.qnaforum.dao.QuestionDao;
import com.db.qnaforum.dao.UserDao;
import com.db.qnaforum.entity.Answer;
import com.db.qnaforum.entity.Category;
import com.db.qnaforum.entity.Question;
import com.db.qnaforum.entity.User;

@Controller
public class MainController {

	@Autowired
	private QuestionDao quesDao;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private UserDao userDao;

	@Autowired
	private AnswerDao ansDao;

	@RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)
	public ModelAndView defaultPage(Principal principal,
			@RequestParam(value = "pageNum", required = false) Integer pageNum,
			@RequestParam(value = "message", required = false) String message) {

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
		model.addObject("message", message);
		model.setViewName("hello");
		return model;

	}

	@RequestMapping(value = { "/Add_Question/create" }, method = RequestMethod.POST)
	public ModelAndView addQuestion(Principal principal, @RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "text", required = true) String text,
			@RequestParam(value = "categories", required = false) List<Integer> categoryIds) {

		ModelAndView model = new ModelAndView();
		if (title == null) {
			model.addObject("message", "Please add title");
		}
		if (text == null) {
			model.addObject("message", "Please add your question");
		}
		User user = userDao.findByUsername(principal.getName());
		int quesId = quesDao.addQuestion(title, text, user.getId(), categoryIds);
		if (quesId == 0) {
			model.setViewName("redirect:/welcome?message=");
		} else {
			model.setViewName("redirect:/quesDetail?quesId=" + quesId);
		}
		return model;

	}

	@RequestMapping(value = { "/Add_Question" }, method = RequestMethod.GET)
	public ModelAndView QuestionPage() {
		List<Category> categories = categoryDao.getAllCategories();

		ModelAndView model = new ModelAndView();
		model.addObject("category_list", categories);
		model.setViewName("Question");
		return model;
	}

	@RequestMapping(value = "/quesDetail", method = RequestMethod.GET)
	public ModelAndView questionDetails(@RequestParam(value = "quesId", required = true) Integer quesId,
			@RequestParam(value = "error", required = false) String error) {
		ModelAndView model = new ModelAndView();
		Question quesDetails = quesDao.findByQuestionId(quesId);
		if (quesDetails.getTitle().startsWith("\n")) {
			quesDetails.setTitle(quesDetails.getTitle().replaceFirst("\\n", ""));
		}
		if (quesDetails.getText().startsWith("\n")) {
			quesDetails.setText(quesDetails.getText().replaceFirst("\\n", ""));
		}
		quesDetails.setTitle(quesDetails.getTitle().replace("\n", "<br/>").replace(" ", "&nbsp;").replace("\"", "'"));
		quesDetails.setText(quesDetails.getText().replace("\n", "<br/>").replace(" ", "&nbsp;").replace("\"", "'"));
		for (Answer answer : quesDetails.getAnswers()) {
			if (answer.getText().startsWith("\n")) {
				answer.setText(answer.getText().replaceFirst("\\n", ""));
			}
			answer.setText(answer.getText().replace("\n", "<br/>").replace(" ", "&nbsp;").replace("\"", "'"));
		}
		model.addObject("question", quesDetails);
		model.addObject("error", error);
		model.setViewName("questionDetails");
		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			@RequestParam(value = "signUpMessage", required = false) String signUpMessage) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}
		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		if (signUpMessage != null) {
			model.addObject("msg", signUpMessage);
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

	@RequestMapping(value = "/deleteQuestion", method = RequestMethod.POST)
	public ModelAndView deleteQuestion(@RequestParam(value = "quesId", required = true) Integer quesId) {
		ModelAndView model = new ModelAndView();
		boolean success = quesDao.deleteQuestion(quesId);
		if (!success) {
			model.setViewName("redirect:/quesDetail?quesId=" + quesId + "&error=Could%20not%20delete%20question");
		} else
			model.setViewName("redirect:/welcome");
		return model;
	}

	@RequestMapping(value = "/createUser", method = RequestMethod.POST)
	public ModelAndView signUp(@RequestParam(value = "fullname", required = true) String fullname,
			@RequestParam(value = "username", required = true) String username,
			@RequestParam(value = "password", required = true) String password) {
		ModelAndView model = new ModelAndView();
		User user = userDao.findByUsername(username);
		if (user != null) {
			model.setViewName("redirect:/login?signUpMessage=Username%20already%20exists");
			return model;
		}
		boolean success = userDao.createUser(fullname, username, password);
		if (!success) {
			model.setViewName("redirect:/login?signUpMessage=Could%20not%20create%20account.");
		} else
			model.setViewName("redirect:/login?signUpMessage=Sign%20up%20successful");
		return model;
	}

	@RequestMapping(value = "/searchQues", method = RequestMethod.GET)
	public ModelAndView signUp(@RequestParam(value = "searchText", required = true) String searchText) {
		ModelAndView model = new ModelAndView();
		List<Question> questions = quesDao.searchQuestions(searchText);
		model.addObject("questions", questions);
		if (questions == null || questions.isEmpty())
			model.addObject("message", "No results found");
		model.setViewName("search");
		return model;
	}

	@RequestMapping(value = { "/myQuestions" }, method = RequestMethod.GET)
	public ModelAndView myQuestions(Principal principal,
			@RequestParam(value = "pageNum", required = false) Integer pageNum) {

		ModelAndView model = new ModelAndView();
		pageNum = pageNum == null ? 0 : pageNum;
		User user = userDao.findByUsername(principal.getName());
		List<Question> questions = quesDao.findQuestionsByUserIdPaginated(pageNum, user.getId());
		model.addObject("questions", questions);
		int noOfRecords = quesDao.getNoOfRecords();
		int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / 20);
		model.addObject("noOfPages", noOfPages);
		model.addObject("currentPage", pageNum);
		model.setViewName("myQuestions");
		return model;

	}

}