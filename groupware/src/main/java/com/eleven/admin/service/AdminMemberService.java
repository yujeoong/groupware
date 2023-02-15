package com.eleven.admin.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.admin.Controller.EncodeController;
import com.eleven.admin.dao.AdminMemberDAO;
import com.eleven.admin.dto.CareerDTO;
import com.eleven.admin.dto.ChangeDTO;
import com.eleven.admin.dto.FileDTO;
import com.eleven.admin.dto.MemberDTO;
import com.eleven.admin.dto.MemberListDTO;
import com.eleven.admin.dto.StateDTO;
import com.eleven.prjManage.dto.AuthorityDTO;

@Service
@MapperScan(value = {"com.eleven.admin.dao"})
public class AdminMemberService {

	@Value("${file.location}") private String goPath;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminMemberDAO dao;
	@Autowired EncodeController enCon; // 비밀번호 인코딩

	
	//사원 리스트
	public HashMap<String, Object> memList(int page, String searchWhat, String searchOption,
			String depOption, String posOption, String dutyOption) {
		String idCheck = ""; // 아이디중복체크랑 차이를 둠

		int offset=(page-1)*10;
		int totalCount=dao.totalCount(idCheck,searchWhat,searchOption,depOption,posOption,dutyOption);
		logger.info("total count : "+ totalCount);

		int totalPages=totalCount/10;
		if(totalCount%10>0) {
			totalPages=(totalCount/10)+1;
		}

		logger.info("총 페이지 수 : "+ totalPages);
		logger.info("총 페이지 수 2: "+Math.ceil(totalCount/10));
		
		//페이지네이션 0이면 jsp 오류생기므로 방지용
		if(totalPages < 1) {
			totalPages = 1;
		}

		HashMap<String, Object> result=new HashMap<String, Object>();
		ArrayList<MemberListDTO> list=dao.memList(offset,searchWhat,searchOption,depOption,posOption,dutyOption);
		result.put("total",totalPages);
		result.put("list", list);		
		result.put("page", page);		
		return result;
	}


	/*사원등록 - 직속상급자 모달 - 직속상급자리스트*/
	public HashMap<String, Object> supervList(String depIdx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<MemberListDTO> list = dao.supervList(depIdx);
		logger.info("잘가져옴? : "+list.size());
		map.put("list",list);
		return map;
	}


	/*사원등록 - 아이디 중복검사*/
	public String idCheck(String idCheck) {
		String msg = "false";
		String searchOption = ""; //검색조건
		String searchWhat = ""; //검색조건2
		
		String depOption = "none"; //부서 필터 : 사원리스트와 구분주기 위해 이 메소드에서 사용 X
		String posOption = "none";//직급 필터 : 사원리스트와 구분주기 위해 이 메소드에서 사용 X
		String dutyOption = "none";//직책 필터 : 사원리스트와 구분주기 위해 이 메소드에서 사용 X

		int row = dao.totalCount(idCheck,searchOption,searchWhat,depOption,posOption,dutyOption);
		if(row == 0) {
			msg = "true";
		}
		return msg;
	}


