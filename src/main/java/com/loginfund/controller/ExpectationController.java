package com.loginfund.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.loginfund.model.Field;
import com.loginfund.model.Scale;
import com.loginfund.service.BaseDataService;

@Controller
public class ExpectationController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	BaseDataService service;
	
	@RequestMapping("expectation")
	public String expectation(Model model) {
		logger.info("enter expectation page……");
		try {
			// 查询规模列表
			List<Scale> scaleList = service.getAllScale();
			// 查询领域列表
			List<Field> fieldList = service.getAllField();
			model.addAttribute("scaleList", scaleList);
			model.addAttribute("fieldList", fieldList);
			return "expectation";
		} catch (Exception e) {
			logger.error("enter expectation error:" + e);
			return "exception";
		}

	}
}
