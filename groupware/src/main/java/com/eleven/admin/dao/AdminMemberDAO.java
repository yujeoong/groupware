package com.eleven.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.eleven.admin.dto.CareerDTO;
import com.eleven.admin.dto.ChangeDTO;
import com.eleven.admin.dto.DepartmentDTO;
import com.eleven.admin.dto.DutyDTO;
import com.eleven.admin.dto.FileDTO;
import com.eleven.admin.dto.MemberDTO;
import com.eleven.admin.dto.MemberListDTO;
import com.eleven.admin.dto.PosDTO;
import com.eleven.admin.dto.StateDTO;
import com.eleven.prjManage.dto.AuthorityDTO;

public interface AdminMemberDAO {

	ArrayList<DepartmentDTO> depList(String option); //부서리스트

	ArrayList<PosDTO> posList(String option); //직급

	ArrayList<DutyDTO> dutyList(String option); //직책

	int totalCount(String idCheck, String searchWhat, String searchOption, String depOption, String posOption, String dutyOption); //중복검사, 페이징 체크

	ArrayList<MemberListDTO> memList(int offset, String searchWhat, String searchOption,
			String depOption, String posOption, String dutyOption); //사원리스트

	ArrayList<MemberListDTO> supervList(String depIdx); //직속상급자 리스트

	int depRegist(HashMap<String, String> params); //부서/직급/직책 등록

	int depUpdate(HashMap<String, String> params); //부서/직급/직책 수정

	int depNameFind(HashMap<String, String> params); //부서/직급/직책 중복검사

	String whatIsName(String nameFinder); //부서/직급/직책 중복검사

	int idCheck(String getId); //아이디 중복체크

	int memRegist(MemberDTO memdto); //사원등록

	int upload(String ori_file_name, String new_file_name, int cate, String getId); // 사원 이미지

	int depChange(MemberDTO memdto); //부서이력 insert

	int stateChange(MemberDTO memdto);//상태이력 insert

	int authChange(MemberDTO memdto);//조회권한 insert

	HashMap<String, Object> memDetail(String mem_id); //사원상세보기

	ArrayList<ChangeDTO> changeList(String mem_id); //부서이력 조회

	ArrayList<StateDTO> stateList(String mem_id); // 상태이력 조회

	int haveCareer(String mem_id, String whatCareer); //이력 학력 유무 조회

	ArrayList<CareerDTO> careerList(String mem_id, String whatCareer); // 이력 학력 조회

	ArrayList<AuthorityDTO> authList(String mem_id); //조회권한 조회

	int memUpdate(MemberDTO memdto); //회원 수정

	int updateFile(String ori_file_name, String new_file_name, int cate, String getId); //회원 사진 수정

	int changePw(String mem_id, String getPw); // 비번 변경 or 초기화

	FileDTO picFile(String mem_id, int cate);//파일 가져와

	int picFileChk(String mem_id, int cate);//파일 있는지 확인

	String getPw(String mem_id); // 비밀번호확인

	int checkLevel(String adminId); //관리자 확인

	String activeFind(HashMap<String, String> params);//active 확인

	int checkPeople(HashMap<String, String> params);//비활성화전 사람이 있는지 확인










}