	/*사원등록 - 서명+프로필*/
	public String memRegist(Model model, MultipartFile profile, MultipartFile sign, MemberDTO memdto, HttpSession session) {
		logger.info("사원등록 시작 mem_id : "+memdto.getMem_id());
		
		String sessionId = (String) session.getAttribute("loginId");

		//변수선언
		int row = 0; //insert 성공 여부
		String page = "redirect:/"; //반환 페이지
		String getId = memdto.getMem_id(); 
		//String pw = memdto.getPw()

		//사원 insert 
		String pw = null; //수정할때와 차이주기
		String getPw = enCon.newPw(pw); //비밀번호 인코딩

		memdto.setPw(getPw); //인코딩된 초기비밀번호
		row = dao.memRegist(memdto);
		logger.info("등록 확인 : "+row);

		String comment = "입사";
		LocalDate todayKor = LocalDate.now(ZoneId.of("Asia/Seoul"));//오늘 날짜 서울


		/*                        트랜잭션 사용해야함                          */

		//입사 부서이력 변경
		memdto.setComment(comment);
		memdto.setTodayKor(todayKor);
		memdto.setSessionId(sessionId);
		int depRow = dao.depChange(memdto);
		logger.info("부서이력 insert : "+depRow);

		//입사 상태이력 변경
		String state = "0"; //상태: 재직중

		memdto.setState(state);
		int stateRow = dao.stateChange(memdto);
		logger.info("상태이력 insert : "+stateRow);

		//조회권한 변경
		int cate = 1; //카테고리 부서
		String auth = "Y"; //조회권한

		memdto.setCate(cate);
		memdto.setAuth(auth);
		int authRow = dao.authChange(memdto);
		logger.info("조회권한 insert : "+authRow);

		if(row == 1) {
			String upSuccess = upload(sign,profile,getId);

			if(upSuccess == "success") {
				page = "redirect:/admin/memList.move";
			}
		}

		return page;
	}//memRegist


	/*서명, 프로필이미지 등록*/
	private String upload(MultipartFile sign, MultipartFile profile, String getId) {
		String upSuccess = ""; //업로드 성공 실패 확인
		int cate = 6;
		String ori_file_name = ""; // 원본 파일 명
		String ext = ""; //확장자
		String new_file_name = ""; // 파일 새이름

		// 프로필 사진 파일 이미 존재하는지
		int checkFile = dao.picFileChk(getId, cate); 

		//파라미터로 들어온 사진이 있고, 이전에 등록된 사진이 없을 시
		if(profile != null) {
			if(!profile.getOriginalFilename().equals("") && checkFile < 1) {
				//프로필 파일명
				cate = 6; //사원등록 - 프로필사진 분류번호
				ori_file_name = profile.getOriginalFilename();
				logger.info("profile_oriName : "+ori_file_name);
				ext = ori_file_name.substring(ori_file_name.lastIndexOf("."));

				//프로필 새 파일명
				new_file_name = System.currentTimeMillis()+ext;

				int profileUpload = dao.upload(ori_file_name,new_file_name,cate,getId);
				logger.info("프로필insert: "+profileUpload);

				try {
					byte[] byteArr = profile.getBytes();
					Path path = Paths.get(goPath+new_file_name); // 위치
					Files.write(path, byteArr); //파일 쓰기

					if(profileUpload == 1) {
						upSuccess = "success";
					}

				} catch (IOException e) {
					e.printStackTrace();
				}//trycatch

			}
		}
		// 서명 이미지 파일 이미 존재하는지
		cate = 7;
		checkFile = dao.picFileChk(getId, cate); 

		//파라미터로 들어온 사진이 있고, 이전에 등록된 사진이 없을 시		
		if(sign != null) {
			if(!sign.getOriginalFilename().equals("") && checkFile < 1){
				upSuccess = ""; // 서명도 업로드되는지 확인 (초기화)

				//사인이미지 파일명
				ori_file_name = sign.getOriginalFilename();
				logger.info("sign_oriName : "+ori_file_name);
				ext = ori_file_name.substring(ori_file_name.lastIndexOf("."));

				//사인이미지 새 파일명
				new_file_name = System.currentTimeMillis()+ext;

				int signUpload = dao.upload(ori_file_name,new_file_name,cate,getId);

				try {
					byte[] byteArr = sign.getBytes();
					Path path = Paths.get(goPath+new_file_name); // 위치
					Files.write(path, byteArr); //파일 쓰기

					if(signUpload == 1) {
						upSuccess = "success";
					}

				} catch (IOException e) {
					e.printStackTrace();
				}//trycatch
			}//sign if문		
		}

		return upSuccess;
	}//upload()


