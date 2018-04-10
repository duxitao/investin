package cn.miniconch.controller;

import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/user")
public class UserController {

	Logger log = Logger.getLogger(UserController.class);

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	//public Map<String, Object> login(@RequestBody Map<String, String> requestMap) throws Exception {
	public Map<String, Object> login() throws Exception {
		Map<String, Object> responseMap = new HashMap<String, Object>();
		responseMap.put("test", "123456");
		return responseMap;

	}

}
