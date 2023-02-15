package com.eleven.schedule.dto;

import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

@Alias("scheNoti")
public class ScheNotiDTO { 
		private String noti_idx;
		private String state;
		private String content;
		private String date;
		private String mem_id;
		private String name;
		private String dep_name;
		private String duty_name;
		private String pos_name;
		private ArrayList<ScheMemberDTO> rcpList;
		
		public String getNoti_idx() {
			return noti_idx;
		}
		public void setNoti_idx(String noti_idx) {
			this.noti_idx = noti_idx;
		}
		public String getState() {
			return state;
		}
		public void setState(String state) {
			this.state = state;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public String getMem_id() {
			return mem_id;
		}
		public void setMem_id(String mem_id) {
			this.mem_id = mem_id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getDep_name() {
			return dep_name;
		}
		public void setDep_name(String dep_name) {
			this.dep_name = dep_name;
		}
		public String getDuty_name() {
			return duty_name;
		}
		public void setDuty_name(String duty_name) {
			this.duty_name = duty_name;
		}
		public String getPos_name() {
			return pos_name;
		}
		public void setPos_name(String pos_name) {
			this.pos_name = pos_name;
		}
		public ArrayList<ScheMemberDTO> getRcpList() {
			return rcpList;
		}
		public void setRcpList(ArrayList<ScheMemberDTO> rcpList) {
			this.rcpList = rcpList;
		}

}
