package com.eleven.admin.Controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.admin.dto.MemberDTO;
import com.eleven.admin.service.AdminMemberService;

@Controller
public class AdminMemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminMemberService service;

	/* 사원 검색 이동 */
	@GetMapping(value = "/memListAll.move")
	public ModelAndView memListAll(HttpSession session) {
		String root = "member";
		String sessionId = (String) session.getAttribute("loginId");
		logger.info("session ID 접근 :" + sessionId);
		logger.info("root 접근 :" + root);

		ModelAndView mav = new ModelAndView("/admin/memList");
		mav.addObject("root", root);

		return mav;
	}
	
	/* (마이페이지) 사원 리스트 이동 */
	@GetMapping(value = "/admin/memList.move")
	public ModelAndView memListForm(HttpSession session) {
		String root = "admin";
		String sessionId = (String) session.getAttribute("loginId");
		logger.info("session ID 접근 :" + sessionId);
		logger.info("root 접근 :" + root);

		ModelAndView mav = new ModelAndView("/admin/memList");
		mav.addObject("root", root);

		return mav;
	}

	/* 사원 리스트+페이지네이션 */
	@ResponseBody
	@PostMapping(value = "/admin/memList.ajax")
	public HashMap<String, Object> memList(@RequestParam int page, String searchWhat, String searchOption,
			String depOption, String posOption, String dutyOption) {
		logger.info("왜 아무것도 안찍혀요?");
		logger.info("list 요청1 : " + page);
		logger.info("list 요청2 : {} , {}", searchWhat, searchOption);
		logger.info("list 요청3 : {} , {} , {}", depOption, posOption, dutyOption);
		return service.memList(page, searchWhat, searchOption, depOption, posOption, dutyOption);

	}
	
	/* 사원 리스트+페이지네이션 */
	@ResponseBody
	@PostMapping(value = "/member/memList.ajax")
	public HashMap<String, Object> memListMem(@RequestParam int page, String searchWhat, String searchOption,
			String depOption, String posOption, String dutyOption) {
		logger.info("왜 아무것도 안찍혀요?");
		logger.info("list 요청1 : " + page);
		logger.info("list 요청2 : {} , {}", searchWhat, searchOption);
		logger.info("list 요청3 : {} , {} , {}", depOption, posOption, dutyOption);
		return service.memList(page, searchWhat, searchOption, depOption, posOption, dutyOption);

	}

	/* 사원등록 - 아이디 중복검사 */
	@ResponseBody
	@PostMapping(value = "/admin/idCheck.ajax")
	public String idCheck(String idCheck) {
		logger.info("넘어옴?");
		return service.idCheck(idCheck);
	}

	/* 사원등록 - 직속상급자 모달 - 직속상급자리스트 */
	@ResponseBody
	@GetMapping(value = "/admin/supervList.ajax")
	public HashMap<String, Object> supervList(String depIdx) {
		logger.info("직속 상급자 리스트를 요청 : " + depIdx);
		return service.supervList(depIdx);
	}

	/* 사원 등록+파일 */
	@PostMapping(value = "/admin/memRegist.do")
	public String memRegist(Model model, MultipartFile profile, MultipartFile sign, MemberDTO memdto,
			HttpSession session) {
		logger.info("사원 등록 요청 1. 파라미터:{} " + memdto);
		logger.info("사원 등록 요청 2. 프로필사진:{} " + profile);
		logger.info("사원 등록 요청 3. 사인이미지:{} " + sign);
		return service.memRegist(model, profile, sign, memdto,session);
	}

	/* 사원 상세보기 */
	@GetMapping(value = "/admin/memDetail.move")
	public ModelAndView memDetail(String mem_id, HttpSession session) {
		logger.info("mem_id 상세보기 :" + mem_id);
		return service.memDetail(mem_id);
	}

	/* (마이페이지) 사원 수정 이동 */
	@GetMapping(value = "/{root}/memUpdate.move")
	public ModelAndView memUpdateForm(String mem_id, HttpSession session, @PathVariable String root) {
		logger.info("mem_id 수정 :" + mem_id);
		return service.memUpdateForm(mem_id, session, root);
	}

	/* 사원 수정+파일 */
	@PostMapping(value = "/{root}/memUpdate.do")
	public String memUpdate(Model model, MultipartFile profile, MultipartFile sign, MemberDTO memdto,
			HttpSession session, @PathVariable String root) {
		logger.info("사원 수정 요청 1. 파라미터 name:{} ", memdto.getName());
		logger.info("사원 수정 요청 1. 파라미터 stack:{} ", memdto.getStack());
		logger.info("사원 수정 요청 2. 프로필사진:{} ", profile);
		logger.info("사원 수정 요청 3. 사인이미지:{} ", sign);
		
		return service.memUpdate(model, profile, sign, memdto, session, root);
	}

	/* 사원 상세보기 - 모든 로그 */
	@ResponseBody
	@GetMapping(value = "/admin/stateList.ajax")
	public HashMap<String, Object> stateList(String mem_id) {
		logger.info("로그 가져오기 :" + mem_id);
		return service.stateList(mem_id);
	}

	/* 비밀번호 초기화 */
	@ResponseBody
	@PostMapping(value = "/admin/returnPw.ajax")
	public HashMap<String, Object> returnPw(String mem_id) {
		logger.info("로그 가져오기 :" + mem_id);

		return service.returnPw(mem_id);
	}

	/* 사원 비밀번호 변경 - 기존 비밀번호 확인 */
	@ResponseBody
	@PostMapping(value = "/member/checkOld.ajax")
	public HashMap<String, Object> checkOld(HttpSession session, String pw) {
		String mem_id = (String) session.getAttribute("loginId");
		logger.info(mem_id);

		return service.checkOld(mem_id, pw);
	}

	/* 사원 비밀번호 변경 - 기존 비밀번호 확인 */
	@PostMapping(value = "/member/changePw.do")
	public ModelAndView changePw(HttpSession session, String pw) {
		String mem_id = (String) session.getAttribute("loginId");
		logger.info(mem_id);

		return service.changePw(mem_id, pw);
	}

	/* 사진 다시 > 없을때는 등록으로 */

}
