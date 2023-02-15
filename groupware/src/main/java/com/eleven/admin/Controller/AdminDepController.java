package com.eleven.admin.Controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.admin.service.AdminDepService;

@Controller
public class AdminDepController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminDepService service;
	
	/*부서 리스트*/
	@ResponseBody
	@GetMapping(value = "/admin/adminDepList")
	public HashMap<String, Object> depList(String option){
		logger.info("부서 리스트를 요청");
		return service.depList(option);
	}
	
	/*직급 리스트*/
	@ResponseBody
	@GetMapping(value = "/admin/posList.ajax")
	public HashMap<String, Object> posList(String option){
		logger.info("직급 리스트를 요청");
		return service.posList(option);
	}
	
	/*직책 리스트*/
	@ResponseBody
	@GetMapping(value = "/admin/dutyList.ajax")
	public HashMap<String, Object> dutyList(String option){
		logger.info("직책 리스트를 요청");
		return service.dutyList(option);
	}
	
	/*부서 직급 직책 등록*/
	@ResponseBody
	@PostMapping(value = "/admin/depRegist.ajax")
	public HashMap<String, String> depRegist(@RequestParam HashMap<String, String> params) {
		logger.info("등록 params :"+params);
		
		String msg = "fail";
		int row = service.depRegist(params);
		logger.info("등록 성공실패 : "+row);
		if(row == 1) {
			msg = "success";	
		}
		logger.info("등록 성공실패 : "+msg);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("msg", msg);
		
		return map;
	}

	/*부서 직급 직책 수정*/
	@ResponseBody
	@PostMapping(value = "/admin/depUpdate.ajax")
	public HashMap<String, String> depUpdate(@RequestParam HashMap<String, String> params) {
		logger.info("수정 params :"+params);
		
		String msg = "fail";
		int row = service.depUpdate(params);
		logger.info("수정 성공실패 : "+row);
			if(row == 1) {
				msg = "success";	
			}else if(row == 99) {
				msg = "activeFail";
			}
		logger.info("수정 성공실패 : "+msg);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("update", msg);
		
		return map;
	}
}