	/*사원 상세보기*/
	public ModelAndView memDetail(String mem_id) {
		int cate = 6; //프로필
		int checkFile = 0; //파일 존재 여부 확인
		HashMap<String, Object> member = dao.memDetail(mem_id);

		ModelAndView mav = new ModelAndView("/admin/memDetail");
		mav.addObject("member",member);
		mav.addObject("mem_id",mem_id); // 지원추가 

			//프로필 사진 조회
			checkFile = dao.picFileChk(mem_id, cate);
			if(checkFile > 0) {
				FileDTO profile = dao.picFile(mem_id,cate);
				mav.addObject("profile", profile);
			}

			//서명이미지 있는지 확인
			checkFile = 0;
			checkFile = dao.picFileChk(mem_id,cate);
			if(checkFile > 0) {
				cate = 7;
				FileDTO sign = dao.picFile(mem_id,cate);
				mav.addObject("sign",sign);			
			}

		return mav;
	}


	public HashMap<String, Object> stateList(String mem_id) {
		int haveCareer = 0;
		String whatCareer = "";

		HashMap<String, Object> map = new HashMap<String, Object>();

		//이력
		whatCareer = "이력";
		haveCareer = dao.haveCareer(mem_id,whatCareer); //이력 유무확인

		if(haveCareer > 0) {
			ArrayList<CareerDTO> school = dao.careerList(mem_id,whatCareer);
			map.put("school", school);
		}

		//학력
		haveCareer = 0;

		whatCareer = "학력";
		haveCareer = dao.haveCareer(mem_id,whatCareer); //이력 유무확인

		if(haveCareer > 0) {
			ArrayList<CareerDTO> work = dao.careerList(mem_id,whatCareer);
			map.put("work", work);
		}

		//조회 권한
		ArrayList<AuthorityDTO> auth = dao.authList(mem_id);

		//부서이력
		ArrayList<ChangeDTO> dep = dao.changeList(mem_id);

		//상태이력
		ArrayList<StateDTO> state = dao.stateList(mem_id);


		map.put("auth", auth);
		map.put("dep", dep);
		map.put("state", state);

		return map;
	}

	/*사원 수정폼으로*/
	public ModelAndView memUpdateForm(String mem_id, HttpSession session, String root) {
		int cate = 6; //프로필
		int checkFile = 0; //파일 존재 여부 확인
		int checkAdmin = 0; // 관리자인지 확인 - 0:관리자 아님 / 1 : 관리자
		String sessionId = (String)session.getAttribute("loginId"); //session에서 빼온 아이디

		ModelAndView mav = new ModelAndView();

		if(root.equals("admin")) { // admin 루트 접근시 관리자 확인

			logger.info(sessionId);
			checkAdmin = dao.checkLevel(sessionId);
		}

		logger.info("세선 아이디 : "+sessionId);
		logger.info("로그인 아이디: "+mem_id);

		//관리자거나 본인의 수정페이지일 경우
		if(checkAdmin == 1 || mem_id.equals(sessionId)) { 

			//사원 정보 조회
			HashMap<String, Object>member = dao.memDetail(mem_id);
			mav.addObject("member",member);

			//프로필 사진 조회
			checkFile = dao.picFileChk(mem_id, cate);
			if(checkFile > 0) {
				FileDTO profile = dao.picFile(mem_id,cate);
				mav.addObject("profile", profile);
			}

			//서명이미지 있는지 확인
			checkFile = 0;
			checkFile = dao.picFileChk(mem_id,cate);
			if(checkFile > 0) {
				cate = 7;
				FileDTO sign = dao.picFile(mem_id,cate);
				mav.addObject("sign",sign);			
			}
			String page = "/"+root+"/memUpdate";
			mav.setViewName(page);
		}

		return mav;
	}




