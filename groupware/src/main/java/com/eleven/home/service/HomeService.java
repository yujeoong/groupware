package com.eleven.home.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.home.dao.HomeDAO;
import com.eleven.home.dto.HomeDocDTO;
import com.eleven.home.dto.HomeTaskDTO;
import com.eleven.home.dto.HomeTodoDTO;


@Service
public class HomeService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired HomeDAO dao;

	// 음원차트 크롤링
	public ArrayList<HashMap<String, String>> chart(String chrart_url) {
		 
		HashMap<String, String> item = null;
		Document doc = null;
		Elements tmp;
		String name_temp  = null;
		String albumImg_temp = null;
		String singer_temp = null;
		String album_temp = null;
		String rank = null;
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>(); // map담아 전달할 list 
		
		try {
			doc = Jsoup.connect(chrart_url).get();
			
			// 1-50위 
			Elements element = doc.select("div#tb_list").select("tr.lst50");
			// 51-100위 
			Elements element2 = doc.select("div#tb_list").select("tr.lst100");
			
			for(int i=0; i < 50; i++) {
				item = new HashMap<String, String>();
				
				// 이름 가져오기 
				tmp = element.select("div.ellipsis.rank01");
				name_temp = tmp.get(i).text();
				
				// 앨범 사진 가져오기 
				tmp = element.select("div").select("a.image_typeAll").select("img");
				albumImg_temp = tmp.get(i).attr("src");
				
				// 가수 가져오기 
				tmp = element.select("div.ellipsis.rank02").select("span");
				singer_temp = tmp.get(i).text();
				
				// 앨범 가져오기 
				tmp = element.select("div.ellipsis.rank03");
				album_temp = tmp.get(i).text();
				
				// 순위 가져오기 
				tmp = element.select("span.rank");
				rank = tmp.get(i).text();
				
				if(name_temp.length() > 20 ) {
					item.put("name_temp", name_temp.substring(0, 10)+"...");
				} else {
					item.put("name_temp", name_temp);	
				}
				if(singer_temp.length() > 20) {
					item.put("singer_temp", singer_temp.substring(0, 10)+"...");
				} else {
					item.put("singer_temp", singer_temp);
				}
				if( album_temp.length() > 20) {
					item.put("album_temp", album_temp.substring(0, 10)+"...");
				} else {
					item.put("album_temp", album_temp);
				} 
				item.put("albumImg_temp", albumImg_temp);
				item.put("rank", rank);
				list.add(item);
				
			}
			for(int j=0; j < 50; j++) {
				item = new HashMap<String, String>();
				
				// 이름 가져오기 
				tmp = element2.select("div.ellipsis.rank01");
				name_temp = tmp.get(j).text();
				
				// 앨범 사진 가져오기 
				tmp = element2.select("div").select("a.image_typeAll").select("img");
				albumImg_temp = tmp.get(j).attr("src");
				
				// 가수 가져오기 
				tmp = element2.select("div.ellipsis.rank02").select("span");
				singer_temp = tmp.get(j).text();
				
				// 앨범 가져오기 
				tmp = element2.select("div.ellipsis.rank03");
				album_temp = tmp.get(j).text();
				
				// 순위 가져오기 
				tmp = element2.select("span.rank");
				rank = tmp.get(j).text();
				
				if(name_temp.length() > 20 ) {
					item.put("name_temp", name_temp.substring(0, 10)+"...");
				} else {
					item.put("name_temp", name_temp);	
				}
				if(singer_temp.length() > 20) {
					item.put("singer_temp", singer_temp.substring(0, 10)+"...");
				} else {
					item.put("singer_temp", singer_temp);
				}
				if( album_temp.length() > 20) {
					item.put("album_temp", album_temp.substring(0, 10)+"...");
				} else {
					item.put("album_temp", album_temp);
				} 
				item.put("albumImg_temp", albumImg_temp);
				item.put("rank", rank);
				list.add(item);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//logger.info("list :{}", list); 
		return list;
	}

	// 주식 크롤링
	public HashMap<String, Object> finance(String finance_url) {
		
		HashMap<String, Object> item = null;
		Document doc = null;
		
		//ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>(); // map담아 전달할 list 
		
		try {
			item = new HashMap<String, Object>(); 
			doc = Jsoup.connect(finance_url).get();
			
			Elements elem = doc.select(".date");
			String[] str = elem.text().split(" ");

			Elements todaylist =doc.select(".new_totalinfo dl>dd");
			
			String juga = todaylist.get(3).text().split(" ")[1];
			String icon = todaylist.get(3).text().split(" ")[3];
			String DungRakrate = todaylist.get(3).text().split(" ")[6];
			String siga =  todaylist.get(5).text().split(" ")[1];
			String goga = todaylist.get(6).text().split(" ")[1];
			String zeoga = todaylist.get(8).text().split(" ")[1];
			String georaeryang = todaylist.get(10).text().split(" ")[1];

			String stype = todaylist.get(3).text().split(" ")[3]; //상한가,상승,보합,하한가,하락 구분

			String vsyesterday_icon = todaylist.get(3).text().split(" ")[3];
			String vsyesterday = todaylist.get(3).text().split(" ")[4];
			
//			logger.info("삼성전자 주가------------------");
//			logger.info("주가:"+juga);
//			logger.info("등락률아이콘:"+icon);
//			logger.info("등락률:"+DungRakrate);
//			logger.info("시가:"+siga);
//			logger.info("고가:"+goga);
//			logger.info("저가:"+zeoga);
//			logger.info("거래량:"+georaeryang);
//			logger.info("타입:"+stype);
//			logger.info("전일대비:"+vsyesterday);
//			logger.info("전일대비 아이콘:"+vsyesterday_icon);
//			logger.info("가져오는 시간:"+str[0]+str[1]);
		
			item.put("juga", juga);
			item.put("icon", icon);
			item.put("DungRakrate", DungRakrate);
			item.put("siga", siga);
			item.put("goga", goga);
			item.put("zeoga", zeoga);
			item.put("georaeryang", georaeryang);
			item.put("stype", stype);
			item.put("vsyesterday", vsyesterday);
			item.put("vsyesterday_icon", vsyesterday_icon);
			item.put("time", str[0]+str[1]);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		logger.info("item :{}", item);
		return item;
	}

	// 캘린더 
	public int calendar() { 
		// 캘린더 인스턴스 생성 
		Calendar now = Calendar.getInstance();
		//logger.info("now:{}",now);
		logger.info("getActualMaximum :"+now.getActualMaximum(Calendar.DATE));
		
		return now.getActualMaximum(Calendar.DATE);
	}
	
	//투두 리스트
	public ArrayList<HomeTodoDTO> todoList(String loginId) {
		
		return dao.todoList(loginId);
	}

	// 투두 삭제 
	public int todoDelete(int todo_idx) {
		
		return dao.todoDelete(todo_idx);
	}
	
	// 투두 등록 
	public int todoRegist(HashMap<String, Object> map) {
		
		return dao.todoRegist(map);
	}
	
	// todo 수정 
	public int todoEdit(HashMap<String, Object> map) {
		 
		return dao.todoEdit(map);
	}
		
	// todo done 수정 
	public int todoDoneEdit(HashMap<String, Object> map) {
		
		return dao.todoDoneEdit(map);
	}

	// todo 일정 삭제 
//	@Scheduled(cron = "59 23 * * *")
//	public void todoCron(HttpSession session) {
//		logger.info("매일 23시 59분에 실행");
//		int cnt = dao.todoCnt();
//		
//		dao.todoCron(cnt);
//	}

	// 결재 문서 
	public ArrayList<HomeDocDTO> appr_docList(String loginId) {
		 
		return dao.appr_docList(loginId);
	}
	
	// 업무 리스트 
	public ArrayList<HashMap<String, Object>> prj_taskList(String loginId) {
		HashMap<String, Object> map = null; 
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		ArrayList<HomeTaskDTO> prjList = dao.prjList();
		
		for(int i=0; i<prjList.size(); i++) {
			map = new HashMap<String, Object>();
			map.put("loginId", loginId);
			
			//logger.info("getPrj_idx :{}", prjList.get(i).getPrj_idx());
			map.put("prj_idx", prjList.get(i).getPrj_idx());
			ArrayList<HomeTaskDTO> taskList = dao.taskList(map);
			//logger.info("taskList.size :{}",taskList.size());
			
			if(taskList.size() > 0) {
				for(int j=0; j<taskList.size(); j++) {
					map = new HashMap<String, Object>();
					//list = new ArrayList<HashMap<String, Object>>();
					logger.info("taskList:{}", j);
					//map.put("taskList", taskList.get(j));
					map.put("prj_subject", taskList.get(j).getPrj_subject());
					map.put("state", taskList.get(j).getState());
					map.put("start", taskList.get(j).getPlan_start());
					map.put("end", taskList.get(j).getPlan_end());
					map.put("task_subject", taskList.get(j).getSubject());
					list.add(j, map);
					//logger.info("list index:{}", list.get(j));
				}
			}  
		} 
		//logger.info("list:{}", list);
		return list;
	}

	
	

	


	

	
	
	
	
	
	
	
}
