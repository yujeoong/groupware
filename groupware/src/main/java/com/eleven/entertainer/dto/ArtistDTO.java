package com.eleven.entertainer.dto;

import org.apache.ibatis.type.Alias;

@Alias("artist")
public class ArtistDTO {
	// artist
		private int ent_idx;
		private String debut_date;
		private String mem_id;
		private String stage_name;
		private String name;
		
		public int getEnt_idx() {
			return ent_idx;
		}
		public void setEnt_idx(int ent_idx) {
			this.ent_idx = ent_idx;
		}
		public String getDebut_date() {
			return debut_date;
		}
		public void setDebut_date(String debut_date) {
			this.debut_date = debut_date;
		}
		public String getMem_id() {
			return mem_id;
		}
		public void setMem_id(String mem_id) {
			this.mem_id = mem_id;
		}
		public String getStage_name() {
			return stage_name;
		}
		public void setStage_name(String stage_name) {
			this.stage_name = stage_name;
		}
		public String getArtg_idx() {
			return artg_idx;
		}
		public void setArtg_idx(String artg_idx) {
			this.artg_idx = artg_idx;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		private String artg_idx;
	
}