	//사원 수정
	public String memUpdate(Model model, MultipartFile profile, MultipartFile sign, 
			MemberDTO memdto, HttpSession session, String root) {
		logger.info("사원 수정 시작 mem_id : "+memdto.getMem_id());
		//변수선언
		int cate = 6; //사진 테이블 카테고리 넘버 - 사원프로필사진 : 6, 서명이미지 : 7
		int row = 0; // member 테이블 update 성공 여부
		int checkAdmin = 0; // 관리자인지 확인 - 0:관리자 아님 / 1 : 관리자
		int checkFile = 0; //파일 존재 여부 확인

		String getId = memdto.getMem_id(); 
		String sessionId = (String)session.getAttribute("loginId"); //session에서 빼온 아이디
		logger.info("사원 수정 시작 loginId : "+sessionId);

		String page = "redirect:/"; //반환 페이지

		if(root.equals("admin")) { // admin 루트 접근시 관리자 확인
			checkAdmin = dao.checkLevel(sessionId);
		}

		//관리자거나 본인의 수정페이지일 경우
		if(checkAdmin == 1 || getId.equals(sessionId)) { 

			//사원 update
			row = dao.memUpdate(memdto);
			logger.info("등록 확인 : "+row);

			LocalDate todayKor = LocalDate.now(ZoneId.of("Asia/Seoul"));//오늘 날짜 서울

			/*                        트랜잭션 사용해야함                          */

			//만약 부서이력이 변경되었다면
			if(memdto.getComment() != null) {
				//부서이력 변경
				memdto.setTodayKor(todayKor);
				memdto.setSessionId(sessionId);
				int depRow = dao.depChange(memdto);
				logger.info("부서이력 insert : "+depRow);
			}

			if(row == 1) { // 다되면 사진 넣으러
				if( !profile.getOriginalFilename().equals("")) {

					//프로필 사진 조회
					checkFile = dao.picFileChk(getId, cate);
					
					if(checkFile < 1) { //이미 등록된 사진이 없다면
						String upSuccess = upload(null,profile,getId); //insert

						if(upSuccess == "success") {
							logger.info("수정 : 프로필 사진 새 등록");
							
							//상세보기... 매핑이다르네.. 차후 수정
							if(root.equals("member")) {
								page = "redirect:/"+root+"/mem_detail.move?mem_id="+getId;
							}else{
								page = "redirect:/"+root+"/memDetail.move?mem_id="+getId;
							}
							
						}else {
							logger.info("수정 : 프로필 사진 새로 등록해야하나 실패함");
						}

					}else { //이미 프로필 사진이 존재
						String updateSuccess = updateFile(null,profile,getId); //update

						if(updateSuccess == "success") {//업데이트 성공 시
							
							//상세보기... 매핑이다르네.. 차후 수정
							if(root.equals("member")) {
								page = "redirect:/"+root+"/mem_detail.move?mem_id="+getId;
							}else{
								page = "redirect:/"+root+"/memDetail.move?mem_id="+getId;
							}
							
						}
					}// checkFile
				}//profile if
				
				if(!sign.getOriginalFilename().equals("")){//서명 이미지 업데이트 들어왔을때

					//서명 이미지 조회
					cate = 7;
					checkFile = dao.picFileChk(getId, cate);
					if(checkFile < 1) { //이미 등록된 사진이 없다면
						String upSuccess = upload(sign,null,getId); //insert

						if(upSuccess == "success") {
							logger.info("수정 : 프로필 사진 새 등록");
							
							//상세보기... 매핑이다르네.. 차후 수정
							if(root.equals("member")) {
								page = "redirect:/"+root+"/mem_detail.move?mem_id="+getId;
							}else{
								page = "redirect:/"+root+"/memDetail.move?mem_id="+getId;
							}
							
						}else {
							logger.info("수정 : 프로필 사진 새로 등록해야하나 실패함");
							
						}

					}else { //이미 프로필 사진이 존재
						String updateSuccess = updateFile(sign,null,getId); //update

						if(updateSuccess == "success") {//업데이트 성공 시
							
							//상세보기... 매핑이다르네.. 차후 수정
							if(root.equals("member")) {
								page = "redirect:/"+root+"/mem_detail.move?mem_id="+getId;
							}else{
								page = "redirect:/"+root+"/memDetail.move?mem_id="+getId;
							}
						}
					}// checkFile		

				}else{ // 아무사진도 들어오지 않았을때
					
					//상세보기... 매핑이다르네.. 차후 수정
					if(root.equals("member")) {
						page = "redirect:/"+root+"/mem_detail.move?mem_id="+getId;
					}else{
						page = "redirect:/"+root+"/memDetail.move?mem_id="+getId;
					}
				}

			}//row =1 if
		}//관리자 권한 체크
		logger.info("page 어디 : "+page);
		return page;
	}//memUpdate


