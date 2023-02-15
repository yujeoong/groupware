package com.eleven.entertainer.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.entertainer.dao.EnterDAO;
import com.eleven.entertainer.dto.ArtgDTO;
import com.eleven.entertainer.dto.ArtistDTO;
import com.eleven.entertainer.dto.Contract_logDTO;
import com.eleven.entertainer.dto.Ent_careerDTO;
import com.eleven.entertainer.dto.EnterDTO;
import com.eleven.entertainer.dto.FileDTO;
import com.eleven.entertainer.dto.TestDTO;

@Service
@MapperScan({ "com.eleven.entertainer" })
public class EnterService {
	
	
	@Autowired
	EnterDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${file.location}")
	private String root;

	
	// 엔터테이너 등록 페이지 서비스
	public ModelAndView enterWriteForm() {
		ModelAndView mav = new ModelAndView("entertainer/enterWriteForm");
		ArrayList<ArtgDTO> artg_dto = dao.enterWriteForm();
		logger.info("엔터테이너 등록 페이지 서비스: "+ artg_dto);
		mav.addObject("artistGroup",artg_dto);
		return mav;
	}
	
	
	
	// 엔터테이너 등록하기
	public String enterRegist(MultipartFile photo, MultipartFile[] files, HashMap<String, String> params, String[] start_date, String[] end_date, String[] content) {
		logger.info("photo 객체: {}", photo.getOriginalFilename());
		logger.info("file 객체: {}", files.length);
		
		// 연습생
		EnterDTO dto = new EnterDTO();
		dto.setName(params.get("name"));
		dto.setBirth(params.get("birth"));
		dto.setGender(params.get("gender"));
		dto.setHeight(params.get("height"));
		dto.setWeight(params.get("weight"));
		dto.setBlood(params.get("blood"));
		dto.setHobby(params.get("hobby"));
		dto.setSkill(params.get("skill"));
		dto.setEnter_com(params.get("enter_com"));
		dto.setLanguage(params.get("language"));
		dto.setState(params.get("state"));
		
		
		int success = dao.enterRegist(dto);
		logger.info("등록성공?: {}", success);
		logger.info("ent_idx: "+dto.getEnt_idx());
		int entIdx = dto.getEnt_idx();
		
		String state = dto.getState();
		logger.info("state:"+state);
		String page = "redirect:/entertainer/enterList.move";
		
		if(state.equals("2")) {
			// 아티스트
			ArtistDTO dto3 = new ArtistDTO();
			dto3.setDebut_date(params.get("debut_date"));
			String debut_date = dto3.getDebut_date();
			
			dto3.setMem_id(params.get("mem_id"));
			String mem_id = dto3.getMem_id();
			logger.info("mem_id: "+dto3.getMem_id());
			
			dto3.setStage_name(params.get("stage_name"));
			String stage_name = dto3.getStage_name();
			
			dto3.setArtg_idx(params.get("artg_idx"));
			String art_group = dto3.getArtg_idx();
			logger.info("artg_idx: "+art_group);
			
			dao.artistRegist(entIdx,debut_date,mem_id,stage_name,art_group);
			logger.info("아티스트 페이지 이동: "+state);
			page="redirect:/artist/artistList.move";
		}
		
		
		// 그룹
//		ArtgDTO artg_dto = new ArtgDTO();
//		artg_dto.setArtg_name(params.get("artg_name")); // 그룹이름
		
		
		// 평가
		TestDTO dto4 = new TestDTO();
		int tune = dto4.getTune();
		int beat = dto4.getBeat();	
		int sing = dto4.getSing();	
		int tone = dto4.getTone();	
		int rap = dto4.getRap();	
		int face = dto4.getFace();	
		int gesture = dto4.getGesture();	
		int dance = dto4.getDance();
		int acting = dto4.getActing();	
		String test_com = dto4.getTest_com();
		dao.test_Regist1(entIdx,tune,beat,sing,tone,rap,face,gesture,dance,acting,test_com);
		
		// 계약로그
		Contract_logDTO dto2 = new Contract_logDTO();
		dto2.setCont_start_date(params.get("cont_start_date"));
		dto2.setCont_end_date(params.get("cont_end_date"));
		dto2.setCon_com(params.get("con_com"));
		String cont_start_date = dto2.getCont_start_date();
		String cont_end_date = dto2.getCont_end_date();
		String con_com = dto2.getCon_com();
		dao.contract_log(entIdx, cont_start_date, cont_end_date, con_com);
		

		// 활동이력
		for(int i=0; i< start_date.length; i++) {
			//Ent_careerDTO dto5 = new Ent_careerDTO();
			logger.info("careers: "+start_date[i]+end_date[i]+content[i]);
			dao.careerRegist(entIdx, start_date[i], end_date[i], content[i]);
			//dto5.setEnd_date(end_date[i]);
			//dao.career(entIdx, dto5);
		}
		
		if (success > 0 && !photo.getOriginalFilename().equals("")) {
			singleFileUpload(photo, entIdx);
		}
		
		if(success > 0) {
			for(MultipartFile file : files) {
				try {
					multiFileUpload(file,entIdx);
					Thread.sleep(1);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		return page;
	}

	private void singleFileUpload(MultipartFile photo, int entIdx) {
		String oriFileName = photo.getOriginalFilename();
		logger.info(oriFileName);
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		
		try {
			byte[] bytes = photo.getBytes();
			
			Path path = Paths.get(root + newFileName);
			Files.write(path, bytes);
			logger.info(newFileName + "업로드 성공");
			
			dao.fileWrite(entIdx, oriFileName, newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	private void multiFileUpload(MultipartFile file, int entIdx) {
		String oriFileName2 = file.getOriginalFilename();
		logger.info(oriFileName2);
		String ext2 = oriFileName2.substring(oriFileName2.lastIndexOf("."));
		String newFileName2 = System.currentTimeMillis() + ext2;

		try {
			byte[] arr = file.getBytes();

			Path path = Paths.get(root + newFileName2);
			Files.write(path, arr);
			logger.info(newFileName2 + "업로드 성공2");

			dao.fileWrite2(entIdx, oriFileName2, newFileName2);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}


	// 엔터테이너 수정하기 폼으로 이동
	public ModelAndView enterEditForm(String ent_idx) {
		ModelAndView mav = new ModelAndView("entertainer/enterEdit");
		FileDTO enterProfile_dto = dao.enterProFile(ent_idx); // 프로필사진
		EnterDTO enter_dto = dao.enter_list(ent_idx); // 기본정보
		ArtistDTO art_dto = dao.art_list(ent_idx);
		ArrayList<Ent_careerDTO> enter_career_dto = dao.enterCareer(ent_idx); //활동이력
		ArrayList<Contract_logDTO> enter_log = dao.enterLog(ent_idx); //계약로그
		ArrayList<FileDTO> enterFiles_dto = dao.enterFiles(ent_idx); // 첨부파일
		logger.info("연습생 수정 서비스");
		mav.addObject("enterProFile",enterProfile_dto);
		mav.addObject("enterList",enter_dto);
		mav.addObject("artList",art_dto);
		mav.addObject("enterCareer",enter_career_dto);
		mav.addObject("enterLog",enter_log);
		mav.addObject("enterFiles",enterFiles_dto);
		
		return mav;
	}
	
	// 엔터테이너 수정하기
	public String enterEdit(MultipartFile photo, MultipartFile[] files, HashMap<String, String> params, String[] start_date, String[] end_date, String[] content) {
		
		logger.info("photo 객체: {}", photo.getOriginalFilename());
		logger.info("file 객체: {}", files.length);
		int success = dao.enterEdit(params);
		String entIdx = params.get("ent_idx");
		logger.info("ent_idx: "+entIdx);

		String state = params.get("state");
		String page = "redirect:/entertainer/enterDetail.move?ent_idx="+entIdx;
		
		if(state.equals("2")) {
		// 아티스트일 경우
		ArtistDTO art_dto = new ArtistDTO();
		art_dto.setDebut_date(params.get("debut_date"));
		art_dto.setStage_name(params.get("stage_name"));
		String debut_date = art_dto.getDebut_date();
		String stage_name = art_dto.getStage_name();
		dao.artEdit(entIdx, debut_date, stage_name);
		
		
		
		page="redirect:/artist/artistDetail.move?ent_idx="+entIdx;
		}
		
		// 계약로그
		Contract_logDTO dto2 = new Contract_logDTO();
		dto2.setCont_start_date(params.get("cont_start_date"));
		dto2.setCont_end_date(params.get("cont_end_date"));
		dto2.setCon_com(params.get("con_com"));
		String cont_start_date = dto2.getCont_start_date();
		String cont_end_date = dto2.getCont_end_date();
		String con_com = dto2.getCon_com();
		dao.logEdit(entIdx, cont_start_date, cont_end_date, con_com);
		

		// 활동이력
		for(int i=0; i< start_date.length; i++) {
			//Ent_careerDTO dto5 = new Ent_careerDTO();
			logger.info("careers: "+start_date[i]+end_date[i]+content[i]);
			dao.careerEdit(entIdx, start_date[i], end_date[i], content[i]);
			//dto5.setEnd_date(end_date[i]);
			//dao.career(entIdx, dto5);
		}
		
		if (success > 0 && !photo.getOriginalFilename().equals("")) {
			singleFileUpdate(photo, Integer.parseInt(entIdx));
		}
		
		if(success > 0) {
			for(MultipartFile file : files) {
				try {
					multiFileUpload(file, Integer.parseInt(entIdx));
					Thread.sleep(1);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		return page;
	}

	private void singleFileUpdate(MultipartFile photo, int entIdx) {
		String oriFileName = photo.getOriginalFilename();
		logger.info(oriFileName);
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		
		try {
			byte[] bytes = photo.getBytes();
			
			Path path = Paths.get(root + newFileName);
			Files.write(path, bytes);
			logger.info(newFileName + "업데이트 성공");
			
			dao.fileUpdate(entIdx, oriFileName, newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	// 엔터테이너 평가 폼으로 이동
	public ModelAndView enterTestForm(String ent_idx) {
		ModelAndView mav = new ModelAndView("entertainer/enterTest");
		TestDTO enterTest_dto = dao.enterTestForm(ent_idx);
		logger.info("연습생 평가 등록 서비스");
		mav.addObject("enterTest",enterTest_dto);
		return mav;
	}

	// 엔터테이너 평가등록
	public String enterTestRegist(HashMap<String, String> params) {
		dao.test_Regist2(params);
		String entIdx = params.get("ent_idx");
		return "redirect:/artist/artistDetail.move?ent_idx="+entIdx;
	}
	
	// 연습생 리스트
	public ModelAndView enterList() {
		ModelAndView mav = new ModelAndView("entertainer/enterList");
		ArrayList<EnterDTO> enter_dto = dao.enterList();
		ArrayList<FileDTO> enterFile_dto = dao.enterFileList();
		logger.info("연습생리스트 서비스");
		mav.addObject("enterList",enter_dto);
		mav.addObject("enterFileList",enterFile_dto);
		
		return mav;
	}
	
	
	// 아티스트 리스트
	public ModelAndView artistList() {
		ModelAndView mav = new ModelAndView("artist/artistList");
		ArrayList<String> cnt = dao.art_count();
		
		for(int i =0; i <cnt.size(); i++) {
			ArrayList<EnterDTO> artist_dto = dao.artistrList(cnt.get(i));			
			logger.info("artist_dto:{}"+artist_dto );
			mav.addObject("artistList",artist_dto);
		}
		ArrayList<FileDTO> artistFile_dto = dao.artistFileList();
		logger.info("아티스트 리스트 서비스");
		mav.addObject("artistFileList",artistFile_dto);
		return mav;
	}

	
	//연습생 검색 서비스
	public ModelAndView enterSearch(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView("entertainer/enterSearchList");
		ArrayList<EnterDTO> enterSch = dao.enterSearchList(params);
		ArrayList<FileDTO> enterSchFile = dao.enterSearchFileList(params);
		mav.addObject("enterSearchList", enterSch);
		mav.addObject("enterSearchFileList", enterSchFile);
		return mav;
	}

	//아티스트 검색 서비스
	public ModelAndView artSearch(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView("artist/artSearchList");
		ArrayList<EnterDTO> artSearch = dao.artSearchList(params);
		ArrayList<FileDTO> artSchFile = dao.artistSearchFileList(params);
		mav.addObject("artSearchList", artSearch);
		mav.addObject("artSearchFileList", artSchFile);
		return mav;
	}
	
	// 연습생 상세보기 서비스(프로필사진+기본정보+평가내역+활동이력+계약일+첨부파일)
	public ModelAndView enterDetail(String ent_idx) {
		ModelAndView mav = new ModelAndView("entertainer/enterDetail");
		FileDTO enterProfile_dto = dao.enterProFile(ent_idx); // 프로필사진
		EnterDTO enter_dto = dao.enter_list(ent_idx); // 기본정보
		ArrayList<TestDTO> enter_test_dto = dao.enterTest(ent_idx); //평가내역
		ArrayList<Ent_careerDTO> enter_career_dto = dao.enterCareer(ent_idx); //활동이력
		ArrayList<Contract_logDTO> enter_log = dao.enterLog(ent_idx); //계약로그
		ArrayList<FileDTO> enterFiles_dto = dao.enterFiles(ent_idx); // 첨부파일
		logger.info("연습생 상세보기 서비스");
		mav.addObject("enterProFile",enterProfile_dto);
		mav.addObject("enterList",enter_dto);
		mav.addObject("enterTest",enter_test_dto);
		mav.addObject("enterCareer",enter_career_dto);
		mav.addObject("enterLog",enter_log);
		mav.addObject("enterFiles",enterFiles_dto);
		return mav;
	}
	
	// 아티스트 그룹 이름 등록
	public String artistGroup(String artg_name) {
		dao.artistGroup(artg_name);
		return "redirect:/artist/artistList.move";
	}

	
	// 아티스트 상세보기
	public ModelAndView artistDetail(String ent_idx) throws IOException {
		ModelAndView mav = new ModelAndView("artist/artistDetail");
		FileDTO enterProfile_dto = dao.enterProFile(ent_idx); // 프로필사진
		EnterDTO enter_dto = dao.enter_list(ent_idx); // 기본정보
		ArrayList<TestDTO> enter_test_dto = dao.enterTest(ent_idx); //평가내역
		ArrayList<Ent_careerDTO> enter_career_dto = dao.enterCareer(ent_idx); //활동이력
		ArrayList<Contract_logDTO> enter_log = dao.enterLog(ent_idx); //계약로그
		ArrayList<FileDTO> enterFiles_dto = dao.enterFiles(ent_idx); // 첨부파일
		logger.info("연습생 상세보기 서비스");
		mav.addObject("enterProFile",enterProfile_dto);
		mav.addObject("enterList",enter_dto);
		mav.addObject("enterTest",enter_test_dto);
		mav.addObject("enterCareer",enter_career_dto);
		mav.addObject("enterLog",enter_log);
		mav.addObject("enterFiles",enterFiles_dto);
		
		
		int artG = dao.artG(ent_idx);
		logger.info("그룹번호: "+artG);
		
		
		String album = "";

		// 멜론 앨범 정보 크롤링
		if(artG == 1) {
			album = "https://www.melon.com/album/detail.htm?albumId=11110911";
		} else if(artG == 2) {
			album = "https://www.melon.com/album/detail.htm?albumId=11124139";
		} else if(artG == 3) {
			album = "https://www.melon.com/album/detail.htm?albumId=10972706";
		} else {
			album = "https://www.melon.com/album/detail.htm?albumId=10494424";
		}
		
		int page = 1;
		Document doc = Jsoup.connect(album).data("page", String.valueOf(page)).get();
		
		
		Elements root = doc.select("div.wrap_info");
		logger.info("size: "+ root.size());
		
		String title ="";
		String image ="";
		
		image = root.select("img").attr("src");
		logger.info("이미지:"+image );
		title = root.select("div.song_name").text();
		
		
		Elements cols = doc.select(".list dd");
		logger.info("size: "+ cols.size());
		
		String date =cols.get(0).text();
		String jangree =cols.get(1).text();
		String company =cols.get(2).text();
		String agency =cols.get(3).text();
		
		logger.info("발매일,장르,발매사,기획사: "+date+jangree+company+agency );
		
		mav.addObject("image",image);
		mav.addObject("title",title);
		mav.addObject("date",date);
		mav.addObject("jangree",jangree);
		mav.addObject("company",company);
		mav.addObject("agency",agency);
		

		return mav;
	}

	
	
	//사원 리스트
	public HashMap<String, Object> memList() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memList", dao.memList());
		map.put("depList", dao.depList());
		return map;
	}

	// 그룹이름 중복검사
    public String idCheck(String idCheck) {
        String msg = "false";
        int row = dao.totalCount(idCheck);
        if(row == 0) {
            msg = "true";
        }
        return msg;
    }
	


	


	

	// 아티스트 상세보기 서비스
//	public ModelAndView artistDetail(Document doc, String ent_idx) {
//		ModelAndView mav = new ModelAndView("artist/artistDetail");
//		FileDTO enterProfile_dto = dao.enterProFile(ent_idx); // 프로필사진
//		EnterDTO enter_dto = dao.enter_list(ent_idx); // 기본정보
//		ArrayList<TestDTO> enter_test_dto = dao.enterTest(ent_idx); //평가내역
//		ArrayList<Ent_careerDTO> enter_career_dto = dao.enterCareer(ent_idx); //활동이력
//		ArrayList<Contract_logDTO> enter_log = dao.enterLog(ent_idx); //계약로그
//		ArrayList<FileDTO> enterFiles_dto = dao.enterFiles(ent_idx); // 첨부파일
//		logger.info("연습생 상세보기 서비스");
//		mav.addObject("enterProFile",enterProfile_dto);
//		mav.addObject("enterList",enter_dto);
//		mav.addObject("enterTest",enter_test_dto);
//		mav.addObject("enterCareer",enter_career_dto);
//		mav.addObject("enterLog",enter_log);
//		mav.addObject("enterFiles",enterFiles_dto);
//		
//		
//		// 연령별 검색량 크롤링(일단 청하)
//		Elements elems = doc.select("div.button.d_album_like"); // 원하는 부분 걸려 있는 div
//		logger.info("size: "+elems);
//		
//		String url ="";
//		String content ="";
//			
//		content = elems.select("button span#d_like_count").text();
//		
//		mav.addObject("url", "https://www.melon.com/album/detail.htm?albumId=10238683#" + url);
//		mav.addObject("content", content);
//		logger.info("좋아요 수: "+ content);
//		
//		return mav;
//	}



	

	



	


	




	


	


}