	//서명, 프로필이미지 업데이트
	private String updateFile(MultipartFile sign, MultipartFile profile, String getId) {
		String upSuccess = ""; //업로드 성공 실패 확인

		String ori_file_name = ""; // 원본 파일 명
		String ext = ""; //확장자
		String new_file_name = ""; // 파일 새이름

		int cate = 999; //카테고리

		if(profile != null){
		//프로필 파일명
		ori_file_name = profile.getOriginalFilename();
		logger.info("profile_oriName : "+ori_file_name);
		ext = ori_file_name.substring(ori_file_name.lastIndexOf("."));

		//프로필 새 파일명
		new_file_name = System.currentTimeMillis()+ext;
			if(!profile.getOriginalFilename().equals("")){
	
				cate = 6; //사원등록 - 프로필사진 분류번호
				int profileUpload = dao.updateFile(ori_file_name,new_file_name,cate,getId);
				logger.info("프로필insert: "+profileUpload);
	
				try {
					byte[] byteArr = profile.getBytes();
					Path path = Paths.get(goPath+new_file_name); // 위치
					Files.write(path, byteArr); //파일 쓰기
	
					if(profileUpload == 1) {
						upSuccess = "success";
					}
	
				} catch (IOException e) {
					e.printStackTrace();
				}//trycatch
			}
		}
		if(sign != null){
			if(!sign.getOriginalFilename().equals("")){
				upSuccess = ""; // 서명도 업로드되는지 확인
	
				//사인이미지 파일명
				ori_file_name = sign.getOriginalFilename();
				logger.info("sign_oriName : "+ori_file_name);
				ext = ori_file_name.substring(ori_file_name.lastIndexOf("."));
	
				//사인이미지 새 파일명
				new_file_name = System.currentTimeMillis()+ext;
	
				cate = 7;
				int signUpload = dao.updateFile(ori_file_name,new_file_name,cate,getId);
	
				try {
					byte[] byteArr = sign.getBytes();
					Path path = Paths.get(goPath+new_file_name); // 위치
					Files.write(path, byteArr); //파일 쓰기
	
					if(signUpload == 1 ) {
						upSuccess = "success";
					}
	
				} catch (IOException e) {
					e.printStackTrace();
				}//trycatch
			}//sign if문	
		}
			
		return upSuccess;
	}//upload()

	//비번 초기화
	public HashMap<String, Object> returnPw(String mem_id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String pw = null; //수정할때와 차이주기
		String getPw = enCon.newPw(pw); //비밀번호 인코딩
		String msg = "비번 변경 실패";

		int row = dao.changePw(mem_id,getPw);

		if(row == 1) {
			msg = "초기화 성공";
			logger.info(msg);
			map.put("msg", msg);
		}

		return map;
	}

	//기존 비밀번호 확인
	public HashMap<String, Object> checkOld(String mem_id, String pw) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String msg = "false";
		String getPw = dao.getPw(mem_id); // 비밀번호 가져오기

		//pw 와 동일한지 encode 대조
		boolean match = enCon.match(pw,getPw);
		logger.info("다시 대조 결과 확인 : "+match);

		if(match == true) {
			msg = "success";
		}

		map.put("msg", msg);

		return map;
	}

	//비밀번호 변경
	public ModelAndView changePw(String mem_id, String pw){
		logger.info(pw);
		String page = "redirect:/";
		String msg = "비밀번호 변경 실패";

		String getPw = enCon.newPw(pw);//비밀번호 인코딩

		int row = dao.changePw(mem_id,getPw); // update 비밀번호

		if(row == 1) {
			msg = "비밀번호 변경 성공";
			page="redirect:/member/mem_detail.move?mem_id="+mem_id;
			logger.info(msg);
		}

		ModelAndView mav = new ModelAndView(page);
		mav.addObject("msg", msg);

		return mav;
	}










}
